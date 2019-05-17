function Add-FSFavorite {

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$path,

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false
		)]
		[string]$name,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[int]$index
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Favorite"
			method  = "add"
			version = "2"
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