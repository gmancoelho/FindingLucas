//
//  BSBlueBorderButton.swift
//  MobileBanking
//
//  Created by Guilherme Coelho on 25/05/2018.
//  Copyright © 2018 BS2. All rights reserved.
//

import UIKit

class FLBlueBorderButton: UIButton {
  
  // MARK: - Private Properties
  private var title:String = ""

  // MARK: - Class Init
  
  override init(frame: CGRect) {
    // set myValue before super.init is called
    super.init(frame: frame)
    // set other operations after super.init, if required
  }
  
  override public func awakeFromNib() {
    super.awakeFromNib()
    
    self.addTarget(self,
                   action: #selector(pulseAnimation),
                   for: .touchUpInside)
    
    self.addTarget(self,
                   action: #selector(disableForASec),
                   for: .touchUpInside)
    
    if let titleLabel = self.titleLabel,
      let text = titleLabel.text {
      self.title = text
      titleLabel.font = UIFont(name: FLFonts.montserratReg.name,
                               size: 14)
    }
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    /// Set Round Corners
    layer.cornerRadius = 4
    layer.borderWidth = 2
    layer.borderColor = FLColors.navyBlue.cgColor
    
  }
  
  // MARK: - Touch Animation
  
  @objc func disableForASec() {
    self.isUserInteractionEnabled = false
    DispatchQueue.main.async {
      Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
        self.isUserInteractionEnabled = true
      }
    }
    
  }
  
  @objc func pulseAnimation() {
    
    UIView.animate(withDuration: TimeInterval(0.1), animations: {
      
      self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
      
    }, completion: { _ in
      
      UIView.animate(withDuration: TimeInterval(0.1),
                     animations: {
                      () -> Void in
                      self.transform = CGAffineTransform(scaleX: 1, y: 1)
      })
      
    })
  }

}
