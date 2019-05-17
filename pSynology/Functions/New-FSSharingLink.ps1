function New-FSSharingLink {

	[CmdletBinding(SupportsShouldProcess)]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string[]]$path,

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
			method  = "create"
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

			#Send Logon Request
			$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

			If ($Response) {
				$Response
			}

		}

	}#process

	END { }#end

}