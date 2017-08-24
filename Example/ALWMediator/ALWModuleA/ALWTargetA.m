//
//  ALWTargetA.m
//  Pods
//
//  Created by lisong on 2017/8/24.
//
//

#import "ALWTargetA.h"
#import "ALWModuleAPrivateClass.h"

@implementation ALWTargetA

- (void)alwAction_methodA
{
    ALWModuleAPrivateClass *obj = [[ALWModuleAPrivateClass alloc] init];
    obj.name = @"TestName";
}

- (NSString *)alwAction_methodB
{
    return @"alwAction_methodB";
}

- (void)alwAction_methodC:(NSDictionary *)params
{

}

- (NSNumber *)alwAction_methodD:(NSDictionary *)params
{
    return @(1);
}

//- (void)alwAction_methodE
//{
//
//}

- (void)alwAction_methodF
{

}

@end
