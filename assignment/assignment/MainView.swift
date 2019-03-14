//
//  MainView.swift
//  assignment
//
//  Created by Chris Chen on 2019/3/13.
//  Copyright © 2019 Dev4App. All rights reserved.
//

import UIKit
import SnapKit

class MainView: UIView {

    var contentView = UIView()
    
    let columnInputTextField = UITextField()
    let rowInputTextField = UITextField()
    
    let doneButton = UIButton()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // Content View
        contentView.backgroundColor = .white
        addSubview(contentView)
        
        contentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addContentSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addContentSubviews() {
        
        // columnInputTextField
        columnInputTextField.placeholder = "Column"
        columnInputTextField.borderStyle = .roundedRect
        columnInputTextField.keyboardType = .numberPad
        contentView.addSubview(columnInputTextField)

        // rowInputTextField
        rowInputTextField.placeholder = "Row"
        rowInputTextField.borderStyle = .roundedRect
        rowInputTextField.keyboardType = .numberPad
        contentView.addSubview(rowInputTextField)
        
        // doneButton
        doneButton.setTitle("Go Next", for: .normal)
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.backgroundColor = .lightGray
        doneButton.layer.cornerRadius = 10
        contentView.addSubview(doneButton)
        
        addContentSubviewConstraints()
    }
    
    func addContentSubviewConstraints() {
        
        // columnInputTextField
        columnInputTextField.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(120)
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(snp.top).offset(100)
        }
        
        // rowInputTextField
        rowInputTextField.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(120)
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(columnInputTextField.snp.bottom).offset(15)
        }
        
        // doneButton
        doneButton.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(80)
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(rowInputTextField.snp.bottom).offset(30)
        }
    }
}
