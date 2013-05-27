class ViewController < UICollectionViewController

  def viewDidLoad
    super
    collectionView.registerClass(Cell, forCellWithReuseIdentifier:"MY_CELL")

    @photos = []
    dir = NSBundle.mainBundle.bundlePath
    Dir.glob(File.join(dir, "*.jpg")) do |file|
      @photos << UIImage.imageNamed(File.basename(file))
    end
  end

  # UICollectionViewDataSource
  def collectionView(view, numberOfItemsInSection:section)
    @photos.count
  end

  def collectionView(view, cellForItemAtIndexPath:path)
    cell = view.dequeueReusableCellWithReuseIdentifier("MY_CELL", forIndexPath:path)
    cell.imageView.image = @photos[path.item]
    cell
  end

end