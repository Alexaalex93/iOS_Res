//
//  Restaurante.swift
//  Eat-ing
//
//  Created by Pablo Mateo Fernández on 13/12/2016.
//  Copyright © 2016 355 Berry Street S.L. All rights reserved.
//

import Foundation

class Restaurante {
    
    // Propiedades
    var nombre = ""
    var tipo = ""
    var localizacion = ""
    var imagen = ""
    var visitado = false
    var valoracion = ""
    
    init(name: String, type: String, location: String, image: String, isVisited: Bool) {
        nombre = name
        self.tipo = type
        self.localizacion = location
        self.imagen = image
        self.visitado = isVisited
        
    }
    
}
