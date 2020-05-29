//
//  RealmManager.swift
//  RealmManager
//
//  Created by yupeng on 2020/5/24.
//  Copyright © 2020 seek. All rights reserved.
//

import RealmSwift

public final class RealmManager<T> {
    
    var base: T
    
    public init(_ instance: T) {
        self.base = instance
    }
}

public final class RealmManagerStatic<T> {
    
    var baseType: T.Type
    
    public init(_ instance: T.Type) {
        self.baseType = instance
    }
}

public protocol RealmManagerCompatible {
    
    associatedtype CompatibleType
    var re: RealmManager<CompatibleType> { get }
    static var re: RealmManagerStatic<CompatibleType> { get }
}

public extension RealmManagerCompatible {
    
    var re: RealmManager<Self> {
        get { return RealmManager.init(self) }
    }
    
    static var re: RealmManagerStatic<Self> {
        get { return RealmManagerStatic.init(Self.self) }
    }
}

public extension RealmManager where T: Object {
    
    var isManaged: Bool {
        return (self.base.realm != nil)
    }
}

extension Object: RealmManagerCompatible {}



