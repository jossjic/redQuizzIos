
import UIKit

class gameController: UIViewController {//outlets
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var barTimer: UIProgressView!
    @IBOutlet weak var categoriaLbl: UILabel!
    @IBOutlet weak var vidas: UILabel!
    
    
    let gameViewModel = GameViewModel()
    let userViewModel = UserViewModel()
    var allQuestions: [Question] = []
    var pregunta = ""
    var categoria = ""
    var correcta = ""
    var incorrecta1 = ""
    var incorrecta2 = ""
    var incorrecta3 = ""
    var puntos = 0
    var vidasUser = 0
    
    var puntuacion = 0
    
    var currentQuestionIndex = 0
    var timer: Timer?
    
    var currentQuestion = Question(categoria: "", correcta: "", incorrecta1: "", incorrecta2: "", incorrecta3: "", pregunta: "", puntos: 0)
    
    var progressAnimator = UIViewPropertyAnimator()
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            gameViewModel.fetchData {
                print("dataFetched")
                
                self.allQuestions = self.gameViewModel.questions
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
            var switchB = false
            var switchLF = false
            // fetching and update lifes
            self.userViewModel.fetchData {
                let fUser = self.userViewModel.fetchedUser
                self.vidasUser = fUser.vidas
                self.vidas.text = "x " + String(self.vidasUser)
                
                if self.currentQuestionIndex >= self.allQuestions.count || self.vidasUser <= 0 {
                    print("Vidas:", self.vidasUser)
                    // Detener el temporizador si no hay más preguntas
                    self.timer?.invalidate()
                    switchB = true
                    if self.vidasUser <= 0{
                        
                    } else {
                        let alertController = UIAlertController(title: "Bien Hecho!", message: "Tu puntaje obtenido fue: "+String(self.puntuacion), preferredStyle: .alert)
                        self.userViewModel.updateScore(score: self.puntuacion, type: "general")
                        
                        // Agregar acciones (botones) a la alerta
                        let okAction = UIAlertAction(title: "Inicio", style: .default) { _ in
                            // Código a ejecutar cuando se presiona el botón OK
                            print("Botón OK presionado")
                        }
                        alertController.addAction(okAction)
                        
                        // Mostrar la alerta
                        self.present(alertController, animated: true, completion: nil)
                                          }
                    
                    
                             }
            
            // Verificar si quedan más preguntas
            
           
            }
            if switchB{
                if switchLF{
                    let alertController = UIAlertController(title: "Te quedaste sin vidas", message: "Espera un tiempo para volver a jugar :)", preferredStyle: .alert)
                    
                    // Agregar acciones (botones) a la alerta
                    let okAction = UIAlertAction(title: "Inicio", style: .default) { _ in
                        // Código a ejecutar cuando se presiona el botón OK
                        print("Botón OK presionado")
                    }
                    alertController.addAction(okAction)
                    
                    // Mostrar la alerta
                    self.present(alertController, animated: true, completion: nil)                } else{
                return switchLF
            }

            // Obtener la pregunta actual
            let pregunta = allQuestions[currentQuestionIndex]

            // Cargar y mostrar la pregunta
            updateLocalData(preguntaI: pregunta)
            loadQuestion(preguntaI: pregunta)
            print(puntuacion)
            

            // Incrementar el índice de la pregunta actual
            currentQuestionIndex += 1
            
            //Progress bar
            animateProgressBar()
            
            //Lifes Update
            
            
        }
    
    func animateProgressBar(){
        print("animation!")
        barTimer.progress = 0.0
        self.view.layoutIfNeeded()
        progressAnimator = UIViewPropertyAnimator(duration: 10, curve: .linear){
            self.barTimer.setProgress(1.0, animated: true)
        }
        progressAnimator.startAnimation()
        
        
    }

    func loadQuestion(preguntaI: Question) {
        var respuestas = [preguntaI.correcta, preguntaI.incorrecta1, preguntaI.incorrecta2, preguntaI.incorrecta3].shuffled()

        btn1.setTitle(respuestas.popLast(), for: .normal)
        btn2.setTitle(respuestas.popLast(), for: .normal)
        btn3.setTitle(respuestas.popLast(), for: .normal)
        btn4.setTitle(respuestas.popLast(), for: .normal)
        
        btn1.isEnabled = true
        btn2.isEnabled = true
        btn3.isEnabled = true
        btn4.isEnabled = true
      
        btn1.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
        btn2.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
        btn3.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
        btn4.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
        
        btn1.setTitleColor(UIColor.lightGray, for: .disabled)
        btn2.setTitleColor(UIColor.lightGray, for: .disabled)
        btn3.setTitleColor(UIColor.lightGray, for: .disabled)
        btn4.setTitleColor(UIColor.lightGray, for: .disabled)

        questionLbl.text = preguntaI.pregunta
        categoriaLbl.text = preguntaI.categoria
        
        
        
        if categoria == "Signos Vitales" {
            categoriaLbl.backgroundColor = UIColor(red: 0.729, green: 0.890, blue: 0.820, alpha: 1.0)
        } else if categoria == "Curación"{
            categoriaLbl.backgroundColor = UIColor(red: 1.000, green: 0.796, blue: 0.796, alpha: 1.0)
        } else if categoria == "Síntomas" {
            categoriaLbl.backgroundColor = UIColor(red: 0.788, green: 0.847, blue: 1.000, alpha: 1.0)
        }else if categoria == "Anatomía" {
            categoriaLbl.backgroundColor = UIColor(red: 1.000, green: 1.000, blue: 0.710, alpha: 1.0)
        }else {
            categoriaLbl.backgroundColor = UIColor(red: 0.788, green: 0.710, blue: 1.000, alpha: 1.0)
        }
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
    
    func resCorrecta(button:UIButton){
        button.backgroundColor = UIColor.green
        puntuacion += puntos
    }
    
    func resIncorrecta(button:UIButton){
        button.backgroundColor = UIColor.red
        puntuacion -= puntos
        if self.vidasUser>1{
            self.userViewModel.updateLives(newLives: vidasUser - 1)
            vidas.text = "x " + String(self.vidasUser - 1)
        } else {
            self.vidasUser = 0
            vidas.text = "x 0"
            self.userViewModel.updateLives(newLives: vidasUser)
        }
        
    }
    
    
    @IBAction func btn1Tap(_ sender: Any) {
        btn1.isEnabled = false
        btn2.isEnabled = false
        btn3.isEnabled = false
        btn4.isEnabled = false
       
        progressAnimator.stopAnimation(true)
        progressAnimator.finishAnimation(at: .current)
        timer?.invalidate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
            self.startQuestionTimer()
        }
        
        btn1.setTitleColor(UIColor.black, for: .disabled)
        if btn1.titleLabel!.text == correcta {
            resCorrecta(button: btn1)
        } else {
            resIncorrecta(button: btn1)
        }
        
    }
    
    @IBAction func btn2Tap(_ sender: Any) {
        btn1.isEnabled = false
        btn2.isEnabled = false
        btn3.isEnabled = false
        btn4.isEnabled = false
        
        progressAnimator.stopAnimation(true)
        progressAnimator.finishAnimation(at: .current)
        timer?.invalidate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
            self.startQuestionTimer()
        }
        
        btn2.setTitleColor(UIColor.black, for: .disabled)
        if btn2.titleLabel!.text == correcta {
            resCorrecta(button: btn2)
        } else {
            resIncorrecta(button: btn2)
        }
    }
    
    @IBAction func btn3Tap(_ sender: Any) {
        btn1.isEnabled = false
        btn2.isEnabled = false
        btn3.isEnabled = false
        btn4.isEnabled = false
        
        progressAnimator.stopAnimation(true)
        progressAnimator.finishAnimation(at: .current)
        timer?.invalidate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
            self.startQuestionTimer()
        }
        
        btn3.setTitleColor(UIColor.black, for: .disabled)
        if btn3.titleLabel!.text == correcta {
            resCorrecta(button: btn3)
        } else {
            resIncorrecta(button: btn3)
        }
    }
    
    @IBAction func btn4Tap(_ sender: Any) {
        btn1.isEnabled = false
        btn2.isEnabled = false
        btn3.isEnabled = false
        btn4.isEnabled = false
        
        progressAnimator.stopAnimation(true)
        progressAnimator.finishAnimation(at: .current)
        timer?.invalidate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
            self.startQuestionTimer()
        }
        
        btn4.setTitleColor(UIColor.black, for: .disabled)
        if btn4.titleLabel!.text == correcta {
            resCorrecta(button: btn4)
        } else {
            resIncorrecta(button: btn4)
        }
    }
}
