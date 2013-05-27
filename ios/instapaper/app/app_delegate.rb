USER = "foobar"
PASS = "password"

class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    insta = Instapaper.alloc.initWithUser(USER, withPassword:PASS)
    insta.addURL("http://www.apple.com") { |status|
      case status
      when Instapaper::SUCCESS
        msg = "Success"
      else
        msg = "Error"
      end

      alert = UIAlertView.alloc.initWithTitle(
                "Instapaper",
                message: msg,
                delegate: nil,
                cancelButtonTitle: nil,
                otherButtonTitles: "OK", 
                nil)
      alert.show
    }

    true
  end
end
