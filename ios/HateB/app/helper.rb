module HateB
  module_function

  def get_avator_url(user)
    raise "needs user name" if user.length <= 0
    dir = user[0..1]
    "http://www.hatena.ne.jp/users/#{dir}/#{user}/profile.gif"
  end
end

module Kernel
  def alert(msg)
    alert = UIAlertView.alloc.initWithTitle(msg,
                                            message: nil,
                                            delegate: nil,
                                            cancelButtonTitle: "OK",
                                            otherButtonTitles: nil)
    alert.show
  end
end

class NSString
  def to_url
    NSURL.URLWithString(self)
  end

  def to_time
    # string like a "2009-02-10T07:00:00"
    tmp = self.split(/[\/ T:-]/).map{|x| x.to_i}
    if (tmp.size < 6)
      raise ArgumentError, "Unknown Time format"
    end
    return Time.mktime(tmp[0], tmp[1], tmp[2], tmp[3], tmp[4], tmp[5])
  end

  def to_color
    # string like a "#0c92f2"
    raise "Unknown color schem" if (self[0] != '#') || (self.length != 7)
    color = self[1..-1]
    r = color[0..1]
    g = color[2..3]
    b = color[4..5]
    UIColor.colorWithRed((r.hex/255.0), green:(g.hex/255.0), blue:(b.hex/255.0), alpha:1)
  end
end

class  UIImage
  def initWithContentsOfURL(url)
    image = NSData.alloc.initWithContentsOfURL(url)
    return UIImage.alloc.initWithData(image) if image
  end
end
