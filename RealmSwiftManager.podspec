Pod::Spec.new do |s|
    s.name         = 'RealmSwiftManager'
    s.version      = '0.0.3'
    s.summary      = '基于RealmSwift封装的微型框架，一行代码实现增删改查，自动管理线程。'
    s.homepage     = 'https://github.com/ypseek/RealmManager'
    s.license      = 'MIT'
    s.authors      = {'ypseek' => 'yupengseek@gmail.com'}
    s.platform     = :ios, '10.0'
    s.source       = {:git => 'https://github.com/ypseek/RealmManager.git', :tag => s.version}
    s.source_files = 'RealmSwiftManager/*'
    s.requires_arc = true
    s.dependency 'RealmSwift', '~> 4.4.0'
    s.swift_version = '5.0'
end
