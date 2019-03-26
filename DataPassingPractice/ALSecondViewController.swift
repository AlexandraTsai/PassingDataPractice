//
//  ALSecondViewController.swift
//  DataPassingPractice
//
//  Created by 蔡佳宣 on 2019/3/25.
//  Copyright © 2019年 lohsts. All rights reserved.
//

import UIKit

class ALSecondViewController: UIViewController {
  
     /*Closure*/
    var text1Handler: (() -> Void)?
    
    /*Delegate*/
    weak var delegate: FetchTextDelegate?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    var secondVCText = Text()
    var observation: NSKeyValueObservation?

    deinit {
        print("-------VC2 is killed--------")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //KOV
//        self.observation = secondVCText.observe(\.text, options: .new) { (text, change) in
//
//            guard let newValue = change.newValue else {
//                return
//            }
//
//            self.label.text = newValue
//
//        }

        /*Notification*/
        createNotification()

    }
    
    @IBAction func clickOnButton(_ sender: Any) {
        
        let vc1 = self.navigationController?.viewControllers[0] as! ALViewController
        
        guard let text = textField.text else {
            return
        }
        vc1.loadViewIfNeeded()
       
        /*Delegate*/
//        self.delegate = vc
//        self.delegate?.fetchText(text)
       
        /*Property*/
//        vc.label.text = text
        
        /*Closure*/
//        text1Handler?() //For Page1
        
//        vc1.text2Handler = { [weak self] in   //For Page2
//
//            guard let text = vc1.textField.text else {
//                return
//
//            }
//
//            self?.label.text = text
//            print(text)
//        }
        
        /*KOV*/
//        vc1.firstVCText.text = text
        
        /*Notification*/ //回傳給第一頁的 observer
        let notificationName = Notification.Name("changeText")
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: [NotificationInfo.newText: text])

        self.navigationController?.popToRootViewController(animated: true)
       
    }
}

extension ALSecondViewController: FetchTextDelegate {
    
    func fetchText(_ text: String) {
        
        label.text = text
    }
    
}

//Notification (Get Text from VC2)
extension ALSecondViewController {
    
    func createNotification() {
        
        // 註冊第二頁的 Observer
        let notificationName = Notification.Name("changeSecondText")
        
        NotificationCenter.default.addObserver(self, selector:
            #selector(changeText(noti:)), name: notificationName, object: nil)
    }
    
    // Observer 收到通知後要執行的動作
    @objc func changeText(noti: Notification) {
        if let userInfo = noti.userInfo,
            let newText = userInfo[NotificationInfo.newText] as? String {
            label.text = newText
        }
    }
}

