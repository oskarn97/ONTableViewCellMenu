//
//  ONTableViewMenuCell.h
//  UITableViewCellMenu
//
//  Created by Oskar Neumann on 31.12.13.
//  Copyright (c) 2013 Oskar Neumann. All rights reserved.
//

#import <UIKit/UIKit.h>

//define the height of the menu here (recommended: 40)
#define ONTableViewMenuCell_Menu_Height 40

//define the size of the buttonimage here (recommended: 0.6, max: 1.0)
#define ONTableViewMenuCell_Button_Frame_Factor 0.6

@class ONTableViewMenuCell;

@protocol ONTableViewMenuCellDelegate <NSObject>
- (void)ONTableViewMenuCell:(ONTableViewMenuCell *)cell didClickOnButtonAtIndex:(NSInteger)buttonIndex;
@end

@interface ONTableViewMenuCell : UITableViewCell{
    BOOL invertedColors;
    UIColor *oldBgColor;
}
- (void)showMenu;
- (void)hideMenu;
- (void)setButtonsWithImages:(NSArray *)buttonImages;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic) BOOL isMenuVisible;
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic) BOOL invertColorsOnSelect;
#if !__has_feature(objc_arc)
@property(assign) id<ONTableViewMenuCellDelegate> delegate;
#else
@property(weak) id<ONTableViewMenuCellDelegate> delegate;
#endif
@end
