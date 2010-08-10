//
//  PickerBackgroundView.m
//  Picker
//
//  Created by Steven Troughton-Smith on 25/09/2009.
//  Copyright 2009 Steven Troughton-Smith. All rights reserved.
//

#import "PickerBackgroundView.h"


@implementation PickerBackgroundView

-(BOOL)opaque
{
	return NO;
}

- (void)drawRect:(NSRect)dirtyRect {
	
	[[NSColor windowBackgroundColor] set];
	
	NSRectFill(NSMakeRect(0, 0, self.bounds.size.width, self.bounds.size.height-20));
	

	NSBezierPath *path = [[NSBezierPath alloc] init];
	
	CGFloat arrowHeight = 10;
	
	[path moveToPoint:NSMakePoint(0, self.bounds.size.height-arrowHeight)];
	[path lineToPoint:NSMakePoint(10, self.bounds.size.height-arrowHeight)];
	[path lineToPoint:NSMakePoint(20, self.bounds.size.height)];
	[path lineToPoint:NSMakePoint(30, self.bounds.size.height-arrowHeight)];
	[path lineToPoint:NSMakePoint(self.bounds.size.width, self.bounds.size.height-arrowHeight)];

	[path lineToPoint:NSMakePoint(self.bounds.size.width, self.bounds.size.height-32-arrowHeight)];
	[path lineToPoint:NSMakePoint(0, self.bounds.size.height-32-arrowHeight)];

	[[NSColor colorWithCalibratedWhite:0.946 alpha:1.000] set];

	
	NSColor *aColor = [NSColor colorWithCalibratedWhite:0.874 alpha:1.000];
	NSColor *bColor = [NSColor colorWithCalibratedWhite:0.590 alpha:1.000];
	
	NSGradient *grad = [[ NSGradient alloc] initWithColors:[NSArray arrayWithObjects:aColor, bColor, nil]];
	
	
	[grad drawInBezierPath:path angle:-90];
}

@end
