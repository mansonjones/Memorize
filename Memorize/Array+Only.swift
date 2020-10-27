//
//  Array+Only.swift
//  Memorize
//
//  Created by Manson Jones on 10/27/20.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
