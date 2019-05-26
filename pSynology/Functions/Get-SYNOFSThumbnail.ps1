function Get-SYNOFSThumbnail {
	<#
	.SYNOPSIS
	Get a thumbnail of a file.

	.DESCRIPTION
	Invokes the "get" method of SYNO.FileStation.Thumb

	1. Supported image formats: jpg, jpeg, jpe, bmp, png, tif, tiff, gif, arw, srf, sr2, dcr, k25, kdc,
	cr2, crw, nef, mrw, ptx, pef, raf, 3fr, erf, mef, mos, orf, rw2, dng, x3f, raw

	2. Supported video formats in an indexed folder: 3gp, 3g2, asf, dat, divx, dvr-ms, m2t, m2ts, m4v,
	mkv, mp4, mts, mov, qt, tp, trp, ts, vob, wmv, xvid, ac3, amr, rm, rmvb, ifo, mpeg, mpg, mpe, m1v,
	m2v, mpeg1, mpeg2, mpeg4, ogv, webm, flv, f4v, avi, swf, vdr, iso

	Video thumbnails exist only if video files are placed in the “photo” shared folder or users'
	home folders.

	.PARAMETER path
	A file path started with a shared folder.

	.PARAMETER size
	Return different size thumbnail.

	Size Options:
	small: small-size thumbnail
	medium: medium-size thumbnail
	large: large-size thumbnail
	original: original-size thumbnail

	.PARAMETER rotate
	Return rotated thumbnail.

	Rotate Options:
	0: Do not rotate
	1: Rotate 90°
	2: Rotate 180°
	3: Rotate 270°
	4: Rotate 360°

	.PARAMETER OutputPath
	Path to output the thumbnail

	.EXAMPLE
	Get-SYNOFSThumbnail -path /home/docs/omar.png -OutputPath C:\Tmp\omar.png

	Saves thumbnail of file omar.png

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

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[ValidateSet("small", "medium", "large", "original")]
		[string]$size,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[ValidateRange(0, 4)]
		[int]$rotate,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript( { Test-Path -Path $_ -PathType Leaf -IsValid })]
		[string]$OutputPath

	)

	BEGIN {

		$Parameters = @{
			api     = "SYNO.FileStation.Thumb"
			method  = "get"
			version = "2"
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

			try {

				$output = @{
					Path     = $OutputPath
					Value    = $Response
					Encoding = "Byte"
				}

				If ($IsCoreCLR) {

					#amend parameters for splatting if we are in Core
					$output.Add("AsByteStream", $true)
					$output.Remove("Encoding")

				}

				#write it to a file
				Set-Content @output -ErrorAction Stop

			} catch { throw "Error Saving $OutputPath" }

		}

	}#process

	END { }#end

}