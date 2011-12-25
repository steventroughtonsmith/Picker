//
//  NSWindow+NSWindow_AlwaysKey.m
//  Picker
//
//  Created by Alex Zielenski on 12/25/11.
//  Copyright (c) 2011 Alex Zielenski. All rights reserved.
//

#import "NSWindow+AlwaysKey.h"

@implementation NSWindow (AlwaysKey)
- (BOOL)canBecomeMainWindow {
	return NO;
}
- (BOOL)canBecomeKeyWindow {
	return YES;
}
- (BOOL)isKeyWindow {
	return self.isVisible;
}
@end
