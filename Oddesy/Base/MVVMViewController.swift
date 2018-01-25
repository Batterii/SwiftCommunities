//
//  MVVMViewController.swift
//  px
//
//  Created by Anthony Kiniyalocts on 1/17/18.
//  Copyright © 2018 Anthony Kiniyalocts. All rights reserved.
//

import UIKit
class MVVMViewController : UIViewController, HasViewModel{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    
    func initView() {}
    func initViewModel() {}
    
    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
