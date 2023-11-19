struct User {
    let categoria: String
    let nombre: String
    let apellidos: String
    let email: String
    let password: String
    let fechaNacimiento: String
    let genero: String
    let indicePregunta: Int
    let puntaje: Int
    let vidas: Int
    // Add an initializer if needed
    init(categoria: String, nombre: String, apellidos: String, email: String, password: String, fechaNacimiento: String, genero: String, indicePregunta: Int, puntaje: Int, vidas: Int) {
            self.categoria = categoria
            self.nombre = nombre
            self.apellidos = apellidos
            self.email = email
            self.password = password
            self.fechaNacimiento = fechaNacimiento
            self.genero = genero
            self.indicePregunta = indicePregunta
            self.puntaje = puntaje
            self.vidas = vidas
        }
}

