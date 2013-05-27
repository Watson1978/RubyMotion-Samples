class AppDelegate
  def applicationDidFinishLaunching(notification)
    buildMenu
    buildWindow

    image = NSImage.imageNamed "status_bar_icon"
    image.setSize(NSMakeSize(16, 16))

    status = NSStatusBar.systemStatusBar
    @item = status.statusItemWithLength(NSVariableStatusItemLength)
    @item.setTitle "test"
    @item.setImage image
    @item.setMenu @mainMenu
  end

  def buildWindow
    @mainWindow = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.orderFrontRegardless
  end
end
