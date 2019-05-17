function Clear-FSBackgroundTask {

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[string[]]$taskid

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.BackgroundTask"
			method  = "clear_finished"
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