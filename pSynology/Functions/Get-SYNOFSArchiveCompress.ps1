function Get-SYNOFSArchiveCompress {
	<#
	.SYNOPSIS
	Get the status of a compress task.

	.DESCRIPTION
	Invokes the "status" method of SYNO.FileStation.Compress

	.PARAMETER taskid
	Unique ID of the task

	.EXAMPLE
	Get-SYNOFSArchiveCompress -taskid 5CDC455CE78D0CF0

	Gets the status of compress task with id 5CDC455CE78D0CF0

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$taskid

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Compress"
			method  = "status"
			version = "3"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

		#Construct Request URI
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter)"

		#Send Request
		$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

		If ($Response) {
			$Response
		}

	}#process

	END { }#end

}