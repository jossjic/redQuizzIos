import UIKit

class scoreController: UIViewController {

    
    var progress: CGFloat = 0.5 // Ajusta este valor según tus necesidades (de 0 a 1)

    override func viewDidLoad() {
        super.viewDidLoad()

        drawProgressCircle()
    }

    func drawProgressCircle() {
        let center = CGPoint(x: progressView.bounds.midX, y: progressView.bounds.midY)
        let radius = min(progressView.bounds.width, progressView.bounds.height) / 2.0
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi * progress

        // Crear la capa del círculo
        let circleLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.green.cgColor
        circleLayer.lineWidth = 10.0 // Ancho de la línea del círculo
        circleLayer.fillColor = UIColor.clear.cgColor

        // Agregar la capa al UIView
        progressView.layer.addSublayer(circleLayer)
    }
}
