function Get-UIPlacement {
  Param (
    [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
    [hashtable]
    $DisplayInfo,
    [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
    [hashtable]
    $UISizes
  )

  if ($DisplayInfo -isnot [hashtable] -and $UISizes -isnot [hashtable]) { return }

  $AvailWidth  = $DisplayInfo.AvailWidth
  $AvailHeight = $DisplayInfo.AvailHeight

  if ($UISizes.ContainsKey('Width')) {
    $Sizes = $UISizes
  } elseif ($UISizes.ContainsKey($DisplayInfo.Resolution)) {
    $Sizes = $UISizes.Item($DisplayInfo.Resolution)
  } elseif ($UISizes.ContainsKey('1920x1080')) {
    $Sizes = $UISizes.Item('1920x1080')
  } else {
    $Sizes = @{
      Width = 0
      Height = 0
    }
  }

  if (!$Sizes.ContainsKey('Offset')) {
    $Sizes += @{
      Offset = @{
        Top  = 0
        Left = 0
      }
    }
  }

  $Left   = [Math]::Floor(($AvailWidth  - $Sizes.Width)  / 2) + $Sizes.Offset.Left
  $Right  = [Math]::Floor(($AvailWidth  + $Sizes.Width)  / 2) + $Sizes.Offset.Left
  $Top    = [Math]::Floor(($AvailHeight - $Sizes.Height) / 2) + $Sizes.Offset.Top
  $Bottom = [Math]::Floor(($AvailHeight + $Sizes.Height) / 2) + $Sizes.Offset.Top

  $UIPlacement = @{
    Left   = $Left
    Right  = $Right
    Top    = $Top
    Bottom = $Bottom
  }

  return $UIPlacement
}
