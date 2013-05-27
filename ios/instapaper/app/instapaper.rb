class Instapaper
  OK            = 200
  SUCCESS       = 201
  BAD_REQUEST   = 400
  INVALID_ERROR = 403
  SERVICE_ERROR = 500
  UNKNOWN_ERROR = -1

  def initWithUser(username, withPassword: password)
    @username = username
    @password = password
    @block    = nil
    self
  end

  def authenticate(&block)
    raise ArgumentError, "no block given" unless block
    raise "can't accept a request" if @block
    @block = block

    request = make_request(@username, @password)
    do_request("https://www.instapaper.com/api/authenticate", request)
  end

  def addURL(url, title=nil, &block)
    raise ArgumentError, "no block given" unless block
    raise "can't accept a request" if @block
    @block = block

    request = make_request(@username, @password, url, title)
    do_request("https://www.instapaper.com/api/add", request)
  end

  def connection(connection, didFailWithError:error)
    connection.cancel
    @block.call(UNKNOWN_ERROR)
    @block = nil
  end

  def connection(connection, didReceiveResponse:response)
    connection.cancel
    @block.call(response.statusCode.to_i)
    @block = nil
  end

  private

  def make_request(username, password, url=nil, title=nil)
    string = "username=#{username}&password=#{password}"
    string << "&url=#{url}" if url
    string << "&title=#{title}" if title
    string
  end

  def do_request(url, request_string)
    request = NSMutableURLRequest.requestWithURL(NSURL.URLWithString(url))
    request.setHTTPBody(request_string.to_data)
    request.setHTTPMethod("POST")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"content-type")
    NSURLConnection.alloc.initWithRequest(request, delegate:self)
  end
end