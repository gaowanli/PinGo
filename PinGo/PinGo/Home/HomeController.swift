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
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet fileprivate weak var layout: UICollectionViewFlowLayout!
    
    fileprivate var queryFollowData: Bool = false
    fileprivate var baseSortValue: String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = topMenu
        
        collectionView?.addSubview(leftRefreshView)
        
        loadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let width = view.bounds.width - kCellInsets.left - kCellInsets.right
        let height = view.bounds.height - kCellInsets.top - kCellInsets.bottom
        layout.itemSize = CGSize(width: width, height: height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func loadData() {
        loadData(.new)
    }
    
    fileprivate func loadData(_ query: QueryMethod) {
        var sortValue: String = ""
        if query == .new {
            sortValue = "0"
        }else {
            sortValue = baseSortValue
        }
        
        TopicInfo.fetchTopicInfoList(isFollow: queryFollowData, order: 1, sortValue: sortValue) { [weak self] (isEnd, sortValue, topicInfoList) in
            if let strongSelf = self {
                if let `topicInfoList` = topicInfoList, `topicInfoList`.count > 0 {
                    strongSelf.baseSortValue = sortValue
                    if query == .new {
                        strongSelf.dataList = `topicInfoList`
                    }else {
                        strongSelf.dataList.append(contentsOf: `topicInfoList`)
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
    fileprivate lazy var topMenu: TopMenu = {
        let t = TopMenu.loadFromNib()
        t.showText = ("精选", "关注")
        t.delegate = self
        return t
    }()
    
    fileprivate lazy var leftRefreshView: LeftRefreshView = {
        let v = LeftRefreshView()
        v.addTarget(self, action: #selector(HomeController.loadData as (HomeController) -> () -> ()), for: .valueChanged)
        return v
    }()
    
    fileprivate lazy var dataList: [TopicInfo] = {
        return [TopicInfo]()
    }()
    
    /// “精选”数据
    fileprivate lazy var topDataList: [TopicInfo] = {
        return [TopicInfo]()
    }()
    
    /// “关注”数据
    fileprivate lazy var followDataList: [TopicInfo] = {
        return [TopicInfo]()
    }()
}

// MARK: UICollectionViewDataSource
extension HomeController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellReuseIdentifier, for: indexPath) as! HomeCollectionViewCell
        cell.delegate = self
        cell.topiInfo = dataList[indexPath.row]
        return cell
    }
}

extension HomeController: TopMenuDelegate {
    
    func topMenu(_ topMenu: TopMenu, didClickButton index: Int) {
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
    
    func homeCollectionViewCell(_ cell: HomeCollectionViewCell, didClickButton button: UIButton, withButtonType btnType: HomeCollectionViewCellButtonType, withTopiInfo topiInfo: TopicInfo) {
        switch btnType {
        case .tag:
            cellDidClickTagButton(topiInfo)
        case .chat:
            cellDidClickChatButton(topiInfo)
        case .comment:
            cellDidClickCommentButton(topiInfo)
        case .star:
            cellDidClickStarButton(topiInfo)
        }
    }
    
    fileprivate func cellDidClickTagButton(_ topiInfo: TopicInfo) {
        performSegue(withIdentifier: kToTopicDetailSegue, sender: topiInfo)
    }
    
    fileprivate func cellDidClickChatButton(_ topiInfo: TopicInfo) {
        
    }
    
    fileprivate func cellDidClickCommentButton(_ topiInfo: TopicInfo) {
        
    }
    
    fileprivate func cellDidClickStarButton(_ topiInfo: TopicInfo) {
        
    }
}

extension HomeController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kToTopicDetailSegue {
            if let toVC = segue.destination as? TopicDetailController  {
                toVC.subjectID = (sender as! TopicInfo).subjectID
                toVC.title = (sender as! TopicInfo).subjectTitle
            }
        }
    }
}
