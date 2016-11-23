//
//  AgendaViewController.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 6/20/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import UIKit

class AgendaViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var agendamentos: Array<Agendamento> = []
    var codCliente: String = ""
    var cliente : Cliente!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Agendamentos"
        self.navigationController!.setNavigationBarHidden(false, animated: false)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let xib = UINib(nibName: "AgendaCell", bundle: nil)
        self.tableView.registerNib(xib, forCellReuseIdentifier: "cell")
        
        self.codCliente = String(cliente.codCliente)
        getAgendamentos(self.codCliente)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agendamentos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            
            let cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! AgendaCell
            let linha = indexPath.row
            let agendamento = self.agendamentos[linha]
            
            cell.descAgenda.text = agendamento.descProcedimento
            cell.dataAgenda.text = "Data: " + agendamento.data + "  Horário: " + agendamento.horario
            
            return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if #available(iOS 8.0, *) {
            Alerta.alerta("Detalhes", mensagem: "Desc procedimento", viewController: self)
        } else {
            // Fallback on earlier versions
        }
    }
    
    func getAgendamentos(codCliente: String) {
        
        AgendaService.getAgendamentos({(agendamentos: Array<Agendamento>, error: NSError!) in
            if (error != nil) {
                if #available(iOS 8.0, *) {
                    Alerta.alerta("Erro", mensagem: "erro", viewController: self)
                } else {
                    // Fallback on earlier versions
                }
            } else {
                self.agendamentos = agendamentos
                self.tableView.reloadData()
                
            }
            }, codCliente: codCliente)
        
    }

}
