//
//  ONTableViewMenuCell.m
//  UITableViewCellMenu
//
//  Created by Oskar Neumann on 31.12.13.
//  Copyright (c) 2013 Oskar Neumann. All rights reserved.
//

#import "ONTableViewMenuCell.h"

@implementation ONTableViewMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //setup the menu view
        _menuView = [[UIView alloc] init];
        _menuView.backgroundColor = [UIColor colorWithRed:92.0f/255.f green:92.0f/255.f blue:92.0f/255.f alpha:1.0f];
        [_menuView setHidden:TRUE];
        [self.contentView addSubview:_menuView];
        
        //setup the label
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        _label.numberOfLines = 0;
        _label.lineBreakMode = UILineBreakModeWordWrap;
        _label.font = [UIFont fontWithName:@"Helvetica" size:15];
        [self.contentView addSubview:_label];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    if((_invertColorsOnSelect && !invertedColors && _isMenuVisible) || (_invertColorsOnSelect && invertedColors &&!_isMenuVisible)){
        [self invertColors];
    }
    
    CGSize size = [_label.text sizeWithFont:_label.font constrainedToSize:CGSizeMake(self.frame.size.width-30, 99999) lineBreakMode:UILineBreakModeWordWrap];
    _label.frame = CGRectMake(15, 15, self.frame.size.width-30, size.height);
    
    if(!_isMenuVisible)
        _menuView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, ONTableViewMenuCell_Menu_Height);
}
- (void)invertColors{
    //setup the inverted colors here
    if([self.backgroundColor isEqual:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]] && !invertedColors){
        oldBgColor = self.backgroundColor;
        self.backgroundColor = [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f];
    }
    if(invertedColors)
        self.backgroundColor = oldBgColor;
    
    
    _label.textColor = [self invertedColorForColor:_label.textColor];
    invertedColors = !invertedColors;
}
- (void)setButtonsWithImages:(NSArray *)buttonImages{
    for(UIView *view in _menuView.subviews){//remove old images and buttons if set
        [view removeFromSuperview];
    }
    int i = 0;
    for(UIImage *image in buttonImages){
        //calculate position
        float x1 = self.frame.size.width / [buttonImages count];
        float imageViewSize = ONTableViewMenuCell_Menu_Height * ONTableViewMenuCell_Button_Frame_Factor;
        //setup imageview
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x1 *i + (x1 - imageViewSize)/2, (ONTableViewMenuCell_Menu_Height-imageViewSize)/2, imageViewSize, imageViewSize)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = image;
        [_menuView addSubview:imageView];
        
        //setup button
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x1 *i + (x1 - ONTableViewMenuCell_Menu_Height)/2, 0, ONTableViewMenuCell_Menu_Height, ONTableViewMenuCell_Menu_Height)];
        button.alpha = 0.8;
        [button addTarget:self action:@selector(didClickOnButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [_menuView addSubview:button];
        i++;
    }
    
}
- (void)didClickOnButton:(UIButton *)button{
    [_delegate ONTableViewMenuCell:self didClickOnButtonAtIndex:button.tag];
}
- (void)showMenu{
    _isMenuVisible = TRUE;
    [_menuView setHidden:FALSE];
}

- (void)hideMenu{
    _isMenuVisible = FALSE;
}

- (UIColor *)invertedColorForColor:(UIColor *)oldColor{
    const CGFloat *componentColors = CGColorGetComponents(oldColor.CGColor);
    
    UIColor *newColor = [[UIColor alloc] initWithRed:(1.0 - componentColors[0])
                                               green:(1.0 - componentColors[1])
                                                blue:(1.0 - componentColors[2])
                                               alpha:componentColors[3]];
    return newColor;
}

@end
