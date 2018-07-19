//
//  FLGameInterfaces.swift
//  FindingLucas
//
//  Created by Guilherme Coelho on 19/07/18.
//  Copyright (c) 2018 DevForFun_Guilherme_Coelho. All rights reserved.
//
//

import UIKit

enum FLGameNavigationOption {
}

protocol FLGameWireframeInterface: WireframeInterface {
  func navigate(to option: FLGameNavigationOption)
}

protocol FLGameViewInterface: ViewInterface {
}

protocol FLGamePresenterInterface: PresenterInterface {
}

protocol FLGameInteractorInterface: InteractorInterface {
}
