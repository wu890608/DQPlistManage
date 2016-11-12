//
//  DQPlistManage.m
//  DQPlistManage
//
//  Created by wu on 2016/11/5.
//  Copyright © 2016年 wu. All rights reserved.
//

#import "DQPlistManage.h"

@implementation DQPlistManage
static  DQPlistManage *shareInstance = nil;

+ (DQPlistManage *)sharedInstance
{
    @synchronized(self) {
        if ( shareInstance == nil ) {
            shareInstance = [[self alloc] init];
        }
    }
    return shareInstance;
}
//获得plist路径
-(NSString*)getPlistPathWithPlistName:(NSString*)plistName{
    //沙盒中的文件路径
    NSArray *storeFilePath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *doucumentsDirectiory = [storeFilePath objectAtIndex:0];
    NSString *plistPath =[doucumentsDirectiory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",plistName]];
    //MYLog(@"%@",plistPath);
    return plistPath;
}

//判断沙盒中名为plistname的文件是否存在
-(BOOL)isPlistFileExistshWithPlistName:(NSString*)plistName{
    
    NSString *plistPath =[[DQPlistManage sharedInstance] getPlistPathWithPlistName:plistName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if( [fileManager fileExistsAtPath:plistPath]== NO ) {
        MYLog(@"not exists");
        return NO;
    }else{
        NSLog(@"exist");
        return YES;
    }
    
}
-(void)initPlistWithPlistName:(NSString*)plistName{
    NSString *plistPath = [self getPlistPathWithPlistName:plistName];
    
    //如果plist文件不存在，将工程中已建起的plist文件写入沙盒中
    if (! [[DQPlistManage sharedInstance] isPlistFileExistshWithPlistName:plistName]) {
        
        //从自己建立的plist文件 复制到沙盒中 ，方法一
//        NSError *error;
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        NSString *bundle = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
//        [fileManager copyItemAtPath:bundle toPath:plistPath error:&error];
        
        //方法二
        //        NSString *path = [[NSBundle mainBundle] pathForResource:@"WBBooks"ofType:@"plist"];
        //        NSMutableDictionary *activityDics = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        //        [activityDics writeToFile:plistPath atomically:YES];
        
//        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES);
//        NSString *path=[paths   objectAtIndex:0];
//        NSLog(@"path = %@",path);
//        NSString *filename=[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",plistName]];

        [@{plistName:@{plistName:plistPath}} writeToFile:plistPath atomically:YES];
    }
}


//判断key的书是否存在
-(BOOL)plist:(NSString*)plistName isBookExistsForKey:(NSString*)key{
    
    NSString *plistPath = [[DQPlistManage sharedInstance] getPlistPathWithPlistName:plistName];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    //根目录下存在名为bookname的字典
    if ([dictionary objectForKey:key]) {
        return YES;
    }else{
        return NO;
    }
}

//根据key值删除对应数据
-(void)plist:(NSString*)plistName removeBookWithKey:(NSString *)key{
    
    NSString *plistPath = [[DQPlistManage sharedInstance] getPlistPathWithPlistName:plistName];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    [dictionary removeObjectForKey:key];
    [dictionary writeToFile:plistPath atomically:YES]; //删除后重新写入
    
}



//删除plistPath路径对应的文件
-(void)deletePlistWithplist:(NSString*)plistName{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath = [[DQPlistManage sharedInstance] getPlistPathWithPlistName:plistName];
    [fileManager removeItemAtPath:plistPath error:nil];
    
}

//将dictionary写入plist文件，前提：dictionary已经准备好
-(void)plist:(NSString*)plistName writePlist:(NSMutableDictionary*)dictionary forKey:(NSString *)key{
    
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]init];
    
    //如果已存在则读取现有数据
    if ([[DQPlistManage sharedInstance]isPlistFileExistshWithPlistName:plistName]) {
        plistDictionary = [[DQPlistManage sharedInstance]readPlistName:plistName];
    }
    //增加一个数据
    [plistDictionary setValue:dictionary forKey:key]; //在plistDictionary增加一个key为...的value
    
    NSString *plistPath = [[DQPlistManage sharedInstance] getPlistPathWithPlistName:plistName];
    
    if([plistDictionary writeToFile:plistPath atomically:YES]){
        MYLog(@"write ok!");
    }else{
        MYLog(@"ddd");
    }
    
}

//读取对应Plist内容
-(NSMutableDictionary*)readPlistName:(NSString*)plistName{
    
    NSString *plistPath = [[DQPlistManage sharedInstance] getPlistPathWithPlistName:plistName];
    NSMutableDictionary *resultDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    return resultDictionary;
}

//读取plist文件内容复制给dictionary   备用
-(void)plist:(NSString*)plistName readPlist:(NSMutableDictionary **)dictionary{
    NSString *plistPath = [[DQPlistManage sharedInstance] getPlistPathWithPlistName:plistName];
    *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
}

//更改一条数据，就是把dictionary内key重写
-(void)plist:(NSString*)plistName replaceDictionary:(NSMutableDictionary *)newDictionary withDictionaryKey:(NSString *)key{
    
    [[DQPlistManage sharedInstance]plist:plistName removeBookWithKey:key];
    [[DQPlistManage sharedInstance]plist:plistName writePlist:newDictionary forKey:key];
}


-(NSInteger)getCountWithPlistName:(NSString*)plistName{
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    dictionary = [[DQPlistManage sharedInstance] readPlistName:plistName];
    return [dictionary count];
    
}

@end
