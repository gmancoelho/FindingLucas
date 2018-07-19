//
//  Double.swift
//  MobileBanking
//
//  Created by Ítalo Sangar on 04/05/18.
//  Copyright © 2018 BS2. All rights reserved.
//

import Foundation

public extension Double {
  
  /// Real currency string from double value
  ///
  /// - Returns: String object from double (if applicable)
  public func currency() -> String {
    
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = Locale(identifier: "pt_BR")
    
    if let amountString = currencyFormatter.string(from: NSNumber(value: self)) {
      currencyFormatter.paddingPosition = .afterPrefix
      currencyFormatter.formatWidth = amountString.count + 1
      currencyFormatter.paddingCharacter = " "
    }
    
    let resp = currencyFormatter.string(from: NSNumber(value: self)) ?? "–"
    return resp
  }
  
  func toString() -> String {
    return String(format: "%.2f", self)
  }
  
}
