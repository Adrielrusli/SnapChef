//
//  ContentView.swift
//  SnapChef
//
//  Created by Adriel Bernard Rusli on 23/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var shouldPresentPhotoView = false
    @State var shouldPresentCreditView = false
    
    var body: some View {
        NavigationView{
            ZStack{
                
                Color("FF7075")
                
                GeometryReader{
                    geometry in
                    
                    let middlePosition = geometry.size.width / 2
                    let logoSize = geometry.size.width * 0.9
                    let rightPosition = geometry.size.width * 0.85
                    
                    //Logo
                    Image("Logo-Home")
                        .resizable()
                        .scaledToFit()
                        .frame(width: logoSize)
                        .position(x: middlePosition, y: geometry.size.height * 0.3)
                    
                    
//                    Button{
//
//                    }label: {
//                        Image(systemName: "person.crop.circle.badge.questionmark.fill")
//                    }.iconStyle()
//                        .position(x: rightPosition, y: geometry.size.height * 0.1)
//
                    
                    
                    VStack{
                        
                        //Start Button
                        Button{
                            shouldPresentPhotoView = true
                        }label: {
                            Text("Start")
                                .buttonStyle()
                            
                        }
                       
                        
                        //Credit Button
                        
                        Button{
                            shouldPresentCreditView = true
                        }label: {
                            Text("Credit")
                                .buttonStyle()
                        }
                       
                        
                    }.position(x: middlePosition, y: geometry.size.height * 0.7)
                }
            }.ignoresSafeArea()
                .fullScreenCover(isPresented: $shouldPresentPhotoView){
                    PhotoView(isPhotoViewShowing: $shouldPresentPhotoView)
                }
                .fullScreenCover(isPresented: $shouldPresentCreditView){
                    CreditView(shouldPresentCreditView: $shouldPresentCreditView)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
