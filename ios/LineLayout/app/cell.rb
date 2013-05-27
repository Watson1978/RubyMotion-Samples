class Cell < PSUICollectionViewCell
  attr_accessor :label

  def initWithFrame(frame)
    if super
      @label = UILabel.alloc.initWithFrame(CGRectMake(0.0, 0.0, frame.size.width, frame.size.height))
      @label.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth
      @label.textAlignment = UITextAlignmentCenter
      @label.font = UIFont.boldSystemFontOfSize(50.0)
      @label.backgroundColor = UIColor.underPageBackgroundColor
      @label.textColor = UIColor.blackColor
      self.contentView.addSubview(@label)
      self.contentView.layer.borderWidth = 1.0
      self.contentView.layer.borderColor = UIColor.whiteColor.CGColor
    end
    self
  end

end
