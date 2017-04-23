//
//  ViewController.swift
//  hackUSTapp
//
//  Created by エリック on 2017/04/22.
//  Copyright © 2017年 エリック. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var SmallerView: SmallerView!
    
    let regionRAdious: CLLocationDistance = 150
//    var firstLocation = CLLocationCoordinate2DMake(22.320365, 114.169773)
//     var firstLocation = CLLocationCoordinate2DMake(22.493982, 114.145203)
    
    var firstLocation = CLLocationCoordinate2DMake(22.5047866, 114.1021156)
    var secondLoaction = CLLocationCoordinate2DMake(22.279991, 114.158798) // this is central
    
    var Aroute   : MKPolyline?
    var Broute : MKPolyline?

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        

        
        var annotation1 = MKPointAnnotation()
   
        annotation1.coordinate = firstLocation

        
        annotation1.title = "Kwu Tung"
        var annotation2 = MKPointAnnotation()
        annotation2.coordinate = secondLoaction
        annotation2.title = "Central"
        
        
        mapView.addAnnotation(annotation2)
        
        //  calculateSegmentDirections(index: 0, time: 0, routes: [])

   
        DirectionPrint()
        mapView.addAnnotation(annotation1)
        
        SmallerView.layer.cornerRadius = 5
        backbtn.layer.cornerRadius = 5
    
        
//        checkLocationAuthorizationStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//    @IBAction func SearchBtnPressed(_ sender: Any) {
//          var annotation2 = MKPointAnnotation()
//        annotation2.coordinate = secondLoaction
//        annotation2.title = "Central"
//        
//
//        mapView.addAnnotation(annotation2)
//
//      //  calculateSegmentDirections(index: 0, time: 0, routes: [])
//        GOBtn.isHidden = false
//        searchBtn.isHidden = true
//    }
//    
//    @IBAction func GOBtnPressed(_ sender: Any) {
//        DirectionPrint()
//    }
    
    func DirectionPrint(){
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: firstLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: secondLoaction))
        request.requestsAlternateRoutes = true
               request.transportType = [.automobile, .automobile]
         request.requestsAlternateRoutes = true
        let directions = MKDirections(request: request)
        
        
        
        directions.calculate(completionHandler: {(response, error) in
            print(response?.routes.count)

            if error != nil {
                print("Error getting directions")
            } else {
                self.showRoute(response!)
            }
        })
        
    }
    
    func showRoute(_ response: MKDirectionsResponse) {
        
//        
//        for i in 0...1 {
//            
//            mapView.add(response.routes[i].polyline,
//                         level: MKOverlayLevel.aboveRoads)
//            // adding the annotation
//            let routeAnnotation = MKPointAnnotation()
//            routeAnnotation.coordinate = MKCoordinateForMapPoint(response.routes[i].polyline.points()[response.routes[i].polyline.pointCount/2])
//            routeAnnotation.title = "\(response.routes[i].expectedTravelTime)"
//            
//
//           
//            mapView.addAnnotation(routeAnnotation)
//
//
//            
//            for step in response.routes[i].steps {
//                print(step.instructions)
//            }
//        }
//        print(response.routes.count)
        
        let polyline1 = response.routes[0].polyline
        let middlePoint = MKCoordinateForMapPoint(polyline1.points()[polyline1.pointCount/2])
        let poly1annotation = MKPointAnnotation()
        poly1annotation.coordinate = middlePoint
        poly1annotation.title = "Recommanded"
      
        mapView.addAnnotation(poly1annotation)
        
 

        Aroute = polyline1
        mapView.add(polyline1)
        
        let polyline2 = response.routes[1].polyline
        
        let middlePoint2 = MKCoordinateForMapPoint(polyline2.points()[polyline2.pointCount/2])
        let polyannotation2 = MKPointAnnotation()
        polyannotation2.coordinate = middlePoint2
        polyannotation2.title = "Not Recommanded"
        mapView.addAnnotation(polyannotation2)
        
        Broute = polyline2
        mapView.add(polyline2)
        
        mapView.selectAnnotation(mapView.annotations[1], animated: true)
   
        


        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor
        overlay: MKOverlay) -> MKOverlayRenderer {
        
//        let renderer = MKPolylineRenderer(overlay: overlay)
//        renderer.strokeColor = UIColor.green
//        renderer.lineWidth = 6.0
//        return renderer
             let renderer = MKPolylineRenderer(overlay: overlay)
        
        if overlay is MKPolyline {
          
                if overlay as? MKPolyline  == Aroute {
                    var polyLineRenderer = MKPolylineRenderer(overlay: overlay)
                    polyLineRenderer.strokeColor = UIColor.green
                    
                    polyLineRenderer.lineWidth = 6
                    
                    return polyLineRenderer
                } else if overlay as? MKPolyline  == Broute {
                    print(overlay.description)
                    var polyLineRenderer = MKPolylineRenderer(overlay: overlay)
                    polyLineRenderer.strokeColor = UIColor.red
                    polyLineRenderer.alpha = 0.6
                    polyLineRenderer.lineWidth = 3
                    
                    return polyLineRenderer
                }
            
        }
        return renderer
    }
    
    


}


extension ViewController: MKMapViewDelegate {
}
