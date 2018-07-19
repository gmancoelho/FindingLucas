//
//  String.swift
//  MobileBanking
//
//  Created by Bruno Marçal on 26/03/2018.
//  Copyright © 2018 BS2. All rights reserved.
//

import Foundation

extension String {
  
  // MARK: - Date extenstions
  
  static func formmatedMoney(value:Double) -> String {
    return String(format: "%.02f", value)
  }
  
  static func formmatedDMYDate(date:Date) -> String {
    
    return String(format: "%02d-%02d-%02d", date.day, date.month, date.year)
    
  }
  
  static func formmatedYYYYMMDDDate(date:Date) -> String {
    
    return String(format: "%02d-%02d-%02d", date.year, date.month, date.day)
    
  }
  
  static func formmatedYYYYMMDate(date:Date) -> String {
    
    return String(format: "%02d-%02d", date.year, date.month)
    
  }
  
  static func formmatedYYYYMMDDTDate(date:Date) -> String {
    
    return String(format: "%02d-%02d-%02d'T'%02d:%02d:%02d",
                  date.year,
                  date.month,
                  date.day,
                  date.hour,
                  date.minute,
                  date.second)
    
  }
  
  static func addZeroLeftDecimalPlaces(value: Int, countDecimalPlaces: Int = 1) -> String {
    return String(format: "%0\(countDecimalPlaces)d", value)
  }
  
