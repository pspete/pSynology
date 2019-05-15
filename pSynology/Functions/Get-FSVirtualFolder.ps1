function Get-FSVirtualFolder {

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("NFS", "CIFS", "ISO")]
		[string]$type,

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
		[ValidateSet("real_path", "size", "owner", "time", "perm", "volume_status")]
		[string[]]$additional
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.VirtualFolder"
			method  = "list"
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
			$Response.folders
		}

	}#process

	END { }#end

}