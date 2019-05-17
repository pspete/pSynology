function Get-FSFile {

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$folder_path,

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

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
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
		[string]$goto_path,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("real_path", "size", "owner", "time", "perm", "type" , "mount_point_type")]
		[string[]]$additional
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.List"
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
			$Response.files
		}

	}#process

	END { }#end

}