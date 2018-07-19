//
//  BSButton.swift
//  MobileBanking
//
//  Created by Guilherme Coelho on 27/03/2018.
//  Copyright © 2018 BS2. All rights reserved.
//

import UIKit

class FLBlueButton: FLButton {
  
  // MARK: - Class Properties
  private var indicatorView:UIActivityIndicatorView = UIActivityIndicatorView()
  private var title:String = ""

  // MARK: - Public Properties
  
  // MARK: - Class Init
  
  override init(frame: CGRect) {
    // set myValue before super.init is called
    super.init(frame: frame)
    // set other operations after super.init, if required
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override public func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    /// Set Colors
    setDefaultColors()
    
    /// SetUp IndicatorView inside the button
    setUpIndicatorView()
    
    if let titleLabel = self.titleLabel,
      let text = titleLabel.text {
      self.title = text
      
    }
  }
  
  // MARK: - Class Methods
  
  private func setDefaultColors() {
    
    self.setTitleColor(.white, for: .normal)
    self.backgroundColor = isEnabled ? FLColors.navyBlue : FLColors.tiffany
    self.indicatorColor = FLColors.white

  }
  
  public func callingPhone(phoneNumber: String) {
    
    let phoneNumberFormated = phoneNumber.removingWhitespaces()
    
    if let phoneCallURL = URL(string: "tel://\(phoneNumberFormated))") {
      
      let application:UIApplication = UIApplication.shared
      if (application.canOpenURL(phoneCallURL)) {
        application.open(phoneCallURL, options: [:], completionHandler: nil)
      }
    }
  }
  
  private func setUpIndicatorView() {
    
    let buttonHeight = self.bounds.size.height
    let buttonWidth = self.bounds.size.width
    let centerPoint =  CGPoint( buttonWidth/2, buttonHeight/2 )
    
    indicatorView.center = centerPoint
    indicatorView.tag = tag
    indicatorView.color = .white
    indicatorView.tintColor = .white

    indicatorView.hidesWhenStopped = true
    
    self.addSubview(indicatorView)
    
  }
  
  func loadingIndicator(show: Bool) {
    
    if (show) {
      self.isUserInteractionEnabled = false
      self.setTitle("", for: .normal)
      indicatorView.startAnimating()
    } else {
      self.isUserInteractionEnabled = true
      self.setTitle(self.title, for: .normal)
      indicatorView.stopAnimating()
    }
    
  }
  
}
