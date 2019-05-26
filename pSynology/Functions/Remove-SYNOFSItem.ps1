function Remove-SYNOFSItem {
	<#
	.SYNOPSIS
	Delete files/folders.

	.DESCRIPTION
	Invokes the "delete" method of SYNO.FileStation.Delete
	This is a blocking method. The response is not returned until the deletion operation is completed.

	.PARAMETER path
	One or more deleted file/folder path(s) started with a shared folder.

	.PARAMETER recursive
	“true”: Recursively delete files within a folder.
	“false”: Only delete first-level file/folder. If a deleted folder contains any file,
	an error will occur because the folder cannot be directly deleted.

	.PARAMETER search_taskid
	A unique ID for the search task

	.EXAMPLE
	Remove-SYNOFSItem -path /home/docs/document.doc

	Deletes document.doc

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
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[boolean]$recursive,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[string]$search_taskid

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Delete"
			method  = "delete"
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