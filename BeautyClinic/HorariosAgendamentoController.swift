//
//  HorariosViewController.swift
//  BeautyClinic
//
//  Created by Arthur on 18/01/17.
//  Copyright © 2017 Matheus Nonaka. All rights reserved.
//

import UIKit

class HorariosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var datePIcker: UIDatePicker!
    @IBOutlet var tableView: UITableView!
    @IBAction func changePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-M-yyyy"
        let date = dateFormatter.stringFromDate(sender.date)
        getHorarios(self.produto.codigo, date: date)
    }
    
    var codCliente: Int = 0
    var listHorarios: Array<Horario> = []
    var produto: Produto!
    var horarioSel: String = ""
    let model = NovoAgendamentoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //        let xib = UINib(nibName: "CarrinhoCell", bundle: nil)
        //        self.tableHorarios.registerNib(xib, forCellReuseIdentifier: "cell")
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-M-yyyy"
        let date = dateFormatter.stringFromDate(self.datePIcker.date)
        getHorarios(self.produto.codigo, date: date)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func getHorarios(codProduto: Int, date: String) {
        AgendamentoService.getHorarios({ (horarios: Array<Horario>, error: NSError!) in
            if(error != nil){
                Alerta.alerta("Erro", mensagem: "Erro de conexão", viewController: self)
            } else {
                self.listHorarios = horarios
                self.tableView.reloadData()
            }
            }, codProcedimento: codProduto, data: date)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listHorarios.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        cell.textLabel?.text = listHorarios[indexPath.row].horarioInicial
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.model.data = listHorarios[indexPath.row].horarioInicial
        self.performSegueWithIdentifier("detailSegue", sender: model)
    }
    
    // This function is called before the segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detalheNovoAgendamento = segue.destinationViewController as! DetalheNovoAgendamentoController
        detalheNovoAgendamento.model = self.model
    }
    
}
