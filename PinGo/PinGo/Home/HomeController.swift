//
//  HomeController.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

private let kCellReuseIdentifier = "homeCell"
private let kCellInsets          = UIEdgeInsetsMake(15, 15, 15, 15)
private let kToTopicDetailSegue  = "home2TopicDetail"

class HomeController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var layout: UICollectionViewFlowLayout!
    
    private var queryFollowData: Bool = false
    private var baseSortValue: String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = topMenu
        
        collectionView?.addSubview(leftRefreshView)
        
        loadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let width = CGRectGetWidth(view.bounds) - kCellInsets.left - kCellInsets.right
        let height = CGRectGetHeight(view.bounds) - kCellInsets.top - kCellInsets.bottom
        layout.itemSize = CGSizeMake(width, height)
    }
    
    func loadData() {
        loadData(.New)
    }
    
    private func loadData(query: QueryMethod) {
        var sortValue: String = ""
        if query == .New {
            sortValue = "0"
        }else {
            sortValue = baseSortValue
        }
        
        TopicInfo.fetchTopicInfoList(isFollow: queryFollowData, order: 1, sortValue: sortValue) { [weak self] (isEnd, sortValue, topicInfoList) in
            if let strongSelf = self {
                if topicInfoList?.count > 0 {
                    strongSelf.baseSortValue = sortValue
                    if query == .New {
                        strongSelf.dataList = topicInfoList!
                    }else {
                        strongSelf.dataList.appendContentsOf(topicInfoList!)
                    }
                    if strongSelf.queryFollowData {
                        strongSelf.followDataList = strongSelf.dataList
                    }else {
                        strongSelf.topDataList = strongSelf.dataList
                    }
                }
                strongSelf.leftRefreshView.endRefresh()
                strongSelf.collectionView?.reloadData()
            }
        }
    }
    
    // MARK: lazy loading
    private lazy var topMenu: TopMenu = {
        let t = TopMenu.loadFromNib()
        t.showText = ("精选", "关注")
        t.delegate = self
        return t
    }()
    
    private lazy var leftRefreshView: LeftRefreshView = {
        let v = LeftRefreshView()
        v.addTarget(self, action: "loadData", forControlEvents: .ValueChanged)
        return v
    }()
    
    private lazy var dataList: [TopicInfo] = {
        return [TopicInfo]()
    }()
    
    /// “精选”数据
    private lazy var topDataList: [TopicInfo] = {
        return [TopicInfo]()
    }()
    
    /// “关注”数据
    private lazy var followDataList: [TopicInfo] = {
        return [TopicInfo]()
    }()
}

// MARK: UICollectionViewDataSource
extension HomeController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellReuseIdentifier, forIndexPath: indexPath) as! HomeCollectionViewCell
        cell.delegate = self
        cell.topiInfo = dataList[indexPath.row]
        return cell
    }
}

extension HomeController: TopMenuDelegate {
    
    func topMenu(topMenu: TopMenu, didClickButton index: Int) {
        queryFollowData = (index == 1)
        
        if followDataList.count > 0 {
            self.dataList = (index == 0) ? self.topDataList : self.followDataList
            self.collectionView.reloadData()
            return
        }
        loadData()
    }
}

extension HomeController: HomeCollectionViewCellDelegate {
    
    func homeCollectionViewCell(cell: HomeCollectionViewCell, didClickButton button: UIButton, withButtonType btnType: HomeCollectionViewCellButtonType, withTopiInfo topiInfo: TopicInfo) {
        switch btnType {
        case .Tag:
            cellDidClickTagButton(topiInfo)
        case .Chat:
            cellDidClickChatButton(topiInfo)
        case .Comment:
            cellDidClickCommentButton(topiInfo)
        case .Star:
            cellDidClickStarButton(topiInfo)
        }
    }
    
    private func cellDidClickTagButton(topiInfo: TopicInfo) {
        performSegueWithIdentifier(kToTopicDetailSegue, sender: topiInfo)
    }
    
    private func cellDidClickChatButton(topiInfo: TopicInfo) {
        
    }
    
    private func cellDidClickCommentButton(topiInfo: TopicInfo) {
        
    }
    
    private func cellDidClickStarButton(topiInfo: TopicInfo) {
        
    }
}

extension HomeController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == kToTopicDetailSegue {
            if let toVC = segue.destinationViewController as? TopicDetailController  {
                toVC.subjectID = (sender as! TopicInfo).subjectID
                toVC.title = (sender as! TopicInfo).subjectTitle
            }
        }
    }
}