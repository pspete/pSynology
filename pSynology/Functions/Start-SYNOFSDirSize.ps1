function Start-SYNOFSDirSize {
	<#
	.SYNOPSIS
	Start to calculate size for one or more file/folder paths.

	.DESCRIPTION
	Invokes the "start" method of SYNO.FileStation.DirSize

	.PARAMETER path
	One or more file/folder paths starting with a shared folder.

	.EXAMPLE
	Start-SYNOFSDirSize -path /home/docs

	Start to calculate size for /home/docs

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
		[string[]]$path

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.DirSize"
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