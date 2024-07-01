//
//  ContentView.swift
//  PayToTheOrderOf
//
//  Created by Alex Mak on 5/19/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var input: String = ""
    
    var body: some View {
        VStack (alignment: .leading)
        {
           
            HStack {
                Text("$").padding(.leading, 200)
                
                TextField("Amount", text: $input)
                    .frame(width: 80)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
                    .font(.custom("ChalkboardSE-Regular", size: 16))
                    .padding()
                
            }
            
            let amount = Double(input) ?? 0.0

            let dl = DollarLine (n:amount)
            
            Text(dl.to_english()).font(.system(size: 14))
         
            
        }
        .padding()
        .background(Gradient(colors: [.teal, .cyan, .green]).opacity(0.6))
    }
}

#Preview {
    ContentView()
}
