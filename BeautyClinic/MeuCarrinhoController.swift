//
//  MeuCarrinhoController.swift
//  BeautyClinic
//
//  Created by Arthur on 30/01/17.
//  Copyright © 2017 Matheus Nonaka. All rights reserved.
//

import UIKit

class MeuCarrinhoController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var lblValor: UILabel!
    
    
    @IBAction func funcBack(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    @IBAction func funcFinalizar(sender: AnyObject) {
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAt indexPath: NSIndexPath) -> UITableViewCell {
//        let cell:FilmeCellTableViewCell = table.dequeueReusableCell(withIdentifier: cellIdentifier) as! FilmeCellTableViewCell!
//        let filme = self.filmes[indexPath.row] as Filme
//        cell.titulo?.text = filme.titulo
//        cell.subtitulo?.text = filme.subTitulo
//        cell.duracao?.text = filme.duracao
//        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAt indexPath: NSIndexPath) {
//        let filme = filmes[indexPath.row]
//        let addAlerta = UIAlertController(title: "Remover", message: "Deseja remover o filme " + filme.titulo + " dos favoritos ?", preferredStyle: UIAlertControllerStyle.alert)
//        addAlerta.addAction(UIAlertAction(title: "Sim", style: .default, handler: { (action: UIAlertAction!) in
//            Favorito.Data.filmes.remove(at: indexPath.row)
//            self.filmes = Favorito.Data.filmes
//            self.table.reloadData()
//            
//        }))
//        
//        addAlerta.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))
//        present(addAlerta, animated: true, completion: nil)
//        self.table.deselectRow(at: indexPath, animated:true)
        
    }
    
}
