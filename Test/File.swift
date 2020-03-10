//
//  File.swift
//  Test
//
//  Created by Владислав on 3/10/20.
//  Copyright © 2020 Владислав. All rights reserved.
//

import Foundation
import UIKit


struct Result   : Decodable {
    var results : [Character]
   
}
struct Character : Decodable {
    var id       :   Int
    var name     :   String
    var status   :   String
    var gender   :   String
    var species  :  String
    var image    :   String
}

