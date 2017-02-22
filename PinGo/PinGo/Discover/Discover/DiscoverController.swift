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
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet fileprivate weak var layout: UICollectionViewFlowLayout!
    
    fileprivate var subjectInfoListArray: [[SubjectInfo]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib.nibWithName("SectionHeader"), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderViewReuseIdentifier)
        
        collectionView.contentInset = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0)
        collectionView.insertSubview(headerView, at: 0)
        
        Banner.fetchBannerList(type: .subject) { [weak self] (bannerList) in
            if let strongSelf = self {
                if bannerList != nil {
                    strongSelf.headerView.bannerList = bannerList
                }
            }
        }
        
        SubjectInfo.fetchSubjectInfoList { [weak self] (s) in
            if let strongSelf = self {
                if s != nil {
                    strongSelf.subjectInfoListArray = s
                    strongSelf.collectionView.reloadData()
                }
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        DispatchQueue.main.async { () in
            self.headerView.frame = CGRect(x: 0, y: -kHeaderViewHeight, width: self.view.bounds.width, height: kHeaderViewHeight)
        }
        let width = (view.bounds.width - 3 * layout.minimumInteritemSpacing) * 0.5
        let height = width * 3.0 / 4.0
        layout.itemSize = CGSize(width: width, height: height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        headerView.scrollImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        headerView.stopScrollImage()
    }
    
    // MARK: lazy loading
    fileprivate lazy var headerView: DiscoverHeaderView = {
        let h = DiscoverHeaderView.loadFromNib()
        return h
    }()
}

extension DiscoverController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return subjectInfoListArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellReuseIdentifier, for: indexPath) as! DiscoverCell
        
        if let subjectInfoList = subjectInfoListArray?[indexPath.section] {
            if subjectInfoList.count > indexPath.item {
                cell.subjectInfo = subjectInfoList[indexPath.item]
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderViewReuseIdentifier, for: indexPath) as! SectionHeaderView
        view.showText = (indexPath.section == 0 ? "热门话题" : "推荐话题")
        return view
    }
}

extension DiscoverController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 40)
    }
}

extension DiscoverController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? DiscoverCell {
            if let toVC = segue.destination as? TopicDetailController  {
                toVC.subjectID = cell.subjectInfo?.subjectID
                toVC.title = cell.subjectInfo?.title
            }
        }
    }
}
