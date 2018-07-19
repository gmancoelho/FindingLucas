//
//  BSNavigationController.swift
//  MobileBanking
//
//  Created by Guilherme Coelho on 28/03/2018.
//  Copyright © 2018 BS2. All rights reserved.
//

import UIKit

protocol StatusBarTheme {
  var navigationStatusBarStyle: UIStatusBarStyle? { get }
}

class FLNavigationController: UINavigationController {
  
  // MARK: - Properties
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    let defaultBarStyle: UIStatusBarStyle = .lightContent
    if let vc = viewControllers.last as? StatusBarTheme {
      return vc.navigationStatusBarStyle ?? defaultBarStyle
    }
    return defaultBarStyle
  }
  
  // MARK: - Private
  override open var childViewControllerForStatusBarStyle: UIViewController? {
    return self.topViewController
  }
  
  // MARK: - Private
  
  // MARK: - Lifecycle
  required convenience init() {
    self.init(navigationBarClass: nil, toolbarClass: nil)
  }
  
  // MARK: - Navigation
  
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    super.pushViewController(viewController, animated: animated)
  }
  
  override func popViewController(animated: Bool) -> UIViewController? {
    _ = viewControllers.dropLast().last
    let poped = super.popViewController(animated: animated)
    return poped
  }
  
  override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
    let poped = super.popToViewController(viewController, animated: animated)
    return poped
  }
  
  override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
    super.setViewControllers(viewControllers, animated: animated)
  }
 
}
