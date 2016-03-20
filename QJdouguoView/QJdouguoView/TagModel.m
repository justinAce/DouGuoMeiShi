//
//  TagModel.m
//  QJdouguoView
//
//  Created by Justin on 16/3/20.
//  Copyright © 2016年 Justin. All rights reserved.
//

#import "TagModel.h"

static TagModel *sharedTagModelInstance = nil;

@implementation TagModel

+ (TagModel *)getInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        sharedTagModelInstance = [[self alloc] init];
        sharedTagModelInstance.TagArr = [[NSMutableArray alloc] initWithCapacity:0];
    });
    return sharedTagModelInstance;
}

@end
