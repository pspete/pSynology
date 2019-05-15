function Get-Parameter {
	<#
.SYNOPSIS
Returns wanted parameter values from a passed $PSBoundParameters object

.DESCRIPTION
When passed a $PSBoundParameters hashtable, this function removes standard parameters
(like Verbose/Confirm etc) and returns the passed object with only the non-standard
parameters left in place.
This enables the returned object to be used to create the required JSON object to pass
to the CyberArk REST API.

.PARAMETER Parameters
This is the input object from which to remove the default set of parameters.
It is intended to accept the $PSBoundParameters object from another function.

.PARAMETER ParametersToRemove
Accepts an array of any additional parameter keys which should be removed from the passed input
object. Specifying additional parameter names/keys here means that the default value assigned
to the BaseParameters parameter will remain unchanged.

.EXAMPLE
$PSBoundParameters | Get-Parameter

.EXAMPLE
Get-Parameter -Parameters $PSBoundParameters -ParametersToRemove param1,param2

.INPUTS
$PSBoundParameters object

.OUTPUTS
Hashtable/$PSBoundParameters object, with defined parameters removed.

.NOTES

.LINK

#>
	[CmdletBinding()]
	[OutputType('System.String')]
	param(
		[parameter(
			Position = 0,
			Mandatory = $true,
			ValueFromPipeline = $true)]
		[ValidateNotNullOrEmpty()]
		[Hashtable]$Parameters,

		[parameter(
			Mandatory = $false)]
		[array]$ParametersToRemove = @()

	)

	BEGIN {

		Write-Debug "Function: $($MyInvocation.InvocationName)"
		#Collection of parameters which are to be excluded from the request URL
		[array]$CommonParameters += [System.Management.Automation.PSCmdlet]::CommonParameters
		[array]$CommonParameters += [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
		[array]$CommonParameters += "BaseURI", "Credential"
		[array]$QueryArgs = @()

	}#begin

	PROCESS {

		#Combine base parameters and any additional parameters to remove
		$UnwantedParameters = ($CommonParameters + $ParametersToRemove)

		#Enumerate bound parameters to build query string for URL
		$Parameters.keys | Where-Object { $UnwantedParameters -notcontains $_ } | ForEach-Object {

			#Get the parameter value
			$Value = $Parameters[$_]

			if ($_ -eq "additional") {

				#if the parameter name is "additional",
				#format the array value:
				#[comma, separated, string, enclosed, in, square, brackets]
				$Value = "[$($Parameters[$_] -join ",")]"

			}

			#Add parameter=escapedValue to $QueryArgs
			$QueryArgs += "$_=$([System.Uri]::EscapeDataString($Value))"



		}

		#Return URL query string
		$QueryArgs -join '&'

	}#process

	END {	}#end
}