//
//  BaseWireframe.swift
//  MobileBanking
//
//  Created by Guilherme Coelho on 27/03/2018.
//  Copyright © 2018 BS2. All rights reserved.
//

import UIKit

enum Transition {
  case root
  case push
  case stack(viewControllers: [UIViewController])
  case present(fromViewController: UIViewController)
}

protocol WireframeInterface: class {
  func popToViewController(viewController: UIViewController, animated: Bool)
  func popFromNavigationController(animated: Bool)
  func dismiss(animated: Bool)
}

class BaseWireframe {
  
  weak var navigationController: UINavigationController!
  weak var tabBarController: UITabBarController?

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func show(_ viewController: UIViewController, with transition: Transition, animated: Bool) {
    switch transition {
      
    case .push:
      navigationController.pushViewController(viewController, animated: animated)
      
    case .present(let fromViewController):
      navigationController.viewControllers = [viewController]
      fromViewController.present(navigationController, animated: animated, completion: nil)
      
    case .root:
      navigationController.setViewControllers([viewController], animated: animated)
      
    case .stack(let viewControllers):
      let stack = viewControllers + [viewController]
      navigationController.setViewControllers(stack, animated: animated)
      
    }
  }
  
  func showAlertErrorGeneric(tapDismiss: Bool = true, doneAction: FLAlertAction? = nil) {
    
  }  
  
}

extension BaseWireframe: WireframeInterface {
  
  func popToRoot(_ animated: Bool) {
    _ = navigationController.popToRootViewController(animated: animated)
  }
  
  func popToViewController(viewController: UIViewController, animated: Bool) {
    _ = navigationController.popToViewController(viewController, animated: animated)
  }
  
  func popFromNavigationController(animated: Bool) {
    _ = navigationController.popViewController(animated: animated)
  }
  
  func dismiss(animated: Bool) {
    if navigationController != nil {
      navigationController.dismiss(animated: animated)
    }
  }
}
