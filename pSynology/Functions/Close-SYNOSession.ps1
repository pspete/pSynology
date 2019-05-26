function Close-SYNOSession {
	<#
	.SYNOPSIS
	Logoff from an API session

	.DESCRIPTION
	Invokes the "logout" method of SYNO.API.Auth

	.PARAMETER session
	Session name to be logged out.

	.EXAMPLE
	Close-SYNOSession -session Filestation

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding(SupportsShouldProcess)]
	param(

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false
		)]
		[string]$session
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.API.Auth"
			method  = "logout"
			version = "1"
		}

		$WebAPIPath = "/webapi/auth.cgi?"

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

		#Construct Request URI
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter)"

		if ($PSCmdlet.ShouldProcess($($Parameters["api"]), "Logout $URL")) {

			#Send Request
			$Session = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

			#If Logon Result
			If ($Session) {

				$Session

			}

		}

	}#process

	END { }#end

}
