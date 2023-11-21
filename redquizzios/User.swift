

struct User {
    let nombre: String
    let apellidos: String
    let email: String
    let fechaNacimiento: String
    let genero: String
    var indicePregunta: Int
    var puntaje: Int
    var vidas: Int
    
    // Add an initializer if needed
    init(nombre: String, apellidos: String, email: String, fechaNacimiento: String, genero: String, indicePregunta: Int, puntaje: Int, vidas: Int) {
        self.nombre = nombre
        self.apellidos = apellidos
        self.email = email
        self.fechaNacimiento = fechaNacimiento
        self.genero = genero
        self.indicePregunta = indicePregunta
        self.puntaje = puntaje
        self.vidas = vidas
    }
}
