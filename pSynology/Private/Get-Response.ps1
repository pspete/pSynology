function Get-Response {
	<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER WebResponse

.EXAMPLE

.EXAMPLE

.INPUTS

.OUTPUTS


.NOTES

.LINK

#>
	[CmdletBinding()]
	[OutputType('System.Object')]
	param(
		[parameter(
			Position = 0,
			Mandatory = $true,
			ValueFromPipeline = $true)]
		[ValidateNotNullOrEmpty()]
		[Microsoft.PowerShell.Commands.WebResponseObject]$WebResponse

	)

	BEGIN {

	}#begin

	PROCESS {

		#StatusCode/Description

		if ( -not ($WebResponse.StatusCode -match "20*")) {
			Write-Verbose $WebResponse.StatusCode
			Write-Verbose $WebResponse.StatusDescription
		}
		#200
		Else {

			Write-Debug "Content Type: $(($webResponse.headers)["Content-Type"])"
			#content
			switch (($webResponse.headers)["Content-Type"]) {

				'text/plain; charset="UTF-8"' {

					$Content = $webResponse.content | ConvertFrom-Json

					If ($Content.success -eq $false) { throw $($Content | Select-Object -ExpandProperty error) }
					ElseIf (($Content.success -eq $true) -and ($Content.data)) { $Content | Select-Object -ExpandProperty data }

				}

				'application/json; charset="UTF-8"' {
					Write-Verbose "here"
					$Content = $webResponse.content | ConvertFrom-Json

					If ($Content.success -eq $false) { throw $($Content | Select-Object -ExpandProperty error) }
					ElseIf ($Content.success -eq $true) { $Content | Select-Object -ExpandProperty data }

				}

				Default { $webResponse.content }

			}

		}

	}#process

	END {	}#end
}