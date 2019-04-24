//
//  FMImagePicker.h
//  Client
//
//  Created by mingo on 2018/12/25.
//  Copyright © 2018年 mingo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^FMImagePickerBlock)(UIImage *image);

@interface FMImagePicker : NSObject

- (void )fm_imagePickerTitle:(NSString *)title alertStyle:(UIAlertControllerStyle)style toScale:(CGFloat)scale imagePickerBlock:(FMImagePickerBlock)imagePicker ;

@end
