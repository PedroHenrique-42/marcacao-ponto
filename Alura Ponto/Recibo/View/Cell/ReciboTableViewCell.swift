//
//  ReciboTableViewCell.swift
//  Alura Ponto
//
//  Created by Ândriu Felipe Coelho on 23/09/21.
//

import UIKit

protocol ReciboTableViewCellDelegate: AnyObject {
    func deletarRecibo(_ index: Int)
}

class ReciboTableViewCell: UITableViewCell {
    
    // MARK: - Atributos
    
    weak var delegate: ReciboTableViewCellDelegate?
    
    private var corSucessoLabel = UIColor(red: 52.0/255.0, green: 199.0/255.0, blue: 89.0/255.0, alpha: 1)
    private var corFalhaLabel = UIColor(red: 215.0/255.0, green: 59.0/255.0, blue: 48.0/255.0, alpha: 1)
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var deletarButton: UIButton!
    
    // MARK: - Class methods
    
    func configuraCelula(_ recibo: Recibo?) {
        statusLabel.text = recibo?.status == true ? "SINCRONIZADO" : "NÃO SINCRONIZADO"
        statusLabel.textColor = recibo?.status == true ? corSucessoLabel : corFalhaLabel
        
        let formatadorDeData = FormatadorDeData()
        dataLabel.text = formatadorDeData.getData(recibo?.data ?? Date())
        deletarButton.setTitle("", for: .normal)
    }
    
    @IBAction func botaoDeletar(_ sender: UIButton) {
        delegate?.deletarRecibo(sender.tag)
    }
    
}
