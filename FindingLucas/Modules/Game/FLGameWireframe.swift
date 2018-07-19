//
//  FLGameWireframe.swift
//  FindingLucas
//
//  Created by Guilherme Coelho on 19/07/18.
//  Copyright (c) 2018 DevForFun_Guilherme_Coelho. All rights reserved.
//
//

import UIKit

final class FLGameWireframe: BaseWireframe {
  
  // MARK: - Private properties -
  
  // MARK: - Module setup -
  
  func configureModule(with viewController: FLGameViewController) {
    
    let presenter = FLGamePresenter(wireframe: self, view: viewController)
    viewController.presenter = presenter
  }
  
  // MARK: - Transitions -
  
  func show(with transition: Transition, animated: Bool = true) {

    let moduleViewController = FLGameViewController(nibName: nil, bundle: nil)
    
    configureModule(with: moduleViewController)
    
    show(moduleViewController, with: transition, animated: animated)
  }
  
  // MARK: - Private Routing -

}

// MARK: - Extensions -

extension FLGameWireframe: FLGameWireframeInterface {
  
  func navigate(to option: FLGameNavigationOption) {

  }
}
