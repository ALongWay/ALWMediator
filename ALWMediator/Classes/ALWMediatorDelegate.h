//
//  ALWMediatorDelegate.h
//  Pods
//
//  Created by lisong on 2017/8/23.
//
//

#import <Foundation/Foundation.h>

@protocol ALWMediatorDelegate <NSObject>

///未发现调用目标
- (void)alwMediatorNotFoundTarget:(NSString *)targetName
                       withAction:(NSString *)actionName
                           params:(NSDictionary *)params;

///未发现调用方法
- (void)alwMediatorNotFoundAction:(NSString *)actionName
                       withTarget:(NSString *)targetName
                           params:(NSDictionary *)params;

///是否可以调用指定对象和方法
- (BOOL)alwMediatorCanPerformTarget:(NSString *)targetName
                             action:(NSString *)actionName
                             params:(NSDictionary *)params;

@end
