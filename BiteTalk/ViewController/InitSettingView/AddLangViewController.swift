//
//  AddLangViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 24/04/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit

class AddLangViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let languages = ["English", "한국어 (Korean)", "中文 (Chinese)", "日本語 (Japanese)", "Español (Spanish)", "Français (French)", "Deutsche (German)",
                     "Pусский (Russian)", "Português (Portuguese)", "Italiano (Italian)", "Türkçe (Turkish)", "Nederlands (Dutch)", "العربية (Arabic)",
                     "ภาษาไทย (Thai)", "Svenska (Swedish)", "Dansk (Danish)", "Tiếng Việt (Vietnamese)", "Norsk (Norwegin)", "Polski (Polish)",
                     "Suomi (finnish)", "Bahasa Indonesia (Indonesian)", "עִברִית (Hebrew)", "Ελληνικά (Greek)", "Română (Romanian)", "Magyar (Hungarian)", "čeština (Czech)", "Català (Caralan)", "Slovenčina (Slovak)", "Українська (Ukrainian)", "Hrvatski (Croatian)", "Hahasa Melayu (Malay)", "हिंदी (Hindi)"]
    
    var selectedLanguages: [String] = []
    
    @IBOutlet weak var laguageTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        laguageTableView.dataSource = self
        laguageTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = laguageTableView.dequeueReusableCell(withIdentifier: "langcell", for: indexPath)
        cell.detailTextLabel?.isHidden = true
        cell.textLabel?.text = languages[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let bool = cell?.detailTextLabel?.isHidden
        cell?.detailTextLabel?.isHidden = !bool!
        if bool == true {
            selectedLanguages.append((cell?.textLabel?.text)!)
        } else {
            selectedLanguages = selectedLanguages.filter() { $0 != (cell?.textLabel?.text)! }
        }
    }
    
    @IBAction func handleDone(_ sender: UIBarButtonItem) {
        if selectedLanguages.count != 0 {
            UserDefaults.standard.set(self.selectedLanguages, forKey: "language")
            if let viewcont = self.presentingViewController as? LanguageSelViewController {
                viewcont.nextLabel.isHidden = false
                viewcont.selLangButton.setTitle("\(selectedLanguages.count) languages selected", for: .normal)
            }
            self.dismiss(animated: true, completion: nil)
        } else {
            let alertCont = UIAlertController(title: "Select at least 1 language", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) in
                return
            }
            alertCont.addAction(okAction)
            self.present(alertCont, animated: true, completion: nil)
        }

    }
    
}
