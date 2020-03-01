
#import "NSString+FMDateFormat.h"
#import "NSDate+FMCategory.h"

@implementation NSString (FMDateFormat)

-(NSString *)fm_formatNianYueRi
{
    NSDate *date = [NSDate fm_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld年%02ld月%02ld日",date.year,date.month,date.day];
}
-(NSString *)fm_formatNianYue
{
    NSDate *date = [NSDate fm_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld年%02ld月",date.year,date.month];
}
-(NSString *)fm_formatYueRi
{
    NSDate *date = [NSDate fm_dateWithDateString:self];
    return [NSString stringWithFormat:@"%02ld月%02ld日",date.month,date.day];
}
-(NSString *)fm_formatNian
{
    NSDate *date = [NSDate fm_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld年",date.year];
}
-(NSString *)fm_formatShiFenMiao
{
    NSDate *date = [NSDate fm_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld时%02ld分%02ld秒",date.hour,date.minute,date.seconds];
}
-(NSString *)fm_formatShiFen
{
    NSDate *date = [NSDate fm_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld时%02ld分",date.hour,date.minute];
}
-(NSString *)fm_formatFenMiao
{
    NSDate *date = [NSDate fm_dateWithDateString:self];
    return [NSString stringWithFormat:@"%02ld分%02ld秒",date.minute,date.seconds];
}
-(NSString *)fm_format_yyyy_MM_dd
{
   NSDate *date = [NSDate fm_dateWithDateString:self];
   return [NSString stringWithFormat:@"%ld-%02ld-%02ld",date.year,date.month,date.day];
}
-(NSString *)fm_format_yyyy_MM
{
    NSDate *date = [NSDate fm_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld-%02ld",date.year,date.month];
}
-(NSString *)fm_format_MM_dd
{
    NSDate *date = [NSDate fm_dateWithDateString:self];
    return [NSString stringWithFormat:@"%02ld-%02ld",date.month,date.day];
}
-(NSString *)fm_format_yyyy
{
    NSDate *date = [NSDate fm_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld",date.year];
}
-(NSString *)fm_format_HH_mm_ss
{
    NSDate *date = [NSDate fm_dateWithDateString:self];
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",date.hour,date.minute,date.seconds];
}
-(NSString *)fm_format_yyyy_MM_dd_HH_mm_ss
{
    NSDate *date = [NSDate fm_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld:%02ld",date.year,date.month,date.day,date.hour,date.minute,date.seconds];
}
-(NSString *)fm_format_HH_mm
{
    NSDate *date = [NSDate fm_dateWithDateString:self];
    return [NSString stringWithFormat:@"%02ld:%02ld",date.hour,date.minute];
}
-(NSString *)fm_format_mm_ss
{
    NSDate *date = [NSDate fm_dateWithDateString:self];
    return [NSString stringWithFormat:@"%02ld:%02ld",date.minute,date.seconds];
}

-(NSString *)fm_formatWeekDay
{
    NSString *weekStr=nil;
    NSDate *date = [NSDate fm_dateWithDateString:self];
    switch (date.weekday) {
        case 2:
            weekStr = @"星期一";
            break;
        case 3:
            weekStr = @"星期二";
            break;
        case 4:
            weekStr = @"星期三";
            break;
        case 5:
            weekStr = @"星期四";
            break;
        case 6:
            weekStr = @"星期五";
            break;
        case 7:
            weekStr = @"星期六";
            break;
        case 1:
            weekStr = @"星期天";
            break;
        default:
            break;
    }
    return weekStr;
}
@end
