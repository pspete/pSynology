#Get Current Directory
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

#Get Function Name
$FunctionName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -Replace ".Tests.ps1"

#Assume ModuleName from Repository Root folder
$ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf

#Resolve Path to Module Directory
$ModulePath = Resolve-Path "$Here\..\$ModuleName"

#Define Path to Module Manifest
$ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

if ( -not (Get-Module -Name $ModuleName -All)) {

	Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

}

BeforeAll {


}

AfterAll {


}

Describe $FunctionName {

	InModuleScope $ModuleName {

		Context "Default" {

			BeforeEach {

				$MockError = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$MockError | Add-Member -MemberType NoteProperty -Name StatusCode -Value 409 -Force
				$MockError | Add-Member -MemberType NoteProperty -Name Headers -Value @{ "Content-Type" = "application/json" } -Force
				$MockError | Add-Member -MemberType NoteProperty -Name StatusDescription -Value "Some Error" -Force

				$MockJSONSuccess = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$MockJSONSuccess | Add-Member -MemberType NoteProperty -Name StatusCode -Value 200 -Force
				$MockJSONSuccess | Add-Member -MemberType NoteProperty -Name Headers -Value @{ "Content-Type" = 'application/json; charset="UTF-8"' } -Force
				$MockJSONSuccess | Add-Member -MemberType NoteProperty -Name Content -Value (@{"success" = "true"; "data" = "some value"; "error" = "some error" } | ConvertTo-Json) -Force

				$MockJSONError = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$MockJSONError | Add-Member -MemberType NoteProperty -Name StatusCode -Value 200 -Force
				$MockJSONError | Add-Member -MemberType NoteProperty -Name Headers -Value @{ "Content-Type" = 'application/json; charset="UTF-8"' } -Force
				$MockJSONError | Add-Member -MemberType NoteProperty -Name Content -Value (@{"success" = "false"; "data" = "some value"; "error" = "some error" } | ConvertTo-Json) -Force

				$MockTextSuccess = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$MockTextSuccess | Add-Member -MemberType NoteProperty -Name StatusCode -Value 200 -Force
				$MockTextSuccess | Add-Member -MemberType NoteProperty -Name Headers -Value @{ "Content-Type" = 'text/plain; charset="UTF-8"' } -Force
				$MockTextSuccess | Add-Member -MemberType NoteProperty -Name Content -Value (@{"success" = "true"; "data" = "some value"; "error" = "some error" } | ConvertTo-Json) -Force

				$MockTextError = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$MockTextError | Add-Member -MemberType NoteProperty -Name StatusCode -Value 200 -Force
				$MockTextError | Add-Member -MemberType NoteProperty -Name Headers -Value @{ "Content-Type" = 'text/plain; charset="UTF-8"' } -Force
				$MockTextError | Add-Member -MemberType NoteProperty -Name Content -Value (@{"success" = "false"; "data" = "some value"; "error" = "some error" } | ConvertTo-Json) -Force

				$MockDefault = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$MockDefault | Add-Member -MemberType NoteProperty -Name StatusCode -Value 200 -Force
				$MockDefault | Add-Member -MemberType NoteProperty -Name Headers -Value @{ "Content-Type" = 'something else' } -Force
				$MockDefault | Add-Member -MemberType NoteProperty -Name Content -Value (@{"success" = "true"; "data" = "some value"; "error" = "some error" } | ConvertTo-Json) -Force


			}

			It "Handles Non 20* Status Codes" { $MockError | Get-Response }
			It "Handles JSON success responses" { $MockJSONSuccess | Get-Response | Should Be "some value" }
			It "Handles JSON error responses" { { $MockJSONError | Get-Response } | should throw }
			It "Handles text success responses" { $MockTextSuccess | Get-Response | Should Be "some value" }
			It "Handles text error responses" { { $MockTextError | Get-Response } | should throw }
			It "By default returns Content of Web Response" { $MockDefault | Get-Response | should be $(@{"success" = "true"; "data" = "some value"; "error" = "some error" } | ConvertTo-Json) }

		}

	}

}