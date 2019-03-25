//
//  ALSecondViewController.swift
//  DataPassingPractice
//
//  Created by 蔡佳宣 on 2019/3/25.
//  Copyright © 2019年 lohsts. All rights reserved.
//

import UIKit

class ALSecondViewController: UIViewController {
    
    typealias ReturnRoutine = (String) -> ()
    var notifier: ReturnRoutine?
    
//    weak var delegate: FetchTextDelegate?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func clickOnButton(_ sender: Any) {
        
        let vc1 = self.navigationController?.viewControllers[0] as! ALViewController
        
        guard let text = textField.text else {
            return
        }
        vc1.loadView()
        
        /*Delegate*/
//        self.delegate = vc
//        self.delegate?.fetchText(text)
       
        /*Property*/
//        vc.label.text = text
        
        vc1.notifier = { text in
            vc1.label.text = text
        }
        vc1.give(text)
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
}

extension ALSecondViewController: FetchTextDelegate {
    
    func fetchText(_ text: String) {
        
        label.text = text
    }
    
}

//Function For Closure (Get Text from VC1)
extension ALSecondViewController {
    
    func give(_ text: String) {
        if let notifier = notifier {
            notifier(text)
        }
    }
}
