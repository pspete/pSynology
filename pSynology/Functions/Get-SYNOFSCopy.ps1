function Get-SYNOFSCopy {
	<#
	.SYNOPSIS
	Get the status of a copy operation

	.DESCRIPTION
	Invokes the "status" method of SYNO.FileStation.CopyMove

	.PARAMETER taskid
	Unique ID of the task

	.EXAMPLE
	Get-SYNOFSCopy -taskid 5CDC455CE78D0CF0

	Gets the status of copy operation with id 5CDC455CE78D0CF0

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$taskid

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.CopyMove"
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