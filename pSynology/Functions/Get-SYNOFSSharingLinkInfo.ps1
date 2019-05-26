function Get-SYNOFSSharingLinkInfo {
	<#
	.SYNOPSIS
	Get information of a sharing link by the sharing link ID

	.DESCRIPTION
	Invokes the "getinfo" method of SYNO.FileStation.Sharing

	.PARAMETER id
	A unique ID of a sharing link.

	.EXAMPLE
	Get-SYNOFSSharingLinkInfo -id 5CDC455CE78D0CF0

	Get information of sharing link with link ID 5CDC455CE78D0CF0

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$id

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Sharing"
			method  = "getinfo"
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
			$Response
		}

	}#process

	END { }#end

}