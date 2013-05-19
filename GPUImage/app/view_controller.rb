class ViewController < UIViewController
  attr_accessor :image_view

  def viewDidLoad
    super

    @image_view = UIImageView.alloc.initWithFrame(CGRectMake(0, 0, 320, 400))
    @image_view.image = UIImage.imageNamed("sample.jpg")
    self.view.addSubview(@image_view)

    filter = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    filter.setTitle('Filter', forState:UIControlStateNormal)
    filter.addTarget(self, action:'press_filter:', forControlEvents:UIControlEventTouchUpInside)
    filter.frame = [[20, 420], [150, 40]]
    self.view.addSubview(filter)
    self
  end

  def press_filter(sender)
    gpu_image = GPUImagePicture.alloc.initWithImage(self.image_view.image)
    filter = GPUImageSepiaFilter.alloc.init
    gpu_image.addTarget(filter)
    gpu_image.processImage()

    self.image_view.image = filter.imageFromCurrentlyProcessedOutput()
  end
end