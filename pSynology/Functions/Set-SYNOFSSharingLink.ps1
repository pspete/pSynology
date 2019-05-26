function Set-SYNOFSSharingLink {
	<#
	.SYNOPSIS
	Edit sharing link(s)

	.DESCRIPTION
	Invokes the "edit" method of SYNO.FileStation.Sharing

	.PARAMETER id
	Unique ID(s) of sharing link(s) to edit

	.PARAMETER password
	If empty string is set, the password is removed.
	The max length of the password is 16 characters.

	.PARAMETER date_expired
	The expiration date for the sharing link

	.PARAMETER date_available
	The available date for the sharing link start effective

	.EXAMPLE
	Set-SYNOFSSharingLink -id 5CDC455CE78D0CF0 -date_expired $(Get-Date 1/1/2020)

	Sets expiry date on sharing link with id 5CDC455CE78D0CF0 to 1-1-2020

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
		[string[]]$id,

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false
		)]
		[ValidateScript( { $(($_ | ConvertTo-InsecureString).length) -le 16 })]
		[securestring]$password,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[datetime]$date_expired,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[datetime]$date_available

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Sharing"
			method  = "edit"
			version = "3"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

		$DateParameters = @("date_expired", "date_available")

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

		foreach ($DateParameter in $DateParameters) {

			if ($PSBoundParameters.ContainsKey("$DateParameter")) {

				#Convert DateParameter to string in Required format
				$Date = (Get-Date $DateParameter -Format yyyy-MM-dd).ToString()

				#Include date string in request
				$Parameters["$DateParameter"] = $Date

			}

		}

		#deal with SecureString Password
		If ($PSBoundParameters.ContainsKey("password")) {

			#Include decoded password in request
			$Parameters["password"] = $(ConvertTo-InsecureString -SecureString $password)

		}

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