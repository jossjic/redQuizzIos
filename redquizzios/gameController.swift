
import UIKit

class gameController: UIViewController {//outlets
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var barTimer: UIProgressView!
    @IBOutlet weak var categoriaLbl: UILabel!
    
    
    let viewModel = GameViewModel()
    var allQuestions: [Question] = []
    var pregunta = ""
    var categoria = ""
    var correcta = ""
    var incorrecta1 = ""
    var incorrecta2 = ""
    var incorrecta3 = ""
    var puntos = 0
    
    var currentQuestionIndex = 0
    var timer: Timer?
    
    var currentQuestion = Question(categoria: "", correcta: "", incorrecta1: "", incorrecta2: "", incorrecta3: "", pregunta: "", puntos: 0)
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            viewModel.fetchData {
                print("dataFetched")
                self.allQuestions = self.viewModel.questions
                self.allQuestions.shuffle()
                self.startQuestionTimer()
            }
        }

        func startQuestionTimer() {
            // Configurar y comenzar el temporizador
            timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(showNextQuestion), userInfo: nil, repeats: true)
            
            // Mostrar la primera pregunta inmediatamente al iniciar la vista
            showNextQuestion()
        }

        @objc func showNextQuestion() {
            // Verificar si quedan más preguntas
            guard currentQuestionIndex < allQuestions.count else {
                // Detener el temporizador si no hay más preguntas
                timer?.invalidate()
                return
            }

            // Obtener la pregunta actual
            let pregunta = allQuestions[currentQuestionIndex]

            // Cargar y mostrar la pregunta
            loadQuestion(preguntaI: pregunta)
            updateLocalData(preguntaI: pregunta)

            // Incrementar el índice de la pregunta actual
            currentQuestionIndex += 1
        }
    
    func loadQuestion(preguntaI: Question) {
        var respuestas = [preguntaI.correcta, preguntaI.incorrecta1, preguntaI.incorrecta2, preguntaI.incorrecta3].shuffled()

        btn1.setTitle(respuestas.popLast(), for: .normal)
        btn2.setTitle(respuestas.popLast(), for: .normal)
        btn3.setTitle(respuestas.popLast(), for: .normal)
        btn4.setTitle(respuestas.popLast(), for: .normal)

        questionLbl.text = preguntaI.pregunta
        categoriaLbl.text = preguntaI.categoria
    }
    
    func updateLocalData(preguntaI: Question){
        pregunta = preguntaI.pregunta
        categoria = preguntaI.categoria
        correcta = preguntaI.correcta
        incorrecta1 = preguntaI.incorrecta1
        incorrecta2 = preguntaI.incorrecta2
        incorrecta3 = preguntaI.incorrecta3
        puntos = preguntaI.puntos
    }

}
