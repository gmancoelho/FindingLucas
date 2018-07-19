//
//  UIViewController.swift
//  MobileBanking
//
//  Created by Guilherme Coelho on 04/04/2018.
//  Copyright © 2018 BS2. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func hideKeyboardWhenTap() {
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}
