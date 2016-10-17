//
//  HomeViewController.swift
//  DYZB
//
//  Created by 胡迪 on 2016/10/17.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupUI(){
        setNavigationBar()
    }
    
    private func setNavigationBar(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let size = CGSize(width: 40, height: 40)
        
        let his = UIBarButtonItem(imageName: "image_my_history", highImage: "Image_my_history_click", size: size)
        let scan = UIBarButtonItem(imageName: "Image_scan", highImage: "Image_scan_click", size: size)
        let search = UIBarButtonItem(imageName: "btn_search", highImage: "btn_search_clicked", size: size)
        
        navigationItem.rightBarButtonItems = [his,scan,search]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
