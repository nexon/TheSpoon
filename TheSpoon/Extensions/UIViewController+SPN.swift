//
//  UIViewController+SPN.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 19-11-22.
//

import UIKit

extension UIViewController {
    func showAlert(with error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let mainAction = UIAlertAction(title: "OK", style: .cancel)
        
        alertController.addAction(mainAction)
        
        present(alertController, animated: true)
    }
}
