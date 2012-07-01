

@interface RootViewController : UITableViewController {
	NSMutableArray *timeZonesArray;
	NSMutableArray *sectionsArray;
	UILocalizedIndexedCollation *collation;
}

@property (nonatomic, retain) NSMutableArray *timeZonesArray;

@end
