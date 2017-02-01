//
//  RestauranteTableViewController.swift
//  Eat-ing
//
//  Created by Pablo Mateo Fernández on 13/12/2016.
//  Copyright © 2016 355 Berry Street S.L. All rights reserved.
//

import UIKit
import CoreData

class RestauranteTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var restaurants: [RestauranteMO] = []
    
    var fetchResultController: NSFetchedResultsController<RestauranteMO>! //2ª opcion de acceder a lavase de datos, añadir nssfetchedcontorllerfellegate
    
    
//    var restaurants: [Restaurante] = [Restaurante(name: "Vips", type: "Cafetería", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", image: "resta001", isVisited: false),
//                                      Restaurante(name: "Ginos", type: "Bar", location: "Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong", image: "resta002", isVisited: false),
//                                      Restaurante(name: "Zalacaín", type: "Restaurante", location: "Shop B, 18 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", image: "resta003", isVisited: false),
//                                      Restaurante(name: "Diverxo", type: "Cafetería", location: "Shop B, 20 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", image: "resta004", isVisited: false),
//                                      Restaurante(name: "La Bola", type: "Restaurante", location: "24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", image: "resta005", isVisited: false),
//                                      Restaurante(name: "Tanteo", type: "Bar", location: "Shop JK., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong", image: "resta006", isVisited: false),
//                                      Restaurante(name: "Daltea", type: "Restaurante", location: "G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong", image: "resta007", isVisited: false),
//                                      Restaurante(name: "Plaza", type: "Cafetería", location: "633 Bourke St Sydney New South Wales 2010 Surry Hills", image: "resta008", isVisited: false),
//                                      Restaurante(name: "Rotonda", type: "Restaurante", location: "412-414 George St Sydney New South Wales", image: "resta009", isVisited: false),
//                                      Restaurante(name: "Fridays", type: "Cafetería", location: "Shop 1 61 York St Sydney New South Wales", image: "resta0010", isVisited: false),
//                                      Restaurante(name: "Opera", type: "Bar", location: "95 1st Ave New York, NY 10003", image: "resta0011", isVisited: false),
//                                      Restaurante(name: "Camión", type: "Cafetería", location: "229 S 4th St Brooklyn, NY 11211", image: "resta0012", isVisited: false),
//                                      Restaurante(name: "Panza", type: "Bar", location: "445 Graham Ave Brooklyn, NY 11211", image: "resta0013", isVisited: false),
//                                      Restaurante(name: "Sancho", type: "Restaurante", location: "413 Graham Ave Brooklyn, NY 11211", image: "resta0014", isVisited: false),
//                                      Restaurante(name: "La casa de Pi", type: "Cafetería", location: "18 Bedford Ave Brooklyn, NY 11222", image: "resta0015", isVisited: false),
//                                      Restaurante(name: "Catorce", type: "Restaurante", location: "Sunset Park 4601 4th Ave Brooklyn, NY 11220", image: "resta0016", isVisited: false),
//                                      Restaurante(name: "El Camino", type: "Cafetería", location: "308 E 6th St New York, NY 10003", image: "resta0017", isVisited: false),
//                                      Restaurante(name: "Aperitivo", type: "Bar", location: "54 Frith Street London W1D 4SL United Kingdom", image: "resta0018", isVisited: false),
//                                      Restaurante(name: "Rico rico", type: "Cafetería", location: "10 Seymour Place London W1H 7ND United Kingdom", image: "resta0019", isVisited: false),
//                                      Restaurante(name: "Arguiñano", type: "Bar", location: "2 Regency Street London SW1P 4BZ United Kingdom", image: "resta0020", isVisited: false),
//                                      Restaurante(name: "Dani García", type: "Bar", location: "22 Charlwood Street London SW1V 2DY Pimlico", image: "resta0021", isVisited: false)]

    //Creamos un array para registrar si un restaurante se ha visitado o no
    var restauranteVisitado = Array(repeating: false, count: 21)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Quitamos el título de los "Back Buttons" de las Views que provengan de esta
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //Ocultar Nav Bar en Swipe
        navigationController?.hidesBarsOnSwipe = true
        
        tableView.estimatedRowHeight = 80.0 //ALTURA ESTIMADA, LO QUE NORMALMENTE VA A TENER
        tableView.rowHeight = UITableViewAutomaticDimension //ADEMAS, TENEMOS QUE PONER LAS LINEAS DEL LABEL A 0 PARA QUE SE TE PONGAN EN VARIAS LINEAS SI NO CABE
        
        //cargar datos base de datos
        let fetchRequest: NSFetchRequest <RestauranteMO> = RestauranteMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "nombre", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do{
            
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects{
                    restaurants = fetchedObjects
                }
            
            }catch{
            
            print("error")
            }
        
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        
        //PARA METER LOS DATOS DE LA BASE DE DATOS HAY QUE  ACCEDER A APPDELEGATE Y CREAR UNA VARIABLE  QUE ES COMO UNA PETICION 
        //EN LA PETICION LE INIDCAMOS EL TIPO QUE QUEREMOS QUE ES RESTAURANTEMO = Y CON RESTAURANTEMO.FETCHREQUEST LE DECIMOS QUE LO COJA TODO
        //CREAMOS UNA VARIABLE CONTEXT QUE ES DONDE SE GUARDAN TODO Y POR UTIMO IGUALAMOS EL ARRAY AL "BAUL" CON LA PETICION
        //PARA HACER LAS PETICIONES A UN SERVIDOR SERIA IGUAL PERO ACCEDIEMDO AL SERVIDOS EN VEZ DE AL APPDELEGATE
        
        //1 MANERA
        
