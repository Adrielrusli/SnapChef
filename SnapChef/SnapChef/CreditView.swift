//
//  CreditView.swift
//  SnapChef
//
//  Created by Adriel Bernard Rusli on 25/05/23.
//

import SwiftUI
import SafariServices

struct CreditView: View {
    @Binding var shouldPresentCreditView: Bool
    @Environment(\.openURL) var openURL
    let destination = "https://www.vecteezy.com/free-vector/chef-hat"
    var body: some View {
        
        
        
        
        
        ZStack{
            Color("FF7075")
            GeometryReader{ geometry in
                
                Button{
                    shouldPresentCreditView = false
                }label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .iconStyle2()
                }
                .position(x: geometry.size.width * 0.16 , y: geometry.size.height * 0.1)
                
                //Page Title
                Text("Credit".uppercased())
                    .Title2()
                    .position(x: geometry.size.width * 0.5 , y: geometry.size.height * 0.1)
                
                VStack{
                    if let url = URL(string: destination) {
                        
                        Button{
                            openURL(url)
                        }label: {
                            Text("Chef Hat Vectors by Vecteezy")
                                .Body()
                            
                        }
                        
                        
                        
                    }
                }.position(x: geometry.size.width/2 , y: geometry.size.height * 0.5)
                
                
            }
        }.ignoresSafeArea()
    }
}

struct CreditView_Previews: PreviewProvider {
    static var previews: some View {
        CreditView(shouldPresentCreditView: .constant(true))
    }
}
