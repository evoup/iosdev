

@interface SimpleSectionedTableViewAppDelegate : NSObject <UIApplicationDelegate> {
	
	UIWindow *window;
	UINavigationController *navigationController;
	
	NSArray *list;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

@property (nonatomic, copy) NSArray *list;

@end
