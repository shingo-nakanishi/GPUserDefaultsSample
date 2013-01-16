//
//  GPUserDefaults.m
//  GPUserDefaultsSample
//
//  Created by shingo.nakanishi on 12/12/18.
//  Copyright (c) 2012年 shingo.nakanishi. All rights reserved.
//

#import "GPUserDefaults.h"
#import <objc/runtime.h>

@implementation GPUserDefaults

static id gPUserDefaults = nil;

- (id)init
{
    self = [super init];
    if (self) {
        //=======================================================================//
        // プロパティをNSStringの配列で取得
        //=======================================================================//
        NSMutableArray *propertiesNames = [self getProperties:[self class]];
        
        //=======================================================================//
        // ユーザでフォルトを準備
        //=======================================================================//
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
        //=======================================================================//
        // setterとgetterをメタプログラミング
        //=======================================================================//
        for(int i=0; i<propertiesNames.count; i++){
            //-----------------------------------------------------//
            // setter
            //-----------------------------------------------------//
            void (^setBlock)(id o, id s) = ^(id o, id s){
                //                NSLog(@">>> %@",s);
                [ud setObject:s forKey:[propertiesNames objectAtIndex:i]];
            };
            
            NSString *capitalString = [self capitalString:[propertiesNames objectAtIndex:i]];
            NSString *setSelString = [NSString stringWithFormat:@"set%@:",capitalString];
            SEL setSel = NSSelectorFromString(setSelString);
            IMP setImp = imp_implementationWithBlock(setBlock);
            class_addMethod([GPUserDefaults class], setSel, setImp, "v@:@");
            
            //-----------------------------------------------------//
            // getter
            //-----------------------------------------------------//
            NSString *(^getBlock)(id o) = ^(id o){
                //                NSLog(@"%@", o);
                return [ud objectForKey:[propertiesNames objectAtIndex:i]];
            };
            SEL getSel = NSSelectorFromString([propertiesNames objectAtIndex:i]);
            IMP getImp = imp_implementationWithBlock(getBlock);
            class_addMethod([GPUserDefaults class], getSel, getImp, "@@:");
            
//            //-----------------------------------------------------//
//            // remove
//            //-----------------------------------------------------//
//            void (^removeBlock)(id o) = ^(id o){
//                //                NSLog(@"%@", o);
//                [ud removeObjectForKey:[propertiesNames objectAtIndex:i]];
//            };
//            NSString *capitalRemoveString = [self capitalString:[propertiesNames objectAtIndex:i]];
//            NSString *deleteSelString = [NSString stringWithFormat:@"delete%@:",capitalRemoveString];
//            SEL removeSel = NSSelectorFromString(deleteSelString);
//            IMP removeImp = imp_implementationWithBlock(removeBlock);
//            class_addMethod([GPUserDefaults class], removeSel, removeImp, "v@:");
        }
    }
    return self;
}

+(instancetype)sharedManager{
    @synchronized(self) {
        if (gPUserDefaults == nil) {
            gPUserDefaults = [[self alloc] init];
        }
    }
    return gPUserDefaults;
}

-(NSMutableArray *)getProperties:(id)c
{
    NSString *propertyName;
    unsigned int outCount, i;
    NSMutableArray *propertieNames = [[NSMutableArray alloc] initWithObjects: nil];
    
    objc_property_t *properties = class_copyPropertyList(c, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        propertyName = [NSString stringWithUTF8String:property_getName(property)];
        [propertieNames addObject:propertyName];
    }
    free(properties);
    return propertieNames;
}

-(NSString *)capitalString:(NSString *)str{
    NSString *initial = [[str substringToIndex:1] capitalizedString];
    NSString *result = [NSString stringWithFormat:@"%@%@", initial, [str substringFromIndex:1]];
    
    //    NSLog(@"initial:%@", initial);
    //    NSLog(@"result:%@", result);
    
    return result;
}

-(void)removeAll{
    //=======================================================================//
    // プロパティをNSStringの配列で取得
    //=======================================================================//
    NSMutableArray *propertiesNames = [self getProperties:[self class]];
    
    //=======================================================================//
    // ユーザでフォルトを準備
    //=======================================================================//
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    //=======================================================================//
    // 消す
    //=======================================================================//
    for(int i=0; i<propertiesNames.count; i++){
        [ud removeObjectForKey:[propertiesNames objectAtIndex:i]];
    }
}


@end
