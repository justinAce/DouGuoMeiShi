//
//  TagModel.h
//  QJdouguoView
//
//  Created by Justin on 16/3/20.
//  Copyright © 2016年 Justin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagModel : NSObject

+ (TagModel *)getInstance;

@property(nonatomic, strong)NSMutableArray *TagArr;

@end
