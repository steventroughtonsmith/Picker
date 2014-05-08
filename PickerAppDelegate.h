//
//  PickerAppDelegate.h
//  Picker
//
//  Created by Steven Troughton-Smith on 25/09/2009.
//  Copyright 2009 Steven Troughton-Smith. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PickerAppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate> {
    NSView *mainView;
	IBOutlet NSTextField *deviceLabel;
	IBOutlet NSTextField *summaryLabel;
	IBOutlet NSView *deviceGraphic;

	NSWindow *popupWindow;
@private
	NSStatusItem *_statusItem;
    NSMenuItem *loginMenuItem;
}

- (NSMenu *) createMenu;
-(NSWindow *)createWindow;

@property (assign) IBOutlet  NSView *mainView;

@end
