//
//  Category.swift
//  Todoey
//
//  Created by Amir Siabi on 5/4/18.
//  Copyright © 2018 Amir Siabi. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
