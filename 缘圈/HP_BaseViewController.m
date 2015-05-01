//
//  HP_BaseViewController.m
//  shise
//
//  Created by Yi Xu on 12-10-30.
//  Copyright (c) 2012年 Yi Xu. All rights reserved.
//


#import "HP_BaseViewController.h"

@interface HP_BaseViewController ()

@end

@implementation HP_BaseViewController

- (NSMutableDictionary *)dataArrayM
{
	if(_dataArrayM == nil)
	{
		_dataArrayM = [NSMutableDictionary dictionary];
	}
	return _dataArrayM;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// getScreenValue 获得屏幕相关数值
-(CGRect) getScreenRect{
    return [[UIScreen mainScreen]bounds];
}

-(CGSize) getScreenSize{
    return [self getScreenRect].size;
}

-(CGFloat) getScreenScale{
    return [UIScreen mainScreen].scale;
}

-(CGFloat) getScreenWidthPixels{
    return [self getScreenScale] * [self getScreenSize].width;
}

-(CGFloat) getScreenHeightPixels{
    return [self getScreenScale] * [self getScreenSize].height;
}



// 显示简单的alertView
-(void)showAlertViewWithTitle:(NSString *)title alertMessage:(NSString *)msg cancelButtonTitle:(NSString *) cancelTitle otherButtonTitles:(NSString *)otherButtonTitles{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:otherButtonTitles,nil];
    [alertView show];
}


-(NSUserDefaults *)getNSUserDefaults{
	return [NSUserDefaults standardUserDefaults];
}

-(void) setDictionaryForNSUserDefaults:(NSMutableDictionary *) dictionary forKey:(NSString *)key{
	[[self getNSUserDefaults] setObject:dictionary forKey:key];
}

-(void) setObjectForNSUserDefaults:(id) object forKey:(NSString *)key{
	[[self getNSUserDefaults] setObject:object forKey:key];
}

-(void) setStringForNSUserDefaults:(NSString *) string forKey:(NSString *)key{
	[[self getNSUserDefaults] setObject:string forKey:key];
}

-(id) getObjectFromNSUserDefaultsForKey:(NSString *)key{
	return [[self getNSUserDefaults] objectForKey:key];
}

-(NSString *) getStringFromNSUserDefaultsForKey:(NSString *)key{
	return [[self getNSUserDefaults] stringForKey:key];
}

-(NSDictionary *) getDictionaryFromNSUserDefaultsForKey:(NSString *)key{
	return [[self getNSUserDefaults] dictionaryForKey:key];
}

- (void)setArchiveObject:(id<NSCoding>)object forKey:(NSString *)key
{
	NSMutableString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	path = [[path stringByAppendingPathComponent:key] mutableCopy];
	path = [[path stringByAppendingString:@".archiver"] mutableCopy];
	[NSKeyedArchiver archiveRootObject:object toFile:path];
	
}

- (id)getArchivedObjectForKey:(NSString *)key
{
	NSMutableString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	path                  = [[path stringByAppendingPathComponent:key] mutableCopy];
	path                  = [[path stringByAppendingString:@".archiver"] mutableCopy];
	
	return  [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}



@end
