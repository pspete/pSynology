function Get-FSSharingLink {

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[int]$offset,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[int]$limit,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[ValidateSet("id", "name", "isFolder", "path", "date_expired", "date_available", "status", "has_password", "url", "link_owner")]
		[string]$sort_by,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("asc", "desc")]
		[string]$sort_direction,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[boolean]$force_clean

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Sharing"
			method  = "list"
			version = "3"
		}

		$WebAPIPath = "/webapi/entry.cgi?"

	}#begin

	PROCESS {

		$Parameters = $Parameters + $PSBoundParameters

		#Construct Request URI
		$URI = $URL + $WebAPIPath + "$($Parameters | Get-Parameter)"

		#Send Request
		$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

		If ($Response) {
			$Response.links
		}

	}#process

	END { }#end

}