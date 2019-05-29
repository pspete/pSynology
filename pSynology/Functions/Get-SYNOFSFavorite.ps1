function Get-SYNOFSFavorite {
	<#
	.SYNOPSIS
	List user's favourites

	.DESCRIPTION
	Invokes the "list" method of SYNO.FileStation.Favorite

	.PARAMETER offset
	Specify how many favourites are skipped before beginning to return user's favourites.

	.PARAMETER limit
	Number of favourites requested.

	.PARAMETER status_filter
	Show favourites with a given favourite status.

	.PARAMETER additional
	Additional requested information of a folder which a favourite links to.

	.EXAMPLE
	Get-SYNOFSFavorite

	List all favouritesfor the user

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[int]$offset,

		[Parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[int]$limit,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet("valid", "broken", "all")]
		[string]$status_filter,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet("real_path", "owner", "time", "perm", "mount_point_type")]
		[string[]]$additional
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Favorite"
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
			$Response.favorites
		}

	}#process

	END { }#end

}