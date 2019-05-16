function Start-FSDeleteItem {

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string[]]$path,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[boolean]$accurate_progress,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[boolean]$recursive,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[string]$search_taskid

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Delete"
			method  = "start"
			version = "2"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

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