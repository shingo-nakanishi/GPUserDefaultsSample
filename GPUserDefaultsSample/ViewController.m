//
//  ViewController.m
//  GPUserDefaultsSample
//
//  Created by shingo.nakanishi on 12/12/18.
//  Copyright (c) 2012年 shingo.nakanishi. All rights reserved.
//

#import "ViewController.h"
#import "YourUserDefaults.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [YourUserDefaults sharedManager].dic = @{@"key1":@"value1",@"key2":@"value2"};
    [YourUserDefaults sharedManager].strHoge = @"BBBB";
    [YourUserDefaults sharedManager].FFFF = @"FFFF";
    
    NSLog(@"dic:%@", [YourUserDefaults sharedManager].dic);
    NSLog(@"str:%@", [YourUserDefaults sharedManager].strHoge);
    NSLog(@"FFFF:%@", [YourUserDefaults sharedManager].FFFF);
    
    [[YourUserDefaults sharedManager] removeAll];
    
    NSLog(@"dic:%@", [YourUserDefaults sharedManager].dic);
    NSLog(@"str:%@", [YourUserDefaults sharedManager].strHoge);
    NSLog(@"FFFF:%@", [YourUserDefaults sharedManager].FFFF);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
