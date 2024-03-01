//
//  Reachability+NetworkType.swift
//  CRM
//
//  Created by Aleksei Chudin on 01.03.2024.
//

import Foundation
import CoreTelephony

enum NetworkType {
    case unknown
    case noConnection
    case wifi
    case wwan2g
    case wwan3g
    case wwan4g
    case unknownTechnology(name: String)

    var description: String {
        switch self {
        case .unknown:                      return "Unknown"
        case .noConnection:                 return "No Connection"
        case .wifi:                         return "Wifi"
        case .wwan2g:                       return "2G"
        case .wwan3g:                       return "3G"
        case .wwan4g:                       return "4G"
        case .unknownTechnology(let name):  return "Unknown Technology: \"\(name)\""
        }
    }
}

extension Reachability {

    static var carrierName: String? {
        let carrier = CTTelephonyNetworkInfo().serviceSubscriberCellularProviders?.first?.value
        return carrier?.carrierName
    }

    static func getNetworkType() -> NetworkType {
        guard let reachability: Reachability = try? Reachability() else { return .unknown }
        do {
            try reachability.startNotifier()
            switch reachability.connection {
            case .unavailable: return .noConnection
            case .wifi: return .wifi
            case .cellular: return Reachability.getWWANNetworkType()
            case .none: return .noConnection
            }
        } catch {
            return .unknown
        }
    }

    static func getWWANNetworkType() -> NetworkType {
        guard let currentRadioAccessTechnology = CTTelephonyNetworkInfo().serviceCurrentRadioAccessTechnology?.values.first else { return .unknown }
        switch currentRadioAccessTechnology {
        case CTRadioAccessTechnologyGPRS,
             CTRadioAccessTechnologyEdge,
             CTRadioAccessTechnologyCDMA1x:
            return .wwan2g
        case CTRadioAccessTechnologyWCDMA,
             CTRadioAccessTechnologyHSDPA,
             CTRadioAccessTechnologyHSUPA,
             CTRadioAccessTechnologyCDMAEVDORev0,
             CTRadioAccessTechnologyCDMAEVDORevA,
             CTRadioAccessTechnologyCDMAEVDORevB,
             CTRadioAccessTechnologyeHRPD:
            return .wwan3g
        case CTRadioAccessTechnologyLTE:
            return .wwan4g
        default:
            return .unknownTechnology(name: currentRadioAccessTechnology)
        }
    }
}
