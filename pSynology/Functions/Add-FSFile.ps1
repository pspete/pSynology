function Add-FSFile {

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$path,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[boolean]$create_parents,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[boolean]$overwrite,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[datetime]$mtime,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[datetime]$crtime,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[datetime]$atime,

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$filename

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Upload"
			method  = "upload"
			version = "2"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

		$TimeParameters = @("mtime", "crtime", "atime")

	}#begin

	PROCESS {

		## TODO - multipart/form-data
		#? https://get-powershellblog.blogspot.com/2017/09/multipartform-data-support-for-invoke.html
		$Parameters = $Parameters + $PSBoundParameters

		foreach ($TimeParameter in $TimeParameters) {

			if ($PSBoundParameters.ContainsKey("$TimeParameter")) {

				#convert to unix time
				$Parameters["$TimeParameter"] = Get-Date $($PSBoundParameters["$TimeParameter"]) -UFormat %s

			}

		}

		#Construct Request URI
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter -ParametersToRemove filename)"

		#Send Request
		$Response = Invoke-Request -Uri $URI -Method POST -WebSession $ThisSession

		If ($Response) {
			$Response
		}

	}#process

	END { }#end

}