//
//  Category.swift
//  Todoey
//
//  Created by Charles Martin Reed on 8/8/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    
    //forward reltionship, many to one
    let items = List<Item>()
}
