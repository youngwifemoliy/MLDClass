//
//  TableBarViewController.h
//  MLDToolsBar
//
//  Created by mac on 16/6/30.
//  Copyright © 2016年 Moliy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLDToolsBar.h"

@interface TableBarViewController : UIViewController
@property (nonatomic,unsafe_unretained)NSInteger selectIndex;
@property (nonatomic,strong) NSArray *viewControllerArray;
@property (nonatomic,strong) MLDToolsBar *toolsBar;

@end
