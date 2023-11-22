
import UIKit

class admCrudController: UIViewController, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, QuestionTableViewCellDelegate{
    
    
    
    
    
    
    
    //outlets
    @IBOutlet weak var questionsTable: UITableView!
    @IBOutlet weak var categoriaPicker: UIPickerView!
    var questions = [Question]()
    
    let categorias = ["Todas", "Signos Vitales", "Curación", "Síntomas", "Anatomía", "Bonus"]
    
    let gameViewModel = GameViewModel()
    var viewControllerSegue: UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriaPicker.delegate = self
        categoriaPicker.dataSource = self
        gameViewModel.fetchData {
            self.questionsTable.dataSource = self
            self.questions = self.gameViewModel.questions
            let nib = UINib(nibName: "preguntaUTableViewCell", bundle: nil)
            self.questionsTable.register(nib, forCellReuseIdentifier: "preguntaCelda")
            self.questionsTable.estimatedRowHeight = 104.0
            
            DispatchQueue.main.async {
                self.view.layoutIfNeeded()
                self.questionsTable.reloadData()
            }
            
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = questionsTable.dequeueReusableCell(withIdentifier: "preguntaCelda", for: indexPath) as! preguntaUTableViewCell
        let question = questions[indexPath.row]
        
        cell.categoriaLbl.text = question.categoria
        cell.questionLbl.text = question.pregunta
        cell.questionID = question.id
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Devuelve la altura deseada para la celda en la posición indexPath
        return UITableView.automaticDimension// Ajusta este valor según tus necesidades
    }
    
    func deletedQuestion(id: String) {
        // Lógica para actualizar self.questions, por ejemplo, eliminar la pregunta correspondiente
        
        
        let alertController = UIAlertController(title: "Pregunta Eliminada", message: "Pregunta eliminada exitosamente, id de pregunta: \(id)", preferredStyle: .alert)
        
        // Agregar acciones (botones) a la alerta
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            // Código a ejecutar cuando se presiona el botón OK
            DispatchQueue.main.async {
                if let index = self.questions.firstIndex(where: { $0.id == id }) {
                    self.questions.remove(at: index)
                }
                self.questionsTable.reloadData()
            }
            
        }
        
        alertController.addAction(okAction)
        
        // Mostrar la alerta
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    func deleteAsk(id: String, completion: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "Eliminar Pregunta", message: "¿Quiere eliminar la pregunta con el id: \(id)?", preferredStyle: .alert)
        
        // Agregar acciones (botones) a la alerta
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { _ in
            completion(false)
        }
        alertController.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Eliminar", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            
            // Lógica para eliminar la pregunta
            completion(true)
        }
        alertController.addAction(deleteAction)
        
        // Mostrar la alerta
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func performSegueUpdt(id: String) {
        self.performSegue(withIdentifier: "updateCrudSegue", sender: id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateCrudSegue" {
            if let id = sender as? String, let destinationVC = segue.destination as? admEditController {
                destinationVC.questionID = id
            }
        }
    }
}

protocol QuestionTableViewCellDelegate: AnyObject {
    func deletedQuestion(id: String)
    func deleteAsk(id: String, completion: @escaping (Bool) -> Void)
    func performSegueUpdt(id: String)
}
