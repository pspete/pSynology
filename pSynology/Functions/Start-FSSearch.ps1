function Start-FSSearch {

	[CmdletBinding(SupportsShouldProcess)]
	param(

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[string]$folder_path,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[boolean]$recursive,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[string]$pattern,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[string]$extension,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("file", "dir", "all")]
		[string]$filetype,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[int]$size_from,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[int]$size_to,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[datetime]$mtime_from,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[datetime]$mtime_to,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[datetime]$crtime_from,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[datetime]$crtime_to,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[datetime]$atime_from,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[datetime]$atime_to,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[string]$owner,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[string]$group
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Search"
			method  = "start"
			version = "2"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

		$TimeParameters = @("mtime_from", "mtime_to", "crtime_from", "crtime_to", "atime_from", "atime_to")

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

		foreach ($TimeParameter in $TimeParameters) {

			if ($PSBoundParameters.ContainsKey("$TimeParameter")) {

				#convert to unix time
				$Parameters["$TimeParameter"] = Get-Date $($PSBoundParameters["$TimeParameter"]) -UFormat %s

			}

		}

		#Construct Request URI
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter)"

		if ($PSCmdlet.ShouldProcess($($Parameters["api"]), "Invoke Method: '$($Parameters["method"])'")) {

			#Send Request
			$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

			If ($Response) {
				$Response.taskid
			}

		}

	}#process

	END { }#end

}