//
//  DetalheAgendamentoController.swift
//  BeautyClinic
//
//  Created by Arthur on 07/02/17.
//  Copyright © 2017 Matheus Nonaka. All rights reserved.
//

import UIKit

class DetalheAgendamentoController: UIViewController {
    
    @IBOutlet var labelProcedimento: UILabel!
    @IBOutlet var labelDataHorario: UILabel!
    @IBOutlet var labelStatus: UILabel!
    
    var agendamento: Agendamento! = nil
    
    override func viewDidLoad() {
        
        labelProcedimento.text = agendamento.descProcedimento
        labelDataHorario.text = agendamento.data
        labelStatus.text = agendamento.status
        
    }
}
