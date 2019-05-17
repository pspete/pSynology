function Test-FSPermission {

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$path,

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$filename,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[boolean]$overwrite,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[boolean]$create_only

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.CheckPermission"
			method  = "write"
			version = "3"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

		#Construct Request URI
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter)"

		#Send Request
		$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

		If ($Response) {
			$Response
		}

	}#process

	END { }#end

}