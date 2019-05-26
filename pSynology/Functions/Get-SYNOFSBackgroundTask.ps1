function Get-SYNOFSBackgroundTask {
	<#
	.SYNOPSIS
	List all background tasks including copy, move, delete, compress and extract tasks

	.DESCRIPTION
	Invokes the "list" method of SYNO.FileStation.BackgroundTask

	.PARAMETER offset
	Specify how many background tasks are skipped before beginning to return listed background tasks.

	.PARAMETER limit
	Number of background tasks requested.

	.PARAMETER sort_by
	Specify which information of the background task to sort on.

	.PARAMETER sort_direction
	Specify to sort ascending or to sort descending.

	.PARAMETER api_filter
	List background tasks for one or more given API name(s)
	If not specified, all background tasks are listed.

	Options include:
	SYNO.FileStation.CopyMove: copy/move tasks
	SYNO.FileStation.Delete: delete tasks
	SYNO.FileStation.Extract: extract tasks
	SYNO.FileStation.Compress: compress tasks

	.EXAMPLE
	Get-SYNOFSBackgroundTask

	Lists all background tasks

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
		[ValidateSet("crtime", "finished")]
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
		[ValidateSet("SYNO.FileStation.CopyMove", "SYNO.FileStation.Delete", "SYNO.FileStation.Extract", "SYNO.FileStation.Compress")]
		[string]$api_filter

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.BackgroundTask"
			method  = "list"
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
			$Response.tasks

		}

	}#process

	END { }#end

}