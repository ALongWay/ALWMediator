//
//  ALWMediator.h
//  Pods
//
//  Created by lisong on 2017/8/23.
//
//

#import <Foundation/Foundation.h>
#import "ALWMediatorDelegate.h"

@interface ALWMediator : NSObject

/**
 设置调用对象和方法的统一前缀

 @param targetPrefix 对象的前缀
 @param actionPrefix 方法的前缀
 */
+ (void)setupWithTargetPrefix:(NSString *)targetPrefix
                 actionPrefix:(NSString *)actionPrefix;

///可以选择设置回调代理者
+ (void)setDelegate:(id<ALWMediatorDelegate>)delegate;

/**
 调用指定对象的有参数方法

 @param targetName 目标对象名
 @param actionName 目标方法名
 @param params 参数字典
 @return 返回值
 */
+ (id)performTarget:(NSString *)targetName
             action:(NSString *)actionName
             params:(NSDictionary *)params;

/**
 调用指定对象的无参数方法
 
 @param targetName 目标对象名
 @param actionName 目标方法名
 @return 返回值
 */
+ (id)performTarget:(NSString *)targetName
             action:(NSString *)actionName;

@end
