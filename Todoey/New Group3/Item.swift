//
//  Item.swift
//  Todoey
//
//  Created by Charles Martin Reed on 8/7/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import Foundation

//encodable, decodale or, just codable in Swift 4 and newer, means that all properties use STANDARD data types
class Item: Codable {
    
    var title: String = ""
    var done: Bool = false
    
}
