//
//  Helper.h
//  QJdouguoView
//
//  Created by Justin on 16/3/19.
//  Copyright © 2016年 Justin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Helper : NSObject

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define Screen_Width    ([UIScreen mainScreen].bounds.size.width)

#define Screen_Height   ([UIScreen mainScreen].bounds.size.height)

#define NAVIGATIONBARHEIGHT ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0 ? 44.0 : 64.0)

#define COLUMN 3

#define ROWHEIHT 30

#define ROWSPACE 10

#define ROWWIDTH  (Screen_Width - 4*ROWSPACE)/3


+ (void)startAnimation:(UIImageView *)view Up:(BOOL)up complete:(void(^)())block;

+ (float)calculateRowHeight;
@end
