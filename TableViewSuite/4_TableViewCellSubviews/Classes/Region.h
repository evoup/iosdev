
@interface Region : NSObject {
	NSString *name;
	NSMutableArray *timeZoneWrappers;
	NSCalendar *calendar;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableArray *timeZoneWrappers;
@property (nonatomic, retain) NSCalendar *calendar;

+ (Region *)regionNamed:(NSString *)name;
+ (Region *)newRegionWithName:(NSString *)regionName;
- (void)addTimeZone:(NSTimeZone *)timeZone nameComponents:(NSArray *)nameComponents;
- (void)sortZones;
- (void)setDate:(NSDate *)date;

@end
