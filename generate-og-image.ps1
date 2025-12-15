Add-Type -AssemblyName System.Drawing

$width = 1200
$height = 630

$bmp = New-Object System.Drawing.Bitmap($width, $height)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

# Background gradient
$bgRect = New-Object System.Drawing.Rectangle(0, 0, $width, $height)
$bgBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    $bgRect,
    [System.Drawing.Color]::FromArgb(255, 11, 11, 11),
    [System.Drawing.Color]::FromArgb(255, 18, 18, 18),
    [System.Drawing.Drawing2D.LinearGradientMode]::Horizontal
)
$g.FillRectangle($bgBrush, $bgRect)

# Content overlay block
$overlayRect = New-Object System.Drawing.Rectangle(70, 120, 1060, 360)
$overlayBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(170, 0, 0, 0))
$g.FillRectangle($overlayBrush, $overlayRect)

# Fonts
$fontSmall = New-Object System.Drawing.Font("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)
$fontTitle = New-Object System.Drawing.Font("Segoe UI", 50, [System.Drawing.FontStyle]::Bold)
$fontSub   = New-Object System.Drawing.Font("Segoe UI", 24, [System.Drawing.FontStyle]::Regular)

$white = [System.Drawing.Brushes]::White
$left  = 90
$top   = 150

# Label
$g.DrawString("PORTFOLIO - FULL STACK", $fontSmall, $white, $left, $top)

# Accent line (gradient)
$gradRect = [System.Drawing.Rectangle]::FromLTRB($left, $top + 36, $left + 160, $top + 39)
$colorStart = [System.Drawing.Color]::FromArgb(255, 79, 70, 229)
$colorEnd   = [System.Drawing.Color]::FromArgb(255, 34, 197, 94)
$gradBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush $gradRect, $colorStart, $colorEnd, ([System.Drawing.Drawing2D.LinearGradientMode]::Horizontal)
$g.FillRectangle($gradBrush, $gradRect)

# Title
$titleTop = $top + 60
$g.DrawString("Daniel Pereira - SnDann", $fontTitle, $white, $left, $titleTop)

# Subtitle
$subTop = $titleTop + 70
$g.DrawString(".NET - C# - JavaScript - SQL Server - Azure", $fontSub, $white, $left, $subTop)

# Save
$bmp.Save("og-image.png", [System.Drawing.Imaging.ImageFormat]::Png)

# Cleanup
$bgBrush.Dispose()
$gradBrush.Dispose()
$overlayBrush.Dispose()
$g.Dispose()
$bmp.Dispose()
