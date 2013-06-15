class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    # Optional: automatically send uncaught exceptions to Google Analytics.
    GAI.sharedInstance.trackUncaughtExceptions = true
    # Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    GAI.sharedInstance.dispatchInterval = 20
    # Optional: set debug to YES for extra debugging information.
    GAI.sharedInstance.debug = true
    # Create tracker instance.
    @tracker = GAI.sharedInstance.trackerWithTrackingId("UA-YOUR-TRACKING-ID")

    true
  end
end
