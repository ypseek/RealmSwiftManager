//
//  Edit.swift
//  RealmManager
//
//  Created by yupeng on 2020/5/24.
//  Copyright © 2020 seek. All rights reserved.
//

import Foundation
import RealmSwift

extension RealmManager where T: Object {
    
    func edit(_ closure: @escaping (_ T: T) -> Void) throws {
        if self.isManaged {
            guard let rq = RealmManagerQueue() else {
                throw RealmManagerError.RealmQueueCantBeCreate
            }
            let ref = ThreadSafeReference(to: self.base)
            try rq.queue.sync {
                guard let object = rq.realm.resolve(ref) else { throw RealmManagerError.ObjectCantBeResolved }
                try rq.realm.write {
                    closure(object)
                }
            }
        }else {
            closure(self.base)
        }
    }
}
