function New-SYNOFSFolder {
	<#
	.SYNOPSIS
	Create folders

	.DESCRIPTION
	Invokes the "create" method of SYNO.FileStation.CreateFolder

	.PARAMETER folder_path
	One or more shared folder paths.
	The number of paths must be the same as the number of names in the name parameter.
	The first folder_path parameter corresponds to the first name parameter.

	.PARAMETER name
	One or more new folder names.
	The number of names must be the same as the number of folder paths in the folder_path parameter.
	The first name parameter corresponding to the first folder_path parameter.

	.PARAMETER force_parent
	“true”: no error occurs if a folder exists and make parent folders as needed;
	“false”: parent folders are not created.

	.PARAMETER additional
	Additional requested file information.

	.EXAMPLE
	New-SYNOFSFolder -folder_path /home/docs -name pwsh

	creates folder /home/docs/pwsh

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
		[string[]]$folder_path,

		[Parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[string[]]$name,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[boolean]$force_parent,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet("real_path", "size", "owner", "time", "perm", "type")]
		[string[]]$additional

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.CreateFolder"
			method  = "create"
			version = "2"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

	}#begin

	PROCESS {

		If (($PSBoundParameters["folder_path"].count) -ne $($PSBoundParameters["name"].count)) {
			Throw "Count of 'path' & 'name' values must be equal"
		}

		$Parameters = $Parameters + $PSBoundParameters

		#Construct Request URI
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter)"

		if ($PSCmdlet.ShouldProcess($($Parameters["api"]), "Invoke Method: '$($Parameters["method"])'")) {

			#Send Request
			$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

			If ($Response) {
				$Response.folders
			}

		}

	}#process

	END { }#end

}