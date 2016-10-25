//
//  PageTitleView.swift
//  DYZB
//
//  Created by 胡迪 on 2016/10/18.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitle(titleView : PageTitleView,selectedIndex Index : Int)
}

let kScrollLineH:CGFloat = 2

class PageTitleView: UIView {
    
    //MARK: - 定义属性
    var titles : [String]
    var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    //MARK: - 懒加载属性
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
        return scrollLine
    }()

    lazy var titleLabels:[UILabel] = [UILabel]()
    
    //MARK: - 构造函数
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
            
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tap:)))
            label.addGestureRecognizer(tap)
        }
    }
    
    func setupBottomMenuAndScrollLine() {
        let buttonline = UIView()
        buttonline.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        buttonline.frame = CGRect(x: 0, y: frame.height - lineH, width: bounds.width, height: lineH)
        addSubview(buttonline)
        
        scrollView.addSubview(scrollLine)
        
        guard let fristLabel = titleLabels.first else{
            print("不在setupLabels里增加titleLabels.append(label)就执行此方法")
            return }
//        scrollLine.addSubview(buttonline)
        scrollLine.frame = CGRect(x: fristLabel.frame.origin.x, y: frame.height - kScrollLineH, width:fristLabel.frame.width , height: kScrollLineH)
        
    }
}


//MARK: - 监听label的点击
extension PageTitleView{
    @objc func titleLabelClick(tap:UITapGestureRecognizer){
        
        //1 获取当前label
        guard let currentLabel = tap.view as? UILabel else { return }
        
        //2 获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //3 切换颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        
        //4 保存新的label的下标值
        currentIndex = currentLabel.tag
        
        //5 滚动条位置的改变
        let scrollLinePostion = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15){
            self.scrollLine.frame.origin.x = scrollLinePostion
        }
        
        //6 通知代理
        delegate?.pageTitle(titleView: self, selectedIndex: currentLabel.tag)
    }
}


//MARK: - 代理协议

