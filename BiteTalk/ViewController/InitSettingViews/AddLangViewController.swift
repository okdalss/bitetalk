//
//  AddLangViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 24/04/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit

class AddLangViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

//    let countries = ["usa", "japan", "canada"]
//    var countries: [String] = {
//
//        var arrayOfCountries: [String] = []
//
//        for code in NSLocale.isoCountryCodes as [String] {
//            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
//            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
//            arrayOfCountries.append(name)
//        }
//
//        return arrayOfCountries
//    }()
    
    var languages: [String] = {
        
        var arrayOfLaguages: [String] = []
        
        for code in NSLocale.isoLanguageCodes as [String] {
            let lang = NSLocale.lo
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
//            arrayOfLaguages.append(name)
            arrayOfLaguages.append(lang)
        }
        
        return arrayOfLaguages
    }()
    
    var selectedCountries: [String] = []
    
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
            selectedCountries.append((cell?.textLabel?.text)!)
            print(selectedCountries)
        } else {
            selectedCountries = selectedCountries.filter() { $0 != (cell?.textLabel?.text)! }
            print(selectedCountries)
        }
        
    }
}
