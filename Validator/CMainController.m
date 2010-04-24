//
//  CMainController.m
//  TouchCode
//
//  Created by Jonathan Wight on 03/18/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "CMainController.h"

#import "CXMLDocument.h"

@implementation CMainController

@synthesize window;
@synthesize XMLString;
@synthesize XPath;
@synthesize status;

- (void)applicationDidFinishLaunching:(NSNotification *)inNotification
{
NSLog(@"Finish");
}

- (void)setXMLString:(NSString *)inXMLString
{
if (inXMLString != XMLString)
	{
	if (XMLString)
		{
		[XMLString release];
		XMLString = NULL;
		}
		
	if (inXMLString)
		{
		XMLString = [inXMLString copy];
		[self updateStatus];
		}
	}
}

- (void)setXPath:(NSString *)inXPath
{
if (inXPath != XPath)
	{
	if (XPath)
		{
		[XPath release];
		XPath = NULL;
		}
		
	if (inXPath)
		{
		XPath = [inXPath copy];
		[self updateStatus];
		}
	}
}

- (void)updateStatus
{
NSError *theError = NULL;
CXMLDocument *theXMLDocument = [[[CXMLDocument alloc] initWithXMLString:self.XMLString options:0 error:&theError] autorelease];
if (theXMLDocument)
	{
	if (self.XPath.length > 0)
		{
		NSArray *theNodes = [theXMLDocument nodesForXPath:self.XPath error:&theError];
		if (theNodes)
			self.status = [theNodes description];
		else
			self.status = @"OK";
		}
	else
		self.status = @"OK";
	}
else
	self.status = [theError description];

}

@end
