//
//  TextView.swift
//  StatUpCodingChallenge
//
//  Created by Syed Sabir Salman on 6/7/17.
//  Copyright © 2017 Syed Sabir Salman. All rights reserved.

import UIKit
import MBProgressHUD

open class TextView: UITableViewCell {

    open static let identifier = "TextView"
    
    fileprivate let awsSnsService = AWSSNSService()

    @IBOutlet weak var textView: UITextView!
    
    open var wordOfTheDay: Word!
    open var apiOutput = ""

    // MARK: - Override function

    open override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
    }

    fileprivate func snsMessage() -> SNSMessage {
        let message = SNSMessage()

        message.textMessage = textView.text
        message.apiOutput = apiOutput
        
        if let userName = UserDefaults.standard.object(forKey: "userName") as? String {
            message.userName = userName
        }

        return message
    }
    
    override open func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            showAccessoryView()
            5.0.delay {
                [unowned self] in

                self.hideAccessoryView()
            }
        }
    }
    
    private func showAccessoryView() {
        textView.inputAccessoryView = toolbarWithWordOfTheDayButton()
        textView.reloadInputViews()
    }

    private func hideAccessoryView() {
        textView.inputAccessoryView = nil
        textView.reloadInputViews()
    }
}


// MARK: - UITextView Delegate

extension TextView: UITextViewDelegate {

    open func textViewDidChange(_ textView: UITextView) {
        updateTextViewBackgroundColor()

        if hasWordOfTheDay(in: textView) {
            _ = MBProgressHUD.toastHUD(textView, labelText: "Word of the day typed. Shake...")

            awsSnsService.publish(snsMessage: snsMessage())
        }
    }
    
    private func updateTextViewBackgroundColor() {
        textView.backgroundColor = textView.text.isEmpty ? UIColor.clear : UIColor.white
    }

    private func hasWordOfTheDay(in textView: UITextView) -> Bool {
        let selectedRange = textView.selectedRange
        var currentWord = ""

        let beginning = textView.beginningOfDocument
        let start = textView.position(from: beginning, offset: selectedRange.location)
        let end = textView.position(from: start!, offset: selectedRange.length)

        let textRange = textView.tokenizer.rangeEnclosingPosition(end!, with: .word, inDirection: UITextLayoutDirection.left.rawValue)

        if textRange != nil {
            currentWord = textView.text(in: textRange!)!
        }

        return currentWord.lowercased() == wordOfTheDay.word.lowercased()
    }

    fileprivate func toolbarWithWordOfTheDayButton() -> UIToolbar {
        let textViewToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: 100, height: 50))
        textViewToolbar.barStyle = UIBarStyle.default

        textViewToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: wordOfTheDay.word, style: UIBarButtonItemStyle.done, target: self, action: #selector(showDefinition)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        ]

        textViewToolbar.sizeToFit()

        return textViewToolbar
    }

    @objc fileprivate func showDefinition() {
        ViewUtils.showAlert(UIAlertController.alertDialog(wordOfTheDay.formattedDefinitions(), title: "Definition of \(wordOfTheDay.word)"))
    }
}
