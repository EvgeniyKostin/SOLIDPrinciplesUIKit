//
//  ViewController.swift
//  SOLIDPrinciplesUIKit
//
//  Created by Evgeniy Kostin on 04.07.2021.
//

import UIKit

struct Country: Decodable {
    var Id: String
    var Time: String
    var Name: String
    var Image: String?
}

class ViewController: UIViewController {
    
    // внешние зависимости
    let urlString = "https://raw.githubusercontent.com/Softex-Group/task-mobile/master/test.json"
    var networkService = NetworkService()
    let dataStore = DataStore()

    // MARK: - IBOutlets
    
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = saveButton.frame.width / 2
        
        //dataFetcher()
        networkService.dataFetcher(urlString: urlString)
    }

    // MARK: - Business logic
    
    // обработка имени
    func changeName() {
        guard let name = textLabel.text, name != "" else {
            showAlert()
            return
        }
        dataStore.saveNameInCashe(name: name)
    }
          
    // MARK: - User interface
    
    // отображение интерфейса
    func showAlert() {
        let alert = UIAlertController(title: "WARNING", message: "Your name can't be empty", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // взаимодействие пользователя с интерфейсом
    @IBAction func changeLable(_ sender: Any) {
        textLabel.text = myTextField.text
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        changeName()
    }
    
    
}

