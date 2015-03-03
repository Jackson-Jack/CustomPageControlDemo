//
//  CustomPageControl.m
//  Physician
//
//  Created by DQB on 14-10-23.
//  Copyright (c) 2014年 BYB. All rights reserved.
//

#import "CustomPageControl.h"
#import <QuartzCore/QuartzCore.h>

#define kIphoneVersionfloatValue    [[[UIDevice currentDevice] systemVersion] floatValue]
#define kSpacing                    10.0f;

@interface CustomPageControl()

@end

@implementation CustomPageControl
{
    UIImage *_activeImage;
    UIImage *_inactiveImage;
}

- (id)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if ([self respondsToSelector:@selector(setCurrentPageIndicatorTintColor:)] && [self respondsToSelector:@selector(setPageIndicatorTintColor:)]) {
        [self setCurrentPageIndicatorTintColor:[UIColor clearColor]];
        [self setPageIndicatorTintColor:[UIColor clearColor]];
    }
    
    [self setBackgroundColor:[UIColor clearColor]];
    _activeImage= [UIImage imageNamed:@"selectedImg.png"];
    _inactiveImage= [UIImage imageNamed:@"normalImg.png"];
    self.contentMode=UIViewContentModeRedraw;
    
    return self;
}

- (void)updateDots
{
    for (int i = 0; i< [self.subviews count]; i++) {
        UIImageView* dot =[self.subviews objectAtIndex:i];
        
        // you can set dot frame Size what you like
        dot.Frame = CGRectMake(dot.frame.origin.x, dot.frame.origin.y, _activeImage.size.width, _activeImage.size.height);
        
        if (i == self.currentPage) {
            if ([dot respondsToSelector:@selector(setImage:)]) {
                dot.image=_activeImage;
            }
            
        } else {
            if ([dot respondsToSelector:@selector(setImage:)]) {
                dot.image=_inactiveImage;
            }
        }
    }
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    if ([[[UIDevice currentDevice]systemVersion]floatValue] <=6.0) {
        [self updateDots];
    }

    [self setNeedsDisplay];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    [super setNumberOfPages:numberOfPages];
    if ([[[UIDevice currentDevice]systemVersion]floatValue] <=6.0) {
        [self updateDots];
    }

    [self setNeedsDisplay];
    
}

-(void)drawRect:(CGRect)iRect
{
    if (kIphoneVersionfloatValue >= 7.0){
        int i;
        CGRect rect;
        
        UIImage *image;
        iRect = self.bounds;
        
        if ( self.opaque ) {
            [self.backgroundColor set];
            UIRectFill( iRect );
        }
        
        if ( self.hidesForSinglePage && self.numberOfPages == 1 ) return;
        
        rect.size.height = _activeImage.size.height;
        rect.size.width = self.numberOfPages * _activeImage.size.width + ( self.numberOfPages - 1 ) * kSpacing;
        rect.origin.x = floorf( ( iRect.size.width - rect.size.width ) / 2.0 );
        rect.origin.y = floorf( ( iRect.size.height - rect.size.height ) / 2.0 );
        rect.size.width = _activeImage.size.width;
        
        for ( i = 0; i < self.numberOfPages; ++i ) {
            image = i == self.currentPage ? _activeImage : _inactiveImage;
            
            [image drawInRect: rect];
            
            rect.origin.x += _activeImage.size.width + kSpacing;
        }
    }else {
        
    }
}

@end
