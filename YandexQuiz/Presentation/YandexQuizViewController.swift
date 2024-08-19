import UIKit


final class YandexQuizViewController: UIViewController, AlertPresenterProtocol, YandexQuizViewControllerProtocol {
    
    // MARK: - Lifecycle
    
    private var alertPresenterDelegate: AlertPresenterDelegate?
    
    private var presenter: YandexQuizPresenter!
    
    @IBOutlet private var imageView: UIImageView!
    
    @IBOutlet private var textLabel: UILabel!
    
    @IBOutlet private var counterLabel: UILabel!
    
    @IBOutlet private var yesButton: UIButton!
    
    @IBOutlet private var noButton: UIButton!
    
    @IBOutlet weak var questionField: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFonts()
        let alertPresenterDelegate = AlertPresenter()
        alertPresenterDelegate.alertView = self
        self.alertPresenterDelegate = alertPresenterDelegate
        
        presenter = YandexQuizPresenter(viewController: self)
    }
    
    private func setupFonts() {
        clearBorder()
        textLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
        counterLabel.font = UIFont(name: "YSDisplay-Medium", size: 20)
        questionField.font = UIFont(name: "YSDisplay-Bold", size: 23)
        yesButton.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
        noButton.titleLabel?.font = UIFont(name: "YSDisplay-Medium", size: 20)
    }
    
    
    func show(quiz step: YandexStepViewModel) {
        imageView.image = step.image
        questionField.text = step.question
        counterLabel.text = step.questionNumber
        changeStateButton(isEnabled: true)
    }
    
    
    func clearBorder() {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = UIColor.clear.cgColor
    }
    
    func highlightImageBorder(isCorrectAnswer: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        showLoadingIndicator()
    }
    
    func changeStateButton(isEnabled: Bool) {
        noButton.isEnabled = isEnabled
        yesButton.isEnabled = isEnabled
    }
    
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.isHidden = true
    }
    
    func showNetworkError(message: String) {
        hideLoadingIndicator()
        
        let alertErrorModel = AlertModel(title: "Ошибка",
                                         message: message,
                                         buttonText:"Попробовать еще раз",
                                         completion: {[weak self] in
            guard let self = self else { return }
            presenter.restartGame()
        })
        alertPresenterDelegate?.alertShow(alertModel: alertErrorModel)
    }
    
    func showAlertResult() {
        
        let alertResultModel = AlertModel(title: "Этот раунд окончен!",
                                          message: presenter.alertResultMessage ?? "",
                                          buttonText:"Сыграть еще раз",
                                          completion: {[weak self] in
            guard let self = self else { return }
            self.presenter.restartGame()
        })
        alertPresenterDelegate?.alertShow(alertModel: alertResultModel)
    }
    
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        presenter.yesButtonClicked()
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        presenter.noButtonClicked()
    }
}
