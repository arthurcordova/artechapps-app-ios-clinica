//
//  VendaViewController.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 6/22/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import UIKit

class VendaViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var vendas: Array<Venda> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Minhas compras"
        self.navigationController!.setNavigationBarHidden(false, animated: false)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let xib = UINib(nibName: "VendaCell", bundle: nil)
        self.tableView.registerNib(xib, forCellReuseIdentifier: "cell")
        
        //self.vendas = VendaService.getVendas("1234")
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vendas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            
            let cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! VendaCell
            let linha = indexPath.row
            let venda = self.vendas[linha]
            
            cell.dataVenda.text = venda.data
            cell.valorVenda.text = venda.valorTotal
            
            return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if #available(iOS 8.0, *) {
            Alerta.alerta("Detalhes", mensagem: "Desc venda", viewController: self)
        } else {
            // Fallback on earlier versions
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
