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
    @IBOutlet var tableView: UITableView!
    
    @IBInspectable var cornerRadius: CGFloat = 2
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.blackColor()
    @IBInspectable var shadowOpacity: Float = 0.5
  
    var list = Array<String>()
    
    @IBAction func funcBack(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    @IBAction func funcFinalizar(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dao = CarrinhoDAO()
        self.list = dao.loadProducts();
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let xib = UINib(nibName: "CarrinhoCell", bundle: nil)
        self.tableView.registerNib(xib, forCellReuseIdentifier: "cell")
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CarrinhoCell
        
        createCardEffect(cell.cardView)
        
        let content = list[indexPath.row]
        var contentArray = content.characters.split(";").map(String.init)
        
        cell.descricao?.text = contentArray[1]
        cell.quantidade?.text = contentArray[2]
        cell.valor?.text = contentArray[3]
       
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func createCardEffect(view: UIView) {
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = false
        view.layer.shadowColor = shadowColor?.CGColor
        view.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        view.layer.shadowOpacity = shadowOpacity
    }
}
