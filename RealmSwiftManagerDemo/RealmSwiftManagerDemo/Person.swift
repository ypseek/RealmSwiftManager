//
//  Person.swift
//  RealmManager
//
//  Created by yupeng. on 2020/5/25.
//  Copyright © 2020 seek. All rights reserved.
//

import Foundation
import RealmSwift

final class Person: Object {
    
    @objc dynamic var name: String?
    @objc dynamic var id: String?
    
    var dogs = List<Dog>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class Dog: Object {
    @objc dynamic var name: String?
    @objc dynamic var id: String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
