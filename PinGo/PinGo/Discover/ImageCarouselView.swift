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
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet fileprivate weak var layout: UICollectionViewFlowLayout!
    @IBOutlet fileprivate weak var pageControl: UIPageControl!
    
    fileprivate var kNumberOfSections = 0
    
    fileprivate var timer: Timer?
    
    var bannerList: [Banner]? {
        didSet {
            collectionView.reloadData()
            
            if (bannerList?.count)! <= 1 {
                collectionView.isScrollEnabled = false
                kNumberOfSections = 1
            }else {
                collectionView.isScrollEnabled = true
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
        
        collectionView.register(UINib.nibWithName("ImageCarouselCell"), forCellWithReuseIdentifier: kCellReuseIdentifier)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout.itemSize = bounds.size
    }
    
    fileprivate func collectionViewScrollToCenter() {
        guard bannerList != nil else {
            return
        }
        collectionView.scrollToItem(at: IndexPath(item: 0, section: Int(kNumberOfSections / 2)), at: .left, animated: false)
    }
    
    func scrollImage() {
        let offsetX = collectionView.contentOffset.x
        let toOffsetX = offsetX + collectionView.bounds.width
        if toOffsetX < collectionView.contentSize.width {
            collectionView.setContentOffset(CGPoint(x: toOffsetX, y: 0), animated: true)
        }else {
            collectionViewScrollToCenter()
        }
    }
    
    func startTimer() {
        guard timer == nil else {
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ImageCarouselView.scrollImage), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    class func loadFromNib() -> ImageCarouselView {
        return Bundle.main.loadNibNamed("ImageCarousel", owner: self, options: nil)!.last as! ImageCarouselView
    }
}

extension ImageCarouselView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return kNumberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellReuseIdentifier, for: indexPath) as! ImageCarouselCell
        cell.bannner = bannerList![indexPath.item]
        return cell
    }
}

extension ImageCarouselView: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5) % bannerList!.count
        pageControl.currentPage = page
    }
}

class ImageCarouselCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var imageView: UIImageView!
    
    var bannner: Banner? {
        didSet {
            if let urlStr = bannner?.imageUrl {
                if let url = URL(string: urlStr) {
                    imageView.kf.setImage(with: url)
                }
            }
        }
    }
}
