GPUserDefaultsSample
====================

インストール
-----
GPUserDefaults.hとGPUserDefaults.mをあなたのプロジェクトに入れる。

GPUserDefaultsを拡張する（あなたのプロジェクトでひとつだけ作れば十分だと思います）。

あとは、ヘッダーに
```
@property(nonatomic, strong) NSDictionary *dic;
@property(nonatomic, strong) NSString *str;
```

ボディーに
```
@dynamic dic;
@dynamic str;
```
といった感じで、プロパティを追加すれば、
```
[YourUserDefaults sharedManager].dic = @{@"key1":@"value1",@"key2":@"value2"};
[YourUserDefaults sharedManager].str = @"BBBB";
    
NSLog(@"dic:%@", [YourUserDefaults sharedManager].dic);
NSLog(@"str:%@", [YourUserDefaults sharedManager].str);
```
でユーザでフォルトにアクセス可能。
