//
//  YQWeakProxy.m
//  YQWKBridgeDemo
//
//  Created by GYQ on 2020/4/9.
//  Copyright © 2020 YQWKBridgeDemoGYQ.com. All rights reserved.
//

#import "YQWeakProxy.h"

@interface YQWeakProxy ()
@property (weak, nonatomic) id target; /**<<#brief#>*/
@end

@implementation YQWeakProxy

- (instancetype)initWithTarget:(id)target
{
    self.target = target;
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:self.target];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [self.target methodSignatureForSelector:sel];
}

@end
