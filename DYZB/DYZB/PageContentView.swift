//
//  PageContentView.swift
//  DYZB
//
//  Created by 胡迪 on 2016/10/24.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    //MARK: - 定义属性
    var chinldVCs:[UIViewController]
    var parentVC:UIViewController
    
    //MARK: - 懒加载属性
    lazy var contentView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame:CGRect.zero,collectionViewLayout:layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    //MARK: - 构造函数
    init(frame: CGRect,childVCs:[UIViewController],parentVC:UIViewController) {
        self.chinldVCs = childVCs
        self.parentVC = parentVC
        
        super.init(frame:frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


//MARK: - 设置UI
extension PageContentView {
    func setupUI()  {
        for childVC in chinldVCs {
            parentVC.addChildViewController(childVC)
        }
        addSubview(contentView)
        contentView.frame = bounds
    }
}


// MARK:- 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chinldVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = chinldVCs[(indexPath as NSIndexPath).item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}
