//
//  ProductService.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

class ProductService {
    
    var products: [String] = ["Курьер B2B", "Курьер C2C" , "Курьер B2C"]
    var updateHandlers = [() -> Void]()
    
    func addProduct(product: String) {
        products.append(product)
        notify()
    }
    
    func removeProduct(product: String) {
        products.removeAll(where: { $0 == product})
        notify()
    }
    
    private func notify() {
        updateHandlers.forEach { $0() }
    }
    
}
