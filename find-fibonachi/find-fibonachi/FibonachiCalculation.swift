//
//  FibonachiCalculation.swift
//  find-fibonachi
//
//  Created by Artsiom Sadyryn on 2/12/18.
//  Copyright © 2018 Artsiom Sadyryn. All rights reserved.
//

import Foundation
import BigInt

class FibonachiCalculation {
    
    
    static func getFibonachiNumber(_ n: Int) -> String {
        
            var result = String()
            var num1: BigInt = 0
            var num2: BigInt = 1
            for _ in 0..<n {
                num1 += num2
                num2 = num1 - num2
            }
            result = "Fib \(n): \(num1)"
        
        return result
    }
    
    
    static func createFibonachiArray(_ index: Int) -> [String] {
        var temp = [String]()
        for i in 1...index {
            temp.append(getFibonachiNumber(i))
        }
        return temp
    }
}
