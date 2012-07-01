

extern NSTimeZone *App_defaultTimeZone;

@interface CustomTableViewCellAppDelegate : NSObject <UIApplicationDelegate> {
	
	UIWindow *window;
	UINavigationController *navigationController;
	
	NSCalendar *calendar;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

- (NSArray *)displayList;
@property (nonatomic, retain, readonly) NSCalendar *calendar;

@end
