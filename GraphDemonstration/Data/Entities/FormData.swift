//
//  FormData.swift
//  GraphDemonstration
//
//  Created by Albert Rayneer on 19/06/22.
//

import Foundation

final class FormData {
    public static var instance = FormData()

    public var from: String?
    public var to: String?
    public var result: String? {
        "\(from ?? "") -> \(to ?? "")"
    }

    private init (){}

}
