//
//  TestVC.swift
//  SwiftLearning
//
//  Created by claudechoi on 2019/4/16.
//  Copyright © 2019 蔡晓东. All rights reserved.
//

import UIKit

class TestVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    
    func setupUI() {
        self.title = "Test"
        let testView = TestView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.width, height: self.view.height))
        self.view.addSubview(testView)
    }
    
    class func classFucntion() {
        
    }

}
