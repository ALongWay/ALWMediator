//
//  ALWMediator+TargetA.h
//  Pods
//
//  Created by lisong on 2017/8/24.
//
//

#import "ALWMediator.h"

@interface ALWMediator (TargetA)

+ (void)targetA_methodA;

+ (NSString *)targetA_methodB;

+ (void)targetA_methodCWithParamA:(NSString *)paramA paramB:(NSInteger)paramB;

+ (NSInteger)targetA_methodDWithParamA:(NSString *)paramA paramB:(NSInteger)paramB;

+ (void)targetA_methodE;

+ (void)targetA_methodF;

@end
