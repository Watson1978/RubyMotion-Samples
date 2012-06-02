class BarCodeReaderController < UIViewController
  def viewDidLoad
    margin = 20
    @action = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @action.setTitle('select barcode', forState:UIControlStateNormal)
    @action.addTarget(self, action:'actionTapped', forControlEvents:UIControlEventTouchUpInside)
    @action.frame = [[margin, 260], [view.frame.size.width - margin * 2, 40]]
    view.addSubview(@action)
  end

  def actionTapped
    @reader = ZBarReaderController.new
    @reader.readerDelegate = self
    @reader.scanner.setSymbology(ZBAR_I25,
                                 config: ZBAR_CFG_ENABLE,
                                 to: 0)
    self.presentModalViewController(@reader,
                                    animated: true)
  end

  def imagePickerController(reader,
                            didFinishPickingMediaWithInfo: info)
    info.objectForKey(ZBarReaderControllerResults).each do |item|
      p item.typeName
      p item.data
    end

    @reader.dismissModalViewControllerAnimated(true)
  end
end

class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = BarCodeReaderController.alloc.init
    @window.makeKeyAndVisible
    true
  end
end
