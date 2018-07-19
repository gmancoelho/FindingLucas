//
//  FSModal.swift
//  FindingLucas
//
//  Created by Guilherme Coelho on 19/07/18.
//  Copyright © 2018 DevForFun_Guilherme_Coelho. All rights reserved.
//

import UIKit

typealias FLAlertAction = (String?) -> Void
typealias FLAlertStyle = (color: UIColor, font: UIFont?)

enum Style: String {
  case doneButton
}

class FLAlert: UIView, Modal {
  
  // MARK: - Public properties
  
  var backgroundView = UIView()
  var dialogView = UIView()
  
  var dialogBackgroundColor: UIColor = FLColors.black
  
  private var tapDismissScreen: Bool = true
  private var disableDoneButton: Bool = false
  
  // MARK: - Init
  
  convenience init() {
    self.init(frame: UIScreen.main.bounds)
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private properties
  
  private var actionDoneCallback: FLAlertAction?
  private var actionCancelCallback: FLAlertAction?
  
  private let alertImage: UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleAspectFit
    img.clipsToBounds = true
    return img
  }()
  
  private var alertTitle: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = UIFont(name: FLFonts.montserratReg.name, size: 15)
    label.textColor = FLColors.navyBlue
    return label
  }()
  
  private var alertSubTitle: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = UIFont(name: FLFonts.montserratLight.name, size: 13)
    label.textColor = FLColors.black
    return label
  }()
  
  private let textButtonDone: String = ""
  
  private let alertDoneButton: UIButton = {
    let button = UIButton(type: .custom)
    button.tag = 1
    button.setTitleColor(FLColors.navyBlue, for: .normal)
    button.setTitleColor(FLColors.gray, for: .disabled)
    button.titleLabel?.font =  UIFont(name: FLFonts.montserratReg.name, size: 15)
    button.addTarget(self, action: #selector(alertButtonAction(_:)), for: .touchUpInside)
    return button
  }()
  
  private let alertCancelButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitleColor(FLColors.navyBlue, for: .normal)
    button.titleLabel?.font = UIFont(name: FLFonts.montserratReg.name, size: 15)
    button.addTarget(self, action: #selector(alertButtonAction(_:)), for: .touchUpInside)
    return button
  }()
  
  private let stack: UIStackView = {
    let s = UIStackView()
    s.axis = .horizontal
    s.distribution = .fillEqually
    s.alignment = .fill
    s.spacing = 0
    
    return s
  }()
  
  var heightStack: CGFloat = 51.0
  
  // MARK: - Public functions
  
  /// Configure alert fields, all parameters are optional and only parameters with values will be shown
  ///
  /// - Parameters:
  ///   - image: image on top of alert. Can be nil
  ///   - title: title of alert. Can be nil
  ///   - description: subtitle of alert. Can be nil
  ///   - textField: phone number of alert. Can be nil
  ///   - tapDismiss: dismiss or not when tap on background view
  ///   - disableDoneButtonWithTextField: disable done button when phone number is not complete
  ///   - cancelButtonTitle: title of cancel button alert. Used when need two buttons on alert. Can be nil
  ///   - doneButtonTitle: title of done button alert. If you show only one button alert use this. Cannot be nil
  func configureAlert(image: UIImage? = nil,
                      title: String? = nil,
                      attributedDescription: NSAttributedString? = nil,
                      tapDismiss: Bool = true,
                      disableDoneButtonWithTextField: Bool = false,
                      cancelButtonTitle: String? = nil,
                      doneButtonTitle: String? = "",
                      style: [String: FLAlertStyle] = [:]) {
    
    configureBackground()
    
    let dialogViewWidth: CGFloat = frame.width-60
    var position: CGFloat = 20.0
    let margin: CGFloat = 15.0
    
    tapDismissScreen = tapDismiss
    disableDoneButton = disableDoneButtonWithTextField
    
    func setupImage() {
      alertImage.image = image
      alertImage.center = CGPoint((dialogViewWidth / 2) - ((image?.size.width)! / 2), position + 10)
      alertImage.sizeToFit()
      dialogView.addSubview(alertImage)
      
      position = alertImage.frame.maxY + 17
    }
    
    func setupTitle() {
      
      let font = UIFont(name: FLFonts.montserratReg.name, size: 15.0)
      let heightLabel = heightForView(text: NSAttributedString(string: title!), font: font!, width: dialogViewWidth - (margin * 2))
      alertTitle.frame = CGRect(x: margin, y: position, width: dialogViewWidth - (margin * 2), height: heightLabel + 5)
      alertTitle.text = title
      dialogView.addSubview(alertTitle)
      
      position = alertTitle.frame.maxY + 5
    }
    
    func setupDescription() {
      let font = UIFont(name: FLFonts.montserratLight.name, size: 15.0)
      let heightLabel = heightForView(text: attributedDescription!, font: font!, width: dialogViewWidth - (margin * 4))
      alertSubTitle.frame = CGRect(x: margin * 2, y: position, width: dialogViewWidth - (margin * 4), height: heightLabel)
      alertSubTitle.attributedText = attributedDescription
      dialogView.addSubview(alertSubTitle)
      
      position = alertSubTitle.frame.maxY + 5
    }
    
    func setupCancelButton() {
      alertCancelButton.setTitle(cancelButtonTitle, for: .normal)
      stack.addArrangedSubview(alertCancelButton)
    }
    
    func setupDoneButton() {
      alertDoneButton.setTitle(doneButtonTitle, for: .normal)
      if let config = style[Style.doneButton.rawValue] {
        alertDoneButton.setTitleColor(config.color, for: .normal)
      }
      stack.addArrangedSubview(alertDoneButton)
      alertDoneButton.isEnabled = !disableDoneButton
    }
    
    func setupStackButtons() {
      
      let configStack = getConfigureButtons(buttonCancelTitle: cancelButtonTitle, buttonDoneTitle: doneButtonTitle, sizeHeightStack: heightStack)
      
      stack.frame = CGRect(x: 0, y: position, width: dialogViewWidth, height: configStack.sizeStack)
      dialogView.addSubview(stack)
      
      position = stack.frame.maxY + 5
    }
    
    let parameters: [Any?] = [image, title, attributedDescription, cancelButtonTitle, doneButtonTitle]
    let functions = [setupImage, setupTitle, setupDescription, setupCancelButton, setupDoneButton]
    _ = parameters.enumerated().map { (index, element) in
      if element != nil {
        functions[index]()
      }
    }
    
    setupStackButtons()
    createDialog(position: position)
  }
  
  /// Set position buttons
  ///
  /// - Parameters:
  ///   - buttonCancelTitle: Action button Cancel
  ///   - buttonDoneTitle: Action button title
  ///   - sizeHeightStack: size of the StackView
  private func getConfigureButtons(buttonCancelTitle: String? = nil, buttonDoneTitle: String? = nil, sizeHeightStack: CGFloat) -> (totalCaracters: Int, sizeStack: CGFloat) {
    
    guard let done = buttonDoneTitle else {
      return(0, sizeHeightStack)
    }
    if done.count > 11 && (buttonCancelTitle != nil) {
      stack.axis = .vertical
      heightStack = (sizeHeightStack * 2)
      
      stack.insertArrangedSubview(alertDoneButton, at: 0)
      stack.insertArrangedSubview(alertCancelButton, at: 1)
    }
    return (done.count, heightStack)
  }
  
  /// Set callback actions of alert buttons
  ///
  /// - Parameters:
  ///   - cancel: callback of cancel button
  ///   - done: callback of done button. String returns phone number in alert text field
  func actionCallback(cancel: FLAlertAction? = nil, done: FLAlertAction? = nil) {
    actionCancelCallback = cancel
    actionDoneCallback = done
  }
  
  // MARK: - Private functions
  private func createDialog(position: CGFloat) {
    
    dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
    dialogView.frame.size = CGSize(width: frame.width-60, height: position)
    dialogView.backgroundColor = UIColor.white
    dialogView.layer.cornerRadius = 10
    addSubview(dialogView)
  }
  
  private func configureBackground() {
    dialogView.clipsToBounds = true
    backgroundView.frame = frame
    backgroundView.backgroundColor = UIColor.black
    backgroundView.alpha = 0.6
    backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
    addSubview(backgroundView)
  }
  
  /// - Returns: Size for Label
  private func heightForView(text: NSAttributedString, font: UIFont, width: CGFloat) -> CGFloat {
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.attributedText = text
    label.sizeToFit()
    
    return label.frame.height
  }
  
  /// - Returns: screen size
  private func screenSize() -> CGSize {
    let screenSize = UIScreen.main.bounds.size
    if (UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation)) {
      return CGSize(width: screenSize.height, height: screenSize.width)
    }
    return screenSize
  }
  
  @objc private func didTappedOnBackgroundView() {
    actionCancelCallback?(nil)
    if tapDismissScreen {
      dismiss(animated: true)
    }
  }
  
  @objc private func alertButtonAction(_ sender: Any) {
//    let tag = (sender as? UIButton)?.tag
////    tag == 1 ? actionDoneCallback?(alertTextField.text) : actionCancelCallback?(nil)
    actionCancelCallback?(nil)
    dismiss(animated: true)
  }
}

