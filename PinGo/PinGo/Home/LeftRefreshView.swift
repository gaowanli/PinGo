//
//  LeftRefreshView.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/31.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

enum LeftRefreshViewState {
    case `default`, pulling, refreshing
}

private let kLeftRefreshViewWidth: CGFloat = 65.0

class LeftRefreshView: UIControl {
    
    fileprivate var scrollView: UIScrollView?
    
    fileprivate var beforeState: LeftRefreshViewState = .default
    fileprivate var refreshState: LeftRefreshViewState = .default {
        didSet {
            switch refreshState {
            case .default:
                imageView.shouldAnimating = false
                if beforeState == .refreshing {
                    UIView.animate(withDuration: 0.25, animations: { () in
                        var contentInset = self.scrollView!.contentInset
                        contentInset.left -= kLeftRefreshViewWidth
                        self.scrollView?.contentInset = contentInset
                        debugPrint("\(type(of: self)) \(#function) \(#line)")
                    })
                }
            case .pulling:
                imageView.shouldAnimating = true
                debugPrint("\(type(of: self)) \(#function) \(#line)")
            case .refreshing:
                UIView.animate(withDuration: 0.25, animations: { () in
                    var contentInset = self.scrollView!.contentInset
                    contentInset.left += kLeftRefreshViewWidth
                    self.scrollView?.contentInset = contentInset
                    debugPrint("\(type(of: self)) \(#function) \(#line)")
                })
                // 调用刷新的方法
                sendActions(for: .valueChanged)
            }
            beforeState = refreshState
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if let s = newSuperview, s.isKind(of: UIScrollView.self) {
            s.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.new, context: nil)
            scrollView = s as? UIScrollView
            frame = CGRect(x: -kLeftRefreshViewWidth, y: 0, width: kLeftRefreshViewWidth, height: s.bounds.height)
            addSubview(imageView)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let leftInset = scrollView!.contentInset.left
        let offsetX = scrollView!.contentOffset.x
        
        let criticalValue = -leftInset - bounds.width
        // 拖动
        if scrollView!.isDragging {
            if refreshState == .default && offsetX < criticalValue {
                // 完全显示出来
                refreshState = .pulling
            }else if refreshState == .pulling && offsetX >= criticalValue {
                // 没有完全显示出来/没有显示出来
                refreshState = .default
            }
        }else {
            // 结束拖动
            if refreshState == .pulling {
                refreshState = .refreshing
            }
        }
    }
    
    func endRefresh() {
        refreshState = .default
    }
    
    deinit {
        if let s = scrollView {
            s.removeObserver(self, forKeyPath: "contentOffset")
        }
    }
    
    // MARK: lazy loading
    fileprivate lazy var imageView: LeftImageView = {
        let y = (self.bounds.height - kLeftRefreshViewWidth) * 0.5 - self.scrollView!.contentInset.top - kTabBarHeight
        let i = LeftImageView(frame: CGRect(x: 0, y: y, width: kLeftRefreshViewWidth, height: kLeftRefreshViewWidth))
        i.image = UIImage(named: "loading0")
        i.contentMode = .center
        return i
    }()
}

private class LeftImageView: UIImageView {
    
    var shouldAnimating: Bool = false {
        didSet {
            if shouldAnimating {
                if !isAnimating {
                    var images = [UIImage]()
                    for i in 0..<3 {
                        images.append(UIImage(named: "loading\(i)")!)
                    }
                    self.animationImages = images
                    self.animationDuration = 1.0
                    startAnimating()
                }
            }else {
                stopAnimating()
            }
        }
    }
}
