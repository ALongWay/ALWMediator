//
//  ALWMediator.m
//  Pods
//
//  Created by lisong on 2017/8/23.
//
//

#import "ALWMediator.h"

@interface ALWMediator ()

@property (nonatomic, strong) NSString *targetPrefix;
@property (nonatomic, strong) NSString *actionPrefix;

@property (nonatomic, weak) id<ALWMediatorDelegate> delegate;

@end

@implementation ALWMediator

+ (instancetype)sharedInstance
{
    static ALWMediator *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ALWMediator alloc] init];
    });
    
    return instance;
}

#pragma mark - 公开的类方法
+ (void)setupWithTargetPrefix:(NSString *)targetPrefix
                 actionPrefix:(NSString *)actionPrefix
{
    ALWMediator *mediator = [self sharedInstance];
    mediator.targetPrefix = targetPrefix;
    mediator.actionPrefix = actionPrefix;
}

+ (void)setDelegate:(id<ALWMediatorDelegate>)delegate
{
    ALWMediator *mediator = [self sharedInstance];
    mediator.delegate = delegate;
}

+ (id)performTarget:(NSString *)targetName
             action:(NSString *)actionName
             params:(NSDictionary *)params
{
    return [[ALWMediator sharedInstance] performTarget:targetName
                                                action:actionName
                                                params:params];
}

+ (id)performTarget:(NSString *)targetName
             action:(NSString *)actionName
{
    return [[ALWMediator sharedInstance] performTarget:targetName
                                                action:actionName];
}

#pragma mark - 私有实例方法
- (id)performTarget:(NSString *)targetName
             action:(NSString *)actionName
             params:(NSDictionary *)params
{
    NSString *className;
    if (_targetPrefix) {
        className = [NSString stringWithFormat:@"%@%@", _targetPrefix, targetName];
    }else{
        className = targetName;
    }
    
    NSString *selectorName;
    if (_actionPrefix) {
        selectorName = [NSString stringWithFormat:@"%@%@:", _actionPrefix, actionName];
    } else {
        selectorName = actionName;
    }
    
    return [self performClass:className
                     selector:selectorName
                       params:params];
}

- (id)performTarget:(NSString *)targetName
             action:(NSString *)actionName
{
    NSString *className;
    if (_targetPrefix) {
        className = [NSString stringWithFormat:@"%@%@", _targetPrefix, targetName];
    }else{
        className = targetName;
    }
    
    NSString *selectorName;
    if (_actionPrefix) {
        selectorName = [NSString stringWithFormat:@"%@%@", _actionPrefix, actionName];
    } else {
        selectorName = actionName;
    }
    
    return [self performClass:className
                     selector:selectorName
                       params:nil];
}

- (id)performClass:(NSString *)className
          selector:(NSString *)selectorName
            params:(NSDictionary *)params
{
    if ([self.delegate respondsToSelector:@selector(alwMediatorCanPerformTarget:action:params:)]) {
        if (![self.delegate alwMediatorCanPerformTarget:className action:selectorName params:params]) {
            return nil;
        }
    }
    
    Class class = NSClassFromString(className);
    SEL action = NSSelectorFromString(selectorName);
    
    NSObject *target = [[class alloc] init];
    
    if (!target) {
        if ([self.delegate respondsToSelector:@selector(alwMediatorNotFoundTarget:withAction:params:)]) {
            [self.delegate alwMediatorNotFoundTarget:className withAction:selectorName params:params];
        }
        
        return nil;
    }
    
    if ([target respondsToSelector:action]) {
        return [self safePerformTarget:target action:action params:params];
    }else{
        if ([self.delegate respondsToSelector:@selector(alwMediatorNotFoundAction:withTarget:params:)]) {
            [self.delegate alwMediatorNotFoundAction:selectorName withTarget:className params:params];
        }
        
        return nil;
    }
}

///可以避免当target返回类型为void时候崩溃的方法
- (id)safePerformTarget:(NSObject *)target
                 action:(SEL)action
                 params:(NSDictionary *)params
{
    NSMethodSignature *methodSignature = [target methodSignatureForSelector:action];
    
    if (!methodSignature) {
        return nil;
    }
    
    const char *returnType = [methodSignature methodReturnType];
    
    //字符串相同返回0
    if (strcmp(returnType, @encode(void)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [invocation setTarget:target];
        [invocation setSelector:action];
        
        if (params) {
            [invocation setArgument:&params atIndex:2];
        }
        
        [invocation invoke];
        
        return nil;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
    }
}

@end
