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

				$URL = "https://DiskStation_URL"

				$MockJSONSuccess = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$MockJSONSuccess | Add-Member -MemberType NoteProperty -Name StatusCode -Value 200 -Force
				$MockJSONSuccess | Add-Member -MemberType NoteProperty -Name Headers -Value @{ "Content-Type" = 'application/json; charset="UTF-8"' } -Force
				$MockJSONSuccess | Add-Member -MemberType NoteProperty -Name Content -Value (@{"success" = "true"; "data" = "some value"; "error" = "some error" } | ConvertTo-Json) -Force

				Mock Invoke-WebRequest -MockWith {
					$MockJSONSuccess
				}

				$InputObj = [PSCustomObject]@{
					"Path"  = "SomePath"
					"Name"  = "SomeName"
					"mtime" = $(Get-Date 1/1/2000)
					"id"    = "SomeID"
				}

			}

			It "does not throw" { { $InputObj | Remove-SYNOFSSharingLink } | Should Not throw }

			It "sends request" {

				$InputObj | Remove-SYNOFSSharingLink

				Assert-MockCalled Invoke-WebRequest -Times 1 -Exactly -Scope It

			}

		}

	}

}