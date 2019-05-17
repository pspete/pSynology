function Start-FSArchiveExtract {

	[CmdletBinding(SupportsShouldProcess)]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$file_path,

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$dest_folder_path,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[boolean]$overwrite,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[boolean]$keep_dir,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[boolean]$create_subfolder,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("enu", "cht", "chs", "krn", "ger", "fre", "ita", "spn", "jpn", "dan", "nor", "sve", "nld", "rus", "plk", "ptb", "ptg", "hun", "trk", "csy")]
		[string]$codepage,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[securestring]$password,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[string]$item_id
	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Extract"
			method  = "start"
			version = "2"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

		#deal with SecureString Password
		If ($PSBoundParameters.ContainsKey("password")) {

			#Include decoded password in request
			$Parameters["password"] = $(ConvertTo-InsecureString -SecureString $password)

		}

		#Construct Request URI
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter)"

		if ($PSCmdlet.ShouldProcess($($Parameters["api"]), "Invoke Method: '$($Parameters["method"])'")) {

			#Send Request
			$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

			If ($Response) {
				$Response

			}

		}

	}#process

	END { }#end

}