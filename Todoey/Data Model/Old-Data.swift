//
//  Data.swift
//  Todoey
//
//  Created by Amir Siabi on 5/4/18.
//  Copyright © 2018 Amir Siabi. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
}
