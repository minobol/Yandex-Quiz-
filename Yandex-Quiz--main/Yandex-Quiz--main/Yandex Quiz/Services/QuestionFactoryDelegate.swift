import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: YandexQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
}
