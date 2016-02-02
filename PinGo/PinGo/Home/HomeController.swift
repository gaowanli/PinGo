//
//  HomeController.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

private let kCellReuseIdentifier = "homeCell"
private let kCellInsets = UIEdgeInsetsMake(15, 15, 15, 15)

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
        
        TopicInfo.fetchTopicInfoList(queryFollowData, order: 1, sortValue: sortValue) { (isEnd, sortValue, topicInfoList) in
            if topicInfoList?.count > 0 {
                self.baseSortValue = sortValue
                if query == .New {
                    self.dataList = topicInfoList!
                }else {
                    self.dataList.appendContentsOf(topicInfoList!)
                }
                if self.queryFollowData {
                    self.followDataList = self.dataList
                }else {
                    self.topDataList = self.dataList
                }
            }
            self.leftRefreshView.endRefresh()
            self.collectionView?.reloadData()
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