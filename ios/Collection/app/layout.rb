class PhotoLayout < UICollectionViewLayout
  ItemSize = 120.0

  def prepareLayout
    super
    size = collectionView.frame.size
    @cell_count = collectionView.numberOfItemsInSection(0)
  end

  def collectionViewContentSize
    collectionView.frame.size
  end

  def layoutAttributesForItemAtIndexPath(path)
    x = path.row % 2
    y = (path.row / 2).floor
    UICollectionViewLayoutAttributes.layoutAttributesForCellWithIndexPath(path).tap do |obj|
      obj.frame = [[(ItemSize + 10)*x, (ItemSize+8)*y], [ItemSize, ItemSize]]
    end
  end  

  def layoutAttributesForElementsInRect(rect)
    (0...@cell_count).map { |i| layoutAttributesForItemAtIndexPath(NSIndexPath.indexPathForItem(i, inSection:0)) }
  end

  def initialLayoutAttributesForInsertedItemAtIndexPath(path)
    layoutAttributesForItemAtIndexPath(path).tap do |obj|
      obj.alpha = 0.0
    end
  end

  def finalLayoutAttributesForDeletedItemAtIndexPath(path)
    layoutAttributesForItemAtIndexPath(path).tap do |obj|
      obj.alpha = 0.0
      obj.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0)
    end
  end
end