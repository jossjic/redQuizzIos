struct Question {
    let categoria: String
    let correcta: String
    let incorrecta1: String
    let incorrecta2: String
    let incorrecta3: String
    let pregunta: String
    let puntos: Int
    let id: String

    // Add an initializer if needed
    init(categoria: String, correcta: String, incorrecta1: String, incorrecta2: String, incorrecta3: String, pregunta: String, puntos: Int, id: String) {
        self.categoria = categoria
        self.correcta = correcta
        self.incorrecta1 = incorrecta1
        self.incorrecta2 = incorrecta2
        self.incorrecta3 = incorrecta3
        self.pregunta = pregunta
        self.puntos = puntos
        self.id = id
    }
}
