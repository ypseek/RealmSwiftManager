//
//  RealmManagerQueen.swift
//  RealmManager
//
//  Created by yupeng. on 2020/5/25.
//  Copyright © 2020 seek. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmManagerQueue {
    
    let realm: Realm
    let queue: DispatchQueue

    init?() {
        queue = DispatchQueue(label: UUID().uuidString)
        var temp: Realm? = nil
        queue.sync {
            temp = try? Realm()
        }
        guard let valid = temp else { return nil }
        self.realm = valid
    }
}
