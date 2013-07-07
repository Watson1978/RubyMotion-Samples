class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    bundle = NSBundle.bundleWithPath(NSBundle.mainBundle.pathForResource("sample", ofType:"bundle"))
    NSLog bundle.localizedStringForKey("Hoge", value:nil, table:nil)
    true
  end
end
