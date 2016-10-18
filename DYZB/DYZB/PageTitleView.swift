//
//  PageTitleView.swift
//  DYZB
//
//  Created by 胡迪 on 2016/10/18.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

let kScrollLineH:CGFloat = 2

class PageTitleView: UIView {
     var titles : [String]
    
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    
    lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        print("123")
        return scrollLine
    }()

    lazy var titleLabels:[UILabel] = [UILabel]()
    
    init(frame : CGRect,titles : [String]) {
        self.titles = titles
        
        super.init(frame:frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleView {
    func setUpUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        setupLabels()
        setupBottomMenuAndScrollLine()
    }
    
    private func setupLabels() {
        let labelY : CGFloat = 0
        let labelH : CGFloat = frame.height - kScrollLineH

        for (index,title) in titles.enumerated(){
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 17)
            label.tintColor = UIColor.darkGray
            label.textAlignment = .center
            
            let labelW:CGFloat = frame.width / CGFloat(titles.count)
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    func setupBottomMenuAndScrollLine() {
        let buttonline = UIView()
        buttonline.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        buttonline.frame = CGRect(x: 0, y: frame.height - lineH, width: bounds.width, height: lineH)
        addSubview(buttonline)
        
        scrollView.addSubview(scrollLine)
        
        guard let fristLabel = titleLabels.first else{ return }
//        scrollLine.addSubview(buttonline)
        scrollLine.frame = CGRect(x: fristLabel.frame.origin.x, y: frame.height - kScrollLineH, width:fristLabel.frame.width , height: kScrollLineH)
        
    }
}
