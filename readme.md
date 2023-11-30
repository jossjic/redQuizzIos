# Proyecto Redquiz (Versión iOS 1.0)

Este proyecto utiliza Firebase y Firestore para gestionar preguntas y usuarios en una aplicación. A continuación, se proporciona una descripción general del código y sus principales funciones.

## GameViewModel

### Métodos Principales

#### fetchData
```swift
func fetchData(completion: @escaping CompletionHandler)
```
Este método recupera las preguntas desde la colección "preguntas" en Firestore. Las preguntas se almacenan en la propiedad `questions` del `GameViewModel`. La finalización se llama cuando la recuperación de datos está completa.

#### createQuestion
```swift
func createQuestion(pregunta: String, categoria: String, correcta: String, incorrecta1: String, incorrecta2: String, incorrecta3: String, puntos: Int, completion: @escaping CompletionHandler)
```
Crea una nueva pregunta en Firestore con los datos proporcionados. Luego, llama a la finalización una vez que la operación está completa.

#### deleteQuestion
```swift
func deleteQuestion(id: String, completion: @escaping CompletionHandler)
```
Elimina una pregunta específica de Firestore según su identificador (`id`). La finalización se llama después de completar la operación.

#### updateQuestion
```swift
func updateQuestion(id: String, pregunta: String, categoria: String, correcta: String, incorrecta1: String, incorrecta2: String, incorrecta3: String, puntos: Int, completion: @escaping CompletionHandler)
```
Actualiza una pregunta existente en Firestore con nuevos datos. También actualiza la pregunta localmente en la propiedad `questions`. La finalización se llama al finalizar la operación.

## UserViewModel

### Métodos Principales

#### fetchData
```swift
func fetchData(completion: @escaping CompletionHandler)
```
Recupera datos del usuario actual desde Firestore. La finalización se llama cuando la recuperación de datos está completa.

#### updateLives
```swift
func updateLives(newLives: Int)
```
Actualiza el número de vidas del usuario en Firestore y localmente en el modelo de usuario.

#### fetchCT
```swift
func fetchCT(completion: @escaping CompletionHandler)
```
Recupera el conteo de intentos correctos (`conteoC`) y totales (`conteoT`) del usuario desde Firestore. La finalización se llama cuando la recuperación de datos está completa.

#### updateCT
```swift
func updateCT(cOt: Bool)
```
Actualiza el conteo de intentos correctos (`conteoC`) o totales (`conteoT`) en Firestore. Llama a `fetchCT` internamente antes de realizar la actualización.

#### updateScore
```swift
func updateScore(score: Int, type: String)
```
Actualiza el puntaje del usuario en Firestore según el tipo de categoría especificado.

#### fetchCat
```swift
func fetchCat(collection: String, completion: @escaping CompletionHandler)
```
Recupera el puntaje acumulado del usuario para una categoría específica desde Firestore.

#### fetchRewards
```swift
func fetchRewards(completion: @escaping CompletionHandler)
```
Recupera las recompensas del usuario desde Firestore y almacena los resultados en la propiedad `rewardsArray`.

#### updateRewards
```swift
func updateRewards(withScore score: Int, completion: @escaping CompletionHandler)
```
Actualiza las recompensas del usuario en Firestore según el puntaje proporcionado. Llama a la finalización al finalizar la operación.

Este README proporciona una visión general de las funciones principales de los modelos de datos. Asegúrate de comprender las dependencias y configuraciones necesarias de Firebase antes de ejecutar la aplicación. ¡Diviértete desarrollando! 🚀
