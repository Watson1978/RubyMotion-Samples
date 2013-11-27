class SpeechViewController < UIViewController
  def init
    @synthesizer = AVSpeechSynthesizer.new
    super
  end

  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor
    @text_field = UITextField.alloc.initWithFrame([[50, 100], [200, 30]])
    @text_field.text = "Hello"
    @text_field.borderStyle = UITextBorderStyleRoundedRect
    view.addSubview(@text_field)

    @action = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @action.setTitle('Say', forState:UIControlStateNormal)
    @action.addTarget(self, action:'say', forControlEvents:UIControlEventTouchUpInside)
    @action.frame = [[50, 150], [80, 40]]
    view.addSubview(@action)
  end

  def say
    utterance = AVSpeechUtterance.speechUtteranceWithString(@text_field.text)
    @synthesizer.speakUtterance(utterance)
  end
end

class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = SpeechViewController.new
    @window.makeKeyAndVisible
    true
  end
end
