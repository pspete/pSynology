function Add-SYNOFSFavorite {
	<#
	.SYNOPSIS
	Add a folder to user's favourites

	.DESCRIPTION
	Invokes the "add" method of SYNO.FileStation.Favorite

	.PARAMETER path
	A folder path starting with a shared folder is added to the user's favourites.

	.PARAMETER name
	A favourite name.

	.PARAMETER index
	Index of location of an added favourite.

	.EXAMPLE
	Add-SYNOFSFavorite -path /home/docs -name docs

	Adds favourite "docs"

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$path,

		[Parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$name,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[int]$index
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Favorite"
			method  = "add"
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