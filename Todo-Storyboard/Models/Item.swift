//
//  Item.swift
//  Todo-Storyboard
//
//  Created by Irakli Sokhaneishvili on 13.03.22.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var status: Bool = false
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
