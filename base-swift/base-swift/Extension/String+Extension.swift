//
//  String+Extension.swift
//  MVVM Example
//
//  Created by Viet Anh Dang on 6/22/20.
//  Copyright © 2020 Cadory. All rights reserved.
//

import Foundation
import UIKit
import CryptoSwift

let keyCrypto: Array<UInt8> = Array("thiemjs-rtyuiopl".utf8)
let saltCrypto: Array<UInt8> = Array("asdfghjklzxcvb".utf8)
let arrIV: [UInt8] = Array("thiemjs-asdfghjk".utf8)


extension String {

    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func colorWithHexString(alpha: CGFloat = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: self))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }

    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }

    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }

    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func encodeURL(_ chars: String) -> String {
        let forbidden = CharacterSet(charactersIn: chars)
        return self.addingPercentEncoding(withAllowedCharacters: forbidden.inverted) ?? self
    }
    
    func enCryptoData() -> (String) {
        //        return self
        
        let data: [UInt8] = Array(self.utf8)
        var resultString = ""
        do {
            let encrypted = try AES(key: keyCrypto, blockMode: CBC(iv: arrIV), padding: .pkcs5).encrypt(data)
            let encryptedData = Data(encrypted)
            resultString = encryptedData.base64EncodedString()
        } catch {
            print(error)
        }
        return resultString
    }
    
    
    func deCryptoData() -> (String) {
        //        return self
        let data = self.base64ToByteArray()
        var resultString = ""
        if let arrData = data {
            do {
                let decrypted = try AES(key: keyCrypto, blockMode: CBC(iv: arrIV), padding: .pkcs5).decrypt(arrData)
                let decryptedData = Data(decrypted)
                resultString = String(decoding: decryptedData, as: UTF8.self)
            } catch {
                print(error)
            }
        }
        return resultString
    }
    
    func base64ToByteArray() -> [UInt8]? {
        if let nsData = NSData(base64Encoded: self, options: .ignoreUnknownCharacters) {
            let bytes = [UInt8](nsData as Data)
            return bytes
        }
        return nil // Invalid input
    }
    
    static func getStringFrom(_ hour: Int,_ minute: Int,_ second: Int ) -> String {
        var result: String = ""
        if hour < 10 {
            result = result + "0\(hour)"
        } else {
            result = result + "\(hour)"
        }
        
        if minute < 10 {
            result = result + "0\(minute)"
        } else {
            result = result + "\(minute)"
        }
        
        if second < 10 {
            result = result + "0\(second)"
        } else {
            result = result + "\(second)"
        }
        
        return result
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}

func getSlicedStringArr(allString: String, seperator: String) -> [String] {
    let delimiter = seperator
    let newstr = allString
    let token = newstr.components(separatedBy: delimiter)
    return token
}

// https://stackoverflow.com/questions/41558832/how-to-format-a-double-into-currency-swift-3
extension String{
     func toCurrencyFormat() -> String {
        if let intValue = Int(self){
           let numberFormatter = NumberFormatter()
           numberFormatter.locale = Locale(identifier: "vi_VN")
           numberFormatter.numberStyle = NumberFormatter.Style.currency
           let currencyString = numberFormatter.string(from: NSNumber(value: intValue)) ?? ""
            let result = currencyString.filter({ $0 != "₫" && $0 != " "})
            return result
      }
    return ""
  }
}

extension String
{
    func encodeUrl() -> String
    {
        return self.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}

extension String {
    var removeColon: String {
        let colon = Set(":")
        return self.filter {!colon.contains($0) }
    }
}
