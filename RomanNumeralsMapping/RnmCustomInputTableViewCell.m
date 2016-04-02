//
//  RnmCustomTableViewCell.m
//  RomanNumeralsMapping
//
//  Created by Hussain  on 30/3/16.
//  Copyright © 2016 Hussain . All rights reserved.
//

#import "RnmCustomInputTableViewCell.h"
#import "RnmViewController.h"
#import "Constants.h"
@interface RnmCustomInputTableViewCell()
@property (nonatomic,strong)NSDictionary *romanNumeralDict;
@property (nonatomic,strong)UIAlertController *alertController;
@end

@implementation RnmCustomInputTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.romanNumeralDict = [NSDictionary dictionaryWithObjects:@[@(1000), @(900), @(500), @(400), @(100), @(90), @(50), @(40),@(10), @(9), @(5), @(4), @(1)] forKeys:@[@"M", @"CM", @"D", @"CD", @"C", @"XC", @"L", @"XL", @"X", @"IX", @"V", @"IV", @"I"]];
}

-(IBAction)convertRomanIntoDecimal:(id)sender{
    NSString *inputValue = self.inputText.text.uppercaseString;
    [self validateCharactersFromString:inputValue];
}


-(void)validateCharactersFromString:(NSString*)inputValue{
    //First Checking Count of character (I,X,X,M) which should not be more than 5.
    NSMutableArray *mutableStrList = [NSMutableArray arrayWithCapacity:0];
    BOOL isValid = NO;
    for (NSInteger i= 0 ; i< inputValue.length; i++)
    {
        char keyCharacter = [inputValue characterAtIndex:i];
        NSString *characterStr = [NSString stringWithFormat:@"%c",keyCharacter];
        [mutableStrList addObject:characterStr];
        NSArray *filteredList;
        if (keyCharacter == 'I' || keyCharacter == 'X' || keyCharacter == 'C'){
            filteredList = [mutableStrList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[c]%@",characterStr]];
            if (filteredList && filteredList.count < 5){
                isValid = YES;
            }
            else{
                isValid = NO;
                [self displayAlert];
                break;
            }
        }
        else if (keyCharacter == 'M'){
            filteredList = [mutableStrList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[c]%@",characterStr]];
            if (filteredList && filteredList.count <= 5){
                isValid = YES;
            }
            else{
                isValid = NO;
                [self displayAlert];
                break;
            }
        }
        
        //Second Checking Count of character (V,L,D) which should not be more than 1.
        else if (keyCharacter == 'V' || keyCharacter == 'L' || keyCharacter == 'D'){
            filteredList = [mutableStrList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[c]%@",characterStr]];
            if (filteredList && filteredList.count < 2){
                isValid = YES;
            }
            else{
                isValid = NO;
                [self displayAlert];
                break;
            }
        }
        
        //Third if charcters are other than  I,X,C,M,V,L,D then display Invalid input.
        else
        {
            isValid = NO;
            [self displayAlert];
            break;
        }
    }
    if (isValid){
    isValid = [self validateTwoOrMoreSmallerNumberInFrontLargerNumber:mutableStrList];
    }
        if (isValid){
        NSInteger totalValue = 0;
        NSInteger strCount = mutableStrList.count;
        for (NSInteger i =0; i<strCount; i++){
            NSInteger j = i + 1;
            if (j >= strCount){
                j = i;
            }
            NSInteger previousIndex = [self.romanNumeralDict[mutableStrList[i]]integerValue];
            NSInteger nextIndex = [self.romanNumeralDict[mutableStrList[j]]integerValue];
            if (previousIndex >= nextIndex){
              totalValue += previousIndex;
            }
            else{
              totalValue -= previousIndex;
            }
        }
            //Checking if decimal value will generate correct Roman Numerals
            if ([self.inputText.text.uppercaseString isEqualToString:[self romanNumeral:totalValue]]){
            isValid = YES;
            self.outPutText.text = [NSString stringWithFormat:@"%ld",totalValue];
        }
        else{
            isValid = NO;
            [self displayAlert];
        }
    }
    else
    {
        isValid = NO;
        [self displayAlert];
    }
}

-(BOOL)validateTwoOrMoreSmallerNumberInFrontLargerNumber:(NSMutableArray *)number{
    NSMutableArray *tempArray = [number mutableCopy];
    BOOL isValid = YES;
    do{
        NSInteger tempCount = tempArray.count-1;
        NSString *lastObj = tempArray.lastObject;
        NSInteger lastInteger = [self.romanNumeralDict[lastObj]integerValue];
        NSInteger integerCount = 0;
        for (NSInteger i = 0; i<tempCount; i++){
            NSString *charStr = tempArray[i];
            NSInteger tempInteger = [self.romanNumeralDict[charStr]integerValue];
            if (tempInteger < lastInteger){
                integerCount++;
            }
            if (integerCount > 1)
            {
                isValid = NO;
            }
        }
        [tempArray removeLastObject];
    }while (tempArray.count > 0);
    return isValid;
}

//Below function will convert decimal into roman numerals
- (NSString *)romanNumeral:(NSInteger)value
{
    NSInteger n = value;
    
    NSArray *numerals = [NSArray arrayWithObjects:@"M", @"CM", @"D", @"CD", @"C", @"XC", @"L", @"XL", @"X", @"IX", @"V", @"IV", @"I", nil];
    
    NSUInteger valueCount = 13;
    NSUInteger values[] = {1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1};
    
    NSMutableString *numeralString = [NSMutableString string];
    
    for (NSUInteger i = 0; i < valueCount; i++)
    {
        while (n >= values[i])
        {
            n -= values[i];
            [numeralString appendString:[numerals objectAtIndex:i]];
        }
    }
    return numeralString;
}

-(void)displayAlert{
    NSString *trimmedString = [self.inputText.text stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    self.alertController = [UIAlertController alertControllerWithTitle:kApplicationName message:(trimmedString.length>0) ?[NSString stringWithFormat: @"%@ is not a valid input",self.inputText.text]:kNoData preferredStyle:UIAlertControllerStyleAlert];
    [self.alertController addAction:[UIAlertAction actionWithTitle:kOkButton style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.inputText.text = kNone;
    }]];
    [self.representedObject presentViewController:self.alertController animated:YES completion:nil];
    NSLog(@"InValidInput");
    self.outPutText.text = kNone;
    return;
}
@end
