function Clear-SYNOFSSharingLink {
	<#
	.SYNOPSIS
	Remove all expired and broken sharing links

	.DESCRIPTION
	Invokes the "clear_invalid" method of SYNO.FileStation.Sharing

	.EXAMPLE
	Clear-SYNOFSSharingLink

	Removes all expired or broken sharing links

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding()]
	param( )

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Sharing"
			method  = "clear_invalid"
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