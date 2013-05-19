class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    lineLayout = LineLayout.alloc.init
    viewController = ViewController.alloc.initWithCollectionViewLayout(lineLayout)

    @window.rootViewController = viewController
    @window.makeKeyAndVisible
    true
  end

end
