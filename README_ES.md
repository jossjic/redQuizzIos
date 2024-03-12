# Proyecto Redquiz (Versión iOS 1.0)

[Click here to see the english version of the documentation](README.md)

RedQuiz es una aplicación de trivia diseñada para preparar a los voluntarios novatos de la Cruz Roja sobre temas de salud. Ofrece trivia con categorías como signos vitales, anatomía, etc. Además, motiva a los usuarios con recompensas y avatares personalizables. La aplicación permite a los usuarios seguir su progreso a través de estadísticas detalladas y tiene un sistema de gestión de preguntas para que los administradores puedan mantener el contenido actualizado. En resumen, RedQuiz combina el aprendizaje interactivo, la motivación y el seguimiento del progreso para una preparación efectiva de los voluntarios.

## GameViewModel

### Métodos principales

#### fetchData
```swift
func fetchData(completion: @escaping CompletionHandler)
```
Este método recupera las preguntas de la colección "questions" en Firestore. Las preguntas se almacenan en la propiedad `questions` del `GameViewModel`. La finalización se llama cuando se completa la recuperación de datos.

#### createQuestion
```swift
func createQuestion(question: String, category: String, correct: String, incorrect1: String, incorrect2: String, incorrect3: String, points: Int, completion: @escaping CompletionHandler)
```
Crea una nueva pregunta en Firestore con los datos proporcionados. Luego, llama a la finalización una vez que se completa la operación.

#### deleteQuestion
```swift
func deleteQuestion(id: String, completion: @escaping CompletionHandler)
```
Elimina una pregunta específica de Firestore en base a su identificador (`id`). La finalización se llama después de que se completa la operación.

#### updateQuestion
```swift
func updateQuestion(id: String, question: String, category: String, correct: String, incorrect1: String, incorrect2: String, incorrect3: String, points: Int, completion: @escaping CompletionHandler)
```
Actualiza una pregunta existente en Firestore con nuevos datos. También actualiza la pregunta localmente en la propiedad `questions`. La finalización se llama cuando se completa la operación.

## UserViewModel

### Métodos principales

#### fetchData
```swift
func fetchData(completion: @escaping CompletionHandler)
```
Recupera los datos del usuario actual de Firestore. La finalización se llama cuando se completa la recuperación de datos.

#### updateLives
```swift
func updateLives(newLives: Int)
```
Actualiza el número de vidas del usuario en Firestore y localmente en el modelo de usuario.

#### fetchCT
```swift
func fetchCT(completion: @escaping CompletionHandler)
```
Recupera los intentos correctos (`correctTally`) y totales (`totalTally`) del usuario de Firestore. La finalización se llama cuando se completa la recuperación de datos.

#### updateCT
```swift
func updateCT(cOrT: Bool)
```
Actualiza los intentos correctos (`correctTally`) o totales (`totalTally`) del usuario en Firestore. Llama a `fetchCT` internamente antes de realizar la actualización.

#### updateScore
```swift
func updateScore(score: Int, type: String)
```
Actualiza la puntuación del usuario en Firestore en base al tipo de categoría especificado.

#### fetchCat
```swift
func fetchCat(collection: String, completion: @escaping CompletionHandler)
```
Recupera la puntuación acumulada del usuario para una categoría específica de Firestore.

#### fetchRewards
```swift
func fetchRewards(completion: @escaping CompletionHandler)
```
Recupera las recompensas del usuario de Firestore y almacena los resultados en la propiedad `rewardsArray`.

#### updateRewards
```swift
func updateRewards(withScore score: Int, completion: @escaping CompletionHandler)
```
Actualiza las recompensas del usuario en Firestore en base a la puntuación proporcionada. Llama a la finalización cuando se completa la operación.

Este README proporciona una visión general de las principales funciones de los modelos de datos. Asegúrate de entender las dependencias y configuraciones necesarias de Firebase antes de ejecutar la aplicación. ¡Diviértete desarrollando! 🚀
