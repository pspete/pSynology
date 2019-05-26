function Start-SYNOFSArchiveExtract {
	<#
	.SYNOPSIS
	Start to extract an archive.

	.DESCRIPTION
	Invokes the "start" method of SYNO.FileStation.Extract

	.PARAMETER file_path
	A file path of an archive to be extracted, starting with a shared folder

	.PARAMETER dest_folder_path
	A destination folder path starting with a shared folder to which the archive will be extracted.

	.PARAMETER overwrite
	Whether or not to overwrite if the extracted file exists in the destination folder.

	.PARAMETER keep_dir
	Whether to keep the folder structure within an archive.

	.PARAMETER create_subfolder
	Whether to create a subfolder with an archive name which archived files are extracted to.

	.PARAMETER codepage
	The language codepage used for decoding file name with an archive.

	.PARAMETER password
	The password for extracting the file.

	.PARAMETER item_id
	Item IDs of archived files used for extracting files within an archive

	.EXAMPLE
	Start-SYNOFSArchiveExtract -file_path /home/backup/docs.zip -dest_folder_path /home

	Starts extraction of the docs.zip archive.

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
		[string]$file_path,

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$dest_folder_path,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[boolean]$overwrite,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[boolean]$keep_dir,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[boolean]$create_subfolder,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("enu", "cht", "chs", "krn", "ger", "fre", "ita", "spn", "jpn", "dan", "nor", "sve", "nld", "rus", "plk", "ptb", "ptg", "hun", "trk", "csy")]
		[string]$codepage,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[securestring]$password,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[string]$item_id
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Extract"
			method  = "start"
			version = "2"
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