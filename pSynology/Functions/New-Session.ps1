function New-Session {

	[CmdletBinding(SupportsShouldProcess)]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[ValidateNotNullOrEmpty()]
		[PSCredential]$Credential,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[string]$session,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[ValidateSet("cookie", "sid")]
		[string]$format,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[int]$otp_code,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[string]$SessionVariable = "NewSession",

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $false
		)]
		[string]$BaseURI
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.API.Auth"
			method  = "login"
			version = "3"
		}

		$WebAPIPath = "/webapi/auth.cgi?"

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

		#Add user name from credential object
		$Parameters["account"] = $($Credential.UserName)
		#Add decoded password value from credential object
		$Parameters["passwd"] = $($Credential.GetNetworkCredential().Password)

		#Construct Request URI
		$URI = $BaseURI + $WebAPIPath + "$($Parameters | Get-Parameter)"

		if ($PSCmdlet.ShouldProcess($($Parameters["api"]), "Logon with User '$($Parameters["account"])'")) {

			#Send Logon Request
			$Response = Invoke-Request -Uri $URI -Method GET -SessionVariable $SessionVariable

			If ($Response) {
				Set-Variable -Name URL -Value $BaseURI -Scope Script
			}

		}

	}#process

	END { }#end

}
