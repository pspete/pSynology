function Update-SYNOFSFavorite {
	<#
	.SYNOPSIS
	Replace multiple favourites of folders in the user's favourites.

	.DESCRIPTION
	Invokes the "replace_all" method of SYNO.FileStation.Favorite

	.PARAMETER path
	One or more folder paths starting with a shared folder.
	The number of paths must be the same as the number of favourite names in the name parameter.
	The first path parameter corresponds to the first name parameter.

	.PARAMETER name
	One or more new favourite names.
	The number of favourite names must be the same as the number of folder paths in the path parameter.
	The first name parameter corresponding to the first path parameter.

	.EXAMPLE
	Update-SYNOFSFavorite -path /home/docs -name documents

	Replaces user favourites

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
		[string[]]$path,

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false
		)]
		[string[]]$name

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Favorite"
			method  = "replace_all"
			version = "2"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

	}#begin

	PROCESS {

		If (($PSBoundParameters["path"].count) -ne $($PSBoundParameters["name"].count)) {
			Throw "Count of 'path' & 'name' values must be equal"
		}

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