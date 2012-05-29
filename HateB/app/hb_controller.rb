FEED_URL = "http://b.hatena.ne.jp/#{USER_NAME.to_s}/favorite.rss"

class HBController < UITableViewController
  def viewDidLoad
    @rss_items = []
    self.view.dataSource = self
    self.view.delegate = self
    self.tableView.showsVerticalScrollIndicator = false

    @parser = RSS.new(self, "getRssItem:")
    @parser.parse(FEED_URL.to_url)
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
    @rss_items.size + 1
  end

  def tableView(tableView,
                cellForRowAtIndexPath: indexPath)
    if indexPath.row == @rss_items.size
      if @rss_items.size > 0 && @load_feed == false
        # load next page
        @load_feed = true
        url = FEED_URL + "?of=#{@rss_items.size}"
        @parser.parse(url.to_url)
      end
      return LoadCell.alloc.initCell(tableView)
    end

    rss = @rss_items[indexPath.row]
    return HBCell.alloc.initCellWithItem(tableView, rss: rss)
  end

  def tableView(tableView,
                heightForRowAtIndexPath:indexPath)
    width = tableView.frame.size.width
    if indexPath.row == @rss_items.size
      return LoadCell::Cell.height
    else
      rss = @rss_items[indexPath.row]
      return HBCell::Cell.height(width, rss)
    end
  end
end
