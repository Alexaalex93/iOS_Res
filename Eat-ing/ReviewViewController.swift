//
//  ReviewViewController.swift
//  Eat-ing
//
//  Created by cice on 14/12/16.
//  Copyright © 2016 355 Berry Street S.L. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var contenedorView: UIView!
    
    @IBOutlet weak var imagenPequeña: UIImageView!
    
    var vistas = ""
    
    var rest: RestauranteMO!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if( vistas == "vistahecha"){
            
            backgroundImage.image = UIImage(data: rest.imagen as! Data)
        
            imagenPequeña.image = UIImage(data: rest.imagen as! Data)
        }
        //BLUR A LA IMAGEN
        let efectoBlur = UIBlurEffect(style: .light)//Creamos el efecto
        let efectoBlurView = UIVisualEffectView(effect: efectoBlur)//Creamos una vista para este efecto (como si arrastraas en el storyboard una view)
        efectoBlurView.frame = view.bounds // Aqui le dices que la vista sea igual que el controlador hasta los bounds. Si le coges view coge la view principal
        backgroundImage.addSubview(efectoBlurView) //Lo añades como subvista
        
        // ANIMACION DEL CONTENEDOR
        // Esta va con la primera animacion
        // contenedorView.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        
//        contenedorView.transform = CGAffineTransform.init(translationX: -1000, y: 0)

    //ANIMACIONES COMBINADAS
        let transformarEscala = CGAffineTransform.init(scaleX: 0, y: 0)
        let translacionTransform = CGAffineTransform.init(translationX: -1000, y: 0)
        let transfromCombinadas = transformarEscala.concatenating(translacionTransform)
        contenedorView.transform = transfromCombinadas
        

        
    }
    
    //A ESTE METODO SE LE LLAMA CADA VEZ QUE APARECE
    override func viewDidAppear(_ animated: Bool) {
       
        //PARA QUE APAREZCA
        /*
        UIView.animate(withDuration: 0.3, animations: {
            self.contenedorView.transform = CGAffineTransform.identity //Con identity le das el tamaño original que le has dado en el storyboard
        })
        */
        
        //PARA QUE PEGUE UN SALTO
        /* UIView.animate(withDuration: 0.9, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
                self.contenedorView.transform = CGAffineTransform.identity
            }, completion: nil)
        */
//    
//        UIView.animate(withDuration: 0.7, animations: {
//            self.contenedorView.transform = CGAffineTransform.init(translationX: 0, y: 0)
//        })
        
        UIView.animate(withDuration: 0.3, animations: {
        self.contenedorView.transform  = CGAffineTransform.identity})
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
