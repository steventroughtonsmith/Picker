//
//  PickerAppDelegate.m
//  Picker
//
//  Created by Steven Troughton-Smith on 25/09/2009.
//  Copyright 2009 Steven Troughton-Smith. All rights reserved.
//

#import "PickerAppDelegate.h"
#import "PickerBackgroundView.h"

/* A few private APIs we need */

@interface NSColorPanel (_STS_PickerExtras)

-(NSView *)_toolbarView;

@end

@interface NSStatusItem (_STS_PickerExtras)

-(NSWindow *)_window;

@end

@implementation PickerAppDelegate

@synthesize mainView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

	popupWindow = [self createWindow];
	
	_statusItem = [[[NSStatusBar systemStatusBar]
					statusItemWithLength:NSSquareStatusItemLength] retain];

	[_statusItem setImage:[NSImage imageNamed:@"wheel"]];
	
	[_statusItem setTarget:self];
	[_statusItem setAction:@selector(menuWillOpen:)];
}

-(NSWindow *)createWindow
{
	PickerBackgroundView *v = [[PickerBackgroundView alloc] initWithFrame:NSMakeRect(0, 0, 320, 410)];
	
	NSRect vFrame = v.bounds;
	vFrame.size.height-=10;

	NSWindow *win = [[NSWindow alloc] initWithContentRect:v.frame styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
	[win setHasShadow:YES];
	[win setLevel:NSStatusWindowLevel];
	[win setOpaque:NO];
	[win setBackgroundColor:[NSColor clearColor]];
	[win setCollectionBehavior:NSWindowCollectionBehaviorStationary];

	[win setContentView:v];
	[v release];
	
	return win;
}

-(void)populate
{
	NSView *v = [popupWindow contentView];
	
	NSRect vFrame = [v frame];
	vFrame.size.height-=10;

	NSColorPanel *picker = [NSColorPanel sharedColorPanel];
	[[picker valueForKey:@"_colorSwatch"] performSelector:@selector(readColors)]; // Private API
	[picker setFrame:vFrame display:YES];

	NSView *toolbar = [picker _toolbarView];  // Private API
	NSView *content = [picker contentView];
	
	[toolbar setFrame:NSMakeRect(0, vFrame.size.height- toolbar.frame.size.height, vFrame.size.width, toolbar.frame.size.height)];
	[content setFrame:NSMakeRect(0, 0, vFrame.size.width, vFrame.size.height-toolbar.frame.size.height)];
	
	[v addSubview:toolbar];
	[v addSubview:content];	
}

-(void)menuWillOpen:(NSMenu *)s
{
	if ([popupWindow isVisible])
	{		
		[[NSAnimationContext currentContext] setDuration:0.15];
		[[popupWindow animator] setAlphaValue:0.0];
		
		[popupWindow performSelector:@selector(orderOut:) withObject:self afterDelay:0.3];
	}
	else
	{
		[self populate];

		NSRect frame = popupWindow.frame;
		
		frame.origin.x = [[_statusItem _window] frame].origin.x-5;
		frame.origin.y = [[_statusItem _window] frame].origin.y - [popupWindow frame].size.height;

		[popupWindow setFrame:frame display:NO];
	
		
		[popupWindow setAlphaValue:0.0];
		[popupWindow makeKeyAndOrderFront:self];
		
		[[NSAnimationContext currentContext] setDuration:0.15];
		[[popupWindow animator] setAlphaValue:1.0];	
	}
}

- (NSMenu *) createMenu {
	NSZone *menuZone = [NSMenu menuZone];
	NSMenu *menu = [[NSMenu allocWithZone:menuZone] init];
	NSMenuItem *menuItem;
	
	menuItem = [menu addItemWithTitle:@"Picker"
							   action:nil
						keyEquivalent:@""];
	[menuItem setTarget:self];
	

	return [menu autorelease];
}

@end
