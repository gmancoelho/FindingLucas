//
//  UIView.swift
//  MobileBanking
//
//  Created by Guilherme Coelho on 28/03/2018.
//  Copyright © 2018 BS2. All rights reserved.
//

import UIKit

extension UIView {
  
  enum ViewSide {
    case left, right, top, bottom
  }
  
  func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
    
    let path = UIBezierPath(roundedRect: self.bounds,
                            byRoundingCorners: corners,
                            cornerRadii: CGSize(width: radius, height: radius))
    
    let mask = CAShapeLayer()
    
    mask.path = path.cgPath
    self.layer.mask = mask
  }
  
  func installShadow() {
    layer.cornerRadius = 2
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 1)
    layer.shadowOpacity = 0.45
    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shadowRadius = 1.0
  }
  
  func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
    
    let border = CALayer()
    border.backgroundColor = color
    
    switch side {
    case .left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
    case .right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
    case .top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.size.width, height: thickness)
    case .bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness)
    }
    
    layer.addSublayer(border)
  }
  
}

extension UIScrollView {
  
  func screenshot(_ frameIn: CGRect? = nil) -> UIImage? {
    let savedContentOffset = contentOffset
    let savedFrame = frame
    
    UIGraphicsBeginImageContextWithOptions(contentSize, false, 0)
    
    contentOffset = .zero
    frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
    self.drawHierarchy(in: frame, afterScreenUpdates: true)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    contentOffset = savedContentOffset
    frame = savedFrame
    
    if let print = image, var cropRect = frameIn {
      cropRect.origin.y += savedFrame.origin.y
      cropRect.origin.x *= print.scale
      cropRect.origin.y *= print.scale
      cropRect.size.height *= print.scale
      cropRect.size.width *= print.scale
      let imageRef = print.cgImage!.cropping(to: cropRect)
      let cropped = UIImage(cgImage: imageRef!, scale: print.scale, orientation: print.imageOrientation)
      return cropped
    }
    
    return image
  }
  
}
