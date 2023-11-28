
import UIKit

class admEditController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
//outlets
    deinit {
        // Liberar notificaciones
        NotificationCenter.default.removeObserver(self)
    }

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
        agregarGestorDeTapParaOcultarTeclado()
            
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
    
//actions
    
    @IBAction func updateBtn(_ sender: Any) {
        self.msgLbl.text = ""
        let categoria = categorias[categoriaPicker.selectedRow(inComponent: 0)]
        
            guard let pregunta = preguntaLbl.text, !pregunta.isEmpty,
                  let correcta = correctaLbl.text, !correcta.isEmpty,
                  let incorrecta1 = incorrecta1Lbl.text, !incorrecta1.isEmpty,
                  let incorrecta2 = incorrecta2Lbl.text, !incorrecta2.isEmpty,
                  let incorrecta3 = incorrecta3Lbl.text, !incorrecta3.isEmpty,
                  let puntajeText = puntosLbl.text, !puntajeText.isEmpty
                  
            else {
                self.msgLbl.textColor = UIColor.red
                self.msgLbl.text = "Por favor, completa todos los campos."
                return
            }
        gameViewModel.updateQuestion(id: questionID, pregunta: pregunta, categoria: categoria, correcta: correcta, incorrecta1: incorrecta1, incorrecta2: incorrecta2, incorrecta3: incorrecta3, puntos: Int(puntajeText) ?? 0){
           
            print("Pregunta actualizada")
            self.msgLbl.textColor = UIColor.green
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
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = categorias[row]
        let color = UIColor.white // Cambia aquí al color que desees, por ejemplo UIColor.white para texto blanco
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color
        ]
        return NSAttributedString(string: title, attributes: attributes)
    }
    
}
