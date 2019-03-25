//
//  ALSecondViewController.swift
//  DataPassingPractice
//
//  Created by 蔡佳宣 on 2019/3/25.
//  Copyright © 2019年 lohsts. All rights reserved.
//

import UIKit

class ALSecondViewController: UIViewController {
    
    weak var delegate: FetchTextDelegate?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func clickOnButton(_ sender: Any) {
        
        let vc = self.navigationController?.viewControllers[0] as! ALViewController
        
        guard let text = textField.text else {
            return
        }
        vc.loadView()
        
        /*Property*/
        
//        vc.label.text = text
        
        self.delegate = vc
        self.delegate?.fetchText(text)
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
}

extension ALSecondViewController: FetchTextDelegate {
    
    func fetchText(_ text: String) {
        
        label.text = text
    }
    
}
