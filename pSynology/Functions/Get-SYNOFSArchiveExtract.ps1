function Get-SYNOFSArchiveExtract {
	<#
	.SYNOPSIS
	Get the extract task status

	.DESCRIPTION
	Invokes the "status" method of SYNO.FileStation.Extract

	.PARAMETER taskid
	Unique ID of the task

	.EXAMPLE
	Get-SYNOFSArchiveExtract -taskid 5CDC455CE78D0CF0

	Returns the status of archive extract task with id 5CDC455CE78D0CF0

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
			api     = "SYNO.FileStation.Extract"
			method  = "status"
			version = "2"
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