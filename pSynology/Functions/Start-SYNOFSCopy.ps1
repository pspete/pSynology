function Start-SYNOFSCopy {
	<#
	.SYNOPSIS
	Start to copy files

	.DESCRIPTION
	Invokes the "start" method of SYNO.FileStation.CopyMove

	.PARAMETER path
	One or more copied file/folder path(s) starting with a shared folder

	.PARAMETER dest_folder_path
	A destination folder path where files/folders are copied.

	.PARAMETER overwrite
	“true”: overwrite all existing files with the same name;
	“false”: skip all existing files with the same name;
	(Not Specified): do not overwrite or skip existed files. If there is any existing files, an error occurs

	.PARAMETER remove_src
	(default) ”false”: copy files/folders
	“true”: move files/folders;

	.PARAMETER accurate_progress
	“true”: calculate the progress by each copied file within sub-folder.
	“false”: calculate the progress by files which you give in path parameters. (faster, but less precise).

	.PARAMETER search_taskid
	A unique ID for the search task

	.EXAMPLE
	Start-SYNOFSCopy -path /home/docs -dest_folder_path /volume1/backup

	Starts copy of contents of "docs" to "/volume1/backup"

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
		[boolean]$remove_src,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[boolean]$accurate_progress,

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$search_taskid


	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.CopyMove"
			method  = "start"
			version = "3"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

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