//
//  ViewController.m
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


#import "LoginViewController.h"
#import "DemoViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User interaction

- (IBAction)loginButtonPushed:(id)sender
{
    // initialize odokus api object
    odokus = [[OdokusGeoApi alloc]initWithDelegate:self andUserName:_userTextField.text andPassword:_passTextField.text];
    // try if odokus credentials provided by user are valid...
    [odokus ping];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"passLogin"]) {
        DemoViewController* dvc = segue.destinationViewController;
        [dvc setOdokus:odokus];
        [dvc setPreviousDelegate:self];
    }
}

#pragma mark - Odokus Geo Api REQUIRED

- (void)odokusGeoApiDidFailWithError:(NSError *)err
{
    // you should inform the user about
    // what went wrong
}

#pragma mark - Odokus Geo Api Optional

- (void)odokus_didReceivePing
{
    // if ping is being received - user credentials are valid.
    // let's move on
    [self performSegueWithIdentifier:@"passLogin" sender:self];
}

@end
