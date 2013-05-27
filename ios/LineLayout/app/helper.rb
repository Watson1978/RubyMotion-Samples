# http://hipbyte.myjetbrains.com/youtrack/issue/RM-60
def UIInterfaceOrientationIsLandscape(orientation)
  return true if orientation == UIInterfaceOrientationLandscapeLeft
  return true if orientation == UIInterfaceOrientationLandscapeRight
  return false
end
