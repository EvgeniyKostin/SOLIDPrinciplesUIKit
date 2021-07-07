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
    
    let urlString = "https://raw.githubusercontent.com/Softex-Group/task-mobile/master/test.json"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = saveButton.frame.width / 2
        
        dataFetcher()
    }

    // MARK: - Business logic
    
    // обработка имени
    func changeName() {
        guard let name = textLabel.text, name != "" else {
            showAlert()
            return
        }
    }
    
    // MARK: - Data storage
    
    // сохранение данных в кеш (базу данных)
    func saveNameInCashe(name: String) {
        print("Your name: \(name) is saved")
    }
    
    // получение данных из кеша (базы данных)
    func getNameFromCache() -> String {
        return "some name"
    }
    
    // MARK: - Networking
    
    func dataFetcher() {
        request { data, error in
            let decoder = JSONDecoder()
            guard let data = data else { return }
            let response = try? decoder.decode([Country].self, from: data)
            print(response)
        }
    }
    
    func request(completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
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

