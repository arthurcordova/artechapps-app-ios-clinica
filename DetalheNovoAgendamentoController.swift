//
//  DetalheNovoAgendamentoController.swift
//  BeautyClinic
//
//  Created by Arthur on 19/02/17.
//  Copyright © 2017 Matheus Nonaka. All rights reserved.
//

import UIKit

class DetalheNovoAgendamentoController: UIViewController {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var dateTime: UILabel!
    @IBOutlet var status: UILabel!
    
    var model: NovoAgendamentoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateTime.text = model?.data
        
   
    }
}
