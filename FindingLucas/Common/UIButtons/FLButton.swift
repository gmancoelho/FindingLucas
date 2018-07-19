//
//  BSButtonConstants.swift
//  MobileBanking
//
//  Created by Guilherme Coelho on 28/03/2018.
//  Copyright © 2018 BS2. All rights reserved.
//

import UIKit

class FLButton: UIButton {
  
  // MARK: - Class Properties
  
  private var title:String = ""
  private var shadowLayer: CAShapeLayer!
  
  var indicatorColor = FLColors.black
  
  // MARK: - Public Properties
  
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
    let rad = self.frame.height/2
    self.roundCorners(.allCorners, radius: rad)
    
  }
  
  // MARK: - Class Methods
  
  private func setDefaultColors() {
    
    self.setTitleColor(.white, for: .normal)
    self.backgroundColor = FLColors.navyBlue
  }
  
  private func setShadow() {
    
    let size = self.layer.frame.height / 2
    shadowLayer = CAShapeLayer()
    shadowLayer.path = UIBezierPath(roundedRect: bounds,
                                    cornerRadius: size).cgPath
    
    let bgColor:UIColor = FLColors.navyBlue
    shadowLayer.fillColor = bgColor.cgColor
    
    shadowLayer.shadowColor = UIColor.darkGray.cgColor
    shadowLayer.shadowPath = shadowLayer.path
    shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    shadowLayer.shadowOpacity = 0.8
    shadowLayer.shadowRadius = 2
    
    //layer.insertSublayer(shadowLayer, at: 0)
  }
  
  // MARK: - Public Methods
  
  func setFont(font:FLFonts, size:CGFloat) {
    
    if let titleLabel = self.titleLabel {
      titleLabel.font = UIFont(name: font.name,
                               size: size)
      self.layoutSubviews()
    }
    
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
