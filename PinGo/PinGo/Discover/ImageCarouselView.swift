//
//  ImageCarouselView.swift
//  PinGo
//
//  Created by GaoWanli on 16/2/1.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

private let kCellReuseIdentifier = "imageCarouselCell"

class ImageCarouselView: UIView {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var layout: UICollectionViewFlowLayout!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    private var kNumberOfSections = 0
    
    private var timer: NSTimer?
    
    var bannerList: [Banner]? {
        didSet {
            collectionView.reloadData()
            
            if bannerList?.count <= 1 {
                collectionView.scrollEnabled = false
                kNumberOfSections = 1
            }else {
                collectionView.scrollEnabled = true
                kNumberOfSections = 100
                
                collectionViewScrollToCenter()
                
                startTimer()
            }
            
            pageControl.numberOfPages = bannerList?.count ?? 0
            pageControl.currentPage = 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.registerNib(UINib.nibWithName("ImageCarouselCell"), forCellWithReuseIdentifier: kCellReuseIdentifier)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout.itemSize = bounds.size
    }
    
    private func collectionViewScrollToCenter() {
        guard bannerList != nil else {
            return
        }
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: Int(kNumberOfSections / 2)), atScrollPosition: .Left, animated: false)
    }
    
    func scrollImage() {
        let offsetX = collectionView.contentOffset.x
        let toOffsetX = offsetX + CGRectGetWidth(collectionView.bounds)
        if toOffsetX < collectionView.contentSize.width {
            collectionView.setContentOffset(CGPointMake(toOffsetX, 0), animated: true)
        }else {
            collectionViewScrollToCenter()
        }
    }
    
    func startTimer() {
        guard timer == nil else {
            return
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "scrollImage", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    class func loadFromNib() -> ImageCarouselView {
        return NSBundle.mainBundle().loadNibNamed("ImageCarousel", owner: self, options: nil).last as! ImageCarouselView
    }
}

extension ImageCarouselView: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return kNumberOfSections
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerList?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellReuseIdentifier, forIndexPath: indexPath) as! ImageCarouselCell
        cell.bannner = bannerList![indexPath.item]
        return cell
    }
}

extension ImageCarouselView: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds) + 0.5) % bannerList!.count
        pageControl.currentPage = page
    }
}

class ImageCarouselCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    var bannner: Banner? {
        didSet {
            if let urlStr = bannner?.imageUrl {
                if let url = NSURL(string: urlStr) {
                    imageView.kf_setImageWithURL(url)
                }
            }
        }
    }
}