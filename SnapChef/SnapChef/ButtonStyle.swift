//
//  ButtonStyle.swift
//  SnapChef
//
//  Created by Adriel Bernard Rusli on 24/05/23.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 22, weight: .bold))
            .foregroundColor(.black)
            .frame(width: 200, height: 60)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .fill(Color.white)
            )
    }
}

extension View {
    func buttonStyle() -> some View {
        modifier(ButtonModifier())
    }
}


struct iconModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 40, weight: .medium))
            .foregroundColor(Color.white)
            .padding()

    }
}

extension View {
    func iconStyle() -> some View {
        modifier(iconModifier())
    }
}

struct iconModifier2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28, weight: .medium))
            .foregroundColor(Color.white)
            .padding()

    }
}

extension View {
    func iconStyle2() -> some View {
        modifier(iconModifier2())
    }
}
struct ButtonStyle: View {
    var body: some View {
        ZStack{
            Color("FF7075")
            VStack{
                Button{
                    
                }label: {
                    Text("Button")
                }.buttonStyle()
                
                
                Button{
                    
                }label: {
                    Image(systemName: "pencil.circle.fill")
                        .iconStyle()
                }
                Button{
                    
                }label: {
                    Image(systemName: "pencil.circle.fill")
                        .iconStyle2()
                }
            }
        }.ignoresSafeArea()
    }
}

struct ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyle()
    }
}

