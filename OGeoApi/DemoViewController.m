//
//  DemoViewController.m
//  OGeoApi
//
//  Created by Johannes on 06.09.17.
//  Copyright © 2017 whileCoffee Software Development - Johannes Dürr. All rights reserved.
//
//
//             .__    .__.__         _________         _____  _____
//     __  _  _|  |__ |__|  |   ____ \_   ___ \  _____/ ____\/ ____\____   ____
//     \ \/ \/ /  |  \|  |  | _/ __ \/    \  \/ /  _ \   __\\   __\/ __ \_/ __ \
//      \     /|   Y  \  |  |_\  ___/\     \___(  <_> )  |   |  | \  ___/\  ___/
//       \/\_/ |___|  /__|____/\___  >\______  /\____/|__|   |__|  \___  >\___  >
//                  \/             \/        \/                        \/     \/
//     Released under MIT License for Hansenhof _electronic
//
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#import "DemoViewController.h"

@interface DemoViewController ()

@end

@implementation DemoViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    responseArray = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // set ourselves as delegate for odokus api
    if (_odokus != nil) {
        // set ourself the api objects delegate
        [_odokus setDelegate:self];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    // we are being dismissed. Set loginViewcontroller back as delegate...
    if (_odokus != nil && _previousDelegate != nil) {
        // we should remove ourself as delegate by replacing with
        // the previous delegate object if available
        [_odokus setDelegate:_previousDelegate];
    }
}

#pragma mark - User interaction

- (IBAction)loadEventsButtonPushed:(id)sender
{
    // Requesting GEO Events from the last 24 hours
    [_odokus requestGeoEventsWithStart:[NSDate dateWithTimeIntervalSinceNow:(-1* 24 * 3600)] andEnd:[NSDate date]];
}

- (IBAction)insertNewGeoEvent:(id)sender {
    
    // check if we have a user location
    if (_mapView.userLocation != nil) {
        // create dictionary with our extension keys and values that we mant to send
        NSMutableDictionary* extensionsDict = [[NSMutableDictionary alloc]init];
        [extensionsDict setObject:[NSString stringWithFormat:@"Created on: %@ by OGeoApi", [[NSDate date]description]] forKey:@"note"];
        [extensionsDict setObject:[NSNumber numberWithInt:99] forKey:@"ext1"];
        
        CLLocation* eventLoacation = [[CLLocation alloc]initWithLatitude:_mapView.userLocation.coordinate.latitude longitude:_mapView.userLocation.coordinate.longitude];
        // save event using our Development API type string for this application as registered with
        // Hansenhof _electronics
        [_odokus saveGeoEvent:[NSDate date] typeString:@"geo-type-3" atLocation:eventLoacation withExtensions:extensionsDict];
    }
}

#pragma mark - Odokus Geo Api REQUIRED

- (void)odokusGeoApiDidFailWithError:(NSError *)err
{
    // something went wrong.
    // you really should add some handling code here
    // to take care and inform the user in production version of
    // your app
}

#pragma mark - Odokus Geo Api OPTIONAL

- (void)odokus_didReceiveGeoEvents:(id)response
{
    // We received the response
    NSLog(@"%@", [response description]);
    // lets fetch the objects and reload the table view
    [responseArray addObjectsFromArray:response];
    [_tableView reloadData];
    
}

#pragma mark - table view delegate & data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return responseArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"odokusCell"];
    
    // get data for cell
    NSDictionary* cellDict = [responseArray objectAtIndex:indexPath.row];
    NSNumber* lat = [cellDict objectForKey:@"latitude"];
    NSNumber* lon = [cellDict objectForKey:@"longitude"];
    NSNumber* iD  = [cellDict objectForKey:@"id"];
    NSString* typeString = [cellDict objectForKey:@"type"];
    
    // update the cell
    [cell.textLabel setText:[NSString stringWithFormat:@"ID%@ - %@",iD, typeString]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"Lat:%@ - Lon%@",lat, lon]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_mapView removeAnnotations:_mapView.annotations];
    
    NSDictionary* cellDict = [responseArray objectAtIndex:indexPath.row];
    NSNumber* lat = [cellDict objectForKey:@"latitude"];
    NSNumber* lon = [cellDict objectForKey:@"longitude"];
    CLLocation* location = [[CLLocation alloc]initWithLatitude:lat.doubleValue longitude:lon.doubleValue];
    MKPointAnnotation* point = [[MKPointAnnotation alloc]init];
    [point setCoordinate:location.coordinate];
    [point setTitle:[[cellDict objectForKey:@"extensions"] objectForKey:@"note"]];
    
    [_mapView showAnnotations:[NSArray arrayWithObject:point] animated:YES];
    
}

#pragma mark - MapView Delegate




@end
