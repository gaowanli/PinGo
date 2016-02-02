//
//  ShowController.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

class ShowController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
 
    @IBAction func closeButtonClick(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    } 
}
