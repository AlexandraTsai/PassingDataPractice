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

struct NotificationInfo {
    static let newText = ""
}

protocol FetchTextDelegate: AnyObject {

    func fetchText(_ text: String)

}

class ALViewController: UIViewController {
    
    var text2Handler: (()-> Void)?
    
    /*Delegate*/
    weak var delegate: FetchTextDelegate?

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!

    var firstVCText = Text()
    
//    var vc2 : ALSecondViewController = UIStoryboard(name: "ALStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ALSecondViewController") as! ALSecondViewController
    var observation: NSKeyValueObservation?
    
    deinit {
        print("-------VC1 is killed--------")
    }
    
   override func viewDidLoad() {
        super.viewDidLoad()

        /*KVO*/
//        self.observation = firstVCText.observe(\.text, options: .new) { (text, change) in
//
//            guard let newValue = change.newValue else {
//                return
//            }
//
//            self.label.text = newValue
//
//        }
    
        createNotification()

    }

    @IBAction func clickOnButton(_ sender: Any) {
        
        performSegue(withIdentifier: "GoSecondVCSegue", sender: self)
        
//        guard let text = textField.text else {
//            return
//        }
//        vc2.loadViewIfNeeded()
//        vc2.label.text = text
//        self.show(vc2, sender: nil)
//
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
//            text2Handler?() //For Page2
            
            vc2.text1Handler = { [weak self] in  //For Page1

                guard let text = vc2.textField.text else {
                    return

                }

                self?.label.text = text
            }
            
            /*KVO*/
//            vc2.viewDidLoad()
//            vc2.secondVCText.text = text
            
           /*Notification*/  // 回傳給第二頁的 observer
            let notificationName = Notification.Name("changeSecondText")
            NotificationCenter.default.post(name: notificationName, object: nil, userInfo: [NotificationInfo.newText: text])
        }

    }
}

extension ALViewController: FetchTextDelegate {
    
    func fetchText(_ text: String) {
        
        label.text = text
    }
    
}

//Notification (Get Text from VC2)
extension ALViewController {
    
    func createNotification() {
        
        // 註冊addObserver
        let notificationName = Notification.Name("changeText")
        
        NotificationCenter.default.addObserver(self, selector:
            #selector(changeText(noti:)), name: notificationName, object: nil)
    }
    
    // 收到通知後要執行的動作
    @objc func changeText(noti: Notification) {
        if let userInfo = noti.userInfo,
            let newText = userInfo[NotificationInfo.newText] as? String {
            label.text = newText
        }
    }
}
