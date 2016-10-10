//
//  OrcamentoViewController.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 7/14/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import UIKit

class OrcamentoViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var codCliente: String = "0"
    var orcamentos: Array<Orcamento> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.setNavigationBarHidden(false, animated: false)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let xib = UINib(nibName: "OrcamentoCell", bundle: nil)
        self.tableView.registerNib(xib, forCellReuseIdentifier: "cell")
        
        getOrcamentos(codCliente)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_animated: Bool) {
        super.viewWillAppear(_animated)        
        self.title = "Orçamentos"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orcamentos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            
            let cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! OrcamentoCell
            let linha = indexPath.row
            let orcamento = self.orcamentos[linha]
            
            cell.codOrcamento.text = "Código: \(orcamento.codigo)"
            cell.dataOrcamento.text = "Data: " + orcamento.data
            cell.valorOrcamento.text = "Valor: R$ \(orcamento.valorTotal - orcamento.desconto)"
            
            return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let linha = indexPath.row
        let orcamento = self.orcamentos[linha]
        
        let detalheView = DetalheOrcViewController(nibName: "DetalheOrcViewController", bundle: nil)
        detalheView.codOrcamento = "\(orcamento.codigo)"
        self.navigationItem.title = ""
        self.navigationController!.pushViewController(detalheView, animated: true)
        
    }
    
    func getOrcamentos(codCliente: String) {
        
        OrcamentoService.getOrcamentos({(orcamentos: Array<Orcamento>, error: NSError!) in
            if (error != nil) {
                if #available(iOS 8.0, *) {
                    Alerta.alerta("Erro", mensagem: "erro", viewController: self)
                } else {
                    // Fallback on earlier versions
                }
            } else {
                self.orcamentos = orcamentos
                self.tableView.reloadData()
                
            }
        }, codCliente: codCliente)
        
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        let moreRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Opções", handler:{action, indexpath in
            
            let alertController = UIAlertController(title: "Opções do orçamento", message: "", preferredStyle: .ActionSheet)
            
            let ok = UIAlertAction(title: "Confirmar", style: .Default, handler: { (action) -> Void in
                print("Ok Button Pressed")
            })
            
            let cancel = UIAlertAction(title: "Cancelar", style: .Cancel, handler: { (action) -> Void in
                print("Cancel Button Pressed")
            })
            
            alertController.addAction(ok)
            alertController.addAction(cancel)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        });
        moreRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
        
        let deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Excluir", handler:{action, indexpath in
            print("DELETE•ACTION");
        });
        
        return [deleteRowAction, moreRowAction];
    }

}
