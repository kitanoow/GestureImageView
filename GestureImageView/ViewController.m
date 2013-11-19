//
//  ViewController.m
//  GestureImageView
//
//  Created by kitano on 2013/11/20.
//  Copyright (c) 2013年 kitano. All rights reserved.
//

#import "ViewController.h"
#import "GestureImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    GestureImageView *imageView = [[GestureImageView alloc] initWithFrame:
                                         CGRectMake(50, 50, 100, 100)];
    
    imageView.image = [UIImage imageNamed:@"1.jpg"];
    [self.view addSubview:imageView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
