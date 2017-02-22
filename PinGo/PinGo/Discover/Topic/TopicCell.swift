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
    
    @IBOutlet fileprivate weak var topView: UIView!
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet fileprivate weak var layout: UICollectionViewFlowLayout!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        topView.addSubview(headerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        DispatchQueue.main.async { () in
            self.headerView.frame = self.topView.bounds
        }
        
        let height = collectionView.bounds.height
        layout.itemSize = CGSize(width: height, height: height)
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
    fileprivate lazy var headerView: SectionHeaderView = {
        return SectionHeaderView.loadFromNib()
    }()
}

extension TopicCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoInfoList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellReuseIdentifier, for: indexPath) as! PhotoCell
        cell.photoInfo = photoInfoList![indexPath.item]
        return cell
    }
}

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var imageView: UIImageView!
    
    var photoInfo: TopicInfo? {
        didSet {
            if let urlStr = photoInfo!.resUrl {
                if let url = URL(string: urlStr) {
                    imageView.kf.setImage(with: url)
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