  /// SwifterSwift: Date object from string of date format.
  ///
  ///    "2017-01-15".date(withFormat: "yyyy-MM-dd") -> Date set to Jan 15, 2017
  ///    "not date string".date(withFormat: "yyyy-MM-dd") -> nil
  ///
  /// - Parameter format: date format.
  /// - Returns: Date object from string (if applicable).
  public func date(withFormat format: String? = "yyyy-MM-dd") -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.date(from: self)
  }
  
  // MARK: - CPF/CNPJ Regex

  var isCPF: Bool {
    let numbers = compactMap({Int(String($0))})
    guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
    let soma1 = 11 - ( numbers[0] * 10 +
      numbers[1] * 9 +
      numbers[2] * 8 +
      numbers[3] * 7 +
      numbers[4] * 6 +
      numbers[5] * 5 +
      numbers[6] * 4 +
      numbers[7] * 3 +
      numbers[8] * 2 ) % 11
    let dv1 = soma1 > 9 ? 0 : soma1
    let soma2 = 11 - ( numbers[0] * 11 +
      numbers[1] * 10 +
      numbers[2] * 9 +
      numbers[3] * 8 +
      numbers[4] * 7 +
      numbers[5] * 6 +
      numbers[6] * 5 +
      numbers[7] * 4 +
      numbers[8] * 3 +
      numbers[9] * 2 ) % 11
    let dv2 = soma2 > 9 ? 0 : soma2
    return dv1 == numbers[9] && dv2 == numbers[10]
  }
  
  var isCNPJ: Bool {
    let numbers = compactMap({Int(String($0))})
    guard numbers.count == 14 && Set(numbers).count != 1 else { return false }
    let soma1 = 11 - ( numbers[11] * 2 +
      numbers[10] * 3 +
      numbers[9] * 4 +
      numbers[8] * 5 +
      numbers[7] * 6 +
      numbers[6] * 7 +
      numbers[5] * 8 +
      numbers[4] * 9 +
      numbers[3] * 2 +
      numbers[2] * 3 +
      numbers[1] * 4 +
      numbers[0] * 5 ) % 11
    let dv1 = soma1 > 9 ? 0 : soma1
    let soma2 = 11 - ( numbers[12] * 2 +
      numbers[11] * 3 +
      numbers[10] * 4 +
      numbers[9] * 5 +
      numbers[8] * 6 +
      numbers[7] * 7 +
      numbers[6] * 8 +
      numbers[5] * 9 +
      numbers[4] * 2 +
      numbers[3] * 3 +
      numbers[2] * 4 +
      numbers[1] * 5 +
      numbers[0] * 6 ) % 11
    let dv2 = soma2 > 9 ? 0 : soma2
    return dv1 == numbers[12] && dv2 == numbers[13]
  }
  
  // MARK: - CEP Validation
  var isCEPValid: Bool {
    let unmaskedCEP = self.removingDigitMask()
    
    if unmaskedCEP.count > 2 {
      
      if let numberPrefixCEP = Int(unmaskedCEP), numberPrefixCEP >= 1000000 {
        return true
      }
    } else {
      return true
    }
    
    return false
  }
  
  // MARK: - Email Regex

  var isEmailValid: Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
  }
  
  // MARK: - Phone Regex
  
  var isValidPhone: Bool {
    let phoneRegex = "\\([1-9]{2}\\)+ 9[0-9]{4}-[0-9]{4}"
    return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: self)
  }
      
  // MARK: - IsEmpty
  
  var isEmptyString: Bool {
    return self.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty
  }
  
  // MARK: - Encoded / Decoded
  
  func encodeString() -> String? {
    let allowCharacters = CharacterSet.alphanumerics
    let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowCharacters)
    
    return encodedString
  }
  
  func decodeString() -> String? {
    let text = self.replacingOccurrences(of: "+", with: " ")
    
    return text.removingPercentEncoding!
  }
  
  func encodeURL() -> String? {
    let encodedString = self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    
    return encodedString!
  }

  // MARK: - Mask
  func currencyInputFormatting() -> String {
    
    var number: NSNumber!
    let formatter = NumberFormatter()
    formatter.numberStyle = .currencyAccounting
    formatter.currencySymbol = "R$ "
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    formatter.locale = Locale(identifier: "pt_BR")
    
    var amountWithPrefix = self
    
    do {
      let regex = try NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
      amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix,
                                                        options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                        range: NSRange(location: 0, length: self.count),
                                                        withTemplate: "")
      
      let double = (amountWithPrefix as NSString).doubleValue
      number = NSNumber(value: (double / 100))
      
      guard number != 0 as NSNumber else {
        return "R$ 0,00"
      }
    } catch {
      return "R$ 0,00"
    }

    return formatter.string(from: number)!
  }
  
  func applyBarCodeMask() -> String {
    let kDigitMaskCIP: String = "########## ########### ########### # ##############"
    let kDigitMaskDealership: String = "############ ############ ############ ############"
    let kDealershipDigit: Character = "8"
    
    let digitMask = self.first == kDealershipDigit ? kDigitMaskDealership : kDigitMaskCIP

    let maskedText = self.applyingDigitMask(digitMask)
    return maskedText
  }
  
  func applyingDigitMask(_ mask: String) -> String {
    let digits = removingDigitMask()
    var masked = ""
    var digitIndex = 0, maskIndex = 0
    while maskIndex < mask.count && digitIndex < digits.count {
      var char = mask[mask.index(mask.startIndex, offsetBy: maskIndex)]
      if char == "#" {
        char = digits[digits.index(digits.startIndex, offsetBy: digitIndex)]
        digitIndex += 1
      }
      masked.append(char)
      maskIndex += 1
    }
    
    return masked
  }
  
  func removingDigitMask() -> String {
    return replacingOccurrences( of:"\\D", with: "", options: .regularExpression)
  }
  
  func removingCurrencyMask() -> String {
    var clearValue = self.replacingOccurrences(of: "R$", with: "")
    clearValue = clearValue.replacingOccurrences(of: ".", with: "")
    clearValue = clearValue.replacingOccurrences(of: ",", with: ".")
    clearValue = clearValue.trimmingCharacters(in: .whitespacesAndNewlines)
    
    return clearValue
  }
  
  func applyMaskSubmitCell() -> String {
    let i1 = self.index(self.startIndex, offsetBy: 1)
    let i2 = self.index(self.startIndex, offsetBy: 2)
    
    let p1 = self.prefix(through: i1)
    let p2 = self.suffix(from: i2)
    let masked = "+55-\(p1)-\(p2)"
    
    return masked
  }
  
  /// Obfuscate Phone Number with ***** on first block numbers
  ///
  /// - Returns: obfuscated phone number
  func obfuscatePhoneNumber() -> String {
    if self.isEmpty {
      return self
    }
    
    let start = self.index(self.startIndex, offsetBy: 4)
    let end = self.index(self.endIndex, offsetBy: -5)
    let range = start..<end
    
    let replaced = self.replacingCharacters(in: range, with: "*****")
    return replaced
  }
  
  /// Remove phone number mask (country code and hyphen)
  ///
  /// - Returns: phone number without +55 or -
  func unmaskCellNumber() -> String {
    return replacingOccurrences(of: "+55", with: "").replacingOccurrences(of: "-", with: "")
  }
  
  // MARK: - IsNumber

  var isNumber: Bool {
    return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
  }
  
  // MARK: - base64
  
  func toBase64() -> String? {
    if let data = self.data(using: .utf8) {
      return data.base64EncodedString()
    }
    
    return nil
  }
  
  func fromBase64() -> String? {
    if let data = Data(base64Encoded: self) {
      return String(data: data, encoding: .utf8)
    }
    
    return nil
  }
  
  func accountType() -> String? {
    if self.isEmpty {
      return self
    }
    var account = self
    let last = self.suffix(1)
    account.removeLast()
    account = (account + "-" + last)
    
    return account
  }
  
  func formatDateString() -> String {
    if self.contains("-") {
      let year = self.split(separator: "-")[0]
      let month = self.split(separator: "-")[1]
      let day = self.split(separator: "-")[2]
      
      return "\(day)/\(month)/\(year)"
    } else if self.contains("/") {
      let year = self.split(separator: "/")[2]
      let month = self.split(separator: "/")[1]
      let day = self.split(separator: "/")[0]
      
      return "\(year)-\(month)-\(day)"
    } else {
      return ""
    }
  }

  func formatYYYYMMDDTDateString() -> String {
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    
    if let date = dateFormatterPrint.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    return ""
  }
  
  func formatYYYYMMDDDateString() -> String {
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "yyyy-MM-dd"
    
    if let date = dateFormatterGet.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    return ""
  }
  
  func formatDDMMYYYYDateString() -> String {
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd/MM/yyyy"
    
    if let date = dateFormatterGet.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    return ""
  }
  
  func formatDDMMYYYYWihtouSSSDateString() -> String {
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd/MM/yyyy"
    
    if let date = dateFormatterGet.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    return ""
  }
  
  func formatDDMMYYYYHHMMSSDateString() -> String {
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "ddMMyyyyHHmmss"
    
    if let date = dateFormatterGet.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    return ""
  }
  
  public func isValidDate() -> Bool {
    if !self.isEmpty {
      if self.count == 10 {
        let dateFormatter = DateFormatter()
        if self.contains("/") {
          dateFormatter.dateFormat = "dd/MM/yyyy"
        } else {
          dateFormatter.dateFormat = "yyyy-MM-dd"
        }

        if dateFormatter.date(from: self) != nil {
          return true
        } else {
          return false
        }
      } else {
        return false
      }
    }

    return false
  }
  
  public func isMoreThenYears(format: String, year: Int) -> Bool {
    if !self.isEmpty {
      let dateFormatter = DateFormatter()
      if self.count == 10 {
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: self) {
          return date.validateYears(year: year)
        } else {
          return false
        }
      } else {
        return false
      }
    }
    
    return true
  }
  
  // MARK: Manipulate string
  
  func formatAccount() -> String {
    if self.isEmpty {
      return "–"
    }
    
    let strAccount = self
    let iAccount = strAccount.index(strAccount.startIndex, offsetBy: 5)
    let iDigit = strAccount.index(strAccount.endIndex, offsetBy: -1)
    let account = strAccount[..<iAccount]
    let digit = strAccount[iDigit...]
    
    return account + "-" + digit
  }
  
  // MARK: Substring
  
  func subString(startIndex: Int, endIndex: Int) -> String {
    let end = (endIndex - self.count) + 1
    let indexStartOfText = self.index(self.startIndex, offsetBy: startIndex)
    let indexEndOfText = self.index(self.endIndex, offsetBy: end)
    let substring = self[indexStartOfText..<indexEndOfText]
    return String(substring)
  }
  
  func formatNameAndMiddleName() -> String {
    var components = self.components(separatedBy: " ")
    
    if components.count > 2 {
      var secondPositionName = 2
      if components[secondPositionName].count <= 3 && components.count >= 2 {
        secondPositionName += 1
      }
      
      return String(format: "%@ %@", components[0], components[secondPositionName])
    }
    
    return self
  }
  
  func initialsOfName() -> String? {
    if !self.isEmpty {
      let initials = self
        .components(separatedBy: " ")
        .reduce("") {
          ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)"
      }
      return initials.uppercased()
    }
    
    return nil
  }
  
  func capitalize() -> String {
    
    var formattedString = self.localizedLowercase
    formattedString = formattedString.capitalized
    return formattedString
  }
  
  func removingWhitespaces() -> String {
    return components(separatedBy: .whitespaces).joined()
  }
  
  // MARK: - Bool
  func isValid(in range: NSRange, string: String) -> Bool {
    let newString = (self as NSString).replacingCharacters(in: range, with: string) as NSString
    if  newString.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
      return true
    } else {
      return false
    }
  }
  
}
