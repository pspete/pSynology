function Remove-SYNOFSSharingLink {
	<#
	.SYNOPSIS
	Delete one or more sharing links.

	.DESCRIPTION
	Invokes the "delete" method of SYNO.FileStation.Sharing

	.PARAMETER id
	Unique IDs of file sharing link(s) to be deleted

	.EXAMPLE
	Remove-SYNOFSSharingLink -id 5CDC455CE78D0CF0

	Deletes Sharing Link with id 5CDC455CE78D0CF0

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
		[string[]]$id

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Sharing"
			method  = "delete"
			version = "3"
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