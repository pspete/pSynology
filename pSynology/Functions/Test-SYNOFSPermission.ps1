function Test-SYNOFSPermission {
	<#
	.SYNOPSIS
	Check if a logged-in user has write permission to create new files/folders in a given folder

	.DESCRIPTION
	Invokes the "write" method of SYNO.FileStation.CheckPermission

	.PARAMETER path
	A file path started with a shared folder.

	.PARAMETER filename
	A filename you want to write to a given path

	.PARAMETER overwrite
	The value can be either below:
	true: overwrite the destination file if it exists.
	false: skip if the destination file exists.
	(When the value is not specified as true or false, it will respond with error if the destination file exists.)

	.PARAMETER create_only
	The permission will be allowed when there is non-existent file/folder.

	.EXAMPLE
	Test-SYNOFSPermission -path /home/docs -filename document.doc

	Checks if logged-in user has write permission on document.doc

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$path,

		[parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[string]$filename,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[boolean]$overwrite,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[boolean]$create_only

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.CheckPermission"
			method  = "write"
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