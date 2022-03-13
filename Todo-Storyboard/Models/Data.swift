//
//  Data.swift
//  Todo-Storyboard
//
//  Created by Irakli Sokhaneishvili on 13.03.22.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
