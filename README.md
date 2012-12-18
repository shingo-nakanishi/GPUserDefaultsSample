GPUserDefaultsSample
====================
Cora Data感覚でUserDefaultsが扱えます。
（まだテストを十分に行っておりません。使用は各自の判断でお願い致します）

ARCのみ対応です。


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
