//
//  TopicDetailCollectionViewFlowLayout.swift
//  Pods
//
//  Created by GaoWanli on 16/2/4.
//
//

import UIKit

class TopicDetailCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var topicInfoList: [TopicInfo]!
    
    /// 一行显示的item个数
    fileprivate let rowItemNum = 2
    
    override func prepare() {
        super.prepare()
        
        let itemWidth = (kScreenWidth - (CGFloat(rowItemNum - 1) * minimumInteritemSpacing) - sectionInset.left - sectionInset.right) / CGFloat(rowItemNum)
        // 计算所有item的布局属性
        calcAllItemLayoutAttributeByItemWidth(itemWidth)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
    
    /// 设置collectionView的滚动范围
    override var collectionViewContentSize : CGSize {
        let y = (colItemHeightValues?.sorted().last)! - minimumInteritemSpacing;
        return CGSize(width: UIScreen.main.bounds.width, height: y + sectionInset.bottom)
    }
    
    // MARK: lazy loading
    /// 布局属性数组
    fileprivate lazy var layoutAttributes: [UICollectionViewLayoutAttributes]? = {
        return [UICollectionViewLayoutAttributes]()
    }()
    
    /// 列高数组
    fileprivate lazy var colItemHeightValues: [CGFloat]? = {
        return [CGFloat](repeating: self.sectionInset.top, count: self.rowItemNum)
    }()
}

extension TopicDetailCollectionViewFlowLayout {
    /**
     计算所有item的布局属性
     */
    fileprivate func calcAllItemLayoutAttributeByItemWidth(_ itemWidth: CGFloat) {
        guard topicInfoList != nil else {
            return
        }
        
        var index = 0
        for _ in topicInfoList {
            let attribute = calcItemLayoutAttribute(index, itemWidth: itemWidth)
            layoutAttributes?.append(attribute)
            
            index = index + 1
        }
    }
    
    /**
     计算一个item的布局属性
     */
    fileprivate func calcItemLayoutAttribute(_ index: Int, itemWidth: CGFloat) -> UICollectionViewLayoutAttributes {
        // 创建布局属性
        let attribute = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: index, section: 0))
        
        // 高度最小的列号和列高
        let colAndHeight = findMinHeightColIndexAndHeight()
        
        let x = sectionInset.left + CGFloat(colAndHeight.col) * (itemWidth + minimumInteritemSpacing)
        let y = colAndHeight.height
        let h = calcItemHeight(index, width: itemWidth)
        
        // 将item的高度添加到数组进行记录
        colItemHeightValues![colAndHeight.col] += (h + minimumLineSpacing)
        
        // 设置frame
        attribute.frame = CGRect(x: x, y: y, width: itemWidth, height: h)
        return attribute
    }
    
    /**
     根据数据源中的宽高计算等比例的高度
     
     :returns: item的高度
     */
    fileprivate func calcItemHeight(_ index: Int, width: CGFloat) -> CGFloat {
        let bgImageH = width * 4.0 / 3.0
        
        var descLabelH: CGFloat = 10 // 底部文字默认高度
        if let desc = topicInfoList[index].content {
            descLabelH = String.size(withText: desc, withFont: UIFont.fontWithSize(10), andMaxSize: CGSize(width: width, height: CGFloat(MAXFLOAT))).height
        }
        let userIconH: CGFloat = 25 // 头像高度
        let margin: CGFloat = 5
        return margin + userIconH + margin + bgImageH + margin + descLabelH + margin
    }
    
    /**
     找出高度最小的列
     
     - returns: 列号和列高
     */
    fileprivate func findMinHeightColIndexAndHeight() -> (col: Int, height: CGFloat) {
        var minHeight: CGFloat = colItemHeightValues![0]
        var index = 0
        for i in 0..<rowItemNum {
            let h = colItemHeightValues![i]
            if minHeight > h {
                minHeight = h
                index = i
            }
        }
        return (index, minHeight)
    }
}
