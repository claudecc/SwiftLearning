//
//  LoginVC.swift
//  SwiftLearning
//
//  Created by 蔡晓东 on 2018/3/22.
//  Copyright © 2018年 蔡晓东. All rights reserved.
//

import UIKit

class LoginVC: BaseVC {

    private var nameInputView:UIInputView!
    private var passInputView:UIInputView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }

    func setupUI() {
        let nameRect = CGRect(x: 100, y: 100, width: 100, height: 30)
        nameInputView = UIInputView(frame: nameRect, inputViewStyle: .default)
        self.view.addSubview(nameInputView)
        
        let passRect = CGRect(x: 100, y: 100, width: 100, height: 30)
        passInputView = UIInputView(frame: passRect, inputViewStyle: .default)
        self.view.addSubview(passInputView)
        
        
    }
}
