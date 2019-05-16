function Start-FSArchiveCompress {

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string[]]$path,

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$dest_file_path,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("moderate", "store", "fastest", "best")]
		[string]$level,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("add", "update", "refreshen", "synchronize")]
		[string]$mode,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("zip", "7z")]
		[string]$format,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[securestring]$password

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Compress"
			method  = "start"
			version = "3"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

		## TODO - securestring Conversion

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