//
//  CGPoint+Math.swift
//  CRM
//
//  Created by Aleksei Chudin on 29.12.2023.
//

import Foundation

public extension CGPoint {

    /// Возвращает точку с противоположной стороны от center
    func opposite(center: CGPoint) -> CGPoint {
        let newX = 2 * center.x - x
        let diffY = abs(y - center.y)
        let newY = center.y + diffY * (y < center.y ? 1 : -1)
        return CGPoint(x: newX, y: newY)
    }

    /// Возвращает середину между точками
    func midPoint(point: CGPoint) -> CGPoint {
        return CGPoint(x: (x + point.x) / 2, y: (y + point.y) / 2)
    }

    /// Функция для нахождения второй контрольной точки при построении кривой Безье
    /// - Parameters:
    ///   - p2: вторая точка отрезка для которого ищется контрольная точка
    ///   - next: предполагаемая следующая точка
    func controlPoint(p2: CGPoint, next p3: CGPoint?) -> CGPoint? {
        guard let p3 = p3 else {
            return nil
        }

        let leftMidPoint  = midPoint(point: p2)
        let rightMidPoint = p2.midPoint(point: p3)

        let rightMidOpposite = rightMidPoint.opposite(center: p2)
        var controlPoint = leftMidPoint.midPoint(point: rightMidOpposite)

        if y.between(a: p2.y, b: controlPoint.y) {
            controlPoint.y = y
        } else if p2.y.between(a: y, b: controlPoint.y) {
            controlPoint.y = p2.y
        }


        let iContol = controlPoint.opposite(center: p2)
        if p2.y.between(a: p3.y, b: iContol.y) {
            controlPoint.y = p2.y
        }
        if p3.y.between(a: p2.y, b: iContol.y) {
            let diffY = abs(p2.y - p3.y)
            controlPoint.y = p2.y + diffY * (p3.y < p2.y ? 1 : -1)
        }

        // make lines easier
        controlPoint.x += (p2.x - x) * 0.1

        return controlPoint
    }
}
