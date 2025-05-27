[cmdletbinding()]
param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)][System.IO.FileInfo]$Image,
    [Parameter(Mandatory = $true)][int]$Size
)
begin {
    "@startuml"
}
process {
    # 0 = Transparent
    # F = Black
    
    $Name = $Image.BaseName
    
    $bmp = [System.Drawing.Bitmap]::FromFile($Image.FullName)
    $resizedBmp = [System.Drawing.Bitmap]::new($Size, $Size)
    $graphics = [System.Drawing.Graphics]::FromImage($resizedBmp)
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.DrawImage($bmp, 0, 0, $Size, $Size)
    $bmp.Dispose()
    $bmp = $resizedBmp
    $graphics.Dispose()
    
    "sprite `$$Name [$($bmp.Width)x$($bmp.Height)/16] {"
    for ($y = 0; $y -lt $bmp.Height; $y++) {
        $line = ""
        for ($x = 0; $x -lt $bmp.Width; $x++) {
            $color = $bmp.GetPixel($x, $y)
    
            $gray = [int](0.299 * $color.R + 0.587 * $color.G + 0.114 * $color.B)
            $n = [math]::Round(($gray / 255) * 15)
            $n = [math]::Abs(0xf - $n)
            $a = [math]::Round($color.A / 255)
    
            $v = $n * $a
            $line += "{0:X}" -f [int]$v
        }
        $line
    }
    "}"
    ""
    
    $bmp.Dispose()
}
end {
    "@enduml"
}