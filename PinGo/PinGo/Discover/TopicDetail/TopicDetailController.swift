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
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet fileprivate weak var layout: TopicDetailCollectionViewFlowLayout!
    
    var subjectID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInset = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0)
        collectionView.insertSubview(headerView, at: 0)
        
        fetchData()
    }
    
    fileprivate func fetchData() {
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
                    if let `topicInfoList` = topicInfoList, `topicInfoList`.count > 0 {
                        strongSelf.topicInfoList = `topicInfoList`
                        strongSelf.layout.topicInfoList = `topicInfoList`
                        strongSelf.collectionView.reloadData()
                    }
                }
            })
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        DispatchQueue.main.async { () in
            self.headerView.frame = CGRect(x: 0, y: -kHeaderViewHeight, width: self.view.bounds.width, height: kHeaderViewHeight)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    fileprivate func setNavigationBarAlpha(_ alpha: CGFloat) {
        if let navigationBar = navigationController?.navigationBar {
            if let bgView = navigationBar.value(forKey: "_backgroundView") as? UIView {
                bgView.alpha = alpha
            }
            
            let titleAlpha = alpha > 0.8 ? alpha : 0
            navigationBar.titleTextAttributes = [
                //            if let titleView = navigationBar.valueForKey("_titleView") as? UIView {
                //                titleView.alpha = titleAlpha
                //            }
                NSFontAttributeName: kNavigationBarFont,
                NSForegroundColorAttributeName: UIColor(white: 1, alpha: titleAlpha)
            ]
        }
    }
    
    // MARK: lazy loading
    fileprivate lazy var topicInfoList: [TopicInfo] = {
        return [TopicInfo]()
    }()
    
    fileprivate lazy var headerView: TopicDetailHeaderView = {
        let t = TopicDetailHeaderView.loadFromNib()
        return t
    }()
}


extension TopicDetailController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topicInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellReuseIdentifier, for: indexPath) as! TopicDetailCell
        cell.topicInfo = topicInfoList[indexPath.item]
        return cell
    }
}

extension TopicDetailController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        
        if offset.y <= -(kHeaderViewHeight - kNavBarHeight) {
            navigationController?.setNavigationBarHidden(true, animated: false)
        }else {
            navigationController?.setNavigationBarHidden(false, animated: false)
        }
        
        if offset.y < kHeaderViewHeight {
            var frame = headerView.frame
            frame.origin.y = offset.y
            frame.size.height = -offset.y
            headerView.frame = frame
        }
    }
}
