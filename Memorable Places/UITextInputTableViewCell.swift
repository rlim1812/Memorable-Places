//
//  UITextInputTableViewCell.swift
//  Memorable Places
//
//  Created by Ryan Lim on 7/17/16.
//  Copyright © 2016 Ryan Lim. All rights reserved.
//

import UIKit

class UITextInputTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    public func configure(text: String?, placeholder: String) {
        textField.text = text
        textField.placeholder = placeholder
        
        textField.accessibilityValue = text
        textField.accessibilityLabel = placeholder
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
