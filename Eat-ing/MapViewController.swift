//
//  MapViewController.swift
//  Eat-ing
//
//  Created by cice on 19/12/16.
//  Copyright © 2016 355 Berry Street S.L. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    var restaurante: RestauranteMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsUserLocation = true
        mapView.showsTraffic = true
        
        let geocoder = CLGeocoder() //Le puedes pasar la informacion del geocoder a traves del segue
        geocoder.geocodeAddressString(restaurante.localizacion!, completionHandler: {
            placemarks, error in
            if error != nil {
                print(error)
                return
            }
            
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurante.nombre
                annotation.subtitle = self.restaurante.tipo
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    self.mapView.showAnnotations([annotation], animated: true) //Aqui no hace falta indicar el zoom. Es mas comoda si no queires especificar el zoom concreto
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            
            }
        })
    
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? { //Esto nos permite ver la vista de las chinchetas
        
        let identifier = "MiChincheta"
        
        if annotation.isKind(of: MKUserLocation.self){ //Para no tocar la localizacion del usuario, porque al fin y al cabo todas son chinchetas y se sobreescribimos tambien se va a tocar esta chincheta
            return nil
        }
        
        var annotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView //Creamos una vista para que no cree mas pines de los necesarios
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true//Tiene que ser true si queremos modificarlo
        }
        
        let iconImage = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))//Como la vista de nuestra chincheta esta vacia y en el storyboard no hay opcion de crear la chincheta lo hacemos mediante codigo. para ello creamos un objeto UIImageView con el inicializador frame. En este caso le damos la posicion de la vista de la chincheta colocarlo
        iconImage.image = UIImage(data: restaurante.imagen as! Data)
        annotationView?.leftCalloutAccessoryView = iconImage //Es el recuadro al lado del titulo y subtitulo
        
        annotationView?.pinTintColor = UIColor.blue //Si queremos cambiarle el color, o diciendole tu el color mediante ()
        return annotationView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
