# RealmManager

## 使用

### 增

```
let person = Person()
person.id = "101"
person.name = "xiaoming"
try? person.re.save()

```
### 查

```
// 查所有
try? Person.re.all()
// 根据主键
try? Person.re.query(primaryKey: "101")

```

### 改

```
try? person.re.edit {
    $0.name = "xiaohong"
}

```

### 删

```
// 普通删除
try? person.re.delete()

// 递归删除所有层级
try? person.re.delete(.cascade)

// 删除所有
try? Person.re.deleteAll()

```

## 安装

pod 'RealmManager'
