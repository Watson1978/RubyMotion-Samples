class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    if USER_NAME.to_s.length == 0
      alert("Need to configure user name")
      return true
    end

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    @window.rootViewController = HBController.alloc.initWithStyle(UITableViewStylePlain)
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
    true
  end
end
