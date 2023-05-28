//
//  FontStyle.swift
//  SnapChef
//
//  Created by Adriel Bernard Rusli on 24/05/23.
//

import SwiftUI

struct LargeTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 34, weight: .bold))
            .foregroundColor(Color.white)
            .multilineTextAlignment(.center)
            .padding()
    }
}

extension View {
    func LargeTitle() -> some View {
        modifier(LargeTitleModifier())
    }
}

struct Title1Modifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28, weight: .bold))
            .foregroundColor(Color.white)
            .multilineTextAlignment(.center)
            .padding()
    }
}

extension View {
    func Title1() -> some View {
        modifier(Title1Modifier())
    }
}

struct Title2Modifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 22, weight: .bold))
            .foregroundColor(Color.white)
            .multilineTextAlignment(.center)
            .padding()
    }
}

extension View {
    func Title2() -> some View {
        modifier(Title2Modifier())
    }
}

struct BodyModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17, weight: .regular))
            .foregroundColor(Color.white)
            .multilineTextAlignment(.center)
            .padding()
    }
}

extension View {
    func Body() -> some View {
        modifier(BodyModifier())
    }
}

struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 28, weight: .regular))
            .foregroundColor(Color.white)
            .multilineTextAlignment(.center)
            .padding()
    }
}

extension View {
    func TextStyle() -> some View {
        modifier(TextModifier())
    }
}

struct FontStyle: View {
    var body: some View {
        ZStack{
            Color("FF7075")
            VStack{
                
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .LargeTitle()
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .Title1()
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .Title2()
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .Body()
            }
                
        }
        .ignoresSafeArea()
    }
}

struct FontStyle_Previews: PreviewProvider {
    static var previews: some View {
        FontStyle()
    }
}
