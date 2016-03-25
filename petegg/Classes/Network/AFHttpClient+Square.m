//
//  AFHttpClient+Square.m
//  petegg
//
//  Created by ldp on 16/3/23.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "AFHttpClient+Square.h"

@implementation AFHttpClient (Square)

-(void)queryFollowSproutpetWithMid:(NSString *)mid
                         pageIndex:(int)pageIndex
                          pageSize:(int)pageSize
                          complete:(void(^)(RecommendListModel *model))completeBlock
                           failure:(void(^)())failureBlock{
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"classes"] = @"appinterface";
    params[@"method"] = @"json";
    params[@"common"] = @"querySproutpet";
    
    params[@"mid"] = mid;
    params[@"page"] = @(pageIndex);
    params[@"size"] = @(pageSize);
    //params[@"ftype"] = ftype;
//    params[@"type"] = type;
   
    [self POST:@"clientAction.do" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (completeBlock) {
            completeBlock([[RecommendListModel alloc] initWithDictionary:responseObject[@"jsondata"] error:nil]);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock();
        }
    }];
}


-(void)querySproutpetWithMid:(NSString *)mid pageIndex:(int)pageIndex pageSize:(int)pageSize complete:(void (^)(RecommendListModel *))completeBlock failure:(void (^)())failureBlock{

    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    params[@"classes"] = @"appinterface";
    params[@"method"] = @"json";
    params[@"common"] = @"queryFollowSproutpet";
    
    params[@"mid"] = mid;
    params[@"page"] = @(pageIndex);
    params[@"size"] = @(pageSize);
    //params[@"ftype"] = ftype;
    //    params[@"type"] = type;
    
    [self POST:@"clientAction.do" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (completeBlock) {
            completeBlock([[RecommendListModel alloc] initWithDictionary:responseObject[@"jsondata"] error:nil]);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock();
        }
    }];



}




@end
