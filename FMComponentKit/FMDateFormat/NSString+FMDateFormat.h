
#import <Foundation/Foundation.h>

@interface NSString (FMDateFormat)

//时间字符串2020-02-18 16:58:36 ->转换

#pragma mark -年月日

/**
 *  x年x月x日
 */
@property(nonatomic,copy,readonly)NSString *fm_formatNianYueRi;

/**
 *  x年x月
 */
@property(nonatomic,copy,readonly)NSString *fm_formatNianYue;

/**
 *  x月x日
 */
@property(nonatomic,copy,readonly)NSString *fm_formatYueRi;

/**
 *  x年
 */
@property(nonatomic,copy,readonly)NSString *fm_formatNian;

/**
 *  x时x分x秒
 */
@property(nonatomic,copy,readonly)NSString *fm_formatShiFenMiao;

/**
 *  x时x分
 */
@property(nonatomic,copy,readonly)NSString *fm_formatShiFen;

/**
 *  x分x秒
 */
@property(nonatomic,copy,readonly)NSString *fm_formatFenMiao;

/**
 *  yyyy-MM-dd
 */
@property(nonatomic,copy,readonly)NSString *fm_format_yyyy_MM_dd;

/**
 *  yyyy-MM
 */
@property(nonatomic,copy,readonly)NSString *fm_format_yyyy_MM;

/**
 *  MM-dd
 */
@property(nonatomic,copy,readonly)NSString *fm_format_MM_dd;

/**
 *  yyyy
 */
@property(nonatomic,copy,readonly)NSString *fm_format_yyyy;

/**
 *  HH:mm:ss
 */
@property(nonatomic,copy,readonly)NSString *fm_format_HH_mm_ss;

/**
 *  yyyy-MM HH:mm:ss
 */
@property(nonatomic,copy,readonly)NSString *fm_format_yyyy_MM_dd_HH_mm_ss;

/**
 *  HH:mm
 */
@property(nonatomic,copy,readonly)NSString *fm_format_HH_mm;

/**
 *  mm:ss
 */
@property(nonatomic,copy,readonly)NSString *fm_format_mm_ss;

#pragma mark - 转换为星期几
@property(nonatomic,copy,readonly)NSString *fm_formatWeekDay;

@end
