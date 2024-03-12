# RedQuiz Proyect (iOS Version 1.0)
[Haz click aquí para ver la versión en español de la documentación](README_ES.md)

RedQuiz is a trivia application designed to prepare novice Red Cross volunteers on health topics. It offers trivia with categories such as vital signs, anatomy, etc. Additionally, it motivates users with rewards and customizable avatars. The application allows users to follow their progress through detailed statistics and has a question management system so that administrators can keep the content up-to-date. In summary, RedQuiz combines interactive learning, motivation, and progress tracking for effective volunteer preparation.

## GameViewModel

### Main Methods

#### fetchData
```swift
func fetchData(completion: @escaping CompletionHandler)
```
This method retrieves questions from the "questions" collection in Firestore. The questions are stored in the `questions` property of the `GameViewModel`. Completion is called when data retrieval is complete.

#### createQuestion
```swift
func createQuestion(question: String, category: String, correct: String, incorrect1: String, incorrect2: String, incorrect3: String, points: Int, completion: @escaping CompletionHandler)
```
Creates a new question in Firestore with the provided data. Then, calls completion once the operation is complete.

#### deleteQuestion
```swift
func deleteQuestion(id: String, completion: @escaping CompletionHandler)
```
Deletes a specific question from Firestore based on its identifier (`id`). Completion is called after the operation is complete.

#### updateQuestion
```swift
func updateQuestion(id: String, question: String, category: String, correct: String, incorrect1: String, incorrect2: String, incorrect3: String, points: Int, completion: @escaping CompletionHandler)
```
Updates an existing question in Firestore with new data. Also updates the question locally in the `questions` property. Completion is called when the operation is complete.

## UserViewModel

### Main Methods

#### fetchData
```swift
func fetchData(completion: @escaping CompletionHandler)
```
Retrieves the current user's data from Firestore. Completion is called when data retrieval is complete.

#### updateLives
```swift
func updateLives(newLives: Int)
```
Updates the user's number of lives in Firestore and locally in the user model.

#### fetchCT
```swift
func fetchCT(completion: @escaping CompletionHandler)
```
Retrieves the user's correct attempts (`correctTally`) and total attempts (`totalTally`) from Firestore. Completion is called when data retrieval is complete.

#### updateCT
```swift
func updateCT(cOrT: Bool)
```
Updates the user's correct attempts (`correctTally`) or total attempts (`totalTally`) in Firestore. Calls `fetchCT` internally before making the update.

#### updateScore
```swift
func updateScore(score: Int, type: String)
```
Updates the user's score in Firestore based on the specified category type.

#### fetchCat
```swift
func fetchCat(collection: String, completion: @escaping CompletionHandler)
```
Retrieves the user's accumulated score for a specific category from Firestore.

#### fetchRewards
```swift
func fetchRewards(completion: @escaping CompletionHandler)
```
Retrieves the user's rewards from Firestore and stores the results in the `rewardsArray` property.

#### updateRewards
```swift
func updateRewards(withScore score: Int, completion: @escaping CompletionHandler)
```
Updates the user's rewards in Firestore based on the provided score. Calls completion when the operation is complete.

This README provides an overview of the main functions of the data models. Make sure to understand the necessary Firebase dependencies and configurations before running the application. Have fun developing! 🚀
