//
//  IntroHomeWireframe.swift
//  MobileBanking
//
//  Created by Guilherme Coelho on 28/03/2018.
//  Copyright (c) 2018 BS2. All rights reserved.
//
//

import UIKit

final class FLIntroWireframe: BaseWireframe {
  
  // MARK: - Private properties -
  
  // MARK: - Module setup -
  
  func configureModule(with viewController: FLIntroViewController) {
    
    let presenter = FLIntroPresenter(wireframe: self,
                                        view: viewController)
    
    viewController.presenter = presenter
  }
  
  // MARK: - Transitions -
  
  func show(with transition: Transition, animated: Bool = true) {

    let moduleViewController = FLIntroViewController(nibName: nil, bundle: nil)
    
    configureModule(with: moduleViewController)
    
    show(moduleViewController, with: transition, animated: animated)
  }
  
  // MARK: - Private Routing
  
  private func goToCharSelection() {
    let charModule = FLCharSelectionWireframe(navigationController: navigationController)
    charModule.show(with: .push)
  }

}

// MARK: - Extensions -

extension FLIntroWireframe: FLIntroWireframeInterface {
  
  func navigate(to option: FLIntroNavigationOption) {
    switch option {
      
    case .goToCharSelection:
      goToCharSelection()
      
    }
  }
}
