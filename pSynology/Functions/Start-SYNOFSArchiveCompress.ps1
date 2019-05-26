function Start-SYNOFSArchiveCompress {
	<#
	.SYNOPSIS
	Start to compress file(s)/folder(s).

	.DESCRIPTION
	Invokes the "start" method of SYNO.FileStation.Compress

	.PARAMETER path
	One or more file paths to be compressed.

	.PARAMETER dest_file_path
	A destination file path (including file name) of an archive for the compressed archive.

	.PARAMETER level
	Compress level used,
	could be one of following values:
	moderate(default): moderate compression and normal compression speed
	store: pack files with no compress
	fastest: fastest compression speed but less compression
	best: slowest compression speed but optimal compression

	.PARAMETER mode
	Compress mode used,
	could be one of following values:
	add (default): Update existing items and add new files. If an archive does not exist, a new one is created.
	update: Update existing items if newer on the file system and add new files. If the archive does not exist create a new archive.
	refreshen: Update existing items of an archive if newer on the file system. Does not add new files to the archive.
	synchronize: Update older files in the archive and add files that are not already in the archive.

	.PARAMETER format
	The compress format, ZIP (Default) or 7z format.

	.PARAMETER password
	The password for the archive.

	.EXAMPLE
	Start-SYNOFSArchiveCompress -path /home/docs -dest_file_path /home/backup

	Starts compress of docs folder

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding(SupportsShouldProcess)]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string[]]$path,

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$dest_file_path,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("moderate", "store", "fastest", "best")]
		[string]$level,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("add", "update", "refreshen", "synchronize")]
		[string]$mode,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("zip", "7z")]
		[string]$format,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[securestring]$password

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Compress"
			method  = "start"
			version = "3"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

		#deal with SecureString Password
		If ($PSBoundParameters.ContainsKey("password")) {

			#Include decoded password in request
			$Parameters["password"] = $(ConvertTo-InsecureString -SecureString $password)

		}

		#Construct Request URI
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter)"

		if ($PSCmdlet.ShouldProcess($($Parameters["api"]), "Invoke Method: '$($Parameters["method"])'")) {

			#Send Request
			$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

			If ($Response) {
				$Response

			}

		}

	}#process

	END { }#end

}