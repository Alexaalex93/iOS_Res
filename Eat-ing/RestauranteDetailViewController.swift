//
//  RestauranteDetailViewController.swift
//  Eat-ing
//
//  Created by Pablo Mateo Fernández on 13/12/2016.
//  Copyright © 2016 355 Berry Street S.L. All rights reserved.
//

import UIKit
import MapKit

class RestauranteDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var restauranteImageView: UIImageView!
    @IBOutlet var tableView: UITableView!

    @IBOutlet weak var mapView: MKMapView!
    
    var restaurante: RestauranteMO!

    override func viewDidLoad() {
        super.viewDidLoad()

        restauranteImageView.image = UIImage(data: restaurante.imagen as! Data)
        
        //Customizamos el Table View
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
            //Hacemos que aparezca el footer (para que no añada celdas sin usar)
        // tableView.tableFooterView = UIView(frame: CGRect.zero)
        
            //Cambiamos el color de los separadores de las celdas
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        
        //Customizamos el título del Nav Bar
        title = restaurante.nombre
        
        navigationController?.hidesBarsOnSwipe = false
        
        tableView.estimatedRowHeight = 36.0 //ALTURA ESTIMADA, LO QUE NORMALMENTE VA A TENER 
        tableView.rowHeight = UITableViewAutomaticDimension //ADEMAS, TENEMOS QUE PONER LAS LINEAS DEL LABEL A 0 PARA QUE SE TE PONGAN EN VARIAS LINEAS SI NO CABE
        
        //Detectar gesto
        let tapGesturesRecognizer = UITapGestureRecognizer(target: self, action: #selector(showMap)) //#Selector es para decirle qe es una funcion que nosotros hacemos
        mapView.addGestureRecognizer(tapGesturesRecognizer)
        
        //Creamos la anotacion para el mapa
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(restaurante.localizacion!, completionHandler: {
            placemarks//Array de posibles resultados
            , error in //Creas dos objetos, placemarks y error
            if error != nil {
                print(error)
                return
            }
            
            if let placemarks = placemarks { //Asi miras si esta vacio
                //Primer resultado
                let placemark = placemarks[0]
                //Añadimos la annotation
                let annotation = MKPointAnnotation()
                
                if let location = placemark.location{ //Si es distinto de nil, de vacio
                    //Mostrar la annotation
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    //Establecemos zoom
                    
                    let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250, 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
            
        }) //Le pasas un string y te busca la direccion. Si lo tienes en coordenadas no hace falta
    }
    
    func showMap(){
        performSegue(withIdentifier: "showMap", sender: self)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestauranteDetailTableViewCell
        
        //Configuramos la celda
        switch indexPath.row {
        case 0:
            cell.campoLabel.text = "Nombre"
            cell.valorLabel.text = restaurante.nombre
        case 1:
            cell.campoLabel.text = "Localización"
            cell.valorLabel.text = restaurante.localizacion
        case 2:
            cell.campoLabel.text = "Tipo"
            cell.valorLabel.text = restaurante.tipo
        case 3:
            cell.campoLabel.text = "Visitado"
            cell.valorLabel.text = (restaurante.visitado) ? "Sí" : "No"

        case 4:
            cell.campoLabel.text = "Valoración"
            cell.valorLabel.text = restaurante.valoracion
            
        default:
            cell.campoLabel.text = ""
            cell.valorLabel.text = ""
        }
        
        //Quitamos el color de fondo de la celda para que se vea el de la tabla
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    //AÑADIDO PARA QUE EL BOTON SEA CAPAZ DE IRSE A LA PANTALLA ANTERIOR PORQUE EL PRESENT MODALLY NO TIENE BOTON DE ATRAS, ENTONCES ARRASTRAS EL BOTON AL EXIT Y LE DAS A CLOSE
    
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReview" {
            let destinationController = segue.destination as! ReviewViewController
                destinationController.rest = restaurante
                destinationController.vistas = "vistahecha"
                
        }
        else if segue.identifier == "showMap" {
            let destinationController = segue.destination as! MapViewController
               destinationController.restaurante = restaurante
        }

    }
    
    //Unwind segue
    @IBAction func close (segue: UIStoryboardSegue){
        
        
    }
    
    @IBAction func ratingButtonTapped( segue: UIStoryboardSegue){
        
        if let valoracion = segue.identifier {
            
            restaurante.visitado = true
            switch valoracion {
                case "genial" :
                    restaurante.valoracion = "Me ha encantado"
                case "normal" :
                    restaurante.valoracion = "Ni fu ni fa"
                case "mal" :
                    restaurante.valoracion = "Mal"
            default:
                break
            
            }
        }
        
        
    }
    
    



}
