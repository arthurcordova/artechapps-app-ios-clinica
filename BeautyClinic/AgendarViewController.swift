//
//  AgendarViewController.swift
//  BeautyClinic
//
//  Created by Matheus Nonaka on 9/12/15.
//  Copyright (c) 2015 Matheus Nonaka. All rights reserved.
//

import UIKit

class AgendarViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITextFieldDelegate, UtilProtocol {
    
    @IBOutlet var tfData: UITextField!
    @IBOutlet var tfProcedimento: UITextField!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tfMedico: UITextField!
    @IBOutlet var lbMedico: UILabel!
    @IBOutlet var lbHorario: UILabel!
    @IBOutlet var cvHorarios: UICollectionView!
    
    var codCliente: Int = 0
    var horarios: Array<Horario> = []
    var produto: Produto = Produto()
    var horarioSel: String = ""
    
    var selectedCellIndexPath : NSIndexPath? {
        didSet {
            var indexPaths = [NSIndexPath]()
            if selectedCellIndexPath != nil {
                indexPaths.append(selectedCellIndexPath!)
            }
            if oldValue != nil {
                indexPaths.append(oldValue!)
            }
            
            collectionView?.performBatchUpdates({self.collectionView?.reloadItemsAtIndexPaths(indexPaths)
                return
                }){
                    completed in
                    if self.selectedCellIndexPath != nil {
                        self.collectionView?.scrollToItemAtIndexPath(
                            self.selectedCellIndexPath!,
                            atScrollPosition: .CenteredVertically,
                            animated: false)
                    }
            }
        }
    }

    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
            if selectedCellIndexPath == indexPath {
                selectedCellIndexPath = nil
            }
            else {
                selectedCellIndexPath = indexPath
            }
            return false
    }

    @IBAction func selecionarData(sender: AnyObject) {
        DatePickerDialog().show("Selecione uma data", doneButtonTitle: "OK", cancelButtonTitle: "Cancelar", datePickerMode: .Date) {
            (date) -> Void in
            let formatter = NSDateFormatter()
            formatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("MMddyyyy", options: 0, locale: NSLocale(localeIdentifier: "pt-BR"))
            self.tfData.text = formatter.stringFromDate(date)
            
            if (self.tfProcedimento.text != "" && self.tfData.text != "") {
                if #available(iOS 8.0, *) {
                    self.getHorariosLivres(self.produto.codigo, data: self.tfData.text!)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
    
    @IBAction func selecionarProduto(sender: AnyObject) {
        self.tfProcedimento.resignFirstResponder()
        let pesquisaProdView = PesquisaProdViewController(nibName: "PesquisaProdViewController", bundle: nil)
        pesquisaProdView.delegate = self
        self.title = ""
        self.navigationController!.pushViewController(pesquisaProdView, animated: false)
    }
    
    @IBAction func agendar(sender: AnyObject) {
        
        let agendamento = Agendamento()
        agendamento.codFilial = 3
        agendamento.codCliente = self.codCliente
        agendamento.codProcedimento = self.produto.codigo
        agendamento.descProcedimento = self.tfProcedimento.text!
        agendamento.data = self.tfData.text!
        agendamento.horario = self.horarioSel
        
        AgendamentoService.agendar(agendamento)
        self.navigationController?.popViewControllerAnimated(false) 


    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let strData = textField.text!.stringByReplacingOccurrencesOfString("/", withString: "", options:NSStringCompareOptions.LiteralSearch, range: nil)
        
        if (textField.text!.isEmpty) {
            return true
        }
        
        switch strData.characters.count {
        case 2,4:
            if (string != "") && (!textField.text!.hasSuffix("/")) {
                textField.text = textField.text!+"/"
            }
            return true
        case 8:
            if (string != "") {
                return false
            } else {
                return true
            }
        default: true
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.tfData.resignFirstResponder()
        if (self.tfProcedimento.text != "" && self.tfData.text != "") {
            if #available(iOS 8.0, *) {
                self.getHorariosLivres(self.produto.codigo, data: self.tfData.text!)
            } else {
                // Fallback on earlier versions
            }
            return true
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Agendar"
        self.navigationController!.setNavigationBarHidden(false, animated: false)
        
        let xib = UINib(nibName: "HorarioCell", bundle: nil)
        collectionView.registerNib(xib, forCellWithReuseIdentifier: "cell")
        
        self.tfData.delegate = self
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return horarios.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! HorarioCell
        let linha = indexPath.row
        let horario = self.horarios[linha]
        
        cell.horario.text = (horario.horarioInicial as NSString).substringToIndex(5)
        cell.codSala = horario.codSala
        cell.intervaloMin = horario.intervaloMin
        
        if indexPath == selectedCellIndexPath {
          cell.horario.backgroundColor = UIColor.purpleColor()
          cell.horario.textColor = UIColor.whiteColor()
          self.horarioSel = cell.horario.text!
        } else {
          cell.horario.backgroundColor = UIColor.whiteColor()
          cell.horario.textColor = UIColor.purpleColor()
        }
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let linha = indexPath.row
        let horario = self.horarios[linha]
        self.horarioSel = horario.horarioInicial
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_animated: Bool) {
        super.viewWillAppear(_animated)
        
        self.title = "Agendar"
        if (self.produto.codigo > 0) {
            self.tfProcedimento.text = "\(self.produto.descricao)"
        }
        if (self.produto.tipoExame == "M") {
            tfMedico.enabled = true
            lbMedico.enabled = true
        } else {
            tfMedico.enabled = false
            lbMedico.enabled = false
        }
    }
    
    @available(iOS 8.0, *)
    func getHorariosLivres(codProcedimento: Int, data: String) {
        
        AgendamentoService.getHorarios({(horarios: Array<Horario>, error: NSError!) in
            if (error != nil) {
                Alerta.alerta("Erro", mensagem: "erro", viewController: self)
            } else {
                self.horarios = horarios
                self.collectionView.reloadData()
                
            }
        }, codProcedimento: codProcedimento, data: data)
        
    }
    
    func saveProdForPreviousVC(data: Produto) {
        self.produto = data
    }
    
}
