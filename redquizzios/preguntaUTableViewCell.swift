//
//  preguntaUTableViewCell.swift
//  redquizzios
//
//  Created by Administrador on 21/11/23.
//

import UIKit

class preguntaUTableViewCell: UITableViewCell {
    
    var delegate: QuestionTableViewCellDelegate?
    
    @IBOutlet weak var categoriaLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    var questionID = ""
    
    
    let gameViewModel = GameViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func editQuestion(_ sender: Any) {
        print("edit, id:", questionID)
        delegate?.performSegueUpdt(id: questionID)
    }
    
    @IBAction func deleteQuestion(_ sender: Any) {
        delegate!.deleteAsk(id: questionID) { [weak self] (shouldDelete) in
            guard let self = self else { return }
            
            if shouldDelete {
                self.gameViewModel.deleteQuestion(id: self.questionID) {
                    self.delegate?.deletedQuestion(id: self.questionID)
                }
            }
        }
    }
}
