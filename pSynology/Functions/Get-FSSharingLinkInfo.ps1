function Get-FSSharingLinkInfo {

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$id

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Sharing"
			method  = "getinfo"
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