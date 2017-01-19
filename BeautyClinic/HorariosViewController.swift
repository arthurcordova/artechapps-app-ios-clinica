//
//  HorariosViewController.swift
//  BeautyClinic
//
//  Created by Arthur on 18/01/17.
//  Copyright © 2017 Matheus Nonaka. All rights reserved.
//

import UIKit

class HorariosViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UITextFieldDelegate, UtilProtocol {
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var gridHorarios: UICollectionView!
    
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
           
            gridHorarios?.performBatchUpdates({self.gridHorarios?.reloadItemsAtIndexPaths(indexPaths)
                return
            }){
                completed in
                if self.selectedCellIndexPath != nil {
                    self.gridHorarios?.scrollToItemAtIndexPath(
                        self.selectedCellIndexPath!,
                        atScrollPosition: .CenteredVertically,
                        animated: true)
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


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
}
