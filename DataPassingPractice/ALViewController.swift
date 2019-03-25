//
//  ALViewController.swift
//  DataPassingPractice
//
//  Created by 蔡佳宣 on 2019/3/25.
//  Copyright © 2019年 lohsts. All rights reserved.
//

import UIKit

class Text: NSObject {
    
    @objc dynamic var text = ""
    
    override init() {
        super.init()
    }
}

protocol FetchTextDelegate: AnyObject {
    
    func fetchText(_ text: String)
    
}

class ALViewController: UIViewController {
    
    typealias ReturnRoutine = (String) -> ()
    var notifier: ReturnRoutine?

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!

    var firstVCText = Text()
    var secondVC = ALSecondViewController()
    var observation: NSKeyValueObservation?
    
   override func viewDidLoad() {
        super.viewDidLoad()

        //KOV
        self.observation = firstVCText.observe(\.text, options: .new) { (text, change) in
            
            guard let newValue = change.newValue else {
                return
            }

            self.label.text = newValue
            
        }

    }

    @IBAction func clickOnButton(_ sender: Any) {
        
        performSegue(withIdentifier: "GoSecondVCSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "GoSecondVCSegue" {
            let vc2 = segue.destination as! ALSecondViewController

            guard let text = textField.text else {
                return
            }
            vc2.loadViewIfNeeded()

//            /*Delegate*/
//            self.delegate = vc2
//            self.delegate?.fetchText(text)

            /*Property*/
//            vc2.label.text = text

            /*Closure*/
//            vc2.notifier = { text in
//               vc2.label.text = text
//            }
//            vc2.give(text)

//            textInTextField.text = text
//            print(textInTextField)
            
            /*KVO*/
            vc2.viewDidLoad()
            vc2.secondVCText.text = text
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
