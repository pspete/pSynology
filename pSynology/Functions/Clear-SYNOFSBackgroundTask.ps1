function Clear-SYNOFSBackgroundTask {
	<#
	.SYNOPSIS
	Delete all finished background tasks.

	.DESCRIPTION
	Invokes the "clear_finished" method of SYNO.FileStation.BackgroundTask

	.PARAMETER taskid
	Unique ID of the task

	.EXAMPLE
	Clear-SYNOFSBackgroundTask -taskid 5CDC455CE78D0CF0

	Deletes finished Background Task with ID 5CDC455CE78D0CF0

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[string[]]$taskid

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.BackgroundTask"
			method  = "clear_finished"
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