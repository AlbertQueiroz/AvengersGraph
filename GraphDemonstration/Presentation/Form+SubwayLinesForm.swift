//
//  Form+SubwayLinesForm.swift
//  GraphDemonstration
//
//  Created by Albert Rayneer on 20/06/22.
//

import Foundation
import UIKit

extension FormViewController {
    func verifySubwayLine(indexStop: Int) -> (String, UIColor) {
        switch indexStop {
        case 0...19: // 20
            return ("Linha Sul", UIColor(red: 0.23, green: 0.18, blue: 0.63, alpha: 1.00))
        case 20...29: // 10
            return ("Linha Oeste", UIColor(red: 0.07, green: 0.60, blue: 0.20, alpha: 1.00))
        case 30...38: // 9
            return ("VLT Parangaba Mucuripe", UIColor(red: 0.74, green: 0.05, blue: 0.05, alpha: 1.00))
        case 39...49: // 11
            return ("Linha Leste", UIColor(red: 0.87, green: 0.51, blue: 0.04, alpha: 1.00))
        default:
            break
        }

        return ("", UIColor.black)
    }

    func verifyStop(indexStop: Int) -> String? {
        let integrationStop = [0, 8, 36]

        if integrationStop.contains(indexStop) {
            return "Integração"
        }

        return nil
    }
}
