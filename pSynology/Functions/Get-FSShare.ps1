function Get-FSShare {

	[CmdletBinding()]
	param(

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
		[ValidateSet("name", "user", "group", "mtime", "atime", "ctime", "crtime", "posix")]
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
		[boolean]$onlywritable,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("real_path", "owner", "time", "perm", "mount_point_type", "sync_share", "volume_status")]
		[string[]]$additional
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.List"
			method  = "list_share"
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
			$Response.shares
		}

	}#process

	END { }#end

}