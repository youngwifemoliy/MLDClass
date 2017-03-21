//
//  ViewController.m
//  Photo
//
//  Created by Moliy on 2017/3/21.
//  Copyright © 2017年 Moliy. All rights reserved.
//

#import "ViewController.h"
#import "LGPhoto.h"
#import "ImageCompress.h"

@interface ViewController ()<LGPhotoPickerViewControllerDelegate,LGPhotoPickerBrowserViewControllerDataSource,LGPhotoPickerBrowserViewControllerDelegate>

@property (nonatomic, assign) LGShowImageType showType;
@property (nonatomic, strong)NSMutableArray *LGPhotoPickerBrowserPhotoArray;
@property (nonatomic, strong)NSMutableArray *LGPhotoPickerBrowserURLArray;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *topImageView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSMutableArray *)LGPhotoPickerBrowserPhotoArray
{
    if (!_LGPhotoPickerBrowserPhotoArray)
    {
        _LGPhotoPickerBrowserPhotoArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _LGPhotoPickerBrowserPhotoArray;
}

- (NSMutableArray *)LGPhotoPickerBrowserURLArray
{
    if (!_LGPhotoPickerBrowserURLArray)
    {
        _LGPhotoPickerBrowserURLArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _LGPhotoPickerBrowserURLArray;
}

- (IBAction)buttonClick:(UIButton *)sender
{
    [self showAlert:sender];
}

/**
 *  初始化自定义相机（单拍）
 */
- (void)presentCameraSingle
{
    ZLCameraViewController *cameraVC = [[ZLCameraViewController alloc] init];
    // 拍照最多个数
    cameraVC.maxCount = 1;
    // 单拍
    cameraVC.cameraType = ZLCameraSingle;
    cameraVC.callback = ^(NSArray *cameras)
    {
        //在这里得到拍照结果
        //数组元素是ZLCamera对象
        /*
         @exemple
         ZLCamera *canamerPhoto = cameras[0];
         UIImage *image = canamerPhoto.photoImage;
         */
        ZLCamera *canamerPhoto = cameras[0];
        UIImage *image = canamerPhoto.photoImage;
        NSLog(@"相机的照片:%@",image);
    };
    [cameraVC showPickerVc:self];
}

/**
 *  初始化相册选择器
 */
- (void)presentPhotoPickerViewControllerWithStyle:(LGShowImageType)style
{
    LGPhotoPickerViewController *pickerVc = [[LGPhotoPickerViewController alloc] initWithShowType:style];
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.maxCount = 9;   // 最多能选9张图片
    pickerVc.delegate = self;
    self.showType = style;
    [pickerVc showPickerVc:self];
}

- (void)showAlert:(UIView *)view
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"现在拍摄"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action)
                                {
                                    [self presentCameraSingle];
                                }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"相机胶卷"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action)
                                {
                                    [self presentPhotoPickerViewControllerWithStyle:LGShowImageTypeImagePicker];
                                }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleDestructive
                                                      handler:^(UIAlertAction * _Nonnull action)
                                {
                                }]];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        if (popover)
        {
            popover.sourceView = view;
            popover.sourceRect = view.bounds;
            popover.permittedArrowDirections=UIPopoverArrowDirectionAny;
        }
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    }
    else
    {
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    }
}

#pragma mark - LGPhotoPickerViewControllerDelegate

- (void)pickerViewControllerDoneAsstes:(NSArray *)assets
                            isOriginal:(BOOL)original
{
    //assets的元素是LGPhotoAssets对象，获取image方法如下:
    NSMutableArray *thumbImageArray = [NSMutableArray array];
    NSMutableArray *originImage = [NSMutableArray array];
    NSMutableArray *fullResolutionImage = [NSMutableArray array];
    
    for (LGPhotoAssets *photo in assets)
    {
        //缩略图
        [thumbImageArray addObject:photo.thumbImage];
        //原图
        [originImage addObject:photo.compressionImage];
        NSData * imageData1 = UIImageJPEGRepresentation(photo.compressionImage,1);
        NSInteger length1 = [imageData1 length]/1024;
        
        NSData * imageData2 = UIImageJPEGRepresentation(photo.originImage,1);
        NSInteger length2 = [imageData2 length]/1024;
        
        
        NSLog(@"缩略图:%ld  \n原图:%ld",(long)length1,(long)length2);

        self.topImageView.image = photo.originImage;
        self.imageView.image = photo.compressionImage;

        //全屏图
        [fullResolutionImage addObject:photo.fullResolutionImage];
    }
    NSLog(@"缩略图:%@  \n原图:%@  \n全屏图:%@",thumbImageArray,originImage,fullResolutionImage);
    
    NSInteger num = (long)assets.count;
    NSString *isOriginal = original ? @"YES" : @"NO";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发送图片"
                                                                   message:[NSString stringWithFormat:@"您选择了%ld张图片\n是否原图：%@",(long)num,isOriginal]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                              style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * _Nonnull action)
    {
    }]];
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}

#pragma mark - LGPhotoPickerBrowserViewControllerDataSource

- (NSInteger)photoBrowser:(LGPhotoPickerBrowserViewController *)photoBrowser
   numberOfItemsInSection:(NSUInteger)section
{
    if (self.showType == LGShowImageTypeImageBroswer)
    {
        return self.LGPhotoPickerBrowserPhotoArray.count;
    }
    else if (self.showType == LGShowImageTypeImageURL)
    {
        return self.LGPhotoPickerBrowserURLArray.count;
    }
    else
    {
        NSLog(@"非法数据源");
        return 0;
    }
}

- (id<LGPhotoPickerBrowserPhoto>)photoBrowser:(LGPhotoPickerBrowserViewController *)pickerBrowser
                             photoAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.showType == LGShowImageTypeImageBroswer)
    {
        return [self.LGPhotoPickerBrowserPhotoArray objectAtIndex:indexPath.item];
    }
    else if (self.showType == LGShowImageTypeImageURL)
    {
        return [self.LGPhotoPickerBrowserURLArray objectAtIndex:indexPath.item];
    }
    else
    {
        NSLog(@"非法数据源");
        return nil;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
