//
//  BSAlert.swift
//  MobileBanking
//
//  Created by Douglas Henrique Goulart Nunes on 10/04/2018.
//  Copyright © 2018 BS2. All rights reserved.
//

import Foundation
import UIKit

protocol Modal {
  var backgroundView:UIView { get }
  var dialogView:UIView { get set }
  
  func show(animated: Bool, alpha: CGFloat, paddingTop: Bool)
  func dismiss(animated: Bool)
}

extension Modal where Self: UIView {
  
  func show(animated:Bool, alpha:CGFloat, paddingTop: Bool) {
      self.backgroundView.alpha = 0
      if var topController = UIApplication.shared.delegate?.window??.rootViewController {
        while let presentedViewController = topController.presentedViewController {
          topController = presentedViewController
        }
        topController.view.addSubview(self)
      }
      
      if animated {
        UIView.animate(withDuration: 0.33, animations: {
          self.backgroundView.alpha = alpha
        })
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
          let padding: CGFloat = paddingTop ? 30.0 : 0.0
          var positionCenter = self.center
          positionCenter.y -= padding
          self.dialogView.center = positionCenter
        }, completion: { ( _ ) in
          
        })
      } else {
        self.backgroundView.alpha = alpha
        let padding: CGFloat = paddingTop ? 30.0 : 0.0
        var positionCenter = self.center
        positionCenter.y -= padding
        self.dialogView.center = positionCenter
      }    
  }
  
  func dismiss(animated:Bool) {
    if animated {
      UIView.animate(withDuration: 0.33, animations: {
        self.backgroundView.alpha = 0
      }, completion: { ( _ ) in
        
      })
      UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
        self.dialogView.center = CGPoint(x: self.center.x, y: self.frame.height + self.dialogView.frame.height/2)
      }, completion: { ( _ ) in
        self.removeFromSuperview()
      })
    } else {
      self.removeFromSuperview()
    }
  }
  
}
