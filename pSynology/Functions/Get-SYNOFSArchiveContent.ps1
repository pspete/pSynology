function Get-SYNOFSArchiveContent {
	<#
	.SYNOPSIS
	List contents of an archive

	.DESCRIPTION
	Invokes the "list" method of SYNO.FileStation.Extract

	.PARAMETER file_path
	An archive file path starting with a shared folder to list.

	.PARAMETER offset
	Specify how many archived files are skipped before beginning to return listed archived files in an archive.

	.PARAMETER limit
	Number of archived files requested.

	.PARAMETER sort_by
	Specify which archived file information to sort on.

	.PARAMETER sort_direction
	Specify to sort ascending or to sort descending.

	.PARAMETER codepage
	The language codepage used for decoding file name with an archive.

	.PARAMETER password
	The password for extracting the file.

	.PARAMETER item_id
	Item ID of an archived folder to be listed within an archive

	.EXAMPLE
	Get-SYNOFSArchiveContent -file_path /home/docs/archive.zip

	Lists the content of archive.zip

	.NOTES
	Author: Pete Maan
 	Twitter: @_psPete
	GitHub: https://github.com/pspete
	#>

	[CmdletBinding()]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[string]$file_path,

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

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateSet("name", "size", "pack_size", "mtime")]
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
			method  = "list"
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

		#Send Request
		$Response = Invoke-Request -Uri $URI -Method GET -WebSession $ThisSession

		If ($Response) {
			$Response.items
		}

	}#process

	END { }#end

}