import Foundation
protocol YandexQuizViewControllerProtocol: AnyObject {
    func show(quiz step: YandexStepViewModel)
    func showAlertResult()
    func highlightImageBorder(isCorrectAnswer: Bool)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showNetworkError(message: String)
    func changeStateButton(isEnabled: Bool)
    func clearBorder()
}
