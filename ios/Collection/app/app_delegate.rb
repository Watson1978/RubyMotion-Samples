class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    @window.rootViewController = ViewController.alloc.initWithCollectionViewLayout(PhotoLayout.new)
    @window.makeKeyAndVisible
    true
  end
end
