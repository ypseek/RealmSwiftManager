//
//  Query.swift
//  RealmManager
//
//  Created by yupeng on 2020/5/24.
//  Copyright © 2020 seek. All rights reserved.
//

import Foundation
import RealmSwift

extension RealmManagerStatic where T: Object {
    
    /// 主键查询
    public func query<K>(primaryKey: K) throws -> T {
        let realm = try Realm()
        if let obj = realm.object(ofType: self.baseType, forPrimaryKey: primaryKey) {
            return obj
        }else {
            throw RealmManagerError.PrimaryKeyNotFound
        }
    }
    
    /// 查询全部
    public func all() throws -> Results<T> {
        let realm = try Realm()
        return realm.objects(self.baseType)
    }
}
