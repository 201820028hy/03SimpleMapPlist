//
//  AnnotationData.swift
//  03SimpleMap
//
//  Created by dit03 on 2019. 9. 27..
//  Copyright © 2019년 201820028. All rights reserved.
//

import UIKit
import MapKit

class AnnotationData: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    //객체 생성자 함수
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
