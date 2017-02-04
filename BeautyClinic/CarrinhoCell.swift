//
//  CarrinhoCell.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 10/18/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import Foundation
import UIKit

class CarrinhoCell: UITableViewCell {
    
    @IBOutlet var cardView: UIView!
    @IBOutlet var descricao: UILabel!
    @IBOutlet var quantidade: UILabel!
    @IBOutlet var valor: UILabel!
    
    @IBAction func add(sender: AnyObject) {
    }
   
    @IBAction func remove(sender: AnyObject) {
    }
    
    @IBOutlet var removeAll: UIButton!
    
}
