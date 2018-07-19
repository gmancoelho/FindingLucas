//
//  BaseRouter.swift
//  MobileBanking
//
//  Created by Guilherme Coelho on 28/03/2018.
//  Copyright © 2018 BS2. All rights reserved.
//

import UIKit

final class FLBaseRouter {
  
  // MARK: - Properties
  
  let window:UIWindow
  
  let baseNavigationController: FLNavigationController = FLNavigationController()
  
  // MARK: - Init

  init(window: UIWindow) {
    self.window = window
    window.rootViewController = baseNavigationController
    window.backgroundColor = UIColor.white
    window.makeKeyAndVisible()
  }
  
  // MARK: - Router
  
  func initRouter() {
    presentIntro()
  }
  
  // MARK: - Private Methods
  
  private func presentIntro() {
    let introModule = FLIntroWireframe(navigationController: baseNavigationController)
    introModule.show(with: .push, animated: true)
  }
  
}
