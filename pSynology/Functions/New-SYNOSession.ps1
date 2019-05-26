function New-SYNOSession {
	<#
	.SYNOPSIS
	Authenticate to Synology Diskstation and start a new API session.

	.DESCRIPTION
	Invokes the "login" method of SYNO.API.Auth

	.PARAMETER Credential
	Username & password to logon to the Synology API

	.PARAMETER session
	Login session name

	.PARAMETER format
	Returned format of session ID,the default value is cookie.

	.PARAMETER otp_code
	OTP verification code to log into DSM

	.PARAMETER SessionVariable
	Specified to create a web request session on logon.
	Web request session contains information about the the request, including cookies and the user agent string.
	Subsequently used to share state and data among other web requests made witht he module.

	.PARAMETER BaseURI
	Your DSM URL

	.EXAMPLE
	New-Session -Credential $(Get-Credential) -session FileStation -BaseURI https://diskstation

	Authenticate to Synology Diskstation and start a new API session.

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

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

			#Send Request
			$Response = Invoke-Request -Uri $URI -Method GET -SessionVariable $SessionVariable

			If ($Response) {
				Set-Variable -Name URL -Value $BaseURI -Scope Script
			}

		}

	}#process

	END { }#end

}
