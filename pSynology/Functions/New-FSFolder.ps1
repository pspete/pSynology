function New-FSFolder {

	[CmdletBinding(SupportsShouldProcess)]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string[]]$folder_path,

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false
		)]
		[string[]]$name,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[boolean]$force_parent,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
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