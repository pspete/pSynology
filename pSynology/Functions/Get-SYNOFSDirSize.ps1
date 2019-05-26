function Get-SYNOFSDirSize {
	<#
	.SYNOPSIS
	Get the status of the size calculating task

	.DESCRIPTION
	Invokes the "status" method of SYNO.FileStation.DirSize

	.PARAMETER taskid
	Unique ID of the task

	.EXAMPLE
	Get-SYNOFSDirSize -taskid 5CDC455CE78D0CF0

	Get the status of the size calculating task with id 5CDC455CE78D0CF0

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
			api     = "SYNO.FileStation.DirSize"
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
			## TODO Size Calculations
		}

	}#process

	END { }#end

}