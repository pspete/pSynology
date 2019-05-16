function New-FSSharingLink {

	[CmdletBinding()]
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

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

		##TODO DateFormat YYY-MM-DD
		##TODO SecureString Conversion
		#? Password has 16 character limit

		#Construct Request URI
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter)"

		#Send Logon Request
		$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

		If ($Response) {
			$Response
		}

	}#process

	END { }#end

}