function Get-FSSearch {

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$taskid,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[int]$offset,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[int]$limit,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("name", "size", "user", "group", "mtime", "atime", "ctime", "crtime", "posix", "type")]
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
		[string]$pattern,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("file", "dir", "all")]
		[string]$filetype,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("real_path", "size", "owner", "time", "perm", "type")]
		[string[]]$additional
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Search"
			method  = "list"
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