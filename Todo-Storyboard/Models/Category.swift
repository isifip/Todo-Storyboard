//
//  Category.swift
//  Todo-Storyboard
//
//  Created by Irakli Sokhaneishvili on 13.03.22.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    
    let items = List<Item>()
}
