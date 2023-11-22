
import UIKit

class admEditController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
//outlets

    @IBOutlet weak var incorrecta3Lbl: UITextField!
    @IBOutlet weak var incorrecta2Lbl: UITextField!
    @IBOutlet weak var incorrecta1Lbl: UITextField!
    @IBOutlet weak var correctaLbl: UITextField!
    @IBOutlet weak var puntosLbl: UITextField!
    @IBOutlet weak var categoriaPicker: UIPickerView!
    @IBOutlet weak var preguntaLbl: UITextField!
    
    @IBOutlet weak var msgLbl: UILabel!
    var questionID = ""
    var count = 0
    
    let categorias = ["Signos Vitales", "Curación", "Síntomas", "Anatomía", "Bonus"]
    var selectedQuestionCategory = ""
    
    let gameViewModel = GameViewModel()
    override func viewDidLoad() {
            super.viewDidLoad()
            
            categoriaPicker.delegate = self
            categoriaPicker.dataSource = self
            
            gameViewModel.fetchData {
                let questions = self.gameViewModel.questions
                if let question = questions.first(where: { $0.id == self.questionID }) {
                    // Actualizar la categoría seleccionada con la categoría de la pregunta
                    self.selectedQuestionCategory = question.categoria
                    self.preguntaLbl.text = question.pregunta
                    self.puntosLbl.text = String(question.puntos)
                    self.correctaLbl.text = question.correcta
                    self.incorrecta1Lbl.text = question.incorrecta1
                    self.incorrecta2Lbl.text = question.incorrecta2
                    self.incorrecta3Lbl.text = question.incorrecta3
                }
                // Recargar el componente seleccionado del UIPickerView
                self.categoriaPicker.reloadAllComponents()
                if let categoryIndex = self.categorias.firstIndex(of: self.selectedQuestionCategory) {
                    self.categoriaPicker.selectRow(categoryIndex, inComponent: 0, animated: false)
                }
            }
        }
    
override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
   //buttons
    }
//actions
    
    @IBAction func updateBtn(_ sender: Any) {
        let categoria = categorias[categoriaPicker.selectedRow(inComponent: 0)]
        gameViewModel.updateQuestion(id: questionID, pregunta: preguntaLbl.text ?? "", categoria: categoria, correcta: correctaLbl.text ?? "", incorrecta1: incorrecta1Lbl.text ?? "", incorrecta2: incorrecta2Lbl.text ?? "", incorrecta3: incorrecta3Lbl.text ?? "", puntos: Int(puntosLbl.text!) ?? 0){
           
            print("Pregunta actualizada")
            self.msgLbl.text = "Pregunta Actualizada Correctamente (\(self.count))"
            self.count += 1
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorias.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorias[row]
    }
    
}
