# DQPlistManage
##介绍
大强哥又一力作.
##install
pod 'DQPlistManage'
##使用方法
####1.导入头文件
\#import "DQPlistManage.h"
####2.工程中使用
1.创建        
    [[DQPlistManage sharedInstance] initPlistWithPlistName:@"你的plist文件的名称"];     
    [[DQPlistManage sharedInstance] plist:@"你的plist文件的名称" writePlist:字典或数组 forKey:Key值];     
2.增       
    [[DQPlistManage sharedInstance] plist:@"你的plist文件的名称" writePlist:字典或数组 forKey:Key值];    
3.删   
    //删除指定值    
    [[DQPlistManage sharedInstance] plist:<#(NSString *)#> removeBookWithKey:<#(NSString *)#>];    
    //删除plist文件    
    [[DQPlistManage sharedInstance] deletePlistWithplist:<#(NSString *)#>];    
4,改        
    直接将新的值写入指定的Plist文件,方法中会替换旧值.        
5,查         
    NSDictionary \*dic=[[DQPlistManage sharedInstance]readPlistName:@"你的plist文件的名称"];
####欢迎各位大神指点,
    
    
