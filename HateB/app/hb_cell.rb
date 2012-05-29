
class HBCell < UITableViewCell
  CELL_ID = "HB_CELL"
  MESSAGE_FONT_SIZE = 13

  attr_accessor :name
  attr_accessor :title
  attr_accessor :comment
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

    @name = UILabel.alloc.initWithFrame([[55, 0], [110, 18]])
    @name.font = UIFont.boldSystemFontOfSize(MESSAGE_FONT_SIZE)
    cell.contentView.addSubview(@name)

    @date = UILabel.alloc.initWithFrame([[250, 0], [@width - 250, 18]])
    @date.font = UIFont.systemFontOfSize(MESSAGE_FONT_SIZE)
    cell.contentView.addSubview(@date)

    @count = UILabel.alloc.initWithFrame([[170, 0], [70, 18]])
    @count.font = UIFont.systemFontOfSize(MESSAGE_FONT_SIZE)
    @count.textAlignment = UITextAlignmentRight
    @count.textColor = "#8e3d3d".to_color
    cell.contentView.addSubview(@count)

    @comment = UILabel.alloc.initWithFrame([[55, 24], [@width - 55, 48]])
    @comment.font = UIFont.systemFontOfSize(MESSAGE_FONT_SIZE)
    @comment.numberOfLines = 0
    cell.contentView.addSubview(@comment)

    @title = UILabel.alloc.initWithFrame([[60, 24], [@width - 60, 48]])
    @title.font = UIFont.systemFontOfSize(MESSAGE_FONT_SIZE)
    @title.numberOfLines = 0
    @title.textColor = "#163a82".to_color
    cell.contentView.addSubview(@title)

    cell
  end
  
  def initCellWithItem(tableView, rss: rss)
    # for GCD trick
    @tableView = tableView
    
    @@user_avator ||= {}
    cell = self.initCell(@tableView)
    
    cell.comment.text = rss["description"]
    cell.title.text = rss["title"]
    cell.name.text = rss["dc:creator"]
    cell.date.text = rss["dc:date"].to_time.strftime("%m/%e %H:%M")
    cell.count.text = rss["hatena:bookmarkcount"] + " users"
    
    unless @@user_avator[cell.name.text]
      Dispatch::Queue.concurrent.async do
        avator_url = HateB.get_avator_url(cell.name.text)
        image = UIImage.alloc.initWithContentsOfURL(avator_url.to_url)
        if image
          @@user_avator[cell.name.text] = image
          Dispatch::Queue.main.sync do
            cell.avator.image = @@user_avator[cell.name.text]
            @tableView.reloadData
            @tableView = nil
          end
        end
      end
    else
      cell.avator.image = @@user_avator[cell.name.text]
    end
    
    cell
  end

  def layoutSubviews
    super

    comment_height = 0
    if @comment.text.to_s.length > 0
      comment_height = Cell.commentHeight(@width, @comment.text)
      @comment.frame = [[55, 24], [@width - 55, comment_height]]
    else
      @comment.frame = [[55, 24], [0, 0]]      
    end

    height = Cell.titleHeight(@width, @title.text)
    @title.frame = [[60, comment_height + 24 + 4], [@width - 60, height]]
  end

  module Cell
    module_function

    def commentHeight(width, comment)
      constrain = CGSize.new(width-55, 1000)
      size = comment.sizeWithFont(UIFont.systemFontOfSize(MESSAGE_FONT_SIZE), constrainedToSize:constrain)
      size.height
    end

    def titleHeight(width, title)
      constrain = CGSize.new(width-60, 1000)
      size = title.sizeWithFont(UIFont.systemFontOfSize(MESSAGE_FONT_SIZE), constrainedToSize:constrain)
      size.height
    end

    def height(screen_width, rss)
      h  = commentHeight(screen_width, rss["description"])
      h += titleHeight(screen_width, rss["title"])
      h += 40
      [h, 70].max
    end
  end
end
