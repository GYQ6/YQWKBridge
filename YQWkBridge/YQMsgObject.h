//
//  YQMsgObject.h
//  002---WKWebView
//
//  Created by GYQ on 2020/3/24.
//  Copyright © 2020 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^JSResponseCallback)(NSDictionary *responseData);

@interface YQMsgObject : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@property (copy, nonatomic) NSString *handler; /**<<#brief#>*/
@property (copy, nonatomic) NSDictionary *parameters; /**<<#brief#>*/
@property (copy, nonatomic) NSString *callbackID; /**<<#brief#>*/
@property (copy, nonatomic) NSString *callbackFunction; /**<<#brief#>*/
@property (copy, nonatomic) JSResponseCallback callback; /**<<#brief#>*/

- (void)callback:(NSDictionary *)result;

@end

NS_ASSUME_NONNULL_END
