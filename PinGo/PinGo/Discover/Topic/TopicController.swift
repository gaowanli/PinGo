//
//  TopicController.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

private let kCellReuseIdentifier = "topicCell"

class TopicController: UIViewController {
    
    @IBOutlet fileprivate weak var tableViewHeaderView: UIView!
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    fileprivate var headerView: TopicHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView = TopicHeaderView.loadFromNib()
        tableViewHeaderView.addSubview(headerView!)
        tableView.rowHeight = 170.0
        
        Banner.fetchBannerList(type: .square) { [weak self] (bannerList) in
            if let strongSelf = self {
                if bannerList != nil {
                    strongSelf.headerView.bannerList = bannerList
                }
            }
        }
        
        TopicInfo.fetchTopicInfoList { [weak self] (isEnd, sortValue, topicInfoList) in
            if let strongSelf = self {
                strongSelf.dataList = topicInfoList!
                strongSelf.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerView?.frame = tableViewHeaderView.bounds
    }
    
    // MARK: lazy loading
    fileprivate lazy var headerViewTextList: [String] = {
        return ["热门照片", "附近照片", "最新照片"]
    }()
    
    fileprivate lazy var dataList: [TopicInfo] = {
        return [TopicInfo]()
    }()
}

extension TopicController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count > 0 ? headerViewTextList.count : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellReuseIdentifier, for: indexPath) as! TopicCell
        cell.headerViewText = headerViewTextList[indexPath.section]
        
        // 将所有的数据分成x份 x = headerViewTextList.count
        let count = dataList.count
        let num = count / headerViewTextList.count
        
        let startIndex = indexPath.section * num
        let endIndex = startIndex + num - 1
        cell.photoInfoList = dataList.split(startIndex: startIndex, endIndex:endIndex)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
