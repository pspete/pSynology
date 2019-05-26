function Rename-SYNOFSItem {
	<#
	.SYNOPSIS
	Rename a file/folder.

	.DESCRIPTION
	Invokes the "rename" method of SYNO.FileStation.Rename

	.PARAMETER path
	One or more paths of files/folders to be renamed.
	The number of paths must be the same as the number of names in the name parameter.
	The first path parameter corresponds to the first name parameter.

	.PARAMETER name
	One or more new names, separated by commas.
	The number of names must be the same as the number of folder paths in the path parameter.
	The first name parameter corresponding to the first path parameter.

	.PARAMETER additional
	Additional requested file information.

	.EXAMPLE
	Rename-SYNOFSItem -path /home/docs/document.doc -name document2.doc

	Renames document.doc to document2.doc

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

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false
		)]
		[string[]]$name,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("real_path", "size", "owner", "time", "perm", "type")]
		[string[]]$additional

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Rename"
			method  = "rename"
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

		#Send Request
		$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

		If ($Response) {
			$Response.files
		}

	}#process

	END { }#end

}