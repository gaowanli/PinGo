//
//  VisitorController.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class VisitorController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VisitorRecord.fetchVisitorRecord { (visitorRecordList) in
            if visitorRecordList != nil {
                self.dataList = visitorRecordList!
                self.tableView.rowHeight = 50.0
                self.tableView.reloadData()
            }
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: lazy loading
    private lazy var dataList: [VisitorRecord] = {
        return [VisitorRecord]()
    }()
}

// MARK: - Table view data source
extension VisitorController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VisitorCell", forIndexPath: indexPath) as! VisitorCell
        cell.visitorRecord = dataList[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else {
            return nil
        }
        
        guard dataList.count != 0 else {
            return nil
        }
        
        let headerView = VisitorHeaderView.loadFromNib()
        let todayVisitor = dataList.filter {
            if let visitTime = $0.visitTime {
                if let date = NSDate.dateWithTimeStamp(visitTime) {
                    return date.isToday()
                }
            }
            return false
            }.count
        headerView.num = (dataList.count, todayVisitor)
        return headerView
    }
}
