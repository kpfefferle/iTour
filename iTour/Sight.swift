//
//  Sight.swift
//  iTour
//
//  Created by Kevin Pfefferle on 10/9/23.
//

import Foundation
import SwiftData

@Model
class Sight {
    var name: String
    
    init(name: String = "") {
        self.name = name
    }
}
