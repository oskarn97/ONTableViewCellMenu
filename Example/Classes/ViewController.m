//
//  ViewController.m
//  UITableViewCellMenu
//
//  Created by Oskar Neumann on 31.12.13.
//  Copyright (c) 2013 Oskar Neumann. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //Initialize the dictionary for loaded cells
    _loadedCells = [[NSMutableDictionary alloc] init];
    objects = [[NSMutableArray alloc] init];
    [objects addObject:@"Lorem ipsum"];
    [objects addObject:@"Lorem ipsum dolor sit amet, consetetur sadipscing elitr."];
    [objects addObject:@"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua."];
    [objects addObject:@"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum."];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [objects count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ONTableViewMenuCell *cell = _loadedCells[@(indexPath.row)];
    if (!cell) {
        cell = [[ONTableViewMenuCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //set the cells tag to save the row for using it if requiered
        cell.tag = indexPath.row;
        cell.invertColorsOnSelect = TRUE;
        cell.delegate = self;
        //pass the button images
        [cell setButtonsWithImages:[NSArray arrayWithObjects:[UIImage imageNamed:@"0001.png"], [UIImage imageNamed:@"0002.png"], [UIImage imageNamed:@"0003.png"], nil]];
        //save the cell to the dic
        [_loadedCells setObject:cell forKey:@(cell.tag)];
    }
    cell.label.text = [objects objectAtIndex:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ONTableViewMenuCell *cell = _loadedCells[@(indexPath.row)];
    
    NSString *text = [objects objectAtIndex:indexPath.row];
    CGSize size = [text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:15] constrainedToSize:CGSizeMake(tableView.frame.size.width-30, 99999) lineBreakMode:UILineBreakModeWordWrap];

    //if the menu is visible add the height of the menu
    return cell.isMenuVisible ? size.height+30+ONTableViewMenuCell_Menu_Height : size.height+30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ONTableViewMenuCell *cell = _loadedCells[@(indexPath.row)];
    
    if(![cell isMenuVisible])
        [cell showMenu];
    else
        [cell hideMenu];
    
    //deselect the row before refreshing height (Seperator would be missing otherwise)
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //refresh the height
    [tableView beginUpdates];
    [tableView endUpdates];
    //select the row again
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    ONTableViewMenuCell *cell = _loadedCells[@(indexPath.row)];
    
    if([cell isMenuVisible])
        [cell hideMenu];
    
    //refresh the height
    [tableView beginUpdates];
    [tableView endUpdates];
}
- (void)ONTableViewMenuCell:(ONTableViewMenuCell *)cell didClickOnButtonAtIndex:(NSInteger)buttonIndex{
    int rowClicked = cell.tag;
    if(buttonIndex == 0){//reply (first button)
        //do sth
        NSLog(@"reply button clicked at row %i", rowClicked);
    }
    if(buttonIndex == 1){//like (second button)
        //do sth
        NSLog(@"like button clicked at row %i", rowClicked);
    }
    if(buttonIndex == 2){//dislike (third button)
        //do sth
        NSLog(@"dislike button clicked at row %i", rowClicked);
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
