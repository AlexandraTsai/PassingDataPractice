//
//  ALSecondViewController.swift
//  DataPassingPractice
//
//  Created by 蔡佳宣 on 2019/3/25.
//  Copyright © 2019年 lohsts. All rights reserved.
//

import UIKit

class ALSecondViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func clickOnButton(_ sender: Any) {
    }
}

extension ALSecondViewController: FetchTextDelegate {
    
    func fetchText(_ text: String) {
        
        label.text = text
    }
    
}
