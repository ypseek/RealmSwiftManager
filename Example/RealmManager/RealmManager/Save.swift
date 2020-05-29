//
//  Update.swift
//  RealmManager
//
//  Created by yupeng on 2020/5/24.
//  Copyright © 2020 seek. All rights reserved.
//

import Foundation
import RealmSwift

extension RealmManager where T: Object {
    
    /// 自动管理线程
    /// - Parameter update: .error 添加   .modify 更新   .all 覆盖更新，不用判断是否存在
    public func save(update: Realm.UpdatePolicy = .error) throws {
        _ = self.isManaged ? try self.managed_saved(update: update) : try self.saved(update: update)
    }
    
    ///非托管对象（未存在realm数据库）
    private func saved(update: Realm.UpdatePolicy) throws -> T {
        let realm = try Realm()
        realm.beginWrite()
        let ret = realm.create(T.self, value: self.base, update: update)
        try realm.commitWrite()
        return ret
    }
    
    ///托管对象（使用同一个realm对象）
    private func managed_saved(update: Realm.UpdatePolicy) throws -> T {
        guard let rq = RealmManagerQueue() else {
            throw RealmManagerError.RealmQueueCantBeCreate
        }
        let ref = ThreadSafeReference(to: self.base)
        return try rq.queue.sync {
            guard let object = rq.realm.resolve(ref) else { throw RealmManagerError.ObjectCantBeResolved }
            rq.realm.beginWrite()
            let ret = rq.realm.create(T.self, value: object, update: update)
            try rq.realm.commitWrite()
            return ret
        }
    }
}

