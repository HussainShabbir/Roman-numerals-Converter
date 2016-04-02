//
//  RnmCustomTableViewCell.h
//  RomanNumeralsMapping
//
//  Created by Hussain  on 30/3/16.
//  Copyright © 2016 Hussain . All rights reserved.
//

#import <UIKit/UIKit.h>
#ifndef RnmCustomInputTableViewCell_h
#define RnmCustomInputTableViewCell_h
@interface RnmCustomInputTableViewCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UITextField *inputText;
@property (nonatomic,weak) IBOutlet UITextField *outPutText;
@property (nonatomic,assign) id representedObject;
@end
#endif