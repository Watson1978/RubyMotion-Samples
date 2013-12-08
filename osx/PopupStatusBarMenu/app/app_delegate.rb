class ContentView < NSView
  attr_accessor :button_quit
  def initWithFrame(frame)
    super
    @button_quit = NSButton.alloc.initWithFrame([[20, 20], [100, 32]])
    @button_quit.title = "Quit"
    @button_quit.bezelStyle = NSRoundedBezelStyle
    @button_quit.autoresizingMask = NSViewMinXMargin|NSViewMinYMargin
    addSubview(@button_quit)

    self
  end
end

class ContentViewController < NSViewController
  attr_accessor :statusItemPopup

  def initWithNibName(nibNameOrNil, bundle:nibBundleOrNil)
    super

    view = ContentView.alloc.initWithFrame([[0, 0], [480, 360]])
    self.view = view
    view.button_quit.action = "quit"
    view.button_quit.target = self
    self
  end

  def quit
    NSApplication.sharedApplication.terminate(nil)
  end
end

class AppDelegate
  def applicationDidFinishLaunching(notification)
    image = NSImage.imageNamed("icon")
    image.size = [16, 16]
    @controller = ContentViewController.alloc.initWithNibName(nil, bundle:nil)
    @controller.statusItemPopup = AXStatusItemPopup.alloc.initWithViewController(@controller, image:image)
  end
end
