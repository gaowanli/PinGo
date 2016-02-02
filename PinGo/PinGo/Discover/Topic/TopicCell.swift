//
//  TopicCell.swift
//  PinGo
//
//  Created by GaoWanli on 16/2/2.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

private let kCellReuseIdentifier = "photoCell"

class TopicCell: UITableViewCell {
    
    @IBOutlet private weak var topView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var layout: UICollectionViewFlowLayout!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        topView.addSubview(headerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headerView.frame = topView.bounds
        
        let height = CGRectGetHeight(collectionView.bounds)
        layout.itemSize = CGSizeMake(height, height)
    }
    
    var headerViewText: String? {
        didSet {
            headerView.showText = headerViewText
        }
    }
    
    var photoInfoList: [TopicInfo]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: lazy loading
    private lazy var headerView: SectionHeaderView = {
        return SectionHeaderView.loadFromNib()
    }()
}

extension TopicCell: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoInfoList?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellReuseIdentifier, forIndexPath: indexPath) as! PhotoCell
        cell.photoInfo = photoInfoList![indexPath.item]
        return cell
    }
}

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    var photoInfo: TopicInfo? {
        didSet {
            if let urlStr = photoInfo!.resUrl {
                if let url = NSURL(string: urlStr) {
                    imageView.kf_setImageWithURL(url)
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 3
        layer.masksToBounds = true
    }
}
