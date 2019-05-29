function Start-SYNOFSDeleteItem {
	<#
	.SYNOPSIS
	Delete file(s)/folder(s)

	.DESCRIPTION
	Invokes the "start" method of SYNO.FileStation.Delete

	.PARAMETER path
	One or more deleted file/folder paths starting with a shared folder.

	.PARAMETER accurate_progress
	“true”: calculates the progress of each deleted file with the sub-folder recursively;
	“false”: calculates the progress of files which you give in path parameters. (faster, but less precise).

	.PARAMETER recursive
	“true”: Recursively delete files within a folder.
	“false”: Only delete first-level file/folder.  If a deleted folder contains any file,
	an error occurs because the folder cannot be directly deleted.

	.PARAMETER search_taskid
	A unique ID for the search task

	.EXAMPLE
	Start-SYNOFSDeleteItem -path /home/docs/old/

	Starts task for deletion of /home/docs/old/

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding(SupportsShouldProcess)]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$path,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[boolean]$accurate_progress,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[boolean]$recursive,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$search_taskid

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Delete"
			method  = "start"
			version = "2"
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