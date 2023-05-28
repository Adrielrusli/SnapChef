//
//  PhotoView.swift
//  SnapChef
//
//  Created by Adriel Bernard Rusli on 24/05/23.
//

import SwiftUI

extension Image {
    
    func asUIImage() -> UIImage? {
        let controller = UIHostingController(rootView: self)
        controller.view.bounds = CGRect(origin: .zero, size: CGSize(width: 300, height: 300)) // Adjust the size as needed
        let imageRenderer = UIGraphicsImageRenderer(size: controller.view.bounds.size)
        
        let image = imageRenderer.image { context in
            controller.view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
        
        return image
    }
}

struct PhotoView: View {
    
    @State var shouldPresentRecipeListView = false
    @State var indgredientsName = ""
    @Binding var isPhotoViewShowing: Bool
    @State private var ingredientsImage: Image? = Image("PlaceHolder-Image")
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    @ObservedObject private var classificationService = ClassificationService()
    
    var body: some View {
        
        ZStack{
            
            GeometryReader{ geometry in
                
                //Background Color
                Color("FF7075")
                
                //Back Button
                Button{
                    isPhotoViewShowing = false
                }label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .iconStyle2()
                }
                .position(x: geometry.size.width * 0.16 , y: geometry.size.height * 0.1)
                
                //Page Title
                Text("Choose Photo".uppercased())
                    .Title2()
                    .position(x: geometry.size.width * 0.5 , y: geometry.size.height * 0.1)
                
                //Photo Box
                ingredientsImage!
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 3)
                            .foregroundColor(.white)
                    )
                    .onTapGesture {
                        self.shouldPresentActionScheet = true
                    }
                    .sheet(isPresented: $shouldPresentImagePicker) {
                        ImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, ingredientsImage: self.$ingredientsImage, shouldPresentImagePicker: self.$shouldPresentImagePicker)
                    }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                        ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                            self.shouldPresentImagePicker = true
                            self.shouldPresentCamera = true
                        }), ActionSheet.Button.default(Text("Photo Library"), action: {
                            self.shouldPresentImagePicker = true
                            self.shouldPresentCamera = false
                        }), ActionSheet.Button.cancel()])
                    }
                    .frame(width: geometry.size.width * 0.8 , height: geometry.size.width * 0.8)
                    .position(x: geometry.size.width / 2 , y: geometry.size.height * 0.4)
                
                //Process Picture Button
                Button{
                    guard let uiImage = ingredientsImage?.asUIImage() else {
                        return
                    }
                    classificationService.updateClassifications(for: uiImage)
                }label: {
                    Text("Start")
                        .buttonStyle()
                }
                    .position(x: geometry.size.width / 2 , y: geometry.size.height * 0.7)
            }
            
        }
        .ignoresSafeArea()
        .onReceive(classificationService.classificationsResultPub) { classification in
            
            
            indgredientsName = classification
            print("Classification: \(indgredientsName)")
            
            
            if indgredientsName != "" {
                shouldPresentRecipeListView = true
            }
            
            
        }
        .fullScreenCover(isPresented: $shouldPresentRecipeListView){
            RecipeListView(isShowingRecipeList: $shouldPresentRecipeListView, ingredientsName: $indgredientsName)
        }
        
    }
    
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(isPhotoViewShowing: .constant(true))
    }
}

