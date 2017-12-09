#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

#include "Runner-Swift.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    
  [WebModalPlugin registerWithRegistrar:[self registrarForPlugin:@"WebModalPlugin"]];
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
