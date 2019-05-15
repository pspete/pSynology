function Get-FSThumbnail {

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[string]$path,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[ValidateSet("small", "medium", "large", "original")]
		[string]$size,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateRange(0, 4)]
		[int]$rotate,

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
			api     = "SYNO.FileStation.Thumb"
			method  = "get"
			version = "2"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

		#Construct Request URI
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter)"

		#Send Logon Request
		$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

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

			} catch { throw "Error Saving $path" }

		}

	}#process

	END { }#end

}