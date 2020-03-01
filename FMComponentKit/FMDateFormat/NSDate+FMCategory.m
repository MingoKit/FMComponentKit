
#import "NSDate+FMCategory.h"
#import "NSDateComponents+FMCategory.h"

@implementation NSDate (FMCategory)

-(NSInteger)year
{
    NSDateComponents *components = [NSDateComponents fm_dateComponentsFromDate:self];
    return components.year;
}
- (NSInteger) month
{
    NSDateComponents *components =  [NSDateComponents fm_dateComponentsFromDate:self];
    return components.month;
}

- (NSInteger) day
{
    NSDateComponents *components =  [NSDateComponents fm_dateComponentsFromDate:self];
    return components.day;
}

- (NSInteger) hour
{
    NSDateComponents *components =  [NSDateComponents fm_dateComponentsFromDate:self];
    return components.hour;
}

- (NSInteger) minute
{
    NSDateComponents *components = [NSDateComponents fm_dateComponentsFromDate:self];
    return components.minute;
}

- (NSInteger) seconds
{
    NSDateComponents *components =  [NSDateComponents fm_dateComponentsFromDate:self];
    return components.second;
}

- (NSInteger) weekday
{
    NSDateComponents *components =  [NSDateComponents fm_dateComponentsFromDate:self];
    return components.weekday;
}

+(NSDate *)fm_dateWithDateString:(NSString *)dateString
{
    NSString *datestr = dateString;
    NSDate *date = nil;
    
    if ([datestr containsString:@"T"] && [datestr containsString:@".000+0000"]) {
        NSString *strt = [datestr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        strt = [strt stringByReplacingOccurrencesOfString:@".000+0000" withString:@""];
        datestr = strt;
    }
    
    date = [self fm_dateWithFormat_yyyy_MM_dd_HH_mm_ss_string:datestr];
    if(date) return date;
    date = [self fm_dateWithFormat_yyyy_MM_dd_HH_mm_string:datestr];
    if(date) return date;
    date = [self fm_dateWithFormat_yyyy_MM_dd_HH_string:datestr];
    if(date) return date;
    date = [self fm_dateWithFormat_yyyy_MM_dd_string:datestr];
    if(date) return date;
    date = [self fm_dateWithFormat_yyyy_MM_string:datestr];
    
    if ([self fm_validateAllNumber:datestr]) {
        NSTimeInterval interval = 0;
        interval = dateString.doubleValue; // iOS 生成的时间戳是10位
                                           // java服务器返回的13位时间戳
        if (dateString.length == 13) {
            interval = [dateString doubleValue] / 1000.0;
        }
        date = [NSDate dateWithTimeIntervalSince1970:interval];
    }
    
    if(date) return date;
    return nil;
}

/** 判断一个字符串是纯数字 */
+ (BOOL)fm_validateAllNumber:(NSString *)objstr {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < objstr.length) {
        NSString * string = [objstr substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

- (void)fm_aa:(NSString *)dateString {
        // selfString 是服务器返回的13位时间戳
        //    NSString *selfString  = @"1495453213000";
    
  
    
   
  
}


+(NSDate *)fm_dateWithFormat_yyyy_MM_dd_HH_mm_ss_string:(NSString *)string
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date =[dateFormat dateFromString:string];
    return date;
}

+(NSDate *)fm_dateWithFormat_yyyy_MM_dd_HH_mm_string:(NSString *)string
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date =[dateFormat dateFromString:string];
    return date;
}

+(NSDate *)fm_dateWithFormat_yyyy_MM_dd_HH_string:(NSString *)string
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH"];
    NSDate *date =[dateFormat dateFromString:string];
    return date;
}

+(NSDate *)fm_dateWithFormat_yyyy_MM_dd_string:(NSString *)string
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date =[dateFormat dateFromString:string];
    return date;
}

+(NSDate *)fm_dateWithFormat_yyyy_MM_string:(NSString *)string
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM"];
    NSDate *date =[dateFormat dateFromString:string];
    return date;
}
@end
