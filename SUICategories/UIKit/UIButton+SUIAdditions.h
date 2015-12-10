//
//  UIButton+SUIAdditions.h
//  SUIToolKitDemo
//
//  Created by zzZ on 15/12/1.
//  Copyright © 2015年 SUIO~. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (SUIAdditions)


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Normal
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Normal

@property (nullable,nonatomic,copy) NSString *sui_normalTitle;
@property (nullable,nonatomic,copy) UIColor *sui_normalTitleColo;
@property (nullable,nonatomic,copy) UIImage *sui_normalImage;
@property (nullable,nonatomic,copy) UIImage *sui_normalBackgroundImage;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Highlighted
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Highlighted

@property (nullable,nonatomic,copy) NSString *sui_highlightedTitle;
@property (nullable,nonatomic,copy) UIColor *sui_highlightedTitleColo;
@property (nullable,nonatomic,copy) UIImage *sui_highlightedImage;
@property (nullable,nonatomic,copy) UIImage *sui_highlightedBackgroundImage;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Selected
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Selected

@property (nullable,nonatomic,copy) NSString *sui_selectedTitle;
@property (nullable,nonatomic,copy) UIColor *sui_selectedTitleColo;
@property (nullable,nonatomic,copy) UIImage *sui_selectedImage;
@property (nullable,nonatomic,copy) UIImage *sui_selectedBackgroundImage;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Disabled
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Disabled

@property (nullable,nonatomic,copy) NSString *sui_disabledTitle;
@property (nullable,nonatomic,copy) UIColor *sui_disabledTitleColo;
@property (nullable,nonatomic,copy) UIImage *sui_disabledImage;
@property (nullable,nonatomic,copy) UIImage *sui_disabledBackgroundImage;


/*o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o*
 *  Padding & Insets
 *o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~o~*/

#pragma mark - Padding & Insets

@property (nonatomic) CGFloat sui_padding; // left & right
@property (nonatomic) UIEdgeInsets sui_insets;


@end

NS_ASSUME_NONNULL_END
