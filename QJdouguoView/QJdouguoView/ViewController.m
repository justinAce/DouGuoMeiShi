//
//  ViewController.m
//  QJdouguoView
//
//  Created by Justin on 16/3/19.
//  Copyright © 2016年 Justin. All rights reserved.
//

#import "ViewController.h"
#import "CategoryCell.h"
#import "QJCell.h"

static NSString *CellIdentifier2 = @"cellidentifer2";

static NSString *CellIdentifier1 = @"cellidentifer1";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)NSArray *DataArr;

@property(nonatomic, strong)UITableView *CategoryTableView;

@end

@implementation ViewController{
    NSIndexPath *selectIndex;
    BOOL isOpen;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"全部分类";
    [self.view addSubview:self.CategoryTableView];
    
}

-(NSArray *)DataArr
{
    if (_DataArr == nil) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"RecipesCatalog" ofType:@"plist"];
        _DataArr = [NSArray arrayWithContentsOfFile:plistPath];
    }
    return _DataArr;
}

-(UITableView *)CategoryTableView
{
    if (_CategoryTableView == nil) {
        _CategoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - NAVIGATIONBARHEIGHT) style:UITableViewStylePlain];
        _CategoryTableView.delegate = self;
        _CategoryTableView.dataSource = self;
        _CategoryTableView.showsHorizontalScrollIndicator = NO;
        _CategoryTableView.showsVerticalScrollIndicator = NO;
        _CategoryTableView.separatorColor = [UIColor clearColor];
        _CategoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _CategoryTableView.backgroundColor = RGBCOLOR(223, 223, 223);
    }
    return _CategoryTableView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.DataArr[0] count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isOpen && selectIndex.section == section) {
        
        return 2;
    }
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isOpen && selectIndex.section == indexPath.section && indexPath.row != 0) {
        
        return [Helper calculateRowHeight];
    }
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self gerenateTablecell:tableView indexpath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UITableViewCell *)gerenateTablecell:(UITableView *)tableview indexpath:(NSIndexPath *)indexpath
{
    if (isOpen && selectIndex.section == indexpath.section && indexpath.row != 0) {
        QJCell * cell = [[QJCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        return cell;
        
    }else{
        CategoryCell *cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (!cell) {
            cell = [[CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSArray *data = self.DataArr[0];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [cell.icon sd_setImageWithURL:data[indexpath.section][@"icon"]];
                cell.titleLabel.text = data[indexpath.section][@"name"];
                
            });
        });
        
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        /**
         *  expand cell select method
         */
        if ([indexPath isEqual:selectIndex]) {
            isOpen = NO;
            [self didSelectCellRowFirstDo:NO nextDo:NO];
            selectIndex = nil;
        }else{
            if (!selectIndex) {
                selectIndex = indexPath;
                [self setModel];
                [self didSelectCellRowFirstDo:YES nextDo:NO];
            }else{
                [self didSelectCellRowFirstDo:NO nextDo:YES];
            }
        }
        
    }else{
        /**
         *  no reaction
         */
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    isOpen = firstDoInsert;
    CategoryCell *cell = (CategoryCell *)[self.CategoryTableView cellForRowAtIndexPath:selectIndex];
    [Helper startAnimation:cell.triangle Up:firstDoInsert complete:^{
        
    }];
    
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:1 inSection:selectIndex.section];
    [rowToInsert addObject:indexPathToInsert];
    
    [self.CategoryTableView beginUpdates];
    if (firstDoInsert)
    {
        [self.CategoryTableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    else
    {
        [self.CategoryTableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    
    [self.CategoryTableView endUpdates];
    
    if (nextDoInsert) {
        isOpen = YES;
        selectIndex = [self.CategoryTableView indexPathForSelectedRow];
        [self setModel];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    
    if (isOpen){
    [self.CategoryTableView scrollToRowAtIndexPath:selectIndex atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}



- (TagModel *)setModel
{
    TagModel *model = [TagModel getInstance];
    model.TagArr = self.DataArr[0][selectIndex.section][@"tags"];
    return model;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
