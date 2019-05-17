function Clear-FSSharingLink {

	[CmdletBinding()]
	param( )

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Sharing"
			method  = "clear_invalid"
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