//        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
//            let request: NSFetchRequest<RestauranteMO> = RestauranteMO.fetchRequest()
//            let context = appDelegate.persistentContainer.viewContext
//            do{
//                restaurants = try context.fetch(request)
//            } catch {
//                print(error)
//            }
//        
//        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestauranteTableViewCell
        cell.nameLabel.text = restaurants[indexPath.row].nombre
        cell.locationLabel.text = restaurants[indexPath.row].localizacion
        cell.typeLabel.text = restaurants[indexPath.row].tipo
        //cell.thumbnailImageView.image = UIImage(named: restaurants[indexPath.row].imagen)
        //Al usar ahora bases de datos en vez del array se define de la siguiente manera, hay que leer las imagenes de forma binaria
        //OJO! ACUERDATE DE QUE HAY QUE MODIFICAR EL XCDATAMODEL PONIENDO EL CODEGEN COMO CLASS DEFINITION Y PONIENDO NOMBRES DIFERENTES A LA CLASE Y A LA ENTIDAD
        cell.thumbnailImageView.image = UIImage(data: restaurants[indexPath.row].imagen as! Data)
        
        //Round Image
        cell.thumbnailImageView.layer.cornerRadius = 30.0
        cell.thumbnailImageView.clipsToBounds = true
        
        //Comprobamos si el restaurante ha sido visitado o no
        cell.accessoryType = restaurants[indexPath.row].visitado ? .checkmark : .none
        
        /* Otra forma de hacerlo
            if restauranteVisitado[indexPath.row] {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        */
        
 
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // Permitir que una celda muestre opciones al deslizarla
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //En caso de tener sólo la opción de borrar
        /*
        if editingStyle == .delete {
            //Borramos la info de cada Array
            restaurantNames.remove(at: indexPath.row)
            restaurantTypes.remove(at: indexPath.row)
            restaurantLocations.remove(at: indexPath.row)
            restauranteVisitado.remove(at: indexPath.row)
            restaurantImages.remove(at: indexPath.row)
        }
        */
        
        //Si queremos recargar la tabla
            // tableView.reloadData()
        //Si queremos eliminar una celda
            // tableView.deleteRows(at:[indexPath], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Añadimos nuestras acciones
        //Social Sharing
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Compartir", handler: { (action, indexPath) -> Void in
            let defaultText = "Estoy comiendo en " + self.restaurants[indexPath.row].nombre!
            let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        })
        
        //Delete Button
        let deleteAction = UITableViewRowAction(style: .default, title: "Borrar", handler: {(action, indexPath) -> Void in
            //Borramos la info
            self.restaurants.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        })
        
        //Customizamos los botones
        shareAction.backgroundColor = UIColor(red: 48.0/255.0, green: 173.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        
        //Dependiendo del orden, sale una antes o después
        return [deleteAction, shareAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestauranteDetail" {
            if let IndexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestauranteDetailViewController
                destinationController.restaurante = restaurants[IndexPath.row]
            }
        }
    }
    
    
    @IBAction func unwindAHome(segue: UIStoryboardSegue){
    }
    
    //FetchResult Methods
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates() //Aqui le dices, vamos a cambiar datos estate atenta para actualizarte
    }
    
    //Cada vez que hagamos algo en la bse de datos se llamaraa a este metodo
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert: //que estemos insertando un dato en nuestra tabla
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete: //Si borramos un dato
            if let myIndexPath = indexPath {
                tableView.deleteRows(at: [myIndexPath], with: .fade)
            }
        case .update: //actualizar en el caso de que hayas modificado un restaurante
            if let myIndexPath = indexPath {
                tableView.reloadRows(at: [myIndexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        if let fetchedObjects = controller.fetchedObjects{
        
            restaurants = fetchedObjects as! [RestauranteMO]
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates() //Ya no tienes que estar mas atenta.©©©©©
    }
}
