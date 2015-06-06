//
//  SettingsViewController.swift
//  swift-socket-example
//
//  Created by Yuta Akizuki on 2014/12/23.
//  Copyright (c) 2014年 ytakzk.me. All rights reserved.
//

import UIKit

private let nameLimit:Int = 30

extension String{
    var length:Int{return count(self)}
}

class SettingsViewController: UIViewController, UITextFieldDelegate {
    var closeMe: () -> Void = {}

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = MyUtils().username
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // 入力された文字数の数を制限する
        if (textField.text + string).length < nameLimit {
            return true
        }
        return false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        closeMe()
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // 条件にある文字列だけ保存
        let name = textField.text
        if MyUtils().stringHasContent(name) && name.length < nameLimit {
            MyUtils().username = name
        }
        return true
    }

}
