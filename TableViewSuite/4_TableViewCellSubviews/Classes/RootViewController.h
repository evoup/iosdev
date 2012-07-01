

@interface RootViewController : UITableViewController {
	NSArray *displayList;
	NSCalendar *calendar;
	NSTimer *minuteTimer;
}

@property (nonatomic, retain) NSArray *displayList;
@property (nonatomic, retain) NSCalendar *calendar;
@property (nonatomic, assign) NSTimer *minuteTimer;

- (UITableViewCell *)tableViewCellWithReuseIdentifier:(NSString *)identifier;
- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;

- (void)update:sender;

@end
