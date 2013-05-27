class Cell < UICollectionViewCell
  attr_accessor :imageView

  def initWithFrame(frame)
    super

    self.backgroundColor = UIColor.whiteColor
    image = UIImageView.alloc.initWithFrame(
                                  CGRectMake(3, 3, frame.size.width - 6, frame.size.height - 6))
        
    image.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
        
    self.contentView.addSubview(image)
    self.imageView = image
    self
  end
end