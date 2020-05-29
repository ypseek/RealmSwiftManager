//
//  RealmMnagerConfig.swift
//  RealmManager
//
//  Created by yupeng. on 2020/5/28.
//  Copyright © 2020 seek. All rights reserved.
//

import Foundation
import RealmSwift

/// 如果要存储的数据模型属性发生变化,需要配置当前版本号比之前大
var schemaVersion : UInt64 = 1

public class RealmMnagerConfig {
    
    @discardableResult
    init() {
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        let dbPath = cachePath.appending("/cacheDB.realm")
        Realm.Configuration.defaultConfiguration.fileURL = URL.init(string: dbPath)
        Realm.Configuration.defaultConfiguration.schemaVersion = schemaVersion
    }
}
