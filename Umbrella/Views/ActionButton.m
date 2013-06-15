//
//  OrderButton.m
//  Elong_Shake
//
//  Created by Wang Shuguang on 13-1-30.
//  Copyright (c) 2013年 elong. All rights reserved.
//

#import "ActionButton.h"
#define BGCOLOR                  UMB_PINK
#define DEEPBGCOLOR              UMB_MARKPINK
#define BORDERCOLOR              [UIColor clearColor]
#define DEEPBORDERCOLOR          [UIColor clearColor]

@implementation ActionButton
@synthesize btnBgColor = _btnBgColor;
@synthesize btnHBgColor = _btnHBgColor;
@synthesize btnBorderColor = _btnBorderColor;
@synthesize btnHBorderColor = _btnHBorderColor;
@synthesize radius = _radius;

- (void) dealloc{
    self.btnBgColor = nil;
    self.btnHBgColor = nil;
    self.btnBorderColor = nil;
    self.btnHBorderColor = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setHighlighted:(BOOL)highlighted{
    
    [super setHighlighted:highlighted];
    
    [self setNeedsDisplay];
}

- (void) setBtnBgColor:(UIColor *)btnBgColor{
    [_btnBgColor release];
    _btnBgColor = btnBgColor;
    [_btnBgColor retain];
    [self setNeedsDisplay];
}

- (void) setBtnHBgColor:(UIColor *)btnHBgColor{
    [_btnHBgColor release];
    _btnHBgColor = btnHBgColor;
    [_btnHBgColor retain];

    [self setNeedsDisplay];
}

- (void) setBtnBorderColor:(UIColor *)btnBorderColor{
    [_btnBorderColor release];
    _btnBorderColor = btnBorderColor;
    [_btnBorderColor retain];
    
    [self setNeedsDisplay];
}

- (void) setBtnHBorderColor:(UIColor *)btnHBorderColor{
    [_btnHBorderColor release];
    _btnHBorderColor = btnHBorderColor;
    [_btnHBorderColor retain];
    
    [self setNeedsDisplay];
}

- (void) setRadius:(float)radius{
    _radius = radius;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect{ 
    // Drawing code
    
   
    
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    // draw background
	CGFloat height = self.bounds.size.height;
	CGContextTranslateCTM(context, 0.0, height);
	CGContextScaleCTM(context, 1.0, -1.0);
	CGContextSetLineWidth(context, 1.0);
	CGContextSaveGState(context);
	
    if (self.highlighted) {
        UIColor *pathColor = DEEPBGCOLOR;
        if (self.btnHBgColor) {
            pathColor = self.btnHBgColor;
        }
        [pathColor setFill];
        
        UIColor *strokeColor = DEEPBORDERCOLOR;
        if (self.btnHBorderColor) {
            strokeColor = self.btnHBorderColor;
        }
        [strokeColor setStroke];
    }else{
        UIColor *pathColor = BGCOLOR;
        if (self.btnBgColor) {
            pathColor = self.btnBgColor;
        }
        [pathColor setFill];
        
        UIColor *strokeColor = BORDERCOLOR;
        if (self.btnBorderColor) {
            strokeColor = self.btnBorderColor;
        }
        [strokeColor setStroke];
    }
	
	
	CGRect rrect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
	CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
	
	// Start at 1
	CGContextMoveToPoint(context, minx, midy);
	// Add an arc through 2 to 3
	CGContextAddArcToPoint(context, minx, miny, midx, miny, self.radius);
	// Add an arc through 4 to 5
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, self.radius);
	// Add an arc through 6 to 7
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, self.radius);
	// Add an arc through 8 to 9
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, self.radius);
	// Close the path
	CGContextClosePath(context);
	CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextDrawPath(context, kCGPathStroke);
}




@end
