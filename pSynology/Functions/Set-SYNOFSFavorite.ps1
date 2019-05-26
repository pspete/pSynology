function Set-SYNOFSFavorite {
	<#
	.SYNOPSIS
	Edit a favourite name.

	.DESCRIPTION
	Invokes the "edit" method of SYNO.FileStation.Favorite

	.PARAMETER path
	A folder path starting with a shared folder is edited from a user's favourites.

	.PARAMETER name
	New favorite name.

	.EXAMPLE
	Set-SYNOFSFavorite -path /home/docs -name documents

	Updates favourite's name to "documents"

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding(SupportsShouldProcess)]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$path,

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false
		)]
		[string]$name

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Favorite"
			method  = "edit"
			version = "2"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

		#Construct Request URI
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter)"

		if ($PSCmdlet.ShouldProcess($($Parameters["api"]), "Invoke Method: '$($Parameters["method"])'")) {

			#Send Request
			$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

			If ($Response) {
				$Response
			}

		}

	}#process

	END { }#end

}