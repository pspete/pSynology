function Invoke-Request {
	<#
.SYNOPSIS
Wrapper for Invoke-WebRequest to invoke API method

.DESCRIPTION
Sends requests to web services, and where appropriate returns structured data.
Acts as wrapper for the Invoke-WebRequest CmdLet so that status codes can be
queried and acted on.
All requests are sent with ContentType=application/json.
If the sessionVariable parameter is passed, the function will return a WebSession
object to be used on subsequent calls to the web service.

.PARAMETER Method
The method for request

.PARAMETER URI
The address of the API or service to send the request to.

.PARAMETER Body
The body of the request to send to the API

.PARAMETER Headers
The header of the request to send to the API.

.PARAMETER SessionVariable
If passed, will be sent to invoke-webrequest which in turn will create a websession
variable using the string value as the name. This variable will only exist in the current scope
so will be returned as a WebSession property in the output object.
Cannot be specified with WebSession

.PARAMETER WebSession
Accepts a WebRequestSession object containing session details
Cannot be specified with SessionVariable

.EXAMPLE

.INPUTS

.OUTPUTS
Return data from the API where content is returned
Will additionally contain a WebSession property containing a WebRequestSession object if SessionVariable
parameter was specified.

.NOTES
SessionVariable/WebSession functionality should be used where the API exists behind a load balancer
to ensure session persistence.

.LINK

#>
	[CmdletBinding(DefaultParameterSetName = "WebSession")]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateSet('GET', 'POST', 'PUT', 'DELETE', 'PATCH')]
		[String]$Method,

		[Parameter(Mandatory = $true)]
		[String]$URI,

		[Parameter(Mandatory = $false)]
		[String]$Body,

		[Parameter(Mandatory = $false)]
		[hashtable]$Headers,

		[Parameter(
			Mandatory = $false,
			ParameterSetName = "SessionVariable"
		)]
		[String]$SessionVariable,

		[Parameter(
			Mandatory = $false,
			ParameterSetName = "WebSession"
		)]
		[Microsoft.PowerShell.Commands.WebRequestSession]$WebSession
	)

	Begin {

		#Get the name of the function which invoked this one
		$CommandOrigin = Get-ParentFunction | Select-Object -ExpandProperty FunctionName
		Write-Debug "Function: $($MyInvocation.InvocationName)"
		Write-Debug "Invocation Origin: $CommandOrigin"

		#Add ContentType for all function calls
		$PSBoundParameters.Add("ContentType", 'application/json')
		#$PSBoundParameters.Add("UseBasicParsing", $true)

		#Bypass strict RFC header parsing in PS Core
		if ($PSVersionTable.PSEdition -eq "Core") {

			$PSBoundParameters.Add("SkipHeaderValidation", $true)
			$PSBoundParameters.Add("SslProtocol", "TLS12")

		}

		#If Tls12 Security Protocol is available
		if (([Net.SecurityProtocolType].GetEnumNames() -contains "Tls12") -and

			#And Tls12 is not already in use
			(-not ([System.Net.ServicePointManager]::SecurityProtocol -match "Tls12"))) {

			Write-Verbose "Setting Security Protocol to TLS12"
			[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

		}

		Else {

			Write-Debug "Security Protocol: $([System.Net.ServicePointManager]::SecurityProtocol)"

		}

	}

	Process {

		#make web request, splat PSBoundParameters
		$Response = Invoke-WebRequest @PSBoundParameters -ErrorAction Stop

		#If Session Variable passed as argument
		If ($PSCmdlet.ParameterSetName -eq "SessionVariable") {

			#Make WebSession available in module scope
			Set-Variable -Name ThisSession -Value $(Get-Variable $(Get-Variable sessionVariable).Value).Value -Scope Script

		}

		$Response | Get-Response

	}

}
