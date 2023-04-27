//
//  BaseIcon.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
struct BaseIcon {
    struct Common {
        static var backward     : String { "chevron.backward" }
        static var forward      : String { "chevron.forward" }
    }
    
    struct Search {
        static var cancel       : String { "x.circle.fill" }
        static var search       : String { "magnifyingglass" }
    }
    
    struct Setting {
        static var privacy      : String { "key.viewfinder" }
        static var rating       : String { "star.bubble" }
        static var share        : String { "square.and.arrow.up.circle" }
        static var feedback     : String { "paperplane.circle" }
    }
    
    struct Favorite {
        static var heart        : String { "hear" }
        static var sun          : String { "sun" }
    }
}
