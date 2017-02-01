//
//  AddRestTableViewController.swift
//  Eat-ing
//
//  Created by cice on 21/12/16.
//  Copyright © 2016 355 Berry Street S.L. All rights reserved.
//

import UIKit

class AddRestTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var photoImagView: UIImageView!
    
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var tipoTextField: UITextField!
    @IBOutlet weak var direccionTextField: UITextField!
    
    var btnYesActive = false
    var btnNoActive = false
    
    var restaurante: RestauranteMO!
    @IBAction func saveButton(_ sender: AnyObject) {
        
        if(nombreTextField.text != "" && tipoTextField.text != ""){
        
            print("Su restaurante \(nombreTextField.text) ha sido creado ")
            
            
            //Con el appDelegate guardamos la informacion que ha indicado el usuario en el Data
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
                restaurante = RestauranteMO(context: appDelegate.persistentContainer.viewContext)
                restaurante.nombre = nombreTextField.text
                restaurante.tipo = tipoTextField.text
                restaurante.localizacion = direccionTextField.text
                
                if let restauranteImage = photoImagView.image{
                
                    if let imageData = UIImagePNGRepresentation(restauranteImage){
                        restaurante.imagen = NSData(data: imageData)
                    
                    }
                    appDelegate.saveContext()
                    
                }
                performSegue(withIdentifier: "unwindAHomeWithSegue", sender: self)
                //En esta aplicacion hay 2 segues, uno asociado al boton cancel y otro asociado a save, para usar un segue
                //que cumpla alguna condicion habra que hacer un segue que no este asociado a nada por ejemplo arrastrar el add rest table a exit y ya lo utilizad, o coger uno que este asociado, como por ejemplo el del boton cancel y usarlo tambien para lo que queramos (ejemplo save)
            
            } else {
                print("Error ")
                
            
            }
        }
        
    }
//    @IBAction func btnYes(_ sender: AnyObject, for segue: UIStoryboardSegue) {
//        
//        btnYesActive == false ? true : false
//        
//        let destinationController = segue.destination as! ReviewViewController
//      //  destinationController.vistas = "vistanueva"
//        
//        
//        
////        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////            if segue.identifier == "showReview" {
////                let destinationController = segue.destination as! ReviewViewController
////                destinationController.rest = restaurante
////            }
////            else if segue.identifier == "showMap" {
////                let destinationController = segue.destination as! MapViewController
////                destinationController.restaurante = restaurante
////            }
////            
////        }
//        
//            
//
//        
//        }
//    
    
//    @IBAction func btnNo(_ sender: AnyObject) {
//        btnNoActive == false ? true : false
//    }
    
    
//    @IBAction func saveAction(_ sender: AnyObject) {
//    
//        if(nombreTextField.text == "" || restTextField.text == "" || direccionTextField.text == "" || (btnNoActive == false && btnYesActive == false)){
//        
//        
//        }
//        
//        
//    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            //UIImagePickerController para poder coger imagenes de la galeria
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)//Si dispone del metodo, los ipods antes no podian
            {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self //que se encargue el uiimagepicker controller de coger la image, no la vista
                imagePicker.allowsEditing = false //Para no poder edirar (borrar ye sas cosas)
                imagePicker.sourceType = .photoLibrary
                present(imagePicker, animated: true, completion: nil)
            }
        }
    } //Hay que añadir permisos en plis -> boton derecho add row y pones privacy photos no se que
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage { //Creamos una variables y entramos dentro de UIIMage... y lo convertimos en UIImage
            
            photoImagView.image = selectedImage
            photoImagView.contentMode = .scaleAspectFill
            photoImagView.clipsToBounds = true
            
        }
        //AÑADIMOS CONSTRAINS
        let leadingConstraint = NSLayoutConstraint(item: photoImagView, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: photoImagView.superview, attribute: .leading, multiplier: 1, constant: 0) //que el lateral izquierdo del photoimage este relacionado con el laetral izquierdo del lateral izquiedo y que sea igual
        
        let trailingConstraint = NSLayoutConstraint(item: photoImagView, attribute: .trailing, relatedBy: .equal, toItem: photoImagView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: photoImagView, attribute: .top, relatedBy: .equal, toItem: photoImagView.superview, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: photoImagView, attribute: .bottom, relatedBy: .equal, toItem: photoImagView.superview, attribute: .bottom, multiplier: 1, constant: 0)
       
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        topConstraint.isActive = true
        bottomConstraint.isActive = true
        
        
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    // MARK: - Table view data source
    //COMO HEMOS PUESTO QUE LA TABLA ES ESTATICA ESTO NO LO NECESITAMOS
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
