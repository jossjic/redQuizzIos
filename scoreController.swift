import UIKit

class scoreController: UIViewController {

    
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var stackSV: UIStackView!
    @IBOutlet weak var stackC: UIStackView!
    @IBOutlet weak var stackS: UIStackView!
    @IBOutlet weak var stackA: UIStackView!
    @IBOutlet weak var stackB: UIStackView!
    
    
    @IBOutlet weak var bLbl: UILabel!
    @IBOutlet weak var aLbl: UILabel!
    @IBOutlet weak var sLbl: UILabel!
    @IBOutlet weak var cLbl: UILabel!
    @IBOutlet weak var sgLbl: UILabel!
    
    let userViewModel = UserViewModel()
    var progress: CGFloat = 0.5 // Ajusta este valor según tus necesidades (de 0 a 1)

    override func viewDidLoad() {
        super.viewDidLoad()

        drawProgressCircle()
        addPercentageLabel()
        addSubtitleLabel()
        
        configureStackView(stackSV, color: UIColor(red: 0.729, green: 0.890, blue: 0.820, alpha: 1.0)) // Verde pastel claro
                configureStackView(stackC, color: UIColor(red: 1.000, green: 0.796, blue: 0.796, alpha: 1.0)) // Rojo pastel claro
                configureStackView(stackS, color: UIColor(red: 0.788, green: 0.847, blue: 1.000, alpha: 1.0)) // Azul pastel claro
                configureStackView(stackA, color: UIColor(red: 1.000, green: 1.000, blue: 0.710, alpha: 1.0)) // Amarillo pastel claro
                configureStackView(stackB, color: UIColor(red: 0.788, green: 0.710, blue: 1.000, alpha: 1.0)) // Morado pastel claro
        
            self.userViewModel.fetchCat(collection: "rqBonus"){
                self.bLbl.text = String(self.userViewModel.puntajeCollection)
                self.userViewModel.fetchCat(collection: "rqAnatomia"){
                    self.aLbl.text = String(self.userViewModel.puntajeCollection)
                    self.userViewModel.fetchCat(collection: "rqSintomas"){
                        self.sLbl.text = String(self.userViewModel.puntajeCollection)
                        self.userViewModel.fetchCat(collection: "rqCuracion"){
                            self.cLbl.text = String(self.userViewModel.puntajeCollection)
                            self.userViewModel.fetchCat(collection: "rqSignosVitales"){
                                self.sgLbl.text = String(self.userViewModel.puntajeCollection)
                            }
                        }
                        
                    }
                }
            }
    }
    
    func configureStackView(_ stackView: UIStackView, color: UIColor) {
            // Asignar el color al fondo
            stackView.backgroundColor = color
            // Redondear los bordes
            stackView.layer.cornerRadius = 10.0 // Ajusta según sea necesario
            stackView.layer.masksToBounds = true
        }

    func drawProgressCircle() {
        // Asegúrate de que bounds.midX y bounds.midY correspondan al centro real del progressView
        let center = CGPoint(x: progressView.bounds.width / 2.0 - 5.5, y: progressView.bounds.height / 2.0)
        let radius = (min(progressView.bounds.width, progressView.bounds.height) / 2.0)-10
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi * progress

        // Crear la capa del círculo
        let circleLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor(red: 0.294, green: 0.580, blue: 0.376, alpha: 1.0).cgColor
        circleLayer.lineWidth = 10.0 // Ancho de la línea del círculo
        circleLayer.fillColor = UIColor.clear.cgColor

        // Agregar la capa al UIView
        progressView.layer.borderWidth = 0.0
        progressView.layer.addSublayer(circleLayer)
        
    }
    
    func addPercentageLabel() {
            // Crear etiqueta
            let label = UILabel()
            label.text = "\(Int(progress * 100))%" // Convierte el valor de progreso a porcentaje
            label.textColor = UIColor(red: 0.294, green: 0.580, blue: 0.376, alpha: 1.0)
            label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
            label.sizeToFit()
            
            // Posicionar la etiqueta en el centro de progressView
            label.center = CGPoint(x: progressView.bounds.width / 2.0, y: progressView.bounds.height / 2.0)
            
            // Agregar la etiqueta a progressView
            progressView.addSubview(label)
        }
    
    func addSubtitleLabel() {
            // Crear subtítulo
            let subtitleLabel = UILabel()
            subtitleLabel.text = "Efectividad"
            subtitleLabel.textColor = UIColor.lightGray
            subtitleLabel.font = UIFont.systemFont(ofSize: 14.0)
            subtitleLabel.sizeToFit()
            
            // Posicionar el subtítulo debajo del label de porcentaje
            subtitleLabel.center = CGPoint(x: progressView.bounds.width / 2.0, y: progressView.bounds.height / 2.0 + 20.0) // Ajusta el valor de 20 según tus necesidades
            
            // Agregar el subtítulo a progressView
            progressView.addSubview(subtitleLabel)
        }
}

