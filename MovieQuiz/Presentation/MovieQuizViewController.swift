import UIKit

enum FileManagerError: Error {
    case fileDoesntExist
}


final class MovieQuizViewController: UIViewController, MovieQuizViewControllerProtocol {
   
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var counterLabel: UILabel!
    @IBOutlet private var noButton: UIButton!
    @IBOutlet private var yesButton: UIButton!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    //var alertPresenter: AlertPresenterProtocol?
    private var presenter: MovieQuizPresenter?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MovieQuizPresenter(viewController: self)
        //alertPresenter = AlertPresenter()
        activityIndicator.hidesWhenStopped
        showLoadingIndicator()
    }
    
    func didRecieveNextQuestion(question: QuizQuestion?) {
        presenter?.didRecieveNextQuestion(question: question)
    }
    
    // MARK: - Actions
    
    @IBAction private func yesButtonClicked(_ sender: Any) {
        enableButtons(false)
        presenter?.yesButtonClicked()
        
    }
    
    @IBAction private func noButtonClicked(_ sender: Any) {
        enableButtons(false)
        presenter?.noButtonClicked()
    }

    
    func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    func showLoadingIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func showNetworkError(message: String) {
        hideLoadingIndicator()
        
        let model = AlertModel(title: "Ошибка",
                               message: message,
                               buttonText: "Попробовать еще раз",
                               compition: { [weak self] _ in
            guard let self = self else { return }
            
            self.presenter?.restartGame()
            showLoadingIndicator()
            presenter?.reloadData()
            
        })
        
        show(allertModel: model)
    }
    
    func show(allertModel: AlertModel) {
        let alert = UIAlertController(title: allertModel.title,
                                      message: allertModel.message,
                                      preferredStyle: .alert)

        let action = UIAlertAction(title: allertModel.buttonText, style: .default, handler: allertModel.compition)

        alert.addAction(action)
        if allertModel.accessibilityIdentifier != "" {
            alert.view.accessibilityIdentifier = allertModel.accessibilityIdentifier
        }

        self.present(alert, animated: true, completion: nil)
    }
    
    func showImageBorder(isCorrect: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
    }
    
    func hideImageBorder() {
        imageView.layer.borderWidth = 0
    }
    
    
    func enableButtons(_ bool: Bool) {
        yesButton.isEnabled = bool
        noButton.isEnabled = bool
    }
}
