function Get-SYNOFSFileInfo {
	<#
	.SYNOPSIS
	Get information of file(s)

	.DESCRIPTION
	Invokes the "getinfo" method of SYNO.FileStation.List

	.PARAMETER path
	A file path started with a shared folder.

	.PARAMETER additional
	Additional requested file information.

	.EXAMPLE
	Get-SYNOFSFileInfo -path /DDSM1/Datastore/@S2S/event.sqlite

	Get information of event.sqlite file

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
		[string[]]$path,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("real_path", "size", "owner", "time", "perm", "type" , "mount_point_type")]
		[string[]]$additional
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.List"
			method  = "getinfo"
			version = "2"
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
			$Response.files
		}

	}#process

	END { }#end

}