//
//  ALViewController.swift
//  DataPassingPractice
//
//  Created by 蔡佳宣 on 2019/3/25.
//  Copyright © 2019年 lohsts. All rights reserved.
//

import UIKit

protocol FetchTextDelegate {
    
    func fetchText(_ text: String)
    
}

class ALViewController: UIViewController {
    
    var delegate: FetchTextDelegate?
    
//    var secondVC = UIStoryboard(name: "ALStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ALSecondViewController") as! ALSecondViewController
    
  
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
   override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func clickOnButton(_ sender: Any) {
        
//        if let secondVC = storyboard?.instantiateViewController(withIdentifier: "ALSecondViewController") as? ALSecondViewController {
        
//            self.delegate = secondVC
        
        
        
//           secondVC.label.text =  text
        
        
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

            vc.label.text = text
            
        }
        
    }
}

