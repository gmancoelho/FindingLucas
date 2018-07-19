//
//  FLCharSelectionInterfaces.swift
//  FindingLucas
//
//  Created by Guilherme Coelho on 19/07/18.
//  Copyright (c) 2018 DevForFun_Guilherme_Coelho. All rights reserved.
//
//

import UIKit

enum FLCharSelectionNavigationOption {
}

protocol FLCharSelectionWireframeInterface: WireframeInterface {
  func navigate(to option: FLCharSelectionNavigationOption)
}

protocol FLCharSelectionViewInterface: ViewInterface {
}

protocol FLCharSelectionPresenterInterface: PresenterInterface {
}
