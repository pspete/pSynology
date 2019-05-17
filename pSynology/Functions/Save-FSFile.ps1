function Save-FSFile {

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$path,

		<#
		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
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