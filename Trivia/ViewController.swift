import UIKit

struct Question {
    let text: String
    let answers: [String]
    let correctAnswer: Int
}

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var progressLabel: UILabel!
    
    var questions: [Question] = [
        Question(text: "What is the capital of France?", answers: ["Berlin", "Madrid", "Paris", "Rome"], correctAnswer: 2),
        Question(text: "What is 2 + 2?", answers: ["3", "4", "5", "6"], correctAnswer: 1),
        Question(text: "What is the largest ocean?", answers: ["Atlantic", "Indian", "Arctic", "Pacific"], correctAnswer: 3)
    ]
    
    var currentQuestionIndex = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        let question = questions[currentQuestionIndex]
        questionLabel.text = question.text
        for (index, button) in answerButtons.enumerated() {
            button.setTitle(question.answers[index], for: .normal)
        }
        progressLabel.text = "Question \(currentQuestionIndex + 1) of \(questions.count)"
    }
    
    @IBAction func answerSelected(_ sender: UIButton) {
        let selectedIndex = answerButtons.firstIndex(of: sender)!
        if selectedIndex == questions[currentQuestionIndex].correctAnswer {
            score += 1
        }
        nextQuestion()
    }
    
    func nextQuestion() {
        if currentQuestionIndex + 1 < questions.count {
            currentQuestionIndex += 1
            updateUI()
        } else {
            showResults()
        }
    }
    
    func showResults() {
        let alert = UIAlertController(title: "Quiz Completed", message: "You scored \(score) out of \(questions.count)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
            self.restartQuiz()
        }))
        present(alert, animated: true)
    }
    
    func restartQuiz() {
        currentQuestionIndex = 0
        score = 0
        updateUI()
    }
}
