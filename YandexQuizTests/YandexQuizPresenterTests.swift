import XCTest
@testable import Yandex_Quiz

class YandexQuizViewControllerMock: YandexQuizViewControllerProtocol {
    
    
    func show(quiz step: YandexStepViewModel) {}
    func showAlertResult() {}
    func highlightImageBorder(isCorrectAnswer: Bool) {}
    func showLoadingIndicator() {}
    func hideLoadingIndicator() {}
    func showNetworkError(message: String) {}
    func changeStateButton(isEnabled: Bool) {}
    func clearBorder() {}
}

class MovieQuizPresenterTests: XCTestCase {
    func testPresenterConvertModel() throws {
        let viewControllerMock = YandexQuizViewControllerMock()
        let sut = YandexQuizPresenter(viewController: viewControllerMock)
        
        let emptyData = Data()
        let question = YandexQuestion(image: emptyData, text: "Question Text", correctAnswer: true)
        let viewModel = sut.convert(model: question)
        
        XCTAssertNotNil(viewModel.image)
        XCTAssertEqual(viewModel.question, "Question Text")
        XCTAssertEqual(viewModel.questionNumber, "1/10")
    }
}
