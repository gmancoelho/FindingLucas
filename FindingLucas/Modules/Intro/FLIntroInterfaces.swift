//
//  IntroHomeInterfaces.swift
//  MobileBanking
//
//  Created by Guilherme Coelho on 28/03/2018.
//  Copyright (c) 2018 BS2. All rights reserved.
//
//

import UIKit

enum FLIntroNavigationOption {
  
  case goToCharSelection

}

protocol FLIntroWireframeInterface: WireframeInterface {
  func navigate(to option: FLIntroNavigationOption)
}

protocol FLIntroViewInterface: ViewInterface {
  
}

protocol FLIntroPresenterInterface: PresenterInterface {
  
}
