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

				$WebSession = New-Object -Type Microsoft.PowerShell.Commands.WebRequestSession
				$WebSession.Headers["test"] = "Expected"

				$MockJSONSuccess = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$MockJSONSuccess | Add-Member -MemberType NoteProperty -Name StatusCode -Value 200 -Force
				$MockJSONSuccess | Add-Member -MemberType NoteProperty -Name Headers -Value @{ "Content-Type" = 'application/json; charset="UTF-8"' } -Force
				$MockJSONSuccess | Add-Member -MemberType NoteProperty -Name Content -Value (@{"success" = "true"; "data" = "some value"; "error" = "some error" } | ConvertTo-Json) -Force

				Mock Invoke-WebRequest -MockWith {
					#Set-Variable -Name NewSession -Value $WebSession -Scope 0
					$MockJSONSuccess

				}

				$InputObj = [PSCustomObject]@{
					"Credential" = $(New-Object System.Management.Automation.PSCredential ("SomeUser", $(ConvertTo-SecureString "SomePassword" -AsPlainText -Force)))
					"BaseURI"    = "https://DiskStation_URL"
					"session"    = "SomeSession"
				}

			}

			It "does not throw" { { $InputObj | New-SYNOSession } | Should Not throw }

			It "sends request" {

				$InputObj | New-SYNOSession

				Assert-MockCalled Invoke-WebRequest -Times 1 -Exactly -Scope It

			}

			It "sets `$URL variable" {

				$InputObj | New-SYNOSession
				(Get-Variable -Name URL).Value | should be $InputObj.BaseURI

			}

		}

	}

}