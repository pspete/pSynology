function Close-Session {

	[CmdletBinding(SupportsShouldProcess)]
	param(

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[string]$_sid
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
