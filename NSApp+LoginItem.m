#import "NSApp+LoginItem.h"


@implementation NSApplication (LoginItem)

-(void)addToStartup
{
    NSString* appPath = [[NSBundle mainBundle] bundlePath];
    
    LSSharedFileListRef theLoginItemsRefs = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    
    // We call LSSharedFileListInsertItemURL to insert the item at the bottom of Login Items list.
    CFURLRef url = (CFURLRef)[NSURL fileURLWithPath:appPath];
    LSSharedFileListItemRef item = LSSharedFileListInsertItemURL(theLoginItemsRefs, kLSSharedFileListItemLast, NULL, NULL, url, NULL, NULL);
    if (item)
        CFRelease(item);
    CFRelease(theLoginItemsRefs); 
}
-(void)removeFromStartup
{
    CFURLRef url = (CFURLRef)[NSURL fileURLWithPath: [[NSBundle mainBundle] bundlePath]];
	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
	UInt32 seedValue;
	NSArray  *loginItemsArray = (NSArray *)LSSharedFileListCopySnapshot(loginItems, &seedValue);
	for (id item in loginItemsArray)
	{		
		LSSharedFileListItemRef itemRef = (LSSharedFileListItemRef)item;
		if (LSSharedFileListItemResolve(itemRef, 0, (CFURLRef*) &url, NULL) == noErr)
		{
			if ([[(NSURL *)url path] hasPrefix:[[NSBundle mainBundle] bundlePath]]) {
				LSSharedFileListItemRemove(loginItems, itemRef);
				break;
			}
		}
	}
	[loginItemsArray release];
	CFRelease(loginItems);
}
- (BOOL)isInStartup
{
	BOOL is_enable = NO;
	CFURLRef url = (CFURLRef)[NSURL fileURLWithPath: [[NSBundle mainBundle] bundlePath]];
	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    
	UInt32 seedValue;
	NSArray  *loginItemsArray = (NSArray *)LSSharedFileListCopySnapshot(loginItems, &seedValue);
	for (id item in loginItemsArray)
	{		
		LSSharedFileListItemRef itemRef = (LSSharedFileListItemRef)item;
		if (LSSharedFileListItemResolve(itemRef, 0, (CFURLRef*) &url, NULL) == noErr)
		{
			if ([[(NSURL *)url path] hasPrefix:[[NSBundle mainBundle] bundlePath]]) {
				is_enable = YES;
				break;
			}
		}
	}
	[loginItemsArray release];
	CFRelease(loginItems);
    
	return is_enable;
}



@end
