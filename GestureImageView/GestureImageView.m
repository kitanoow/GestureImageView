//
//  GestureImageView.m
//  GestureImageView
//
//  Created by kitano on 2013/11/20.
//  Copyright (c) 2013年 kitano. All rights reserved.
//

#import "GestureImageView.h"

@implementation GestureImageView
{
    float _scale;
    float _rotation;
    BOOL _isChange;
    CGAffineTransform _defaultTransform;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUp];
    }
    return self;
}

-(void)setUp
{
    self.userInteractionEnabled = YES;
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(doAnimation:)];
    rotation.delegate = self;
    [self addGestureRecognizer:rotation];
    UIPinchGestureRecognizer *pinch =
    [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(doAnimation:)];
    pinch.delegate = self;
    [self addGestureRecognizer:pinch];
    _isChange = false;
    _scale = 1.0f;
    _rotation = 0.0f;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doPanAciton:)];
    [self addGestureRecognizer:pan];
}

- (void)doPanAciton:(UIPanGestureRecognizer *)sender {
	
    CGPoint translation = [sender translationInView:[self superview]];
    
    CGPoint movedPoint = CGPointMake(self.center.x + translation.x,
                                     self.center.y + translation.y);
    self.center = movedPoint;
    [sender setTranslation:CGPointZero inView:self];
}

- (void)doAnimation:(UIGestureRecognizer*)sender {
    if (!_isChange && sender.state == UIGestureRecognizerStateBegan) {
        _isChange = true;
        _defaultTransform = self.transform;
    }
    else if (_isChange && sender.state == UIGestureRecognizerStateEnded) {
        [self reset];
        return;
    }
    if( sender.state == UIGestureRecognizerStateEnded ) {
        return;
    }
    
    if([sender isKindOfClass:[UIRotationGestureRecognizer class]]) {
        _rotation = ((UIRotationGestureRecognizer*)sender).rotation;
    } else {
        _scale    = ((UIPinchGestureRecognizer*)sender).scale;
    }
    CGAffineTransform transform = CGAffineTransformConcat(
                                                          CGAffineTransformConcat(
                                                                                  _defaultTransform,
                                                                                  CGAffineTransformMakeRotation(_rotation)
                                                                                  ),
                                                          CGAffineTransformMakeScale(_scale, _scale)
                                                          );
    self.transform = transform;
}

-(void)resetAnimation
{
    if(_isReset == true) {
        [UIView animateWithDuration:0.2 animations:^(){
            self.transform = _defaultTransform;
        }];
    }
}

-(void)reset {
    _isChange = false;
    _scale = 1.0f;
    _rotation = 0.0f;
    [NSTimer scheduledTimerWithTimeInterval:0.1f
                                     target:self
                                   selector:@selector(resetAnimation)
                                   userInfo:nil
                                    repeats:NO];
    
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


@end
