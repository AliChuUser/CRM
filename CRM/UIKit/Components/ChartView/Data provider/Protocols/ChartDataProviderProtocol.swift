//
//  ChartDataProviderProtocol.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.11.2023.
//

import Foundation

protocol ChartDataProviderProtocol {

    var model: ChartModel? { get set }

    /// Возвращает индекс ближайшего ключа из `model.data` к нажатию и отформатированный текст
    /// - Parameter point: нормализованная позиция нажатия в графике
    func hitTest(normalizedPoint point: CGPoint) -> (Int, String)?
    func applyStyle(_ style: ChartStyleProtocol)
    func reset()
    func recalc()
}

extension ChartDataProviderProtocol {

    func hitTest(normalizedPoint point: CGPoint) -> (Int, String)? { return nil }
}
