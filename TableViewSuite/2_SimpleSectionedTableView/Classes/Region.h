

@interface Region : NSObject {
	NSString *name;
	NSMutableArray *timeZoneWrappers;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSMutableArray *timeZoneWrappers;

+ (NSArray *)knownRegions;

@end
