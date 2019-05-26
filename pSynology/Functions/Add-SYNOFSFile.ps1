function Add-SYNOFSFile {
	<#
	.SYNOPSIS
	Upload a file

	.DESCRIPTION
	Invokes the "upload" method of SYNO.FileStation.Upload

	.PARAMETER path
	A file path started with a shared folder.

	.PARAMETER create_parents
	Create parent folder(s) if none exist.

	.PARAMETER overwrite
	The value could be one of following:
	true: overwrite the destination file if one exists
	false: skip the upload if the destination file exists
	(None): when not specified, the upload will be respond with an error when the destination file exists

	.PARAMETER mtime
	Set last modify time of the uploaded file

	.PARAMETER crtime
	Set the create time of the uploaded file

	.PARAMETER atime
	Set last access time of the uploaded file

	.PARAMETER filename
	File content ##TODO

	.EXAMPLE
	Add-SYNOFSFile -path /home/docs/ -filename ./doc1.doc

	Uploads doc1.doc to the /home/docs/ folder

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