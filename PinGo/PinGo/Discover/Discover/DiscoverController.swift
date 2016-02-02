//
//  DiscoverController.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

private let kCellReuseIdentifier              = "discoverCell"
private let kSectionHeaderViewReuseIdentifier = "sectionHeaderViewReuseIdentifier"
private let kHeaderViewHeight: CGFloat        = 174.0

class DiscoverController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var layout: UICollectionViewFlowLayout!
    
    private var subjectInfoListArray: [[SubjectInfo]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.registerNib(UINib.nibWithName("SectionHeader"), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderViewReuseIdentifier)
        
        collectionView.contentInset = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0)
        collectionView.insertSubview(headerView, atIndex: 0)
        
        Banner.fetchBannerList(.Subject) { (bannerList) in
            if bannerList != nil {
                self.headerView.bannerList = bannerList
            }
        }
        
        SubjectInfo.fetchSubjectInfoList { (s) in
            if s != nil {
                self.subjectInfoListArray = s
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        headerView.frame = CGRectMake(0, -kHeaderViewHeight, CGRectGetWidth(self.view.bounds), kHeaderViewHeight)
        
        let width = (CGRectGetWidth(view.bounds) - 3 * layout.minimumInteritemSpacing) * 0.5
        let height = width * 3.0 / 4.0
        layout.itemSize = CGSizeMake(width, height)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        headerView.scrollImage()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        headerView.stopScrollImage()
    }
    
    // MARK: lazy loading
    private lazy var headerView: DiscoverHeaderView = {
        let h = DiscoverHeaderView.loadFromNib()
        return h
    }()
}

extension DiscoverController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return subjectInfoListArray?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellReuseIdentifier, forIndexPath: indexPath) as! DiscoverCell
        
        if let subjectInfoList = subjectInfoListArray?[indexPath.section] {
            if subjectInfoList.count > indexPath.item {
                cell.subjectInfo = subjectInfoList[indexPath.item]
            }
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderViewReuseIdentifier, forIndexPath: indexPath) as! SectionHeaderView
        view.showText = (indexPath.section == 0 ? "热门话题" : "推荐话题")
        return view
    }
}

extension DiscoverController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 40)
    }
}