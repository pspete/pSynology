function Stop-SYNOFSSearch {
	<#
	.SYNOPSIS
	Stop the searching task(s).
	The search temporary database will not be deleted. It is possible to list the search result using list method after stopping it.

	.DESCRIPTION
	Invokes the "stop" method of SYNO.FileStation.Search

	.PARAMETER taskid
	Unique ID(s) for the search task(s)

	.EXAMPLE
	Stop-SYNOFSSearch taskid 5CDC455CE78D0CF0

	Stop search task with id 5CDC455CE78D0CF0

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
		[string]$taskid
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Search"
			method  = "stop"
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