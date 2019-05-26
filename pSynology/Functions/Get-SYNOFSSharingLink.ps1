function Get-SYNOFSSharingLink {
	<#
	.SYNOPSIS
	List user’s file sharing links.

	.DESCRIPTION
	Invokes the "list" method of SYNO.FileStation.Sharing

	.PARAMETER offset
	Specify how many sharing links are skipped before beginning to return listed sharing links.

	.PARAMETER limit
	Number of sharing links requested

	.PARAMETER sort_by
	Specify information of the sharing link to sort on.

	.PARAMETER sort_direction
	Specify to sort ascending or to sort descending.

	.PARAMETER force_clean
	If set to false, the data will be retrieval from cache database rapidly. If set to true,
	all sharing information including sharing statuses and user name of sharing owner will be synchronized.

	.EXAMPLE
	Get-SYNOFSSharingLink

	List all of the user’s file sharing links.

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

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[ValidateSet("id", "name", "isFolder", "path", "date_expired", "date_available", "status", "has_password", "url", "link_owner")]
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
		[boolean]$force_clean

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Sharing"
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
			$Response.links
		}

	}#process

	END { }#end

}