//
//  ALWMediator+TargetA.m
//  Pods
//
//  Created by lisong on 2017/8/24.
//
//

#import "ALWMediator+TargetA.h"

#define Target_(name) static NSString *const ALWTarget##name = @#name;
#define Action_(name) static NSString *const alwAction_##name = @#name;

Target_(A)

Action_(methodA)
Action_(methodB)
Action_(methodC)
Action_(methodD)
Action_(methodE)
Action_(methodF)

@implementation ALWMediator (TargetA)

+ (void)targetA_methodA
{
    [self performTarget:ALWTargetA action:alwAction_methodA];
}

+ (NSString *)targetA_methodB
{
    return [self performTarget:ALWTargetA action:alwAction_methodB];
}

+ (void)targetA_methodCWithParamA:(NSString *)paramA paramB:(NSInteger)paramB
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (paramA) {
        [params setObject:paramA forKey:@"paramA"];
    }
    
    [params setObject:@(paramB) forKey:@"paramB"];
    
    [self performTarget:ALWTargetA action:alwAction_methodC params:params];
}

+ (NSInteger)targetA_methodDWithParamA:(NSString *)paramA paramB:(NSInteger)paramB
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (paramA) {
        [params setObject:paramA forKey:@"paramA"];
    }
    
    [params setObject:@(paramB) forKey:@"paramB"];
    
    NSNumber *number = [self performTarget:ALWTargetA action:alwAction_methodD params:params];
    
    return [number integerValue];
}

+ (void)targetA_methodE
{
    [self performTarget:ALWTargetA action:alwAction_methodE];
}

+ (void)targetA_methodF
{
    [self performTarget:@"B" action:alwAction_methodF];
}

@end
