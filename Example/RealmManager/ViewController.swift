//
//  ViewController.swift
//  RealmManager
//
//  Created by yupeng on 2020/5/24.
//  Copyright © 2020 seek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        RealmMnagerConfig()
        
        add()
        query()
        update()
//        delete()
    }

    //增
    private func add() {
        let person = Person()
        person.id = "101"
        person.name = "xiaoming"

        let dog = Dog()
        dog.name = "hashiqi"
        dog.id = "1001"
    
        person.dogs.append(dog)
        // 添加使用 person.re.save(） 此处防止每次运行插入相同的id崩溃
        // .error 添加   .modify 更新   .all 覆盖更新，不用判断是否存在
        try? person.re.save(update: .all)
    }
    
    //查
    private func query() {
        // 查询所有
        let persons = try? Person.re.all()
        print("query all    ",persons ?? "error")
        
        // 根据主键查询（需要查询必须含有主键）
        let person = try? Person.re.query(primaryKey: "101")
        print("query primaryKey    ",person ?? "error")
    }
    
    //改
    private func update() {
        if let person = try? Person.re.query(primaryKey: "101") {
            try? person.re.edit {
                $0.name = "xiaohong"
                $0.dogs.forEach { (dog) in
                    dog.name = "jinmao"
                }
            }
        }
        query()
    }
    
    //删
    private func delete() {
        //普通删除
        if let person = try? Person.re.query(primaryKey: "101") {
            do {
                try person.re.delete()
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
//        //递归删除所有层级
//        if let person = try? Person.re.query(primaryKey: "101") {
//            try? person.re.delete(.cascade)
//        }
//
//        //删除所有
//        try? Person.re.deleteAll()
    }
}

