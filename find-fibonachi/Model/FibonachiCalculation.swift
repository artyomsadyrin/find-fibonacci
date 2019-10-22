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
        DispatchQueue.global(qos: .userInitiated).sync {
            var num1: BigInt = 0
            var num2: BigInt = 1
            var result = String()
            
            for _ in 0..<n {
                num1 += num2
                num2 = num1 - num2
            }
            
            result = "Fib \(n): \(num1)"

            return result
        }
        
    }
    
    static func createFibonachiArray(firstIndex: Int, lastIndex: Int) -> [String] {
        var temp = [String]()
        for i in firstIndex...lastIndex {
            temp.append(getFibonachiNumber(i))
        }
        return temp
        
    }
}
