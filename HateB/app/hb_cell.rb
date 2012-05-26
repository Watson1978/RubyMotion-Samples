CELL_ID = "HB_CELL"
MESSAGE_FONT_SIZE = 12

class HBCell < UITableViewCell
  attr_accessor :name
  attr_accessor :title
  attr_accessor :date
  attr_accessor :count
  attr_accessor :avator

  def initCell(tableView)
    cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID)
    return cell if cell

    cell = self.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: CELL_ID)
    cell.contentView.subviews.each do |v|
      v.removeFromSuperview
    end
    @width = tableView.frame.size.width

    @avator = UIImageView.alloc.initWithFrame([[2, 2], [46, 46]])
    cell.contentView.addSubview(@avator)

    @name = UILabel.alloc.initWithFrame([[55, 0], [140, 18]])
    @name.font = UIFont.boldSystemFontOfSize(MESSAGE_FONT_SIZE)
    cell.contentView.addSubview(@name)

    @date = UILabel.alloc.initWithFrame([[250, 0], [@width - 250, 18]])
    @date.font = UIFont.systemFontOfSize(MESSAGE_FONT_SIZE)
    cell.contentView.addSubview(@date)

    @count = UILabel.alloc.initWithFrame([[180, 0], [60, 18]])
    @count.font = UIFont.systemFontOfSize(MESSAGE_FONT_SIZE)
    @count.textAlignment = UITextAlignmentRight
    cell.contentView.addSubview(@count)

    @title = UILabel.alloc.initWithFrame([[55, 24], [@width - 55, 48]])
    @title.font = UIFont.systemFontOfSize(MESSAGE_FONT_SIZE)
    @title.numberOfLines = 0
    cell.contentView.addSubview(@title)

    cell
  end

  def layoutSubviews
    super
    constrain = CGSize.new(@width - 55, 1000)
    size = @title.text.sizeWithFont(UIFont.systemFontOfSize(MESSAGE_FONT_SIZE), constrainedToSize:constrain)
    height = [48, size.height].min
    @title.frame = [[55, 24], [@width - 55, height]]
  end

  module Cell
    module_function

    def height
      75
    end
  end
end
