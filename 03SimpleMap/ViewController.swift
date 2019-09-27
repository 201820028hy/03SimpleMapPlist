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
    
    var points = [AnnotationData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //35.166537 위도Latitude, 129.072061 경도longitude (학교)
        
        //중심점 설정
        let center = CLLocationCoordinate2D(latitude: 35.166537, longitude: 129.072061)
        
        //반경 설정
        //let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        //region 설정
        //let region = MKCoordinateRegion(center: center, span: span)
        //let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        //MapView에 추가
        //mapView.setRegion(region, animated: true)
        
        //MKMapViewDelegate
        mapView.delegate = self
        
        
        //annotation set
//        let ann = MKPointAnnotation()
//        ann.coordinate = center
//        ann.title = "동의과학대학교"
//        ann.subtitle = "미래관"
//        points.append(ann)
        let ann1 = AnnotationData(coordinate: center, title: "동의과학대학교", subtitle: "미래관")
        points.append(ann1)
        
        //2
//        let ann2 = MKPointAnnotation()
//        ann2.coordinate.latitude = 35.161167
//        ann2.coordinate.longitude = 129.064525
//        ann2.title = "토포필리아센트럴"
//        ann2.subtitle = "우리집"
//        points.append(ann2)
        let ann2 = AnnotationData(coordinate: CLLocationCoordinate2D(latitude: 35.161167, longitude: 129.064524), title: "토포필리아센트럴", subtitle: "우리집")
        points.append(ann2)
        
//        let ann3 = MKPointAnnotation()
//        ann3.coordinate.longitude = 128.943159
//        ann3.coordinate.latitude = 35.105746
//        ann3.title = "을숙도"
//        ann3.subtitle = "경치 좋은 영도 맛집"
//        points.append(ann3)
        let ann3 = AnnotationData(coordinate: CLLocationCoordinate2D(latitude: 35.105746, longitude: 128.943159), title: "을숙도", subtitle: "어디지")
        points.append(ann3)
        
        //PointAnnotation add
        //mapView.addAnnotations([ann, ann2])
        //모든 핀을 다 보여줌
        mapView.showAnnotations(points, animated: true)
        
        //35.161167, 129.064525 (우리집)
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
                annotationView?.setSelected(true, animated: false)
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
        let alertController = UIAlertController(title: "title", message: "sub", preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

