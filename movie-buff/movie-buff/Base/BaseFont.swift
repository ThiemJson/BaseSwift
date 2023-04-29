//
//  BaseFont.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
import UIKit

struct BaseFont {
    
    struct System {
        static var text_ulltrathin : UIFont     { UIFont.systemFont(ofSize: HelperUtils.isPad ? 16 : 14, weight: .ultraLight) }
        static var text_thin : UIFont           { UIFont.systemFont(ofSize: HelperUtils.isPad ? 16 : 14, weight: .thin) }
        static var text_regular_subcr : UIFont  { UIFont.systemFont(ofSize: HelperUtils.isPad ? 14 : 12, weight: .regular) }
        static var text_regular : UIFont        { UIFont.systemFont(ofSize: HelperUtils.isPad ? 16 : 14, weight: .regular) }
        static var text_semibold : UIFont       { UIFont.systemFont(ofSize: HelperUtils.isPad ? 16 : 14, weight: .semibold) }
        static var text_bold : UIFont           { UIFont.systemFont(ofSize: HelperUtils.isPad ? 16 : 14, weight: .bold) }
        static var text_heavy : UIFont          { UIFont.systemFont(ofSize: HelperUtils.isPad ? 16 : 14, weight: .heavy) }
    }
    
    struct Libre {}
    struct Mono {}
}


extension UIFont {
    private static let baseFontSize: CGFloat = 14
    
    static func font(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        var traits = [UIFontDescriptor.TraitKey: Any]()
        traits[.weight] = weight
        
        var attributes = [UIFontDescriptor.AttributeName: Any]()
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = "LibreFranklin"
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: descriptor, size: size)
    }
    
    //    static func regularFont(size: CGFloat) -> UIFont {
    //        let descriptor = UIFontDescriptor(name: "OpenSans-Regular", size: size)
    //        return UIFont(name: "OpenSans-Regular", size: size) ?? .systemFont(ofSize: size, weight: .regular)
    //    }
    //
    //    static func boldFont(size: CGFloat) -> UIFont {
    //        return UIFont(name: "OpenSans-Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
    //    }
    //
    //    static func italicFont(size: CGFloat) -> UIFont {
    //        return UIFont(name: "OpenSans-Italic", size: size) ?? .italicSystemFont(ofSize: size)
    //    }
    
    /**
     Text hiển thị nội dung bình thường
     
     - returns
     Size: 14
     Weight: regular
     */
    static var normal: UIFont {
        return .font(size: baseFontSize, weight: .regular)
    }
    
    /**
     Text hiển thị Button
     
     - returns
     Size: 14
     Weight: medium
     */
    static var medium: UIFont {
        return .font(size: baseFontSize, weight: .medium)
    }
    
    /**
     Hiển thị ở các Header view
     
     - returns
     Size: 16
     Weight: regular
     */
    static var header: UIFont {
        return .font(size: baseFontSize + 2, weight: .regular)
    }
    
    /**
     Hiển thị ở các Header view
     
     - returns
     Size: 16
     Weight: medium
     */
    static var mediumHeader: UIFont {
        return .font(size: baseFontSize + 2, weight: .medium)
    }
    
    /**
     Hiển thị ở các Header view
     
     - returns
     Size: 18
     Weight: regular
     */
    static var title: UIFont {
        return .font(size: baseFontSize + 4, weight: .regular)
    }
    
    /**
     Hiển thị ở các Title Screen,..
     
     - returns
     Size: 18
     Weight: medium
     */
    static var mediumTitle: UIFont {
        return .font(size: baseFontSize + 4, weight: .medium)
    }
    
    /**
     Text hiển thị mô tả/caption
     
     - returns
     Size: 12
     Weight: medium
     */
    static var mediumCaption: UIFont {
        return .font(size: baseFontSize - 2, weight: .medium)
    }
    
    /**
     
     - returns
     Size: 20
     Weight: medium
     */
    static var mediumLargeTitle: UIFont {
        return .font(size: baseFontSize + 6, weight: .medium)
    }
}
