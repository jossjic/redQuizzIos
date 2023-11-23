

struct User {
    let nombre: String
    let apellidos: String
    let email: String
    let fechaNacimiento: String
    let genero: String
    var puntaje: Int
    var vidas: Int
    let tipo: String
    
    // Add an initializer if needed
    init(nombre: String, apellidos: String, email: String, fechaNacimiento: String, genero: String, puntaje: Int, vidas: Int, tipo: String) {
        self.nombre = nombre
        self.apellidos = apellidos
        self.email = email
        self.fechaNacimiento = fechaNacimiento
        self.genero = genero
        self.puntaje = puntaje
        self.vidas = vidas
        self.tipo = tipo
    }
}
