//
//  ALWTargetA.h
//  Pods
//
//  Created by lisong on 2017/8/24.
//
//

#import <Foundation/Foundation.h>

#pragma mark - 被Target-Action模式调用的实例方法，建议统一将参数装入字典传递；若有返回值，返回值类型为id

@interface ALWTargetA : NSObject

- (void)alwAction_methodA;

- (NSString *)alwAction_methodB;

- (void)alwAction_methodC:(NSDictionary *)params;

- (NSNumber *)alwAction_methodD:(NSDictionary *)params;

//- (void)alwAction_methodE;

- (void)alwAction_methodF;

@end
