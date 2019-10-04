//
//  ViewController.swift
//  03SimpleMap
//
//  Created by dit03 on 2019. 9. 20..
//  Copyright © 2019년 201820028. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var points = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //중심점 설정
        let center = CLLocationCoordinate2D(latitude: 35.166537, longitude: 129.072061)
        
        mapView.delegate = self
        
        let path = Bundle.main.path(forResource: "PinData", ofType: "plist")
        //print(path)
        
        let contents = NSArray(contentsOfFile: path!)
        //print(contents)
        
        if let myItem = contents {
            for item in myItem {
                let lat = (item as AnyObject).value(forKey: "lat")
                let long = (item as AnyObject).value(forKey: "long")
                let title = (item as AnyObject).value(forKey: "title")
                let subTitle = (item as AnyObject).value(forKey: "subTitle")
                
                let myLat = (lat as! NSString).doubleValue
                let myLong = (long as! NSString).doubleValue
                
                let anno = MKPointAnnotation()
                anno.coordinate.latitude = myLat
                anno.coordinate.longitude = myLong
                anno.title = title as! String
                anno.subtitle = subTitle as! String
                
                points.append(anno)
                
            }
        } else {
            print("Error")
        }
        
        mapView.showAnnotations(points, animated: true)
    }
    
    
    //mapType 변경
    @IBAction func standardBtn(_ sender: Any) {
        mapView.mapType = MKMapType.standard//기본지도로 변경
    }
    
    @IBAction func SatelliteBtn(_ sender: Any) {
        mapView.mapType = MKMapType.satellite//위성지도로 변경
    }
    
    @IBAction func HybridBtn(_ sender: Any) {
        mapView.mapType = MKMapType.hybrid//하이브리드지도로 변경
    }
    
    
    //MKMapViewDelegate
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //Pin 재활용
        let identifier = "RE"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            //annotationView?.pinTintColor = UIColor.blue
            annotationView?.animatesDrop = true
            
            if annotation.title == "동의과학대학교" {
                annotationView?.pinTintColor = UIColor.blue
            } else if annotation.title == "토포필리아센트럴" {
                annotationView?.pinTintColor = UIColor.red
            } else if annotation.title == "을숙도" {
                annotationView?.pinTintColor = UIColor.black
            }
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            
            let imgV = UIImageView(image: UIImage(named: "cat.jpeg"))
            imgV.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            annotationView?.leftCalloutAccessoryView = imgV
            
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let alertController = UIAlertController(title: (view.annotation?.title)!, message: (view.annotation?.subtitle)!, preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

