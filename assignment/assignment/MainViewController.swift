//
//  MainViewController.swift
//  assignment
//
//  Created by Chris Chen on 2019/3/13.
//  Copyright © 2019 Dev4App. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var mainView = MainView()

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView = MainView(frame: view.bounds)
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
                make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            } else {
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
        }
        
        mainView.doneButton.addTarget(self,
                                      action: #selector(doneButtonTapped(_:)),
                                      for: .touchUpInside)
    }
    
    // MARK: - helper functions

    func inputIsValid() -> String? {
        guard
            let columnText = mainView.columnInputTextField.text,
            let rowText = mainView.rowInputTextField.text else {
                return "input error"
        }
        
        let columnsCount = Int(columnText)
        let rowsCount = Int(rowText)
        if
            let columnsCount = columnsCount,
            let rowsCount = rowsCount {
            if columnsCount > 50 || columnsCount < 1
                || rowsCount > 50 || rowsCount < 1 {
                return "別鬧了"
            }
            return nil
        } else {
            return "input error"
        }
    }
    
    @objc func doneButtonTapped(_ sender: UIButton) {
        
        // check input to avoid error
        let errorMessage = inputIsValid()
        
        if errorMessage == nil {
            let viewController = LayoutViewController()
            viewController.columnsCount = Int(mainView.columnInputTextField.text!)
            viewController.rowsCount = Int(mainView.rowInputTextField.text!)
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            let alertView = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertView.addAction(okAction)
            present(alertView, animated: true, completion: nil)
        }
    }
}
