//
//  ALViewController.swift
//  DataPassingPractice
//
//  Created by 蔡佳宣 on 2019/3/25.
//  Copyright © 2019年 lohsts. All rights reserved.
//

import UIKit

protocol FetchTextDelegate: AnyObject {
    
    func fetchText(_ text: String)
    
}

class ALViewController: UIViewController {
    
    typealias ReturnRoutine = (String) -> ()
    var notifier: ReturnRoutine?

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
   override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func clickOnButton(_ sender: Any) {
        
        performSegue(withIdentifier: "GoSecondVCSegue", sender: self)
//            self.delegate?.fetchText(text)
//            print(secondVC.label.text)
        
            
//            navigationController?.pushViewController(secondVC, animated: true)
        
//        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoSecondVCSegue" {
            let vc = segue.destination as! ALSecondViewController

            guard let text = textField.text else {
                return
            }
            vc.loadView()
            
            /*Delegate*/
//            self.delegate = vc
//            self.delegate?.fetchText(text)

            /*Property*/
//            vc.label.text = text
            
            vc.notifier = { text in
               vc.label.text = text
            }
            vc.give(text)
        }
        
    }
}

extension ALViewController: FetchTextDelegate {
    
    func fetchText(_ text: String) {
        
        label.text = text
    }
    
}

//Function For Closure (Get Text from VC2)
extension ALViewController {
    
    func give(_ text: String) {
        if let notifier = notifier {
            notifier(text)
        }
    }
}
