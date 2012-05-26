class RSS
  def parse(url,
            delegate: delegate,
            selector: callback)
    @delegate = delegate
    @callback = callback

    # for GCD trick
    @url = url
    @self = self
    Dispatch::Queue.main.async do
      xml = NSXMLParser.alloc.initWithContentsOfURL(@url)
      xml.delegate = @self
      xml.parse
    end
  end

  def parserDidStartDocument(parser)
    @item = {}
  end

  def parserDidEndDocument(parser)
    if @delegate.respond_to?("parserDidEndDocument")
      @delegate.send("parserDidEndDocument")
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
      @delegate.send(@callback, @item)
      @item = {}
    end
  end

  def parser(parser,
             foundCharacters: string)
    @string << string.strip
  end
end
