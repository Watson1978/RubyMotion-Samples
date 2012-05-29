class RSS
  def initialize(delegate, callback)
    @delegate = delegate
    @callback = callback
  end

  def parse(url)
    # for GCD trick
    @url = url
    @self = self
    Dispatch::Queue.concurrent.async do
      xml = NSXMLParser.alloc.initWithContentsOfURL(@url)
      xml.delegate = @self
      xml.parse
      @url = @self = nil
    end
  end

  def parserDidStartDocument(parser)
    @item = {}
  end

  def parserDidEndDocument(parser)
    if @delegate.respond_to?("parserDidEndDocument")
      Dispatch::Queue.main.sync do
        @delegate.send("parserDidEndDocument")
      end
    end
  end

  def parser(parser,
             didStartElement: elementName,
             namespaceURI: namespaceURI,
             qualifiedName: qualifiedName,
             attributes: attributeDict)
    @string = ""
  end

  def parser(parser,
             didEndElement: elementName,
             namespaceURI: namespaceURI,
             qualifiedName: qName)
    @item[elementName] = @string
    if elementName == "item"
      Dispatch::Queue.main.sync do
        @delegate.send(@callback, @item)
      end
      @item = {}
    end
  end

  def parser(parser,
             foundCharacters: string)
    @string << string.strip
  end
end
