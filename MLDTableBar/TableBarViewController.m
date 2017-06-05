//
//  TableBarViewController.m
//  MLDToolsBar
//
//  Created by mac on 16/6/30.
//  Copyright © 2016年 Moliy. All rights reserved.
//

#import "TableBarViewController.h"
#import "UIColor+Hex.h"



@interface TableBarViewController ()<MLDToolsBarDelegate>
{
}

@end

@implementation TableBarViewController
#pragma mark - 生命周期
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _toolsBar = [[MLDToolsBar alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 44, [UIScreen mainScreen].bounds.size.width, 44) withToolsBarStyle:ToolsBarImageType withButtonImageArray:[self getImageArray] withButtonTitleArray:nil];
    
    
    _toolsBar.layer.borderColor = [UIColor colorWithHexString:@"#e8e8e9"].CGColor;
    _toolsBar.layer.borderWidth = .5f;
    
    _toolsBar.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
    _toolsBar.lastButton=_toolsBar.buttonArray[0];
    
    _toolsBar.delegate = self;
    
    
    /*有可能会出现懒加载
     *如果出现懒加载将下面两行代码放到ViewDidApper里面
     */
     _selectIndex = -1;
     self.selectIndex = 0;
     /*-----*/
    [self.view addSubview:_toolsBar];
}



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    

    
    
}




#pragma mark -
#pragma mark DataInit
-(NSArray *)getImageArray
{
    NSDictionary *home = @{@"normal":[UIImage imageNamed:@"tab_home_dis"],@"selected":[UIImage imageNamed:@"tab_home"]};
    
    NSDictionary *search = @{@"normal":[UIImage imageNamed:@"tab_boutique_dis"],@"selected":[UIImage imageNamed:@"tab_boutique"]};
    
    NSDictionary *buy = @{@"normal":[UIImage imageNamed:@"tab_brand_dis"],@"selected":[UIImage imageNamed:@"tab_brand"]};
    
    
    NSDictionary *cheap = @{@"normal":[UIImage imageNamed:@"tab_value_dis"],@"selected":[UIImage imageNamed:@"tab_value"]};
    
    
    
    NSDictionary *my = @{@"normal":[UIImage imageNamed:@"tab_personal_dis"],@"selected":[UIImage imageNamed:@"tab_personal"]};
    
    

    NSArray *array = @[home,search,buy,cheap,my];
    return array;
    
}













#pragma mark -
#pragma mark MLDToolsBarDelegate
-(void)toolsBarButtonClick:(UIButton *)sender;
{
    [self changeViewControllerButtonClick:sender];
}











#pragma mark -
#pragma mark ButtonClick

-(void)setSelectIndex:(NSInteger)selectIndex
{
    if (_selectIndex ==selectIndex)
    {
        return;
    }
    else
    {
        if (_selectIndex>=0)
        {
            
            
            UIViewController *oldView =[self.viewControllerArray objectAtIndex:_selectIndex];
            
            [oldView.view removeFromSuperview];
        }
        
        UIViewController *newView =[self.viewControllerArray objectAtIndex:selectIndex];
        [self.view addSubview:newView.view];
        [self.view sendSubviewToBack:newView.view];
    }
    _selectIndex =selectIndex;
}




- (void)changeViewControllerButtonClick:(UIButton *)sender
{
    self.selectIndex =sender.tag;
}



@end
