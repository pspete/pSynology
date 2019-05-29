function Stop-SYNOFSMD5 {
	<#
	.SYNOPSIS
	Stop calculating the MD5 of a file

	.DESCRIPTION
	Invokes the "stop" method of SYNO.FileStation.MD5

	.PARAMETER taskid
	Unique ID of the task

	.EXAMPLE
	Stop-SYNOFSMD5 taskid 5CDC455CE78D0CF0

	Stop MD5 calculation task with id 5CDC455CE78D0CF0

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
			api     = "SYNO.FileStation.MD5"
			method  = "stop"
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

		if ($PSCmdlet.ShouldProcess($($Parameters["api"]), "Invoke Method: '$($Parameters["method"])'")) {

			If ($Response) {
				$Response
			}

		}

	}#process

	END { }#end

}