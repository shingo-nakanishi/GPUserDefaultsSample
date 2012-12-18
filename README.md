GPUserDefaultsSample
====================

インストール
-----
GPUserDefaults.hとGPUserDefaults.mをあなたのプロジェクトに入れる。

GPUserDefaultsを拡張する（あなたのプロジェクトでひとつだけ作れば十分だと思います）。

あとは、ヘッダーに
```
@property(nonatomic, strong) NSString *bar;
@property(nonatomic, strong) NSString *piyo;
```

ボディーに
```
@dynamic bar;
@dynamic piyo;
```
といった感じで、プロパティを追加すれば、
```
[[YourUserDefaults sharedManager] setBar:@"BBB"];
[[YourUserDefaults sharedManager] setPiyo:@"PPP"];
    
NSLog(@"bar:%@", [YourUserDefaults sharedManager].bar);
NSLog(@"piyo:%@", [YourUserDefaults sharedManager].piyo);
```
でユーザでフォルトにアクセス可能。
