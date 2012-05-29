class LoadCell < UITableViewCell
  CELL_ID = "LD_CELL"
  attr_reader :imageView
  
  def initCell(tableView)
    cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID)
    if cell
      cell.imageView.startAnimating
      return cell
    end

    cell = self.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: CELL_ID)
    cell.contentView.subviews.each do |v|
      v.removeFromSuperview
    end
    
    images = 1.upto(16).inject([]) do |ary, i|
      ary << UIImage.imageNamed("loading%02d.png" % i)
    end

    @imageView = UIImageView.alloc.initWithFrame([[144, 4], [32, 32]])
    @imageView.image = images.first
    @imageView.animationImages = images
    @imageView.animationRepeatCount = 0
    @imageView.animationDuration = 4.0
    @imageView.startAnimating
    cell.contentView.addSubview(@imageView)

    cell
  end

  module Cell
    module_function

    def height
      70
    end
  end

end