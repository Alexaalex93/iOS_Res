//
//  ViewController.swift
//  Eat-ing
//
//  Created by Pablo Mateo Fernández on 13/12/2016.
//  Copyright © 2016 355 Berry Street S.L. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var restaurantNames = ["Vips", "Ginos", "Zalacaín", "Diverxo", "La Bola", "Tanteo", "Daltea", "La Ancha", "Vait", "Fridays", "Opera", "Alizaque", "Panza", "El molino", "Catorce", "La casa de Pi", "Ochenta", "Nachismes", "Rico rico", "Arguiñano", "Dani García"]
    
    var restaurantImages = ["resta001","resta002","resta003","resta004","resta005","resta006","resta007","resta008","resta009","resta0010","resta0011","resta0012","resta0013","resta0014","resta0015","resta0016","resta0017","resta0018","resta0019","resta0020","resta0021"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Table View Protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = restaurantNames[indexPath.row]
        cell.imageView?.image = UIImage(named: restaurantImages[indexPath.row])
        
        return cell
    }
    
    //Hide Statuss Bar
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

