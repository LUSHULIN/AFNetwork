//
//  ViewController.h
//  DownLoadImage
//
//  Created by Jason on 17/11/30.
//  Copyright © 2017年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)downAction:(UIButton *)sender;
- (IBAction)clearAction:(id)sender;

@end

