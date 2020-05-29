//
//  Delete.swift
//  RealmManager
//
//  Created by yupeng on 2020/5/24.
//  Copyright © 2020 seek. All rights reserved.
//

import Foundation
import RealmSwift

public enum RealManagerDeleteMethod {
    case simple
    case cascade
}

protocol RealmManagerList {

    func children() -> [Object]
}

extension List: RealmManagerList {
    
    func children() -> [Object] {
        return self.compactMap { $0 as? Object }
    }
}

extension RealmManagerStatic where T: Object {
    
    /// 删除所有
    func deleteAll() throws {
        let realm = try Realm()
        realm.delete(realm.objects(self.baseType))
    }
}

/// 普通删除
extension RealmManager where T: Object {
    
    func delete(_ method: RealManagerDeleteMethod = .simple) throws {
        switch method {
        case .simple:
            self.isManaged ? try self.manager_delete() : try self.unmanager_delete()
        case .cascade:
            self.isManaged ? try self.manager_cascadeDelete() : try self.unmanager_cascadeDelete()
        }
    }
    
    /// realm.delete(self.base) 直接删除会出现 [invalid object]
    private func unmanager_delete() throws {
        let realm = try Realm()
        if let key = T.primaryKey() {
            let value = self.base.value(forKey: key)
            if let object = value as? Object {
                try realm.write {
                    realm.delete(object)
                }
            }
        }else {
            throw RealmManagerError.PrimaryKeyNotFound
        }
    }
    
    private func manager_delete() throws {
        guard let rq = RealmManagerQueue() else { throw RealmManagerError.RealmQueueCantBeCreate }
        let ref = ThreadSafeReference.init(to: self.base)
        try rq.queue.sync {
            guard let value = rq.realm.resolve(ref) else { throw RealmManagerError.ObjectCantBeResolved }
            try rq.realm.write {
                rq.realm.delete(value)
            }
        }
    }
}

/// 递归删除
extension RealmManager where T: Object {
    
    private func unmanager_cascadeDelete() throws {
        guard let rq = RealmManagerQueue() else { throw RealmManagerError.RealmQueueCantBeCreate }
        guard let key = T.primaryKey() else { throw RealmManagerError.PrimaryKeyNotFound }
        let value = self.base.value(forKey: key)
        if let object = value as? Object {
            try rq.realm.write {
                RealmManager.cascadeDelete(object: object, queue: rq)
            }
        }
    }
    
    private func manager_cascadeDelete() throws {
        guard let rq = RealmManagerQueue() else { throw RealmManagerError.RealmQueueCantBeCreate }
        let ref = ThreadSafeReference.init(to: self.base)
        try rq.queue.sync {
            guard let object = rq.realm.resolve(ref) else { throw RealmManagerError.ObjectCantBeResolved }
            try rq.realm.write {
                RealmManager.cascadeDelete(object: object, queue: rq)
            }
        }
    }
    
    /// 递归删除List对象
    private static func cascadeDelete(object:Object, queue: RealmManagerQueue) {
        for property in object.objectSchema.properties {
            guard let value = object.value(forKey: property.name) else { continue }
            if let object = value as? Object {
                RealmManager.cascadeDelete(object: object, queue: queue)
            }
            if let list = value as? RealmManagerList {
                list.children().forEach {
                    RealmManager.cascadeDelete(object: $0, queue: queue)
                }
            }
        }
        queue.realm.delete(object)
    }
}
