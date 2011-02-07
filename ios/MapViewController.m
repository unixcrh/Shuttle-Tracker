//
//  MapViewController.m
//  Shuttle-Tracker
//
//  Created by Brendon Justin on 1/29/11.
//  Copyright 2011 Brendon Justin. All rights reserved.
//

#import "MapViewController.h"
#import "KMLParser.h"

@interface MapViewController()
- (void)routeKmlLoaded;

@end

@implementation MapViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
	[self.view addSubview:mapView];
	
	//	Shuttles KML: http://shuttles.rpi.edu/displays/netlink.kml
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    mapView.showsUserLocation = YES;
    
    //  The student union is at -73.6765441399,42.7302712352
    MKCoordinateRegion region;
    region.center.longitude = -73.67654;
    region.center.latitude = 42.73027;
    region.span.latitudeDelta = 0.0080;
    region.span.longitudeDelta = 0.0070;
    
    mapView.region = region;
    
    routeKmlParser = [[KMLParser alloc] initWithContentsOfUrl:[[NSBundle mainBundle] URLForResource:@"netlink" withExtension:@"kml"]];
    [self routeKmlLoaded];
}

- (void)routeKmlLoaded {
    [routeKmlParser parse];
    
    routes = [routeKmlParser routes];
    [routes retain];
    
    stops = [routeKmlParser stops];
    [stops retain];
    
}

- (void)drawPathWithRoute:(KMLRoute *)route {
    MKOverlayPathView *pathView = [[MKOverlayPathView alloc] init];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    BOOL startingPoint = YES;
    CGPoint point;
    NSArray *temp;
    CLLocationCoordinate2D clLoc;
    
    for (NSString *coordinate in route.lineString) {
        temp = [coordinate componentsSeparatedByString:@","];
        
        if (temp) {
            //  Get a CoreLocation coordinate from the coordinate string
            clLoc = CLLocationCoordinate2DMake([[temp objectAtIndex:0] floatValue], [[temp objectAtIndex:1] floatValue]);
            
            point = [mapView convertCoordinate:clLoc toPointToView:self.view];
            
            //  Add the current point to the path representing this route
            if (startingPoint) {
                CGPathMoveToPoint(path, NULL, point.x, point.y);
            } else {
                CGPathAddLineToPoint(path, NULL, point.x, point.y);
            }
        }
    }
    
    //  Close the subpath and add a line from the last point to the first point.
    CGPathCloseSubpath(path);
    
    pathView.path = path;
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark MKMapViewDelegate Methods
/*
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    //  If the annotation is the user's location, return nil so the platform
    //  just uses the blue dot
    if (annotation == mapView.userLocation)
        return nil;
    
    return nil;
}
*/

@end
