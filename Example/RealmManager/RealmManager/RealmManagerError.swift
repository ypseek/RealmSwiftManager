//
//  RealmManagerError.swift
//  RealmManager
//
//  Created by yupeng on 2020/5/24.
//  Copyright © 2020 seek. All rights reserved.
//

import Foundation

public enum RealmManagerError: Error {
    
    case PrimaryKeyNotFound
    case RealmQueueCantBeCreate
    case ObjectCantBeResolved
}
