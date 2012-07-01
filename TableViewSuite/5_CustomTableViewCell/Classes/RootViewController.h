 

@interface RootViewController : UITableViewController {
	NSArray *displayList;
	NSCalendar *calendar;
	NSTimer *minuteTimer;
	NSTimer *regionsTimer;

}

@property (nonatomic, retain) NSArray *displayList;
@property (nonatomic, retain) NSCalendar *calendar;

@property (nonatomic, assign) NSTimer *minuteTimer;
@property (nonatomic, assign) NSTimer *regionsTimer;

- (void)updateTime:(NSTimer *)timer;
- (void)updateRegions:(id)sender;

@end
