//
//  QJCell.m
//  QJdouguoView
//
//  Created by Justin on 16/3/19.
//  Copyright © 2016年 Justin. All rights reserved.
//

#import "QJCell.h"

@implementation QJCell{
    TagModel *model;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = RGBCOLOR(223, 223, 223);
        model = [TagModel getInstance];
        NSInteger total = model.TagArr.count;
        for (int i=0; i<total; i++) {
            int row = i / COLUMN;
            int column = i % COLUMN;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(ROWSPACE + ROWWIDTH*column + ROWSPACE * column, ROWSPACE + (ROWHEIHT + ROWSPACE)*row, ROWWIDTH, ROWHEIHT);
            btn.tag = i;
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitle:model.TagArr[i][@"t"] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [btn setTitleColor:UIColorFromRGB(0x4c4c4c) forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(subCateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn];
            
        }
    }
    return self;
}

-(void)subCateBtnAction:(UIButton *)bt
{
    NSString *name = model.TagArr[bt.tag][@"t"];
    UIAlertView *Notpermitted=[[UIAlertView alloc] initWithTitle:@"跳转提示"
                                                         message:[NSString stringWithFormat:@"当前是<<%@>>页面",name]
                                                        delegate:nil
                                               cancelButtonTitle:@"确认"
                                               otherButtonTitles:nil];
    [Notpermitted show];

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
