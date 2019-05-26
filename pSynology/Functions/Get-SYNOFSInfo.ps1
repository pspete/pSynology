function Get-SYNOFSInfo {
	<#
	.SYNOPSIS
	Get File Station information

	.DESCRIPTION
	Invokes the "get" method of SYNO.FileStation.Info

	.EXAMPLE
	Get-SYNOFSInfo

	Returns File Station information

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding()]
	param()

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Info"
			method  = "get"
			version = "2"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

	}#begin

	PROCESS {

		#Construct Request URI
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter)"

		Write-Verbose $URI

		#Send Request
		$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

		If ($Response) {
			$Response
		}

	}#process

	END { }#end

}