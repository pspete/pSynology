function Rename-FSItem {

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string[]]$path,

		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $false
		)]
		[string[]]$name,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("real_path", "size", "owner", "time", "perm", "type")]
		[string[]]$additional

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Rename"
			method  = "rename"
			version = "2"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

	}#begin

	PROCESS {

		If (($PSBoundParameters["path"].count) -ne $($PSBoundParameters["name"].count)) {
			Throw "Count of 'path' & 'name' values must be equal"
		}

		$Parameters = $Parameters + $PSBoundParameters

		#Construct Request URI
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter)"

		#Send Request
		$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

		If ($Response) {
			$Response.files
		}

	}#process

	END { }#end

}