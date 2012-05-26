FEED_URL = "http://b.hatena.ne.jp/#{USER_NAME.to_s}/favorite.rss"

class HBController < UITableViewController
  def viewDidLoad
    @rss_items = []
    @user_avator = {}
    self.view.dataSource = self
    self.view.delegate = self
    self.tableView.showsVerticalScrollIndicator = false

    RSS.new.parse(FEED_URL.to_url, delegate: self, selector: "getRssItem:")
  end

  def getRssItem(obj)
    @rss_items << obj
  end

  def parserDidEndDocument
    @load_feed = false
    self.view.reloadData
  end

  def tableView(tableView,
                numberOfRowsInSection: section)
    @rss_items.size
  end

  def tableView(tableView,
                cellForRowAtIndexPath: indexPath)
    if indexPath.row + 1 == @rss_items.size && @load_feed == false
      # load next page
      @load_feed = true
      url = FEED_URL + "?of=#{@rss_items.size}"
      RSS.new.parse(url.to_url, delegate: self, selector: "getRssItem:")
    end

    rss = @rss_items[indexPath.row]
    cell = HBCell.alloc.initCell(tableView)
    user_name = rss["dc:creator"]
    cell.title.text = rss["title"]
    cell.name.text = user_name
    cell.date.text = rss["dc:date"].to_time.strftime("%m/%e %H:%M")
    cell.count.text = rss["hatena:bookmarkcount"] + " users"

    unless @user_avator[user_name]
      Dispatch::Queue.concurrent.async do
        avator_url = HateB.get_avator_url(user_name)
        image = UIImage.alloc.initWithContentsOfURL(avator_url.to_url)
        if image
          @user_avator[user_name] = image
          Dispatch::Queue.main.sync do
            cell.avator.image = @user_avator[user_name]
            self.view.reloadData
          end
        end
      end
    else
      cell.avator.image = @user_avator[user_name]
    end

    cell
  end

  def tableView(tableView,
                heightForRowAtIndexPath:indexPath)
    HBCell::Cell.height
  end
end
