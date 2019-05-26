function Get-SYNOFSVirtualFolder {
	<#
	.SYNOPSIS
	List all mount point folders on one given type of virtual file system

	.DESCRIPTION
	Invokes the "list" method of SYNO.FileStation.VirtualFolder

	.PARAMETER type
	The type of virtual file system

	.PARAMETER offset
	Specify how many mount point folders are skipped before beginning to return
	listed mount point folders in virtual file system.

	.PARAMETER limit
	Number of mount point folders requested.

	.PARAMETER sort_by
	Specify which file information to sort on.

	.PARAMETER sort_direction
	Specify to sort ascending or to sort descending.

	.PARAMETER additional
	Additional requested file information.

	.EXAMPLE
	Get-SYNOFSVirtualFolder

	Lists all mount point folders

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

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

		#Send Request
		$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

		If ($Response) {
			$Response.folders
		}

	}#process

	END { }#end

}