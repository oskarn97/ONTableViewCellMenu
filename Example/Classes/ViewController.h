//
//  ViewController.h
//  UITableViewCellMenu
//
//  Created by Oskar Neumann on 31.12.13.
//  Copyright (c) 2013 Oskar Neumann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONTableViewMenuCell.h"

@interface ViewController : UIViewController <UITableViewDelegate, ONTableViewMenuCellDelegate>{
    NSMutableDictionary *_loadedCells;
    NSMutableArray *objects;
}

@end
