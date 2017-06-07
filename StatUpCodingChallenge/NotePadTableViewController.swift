//
//  ViewController.swift
//  StatUpCodingChallenge
//
//  Created by Syed Sabir Salman on 6/6/17.
//  Copyright © 2017 Syed Sabir Salman. All rights reserved.
//

import UIKit
import MBProgressHUD

class NotePadTableViewController: UITableViewController {

    fileprivate let wordService = WordService()
    fileprivate let addNameDialog = UIAlertController(title: "User Name", message: "Please input your name:", preferredStyle: .alert)

    fileprivate var wordOfTheDay = Word()
    fileprivate var apiOutput = ""
    
    @IBAction func editUserName(_ sender: UIBarButtonItem) {
        ViewUtils.showAlert(addNameDialog)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib.init(nibName: TextView.identifier, bundle: nil), forCellReuseIdentifier: TextView.identifier)
        adjustFontSizeDynamically()
        
        prepareAddNameDialog()

        retrieveWordOfTheDay()
    }
    
    private func adjustFontSizeDynamically() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil, queue: nil, using: {
            [weak self] Notification in
            
            self?.tableView.reloadData()
        })
    }
    
    private func prepareAddNameDialog() {
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let nameInput = self.addNameDialog.textFields?[0] {
                UserDefaults.standard.set(nameInput.text, forKey: "userName")
                UserDefaults.standard.synchronize()
            }
        }
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    
        addNameDialog.addTextField { (textField) in
            textField.placeholder = "Your Name..."
        }
    
        addNameDialog.addAction(addAction)
        addNameDialog.addAction(cancelAction)
    }

    private func retrieveWordOfTheDay() {
         _ = MBProgressHUD.indeterminateHUD(view, labelText: "Retrieving Word of the Day")
        
        wordService.retrieveWordOfTheDay(withApiKey: WebServiceConfigurator.wordOfTheDayApiKey!, webServiceResponse: DefaultWebServiceResponseHandler(success: {
                [weak self] httpStatusCode, responseObject, jsonResponse in
            
                self?.onWordOfTheDaySuccessfullyRetrieved(withResponseObject: responseObject as! Word, andJson: jsonResponse as! String)
            }, finally: {
                [weak self] httpStatusCode in
                
                if let view = self?.view {
                    _ = MBProgressHUD.hide(for: view, animated: true)
                }
            }, view: view))
    }
    
    private func onWordOfTheDaySuccessfullyRetrieved(withResponseObject responseObject: Word, andJson jsonResponse: String) {
        _ = MBProgressHUD.successHUD(view)

        wordOfTheDay = responseObject
        apiOutput = jsonResponse

        tableView.reloadData()
    }

    deinit {
       NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }
}


// MARK: TableView Delegate and DataSource methods

extension NotePadTableViewController {
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    open override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(5.0)
    }
    
    open override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(0.1)
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextView.identifier) as! TextView

        cell.wordOfTheDay = wordOfTheDay
        cell.apiOutput = apiOutput

        return cell
    }
}
