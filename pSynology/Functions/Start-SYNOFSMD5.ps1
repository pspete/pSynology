function Start-SYNOFSMD5 {
	<#
	.SYNOPSIS
	Start to get MD5 of a file

	.DESCRIPTION
	Invokes the "start" method of SYNO.FileStation.MD5

	.PARAMETER file_path
	A file path starting with a shared folder

	.EXAMPLE
	Start-SYNOFSMD5 -file_path /home/docs/document.doc

	Starts task to get MD5 of file document.doc

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding(SupportsShouldProcess)]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$file_path

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.MD5"
			method  = "start"
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