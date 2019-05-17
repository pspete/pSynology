function Remove-FSFavorite {

	[CmdletBinding(SupportsShouldProcess)]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$path
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Favorite"
			method  = "delete"
			version = "2"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

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