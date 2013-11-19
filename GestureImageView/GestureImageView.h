//
//  GestureImageView.h
//  GestureImageView
//
//  Created by kitano on 2013/11/20.
//  Copyright (c) 2013年 kitano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GestureImageView : UIImageView
<UIGestureRecognizerDelegate>

@property (nonatomic,assign) BOOL isReset;
@end
