function Get-SYNOInfo {
	<#
	.SYNOPSIS
	Get DiskStation API information

	.DESCRIPTION
	Invokes the "query" method of SYNO.API.Info

	.EXAMPLE
	Get-SYNOInfo

	Lists DiskStation API information

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding()]
	param()

	BEGIN {

		$Parameters = @{
			api     = "SYNO.API.Info"
			method  = "query"
			version = "1"
		}

		$WebAPIPath = "/webapi/query.cgi?"

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