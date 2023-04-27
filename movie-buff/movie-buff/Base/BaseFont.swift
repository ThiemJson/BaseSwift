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
        static var text_regular : UIFont        { UIFont.systemFont(ofSize: HelperUtils.isPad ? 16 : 14, weight: .regular) }
        static var text_semibold : UIFont       { UIFont.systemFont(ofSize: HelperUtils.isPad ? 16 : 14, weight: .semibold) }
        static var text_bold : UIFont           { UIFont.systemFont(ofSize: HelperUtils.isPad ? 16 : 14, weight: .bold) }
        static var text_heavy : UIFont          { UIFont.systemFont(ofSize: HelperUtils.isPad ? 16 : 14, weight: .heavy) }
    }
    
    struct Libre {}
    struct Mono {}
}
