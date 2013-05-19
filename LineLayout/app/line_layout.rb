ITEM_SIZE = 200.0
ACTIVE_DISTANCE = 200
ZOOM_FACTOR = 0.3

class LineLayout < PSUICollectionViewFlowLayout

  def init
    if super
      @itemSize = CGSizeMake(ITEM_SIZE, ITEM_SIZE)
      @scrollDirection = UICollectionViewScrollDirectionHorizontal
      @sectionInset = UIEdgeInsetsMake(200, 0.0, 200, 0.0)
      @minimumLineSpacing = 50.0
    end
    self
  end

  def shouldInvalidateLayoutForBoundsChange(oldBounds)
    true
  end

  def layoutAttributesForElementsInRect(rect)
    array = super
    visibleRect = CGRect.new
    visibleRect.origin = self.collectionView.contentOffset
    visibleRect.size = self.collectionView.bounds.size

    array.each do |attributes|
      if CGRectIntersectsRect(attributes.frame, rect)
        distance = CGRectGetMidX(visibleRect) - attributes.center.x
        normalizedDistance = distance / ACTIVE_DISTANCE
        if distance.abs < ACTIVE_DISTANCE
          zoom = 1 + ZOOM_FACTOR*(1 - normalizedDistance.abs)
          attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0)
          attributes.zIndex = 1
          end
      end
    end
    array
  end

  def targetContentOffsetForProposedContentOffset(proposedContentOffset, withScrollingVelocity:velocity)
    offsetAdjustment = Float::MAX
    horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0)

    targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height)
    array = self.layoutAttributesForElementsInRect(targetRect)

    array.each do |layoutAttributes|
      itemHorizontalCenter = layoutAttributes.center.x
      if (itemHorizontalCenter - horizontalCenter).abs < offsetAdjustment.abs
        offsetAdjustment = itemHorizontalCenter - horizontalCenter
      end
    end
    CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y)
  end

end
