function Get-FSArchiveContent {

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$file_path,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[int]$offset,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[int]$limit,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("name", "size", "pack_size", "mtime")]
		[string]$sort_by,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("asc", "desc")]
		[string]$sort_direction,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("enu", "cht", "chs", "krn", "ger", "fre", "ita", "spn", "jpn", "dan", "nor", "sve", "nld", "rus", "plk", "ptb", "ptg", "hun", "trk", "csy")]
		[string]$codepage,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[securestring]$password,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[string]$item_id
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Extract"
			method  = "list"
			version = "2"
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
			$Response.items
		}

	}#process

	END { }#end

}