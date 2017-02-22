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
        
        VisitorRecord.fetchVisitorRecord { [weak self] (visitorRecordList) in
            if let strongSelf = self {
                if visitorRecordList != nil {
                    strongSelf.dataList = visitorRecordList!
                    strongSelf.tableView.rowHeight = 50.0
                    strongSelf.tableView.reloadData()
                }
            }
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: lazy loading
    fileprivate lazy var dataList: [VisitorRecord] = {
        return [VisitorRecord]()
    }()
}

// MARK: - Table view data source
extension VisitorController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VisitorCell", for: indexPath) as! VisitorCell
        cell.visitorRecord = dataList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else {
            return nil
        }
        
        guard dataList.count != 0 else {
            return nil
        }
        
        let headerView = VisitorHeaderView.loadFromNib()
        let todayVisitor = dataList.filter {
            if let visitTime = $0.visitTime {
                if let date = Date.dateWithTimeStamp(visitTime) {
                    return date.isToday()
                }
            }
            return false
            }.count
        headerView.num = (dataList.count, todayVisitor)
        return headerView
    }
}
