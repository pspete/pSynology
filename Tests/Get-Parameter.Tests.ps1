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

Describe $FunctionName {

	InModuleScope $ModuleName {

		[array]$CommonParameters += [System.Management.Automation.PSCmdlet]::CommonParameters
		[array]$CommonParameters += [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
		[hashtable]$InputParams = @{"KeepThis" = "Kept"; "RemoveThis" = "Removed" }

		$CommonParameters | ForEach-Object { $InputParams.Add($_, "something") }

		$ReturnData = $InputParams | Get-Parameter -ParametersToRemove RemoveThis

		It 'returns a string' {

			$ReturnData | Should BeOfType System.String

		}

		$CommonParameters | ForEach-Object {

			It "does not include $_ in return data" {

				$ReturnData[$_] | Should BeNullOrEmpty

			}

		}

		It 'returns expected value' {
			$ReturnData | Should Be "KeepThis=Kept"
		}

	}

}