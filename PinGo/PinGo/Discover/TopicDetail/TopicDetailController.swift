//
//  TopicDetailController.swift
//  PinGo
//
//  Created by GaoWanli on 16/2/4.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

private let kCellReuseIdentifier              = "topicDetailCell"
private let kSectionHeaderViewReuseIdentifier = "sectionHeaderViewReuseIdentifier"
private let kHeaderViewHeight: CGFloat        = iPhone4s ? 180.0 : 280.0

class TopicDetailController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var layout: TopicDetailCollectionViewFlowLayout!
    
    var subjectID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInset = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0)
        collectionView.insertSubview(headerView, atIndex: 0)
        
        fetchData()
    }
    
    private func fetchData() {
        guard subjectID != nil else {
            return
        }
        if let subjectId = Int(subjectID!) {
            SubjectInfo.fetchSubjectInfo(subjectID: subjectId, completion: { [weak self] (subjectInfo, managerUserList) in
                if let strongSelf = self {
                    strongSelf.headerView.showDataList = (subjectInfo, managerUserList)
                }
                })
            
            TopicInfo.fetchSubjectTopicList(subjectID: subjectId, completion: {  [weak self] (isEnd, sortValue, topicInfoList) in
                if let strongSelf = self {
                    if topicInfoList?.count > 0 {
                        strongSelf.topicInfoList = topicInfoList!
                        strongSelf.layout.topicInfoList = topicInfoList!
                        strongSelf.collectionView.reloadData()
                    }
                }
                })
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        dispatch_async(dispatch_get_main_queue()) { () in
            self.headerView.frame = CGRectMake(0, -kHeaderViewHeight, CGRectGetWidth(self.view.bounds), kHeaderViewHeight)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationBarAlpha(0.0)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        setNavigationBarAlpha(1.0)
    }
    
    private func setNavigationBarAlpha(alpha: CGFloat) {
        if let navigationBar = navigationController?.navigationBar {
            if let bgView = navigationBar.valueForKey("_backgroundView") as? UIView {
                bgView.alpha = alpha
            }
            
            let titleAlpha = alpha > 0.8 ? alpha : 0
            //            if let titleView = navigationBar.valueForKey("_titleView") as? UIView {
            //                titleView.alpha = titleAlpha
            //            }
            navigationBar.titleTextAttributes = [
                NSFontAttributeName: kNavigationBarFont,
                NSForegroundColorAttributeName: UIColor(white: 1, alpha: titleAlpha)
            ]
        }
    }
    
    // MARK: lazy loading
    private lazy var topicInfoList: [TopicInfo] = {
        return [TopicInfo]()
    }()
    
    private lazy var headerView: TopicDetailHeaderView = {
        let t = TopicDetailHeaderView.loadFromNib()
        return t
    }()
}


extension TopicDetailController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topicInfoList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellReuseIdentifier, forIndexPath: indexPath) as! TopicDetailCell
        cell.topicInfo = topicInfoList[indexPath.item]
        return cell
    }
}

extension TopicDetailController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        
        if offset.y <= -(kHeaderViewHeight - kNavBarHeight) {
            setNavigationBarAlpha(0)
        }else {
            setNavigationBarAlpha(offset.y / (kHeaderViewHeight - kNavBarHeight))
        }
        
        if offset.y < kHeaderViewHeight {
            var frame = headerView.frame
            frame.origin.y = offset.y
            frame.size.height = -offset.y
            headerView.frame = frame
        }
    }
}
