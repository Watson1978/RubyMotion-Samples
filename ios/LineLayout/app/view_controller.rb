class ViewController < PSUICollectionViewController

  def viewDidLoad
    super
    self.collectionView.registerClass(Cell, forCellWithReuseIdentifier:"MY_CELL")
  end

  def collectionView(view, numberOfItemsInSection:section)
    60
  end

  def collectionView(cv, cellForItemAtIndexPath:indexPath)
    cell = cv.dequeueReusableCellWithReuseIdentifier("MY_CELL", forIndexPath:indexPath)
    cell.label.text = NSString.stringWithFormat("%d",indexPath.item)
    cell
  end

  def shouldAutorotateToInterfaceOrientation(toInterfaceOrientation)
    UIInterfaceOrientationIsLandscape(toInterfaceOrientation)
  end

end
