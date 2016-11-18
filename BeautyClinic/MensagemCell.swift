//
//  MensagemCell.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 9/14/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import Foundation
import UIKit

class MensagemCell: UITableViewCell {
    
    @IBOutlet var titulo: UILabel!
    @IBOutlet var data: UILabel!
    @IBOutlet var Msg: UILabel!
    
    var id: Int = 0
    var mensagem: String = ""

    
}
