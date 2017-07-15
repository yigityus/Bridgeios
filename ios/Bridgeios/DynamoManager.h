//
//  DynamoManager.h
//  Bridgeios
//
//  Created by digital on 15/07/2017.
//  Copyright © 2017 Facebook. All rights reserved.
//

// add Lib/libMTSCRA.a Lib/MTSCRA.h
// ensure Build Settings -> Library Search Paths point to Lib
// add to plist

/*
	<key>UISupportedExternalAccessoryProtocols<key>
	<array>
		<string>com.magtek.cdynamo<string>
		<string>com.magtek.idynamo<string>
	<array>
*/



#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import "MTSCRA.h"

@interface DynamoManager : RCTEventEmitter <RCTBridgeModule, MTSCRAEventDelegate>

@property(nonatomic, strong) MTSCRA* lib;

@end
