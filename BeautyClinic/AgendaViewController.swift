//
//  AgendaViewController.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 6/20/15.
//  Copyright (c) 2015 Arthur Cordova. All rights reserved.
//

import UIKit

class AgendaViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var agendamentos: Array<Agendamento> = []
    var codCliente: String = ""
    var cliente : Cliente!
    
    func novoAgendamento(BtnPsgVar: UIBarButtonItem)
    {
        let agendar = NovoAgendamento(nibName: "NovoAgendamento", bundle: nil)
        self.navigationController!.pushViewController(agendar, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn1 = UIButton()
        btn1.setImage(UIImage(named: "ico_date"), forState: .Normal)
        btn1.frame = CGRectMake(0, 0, 30, 30)
        btn1.addTarget(self, action: Selector("action1:"), forControlEvents: .TouchUpInside)
        let item1 = UIBarButtonItem()
        item1.customView = btn1
        
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
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.backItem?.title = " "

        let rightButtonItem = UIBarButtonItem.init(
            title: "Novo",
            style: .Done,
            target: self,
            action: #selector(AgendaViewController.rightButtonAction(_:))
        )
        
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
    }
    
    func rightButtonAction(sender: UIBarButtonItem) {
        let novoAgendamento = ProdutoViewController(nibName: "ProdutoViewController", bundle: nil)
//        let cliente: Cliente = Cliente()
//        cliente.codCliente = codigo
//        cliente.nome = defaults.objectForKey("nome") as! String
//        dash.cliente = Cliente()
//        dash.cliente = cliente
        self.navigationController!.pushViewController(novoAgendamento, animated: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.navigationItem.setRightBarButtonItem(nil, animated: true)
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
