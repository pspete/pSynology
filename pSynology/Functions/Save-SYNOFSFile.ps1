function Save-SYNOFSFile {
	<#
	.SYNOPSIS
	Download files/folders.

	.DESCRIPTION
	Invokes the "download" method of SYNO.FileStation.Download
	If only one file is specified, the file content is returned.
	If more than one file/folder is given, binary content in ZIP format is returned.

	.PARAMETER path
	One or more file/folder paths started with a shared folder.

	.PARAMETER OutputPath
	The output file path to save the file

	.EXAMPLE
	Save-SYNOFSFile -path /home/docs/document.doc -OutputPath ./document.doc

	Downloads document.doc

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

		<#
		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[ValidateSet("open", "download")]
		[string]$mode,
		#>

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript( { Test-Path -Path $_ -PathType Leaf -IsValid })]
		[string]$OutputPath

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Download"
			method  = "download"
			version = "2"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

		#Construct Request URI
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter -ParametersToRemove OutputPath)" + "&mode=%22download%22"

		#Send Request
		$Response = Invoke-Request -Uri $URI -Method POST -WebSession $ThisSession

		If ($Response) {

			try {

				$output = @{
					Path     = $OutputPath
					Value    = $Response
					Encoding = "Byte"
				}

				If ($IsCoreCLR) {

					#amend parameters for splatting if we are in Core
					$output.Add("AsByteStream", $true)
					$output.Remove("Encoding")

				}

				#write it to a file
				Set-Content @output -ErrorAction Stop

			} catch { throw "Error Saving $OutputPath" }

		}

	}#process

	END { }#end

}