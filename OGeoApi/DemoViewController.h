//
//  DemoViewController.h
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


@import CoreLocation;

#import <UIKit/UIKit.h>
#import "OdokusGeoApi.h"
#import <MapKit/MapKit.h>

@interface DemoViewController : UIViewController <OdokusGeoApiDelegate, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate>
{
    NSMutableArray* responseArray;
}

@property (nonnull) OdokusGeoApi* odokus;
@property (nonnull) id previousDelegate;

@property (weak, nonatomic) IBOutlet MKMapView * _Nullable mapView;
@property (weak, nonatomic) IBOutlet UITableView * _Nullable tableView;


@end
