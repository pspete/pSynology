function Remove-SYNOFSSearch {
	<#
	.SYNOPSIS
	Delete search temporary database(s)

	.DESCRIPTION
	Invokes the "clean" method of SYNO.FileStation.Search

	.PARAMETER taskid
	Unique ID(s) for the search task(s)

	.EXAMPLE
	Remove-SYNOFSSearch -taskid 5CDC455CE78D0CF0

	Deletes search task temporary database with id 5CDC455CE78D0CF0

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
		[string]$taskid
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Search"
			method  = "clean"
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