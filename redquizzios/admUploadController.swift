
import UIKit

class admUploadController: UIViewController ,UIPickerViewDelegate, UIPickerViewDataSource{
    
//outlets
    
    @IBOutlet weak var preguntaText: UITextField!
    @IBOutlet weak var categoriaPicker: UIPickerView!
    @IBOutlet weak var puntajeText: UITextField!
    @IBOutlet weak var correctaText: UITextField!
    @IBOutlet weak var incorrecta1Text: UITextField!
    @IBOutlet weak var incorrecta2Text: UITextField!
    @IBOutlet weak var incorrecta3Text: UITextField!
    @IBOutlet weak var msgLbl: UILabel!
    
    let categorias = ["Signos Vitales", "Curación", "Síntomas", "Anatomía", "Bonus"]
    
    var count = 0
    
    let gameViewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriaPicker.delegate = self
        categoriaPicker.dataSource = self

    }
    
override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
   //buttons
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
//actions
    
    @IBAction func updload(_ sender: Any) {
        self.msgLbl.text = ""
        let categoria = categorias[categoriaPicker.selectedRow(inComponent: 0)]
        
            guard let pregunta = preguntaText.text, !pregunta.isEmpty,
                  let correcta = correctaText.text, !correcta.isEmpty,
                  let incorrecta1 = incorrecta1Text.text, !incorrecta1.isEmpty,
                  let incorrecta2 = incorrecta2Text.text, !incorrecta2.isEmpty,
                  let incorrecta3 = incorrecta3Text.text, !incorrecta3.isEmpty,
                  let puntajeText = puntajeText.text, !puntajeText.isEmpty
                  
            else {
                self.msgLbl.textColor = UIColor.red
                self.msgLbl.text = "Por favor, completa todos los campos."
                return
            }
        
        gameViewModel.createQuestion(pregunta: pregunta, categoria: categoria, correcta: correcta, incorrecta1: incorrecta1, incorrecta2: incorrecta2, incorrecta3: incorrecta3, puntos: Int(puntajeText) ?? 5){
            self.preguntaText.text = ""
            self.correctaText.text = ""
            self.incorrecta1Text.text = ""
            self.incorrecta2Text.text = ""
            self.incorrecta3Text.text = ""
            self.puntajeText.text = ""
            self.msgLbl.textColor = UIColor.green
            self.msgLbl.text = "Pregunta agregada correctamente (\(self.count)"
            self.count += 1

            
        }
        
        
    }
    
}
