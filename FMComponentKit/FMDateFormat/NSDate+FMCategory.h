
#import <Foundation/Foundation.h>

@interface NSDate (FMCategory)

@property(nonatomic,assign,readonly)NSInteger year;
@property(nonatomic,assign,readonly)NSInteger month;
@property(nonatomic,assign,readonly)NSInteger day;
@property(nonatomic,assign,readonly)NSInteger hour;
@property(nonatomic,assign,readonly)NSInteger minute;
@property(nonatomic,assign,readonly)NSInteger seconds;
@property (nonatomic,assign,readonly)NSInteger weekday;

+(NSDate *)fm_dateWithDateString:(NSString *)dateString;

+(NSDate *)fm_dateWithFormat_yyyy_MM_dd_HH_mm_ss_string:(NSString *)string;
+(NSDate *)fm_dateWithFormat_yyyy_MM_dd_HH_mm_string:(NSString *)string;
+(NSDate *)fm_dateWithFormat_yyyy_MM_dd_HH_string:(NSString *)string;
+(NSDate *)fm_dateWithFormat_yyyy_MM_dd_string:(NSString *)string;
+(NSDate *)fm_dateWithFormat_yyyy_MM_string:(NSString *)string;

@end
