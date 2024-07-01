//
//  ToEnglish.swift
//  PayToTheOrderOf
//
//  Created by Alex Mak on 5/19/24.
//  translated from Java excepts of Android app Chinese Numerals from 2012

import Foundation

class DollarLine {
    
    var Number: Int
    var lst = [String]()
    var to_19:[String] = [ "", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
    var tens:[String] = [ "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
    var denom:[String] = [ "", "thousand", "million", "billion" ]
    
    var Answer: String
    var Cent: Int
    
    init(n: Double) {
       // Number = n
        
        Number = Int(n.rounded(.towardZero))
        
        let fcent = n.truncatingRemainder(dividingBy: 1) * 100
        Cent = Int(fcent.rounded())
        
        Answer = ""
    }
    
    func group()
    {
        let str = String(Number)
        let len = str.count
        let groupSize = 3
   
        var g = len / groupSize
        var r = len % groupSize

        if (r > 0) {
            g+=1
        }
        
        var ndx = 0
       
        for _ in 0...g {
            if (r != 0) {
                
                // str.substring(0,r)
                let sub_string = str.prefix(r)
                
                lst.append(String(sub_string))
                ndx += r
                r = 0
                continue
            }
            
            // lst.add(str.substring(ndx, ndx+ groupSize))
            
            if (ndx + groupSize > len) {
                break
            }
            
            // swift has awful horrific way just to get a substring
            let start = str.index(str.startIndex, offsetBy: ndx)
            let end = str.index(str.startIndex, offsetBy: ndx + groupSize )
            let range = start..<end
  
            lst.append(String(str[range]))
            ndx += groupSize
        }
        
    }
    
    func to_english()->String
    {
     
        group()
        
        Answer = listGroupEnglish()
        if (Cent > 0)
        {
            Answer.append("& " + String(Cent) + "/100")
        }
        return Answer
    }
    
    
    func toEnglish(str: String)->String
    {
        let num = Int(str) ?? 0
        
        if (num < 100)
        {
            return convert_nn(val:num)
        }
        
        if (num < 1000)
        {
            return convert_nnn(val:num)
        }
        
        return ""
    }
    
    
    func convert_nn( val: Int) ->String
    {
        if (val < 20)
        {
            return to_19[val]
        }
        
        for v in 0..<tens.count
        {
            var dcap: String
            var dval: Int
            dcap = tens[v]
            dval = 20 + 10 * v
            if (dval + 10 > val) {
                if (( val  % 10 ) != 0)
                {
                    return dcap + " " + to_19[val % 10]
                }
                else
                {
                    return dcap
                }
            }
        }
        
        return ""
    }
    
    func convert_nnn( val:Int) -> String
    {
        var word : String
        var rem : Int
        var mod : Int
        word = ""
        
        rem = val / 100
        mod = val % 100
        if (rem > 0) {
            word = to_19[rem] + " hundred "
            if (mod > 0)
            {
                word = word + convert_nn(val:mod)
            }
        }
        return word
    }
    
    func listGroupEnglish()->String
    {
        let size = lst.count
        var i = size - 1
        var sb = String()
        
        for s in lst {
            if s == "000"{
                i = i-1
                continue
            }
            else
            {
                sb.append(toEnglish(str:s))
            }
            
            sb.append(" ")
            sb.append(denom[i])
            sb.append(" ")
            i = i-1
        }
        
        return sb
    }
    
}
