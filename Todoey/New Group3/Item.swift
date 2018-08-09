//
//  Item.swift
//  Todoey
//
//  Created by Charles Martin Reed on 8/8/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    //backward relationship, pointing to the many to one
    //each item has a parent category of type Category, from the items property on that type
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
