//
//  FLFonts.swift
//  MobileBanking
//
//  Created by Guilherme Coelho on 10/04/2018.
//  Copyright © 2018 BS2. All rights reserved.
//

import Foundation

enum FLFonts {
  
  case montserratReg
  case montserratBold
  case montserratExtraBold
  case montserratLight
  case montserratMedium

  var name:String {
    
    switch self {
      
    case .montserratBold:
      return "Montserrat-Bold"
      
    case .montserratReg:
      return "Montserrat-Regular"
      
    case .montserratExtraBold:
      return "Montserrat-ExtraBold"

    case .montserratLight:
      return "Montserrat-Light"
      
    case .montserratMedium:
      return "Montserrat-Medium"
    }
    
  }

}
