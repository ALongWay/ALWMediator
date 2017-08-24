//
//  ALWViewController.m
//  ALWMediator
//
//  Created by lisong on 08/23/2017.
//  Copyright (c) 2017 lisong. All rights reserved.
//

#import "ALWViewController.h"
#import "ALWMediator+TargetA.h"

//统一调用对象和方法的前缀
static NSString *const kTargetPrefix = @"ALWTarget";
static NSString *const kActionPrefix = @"alwAction_";

@interface ALWViewController ()<ALWMediatorDelegate>

@end

@implementation ALWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [ALWMediator setupWithTargetPrefix:kTargetPrefix actionPrefix:kActionPrefix];
    [ALWMediator setDelegate:self];
    
    [ALWMediator targetA_methodA];
    
    NSString *resultB = [ALWMediator targetA_methodB];
    NSLog(@"resultB: %@", resultB);
    
    [ALWMediator targetA_methodCWithParamA:@"test" paramB:1];
    
    NSInteger resultD = [ALWMediator targetA_methodDWithParamA:@"test" paramB:2];
    NSLog(@"resultD: %ld", (long)resultD);
    
    [ALWMediator targetA_methodE];
    
    [ALWMediator targetA_methodF];
}

#pragma mark - ALWMediatorDelegate
- (BOOL)alwMediatorCanPerformTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params
{
    if ([targetName isEqualToString:@"ALWTargetA"]
        && [actionName isEqualToString:@"alwAction_methodC:"]) {
        NSLog(@"alwMediatorCanNotPerformTarget: %@, action: %@, params: %@", targetName, actionName, params);

        return NO;
    }
    
    return YES;
}

- (void)alwMediatorNotFoundTarget:(NSString *)targetName withAction:(NSString *)actionName params:(NSDictionary *)params
{
    NSLog(@"alwMediatorNotFoundTarget: %@, withAction: %@, params: %@", targetName, actionName, params);
}

- (void)alwMediatorNotFoundAction:(NSString *)actionName withTarget:(NSString *)targetName params:(NSDictionary *)params
{
    NSLog(@"alwMediatorNotFoundAction: %@, withTarget: %@, params: %@", actionName, targetName, params);
}

@end
