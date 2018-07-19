//
//  UIImage.swift
//  MobileBanking
//
//  Created by Diogo on 06/04/18.
//  Copyright © 2018 BS2. All rights reserved.
//

import UIKit

extension UIImage {
  
  enum JPEGQuality: CGFloat {
    case lowest = 0
    case low = 0.25
    case medium = 0.5
    case high = 0.75
    case highest = 1
  }
  
  func jpeg(_ quality: JPEGQuality) -> Data? {
    return UIImageJPEGRepresentation(self, quality.rawValue)
  }
  
  func convertToBase64String() -> String {
    let data = jpeg(.low)
    let imageBase64: String = (data?.base64EncodedString(options: .endLineWithLineFeed))!
    return imageBase64
  }
}
