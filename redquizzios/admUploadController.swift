
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
    
    let gameViewModel = GameViewModel()
    
    var msgSwitch = false
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
        let pregunta = preguntaText.text!
        let categoria = categorias[categoriaPicker.selectedRow(inComponent: 0)]
        let correcta = correctaText.text!
        let incorrecta1 = incorrecta1Text.text!
        let incorrecta2 = incorrecta2Text.text!
        let incorrecta3 = incorrecta3Text.text!
        let puntajeText = puntajeText.text!
        
        gameViewModel.createQuestion(pregunta: pregunta, categoria: categoria, correcta: correcta, incorrecta1: incorrecta1, incorrecta2: incorrecta2, incorrecta3: incorrecta3, puntos: Int(puntajeText) ?? 5){
            self.preguntaText.text = ""
            self.correctaText.text = ""
            self.incorrecta1Text.text = ""
            self.incorrecta2Text.text = ""
            self.incorrecta3Text.text = ""
            self.puntajeText.text = ""
            self.msgLbl.text = "Pregunta agregada correctamente"
            self.msgSwitch = !self.msgSwitch
            if self.msgSwitch{
                self.msgLbl.textColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
            } else {
                self.msgLbl.textColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 5.0)
            }
            
        }
        
        
    }
    
}
