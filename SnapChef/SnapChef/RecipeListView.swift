//
//  RecipeListView.swift
//  SnapChef
//
//  Created by Adriel Bernard Rusli on 25/05/23.
//

import SwiftUI


struct RecipeListView: View {
    
    @Binding var isShowingRecipeList: Bool
    
    @State private var meals: [Meal] = []
    
    @Binding var ingredientsName: String
    
    var body: some View {
        
        
        GeometryReader{ geometry in
            ZStack{
                
                Color("FF7075")
       
                //Back Button
                Button{
                    isShowingRecipeList = false
                }label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .iconStyle2()
                }
                .position(x: geometry.size.width * 0.16 , y: geometry.size.height * 0.1)
                
                
                    Text(ingredientsName.uppercased())
                        .Title2()
                        .position(x: geometry.size.width * 0.5 , y: geometry.size.height * 0.1)
                    
                    NavigationView{
                        ZStack{
                            
                            List(meals) { meal in
                                NavigationLink(destination: RecipeDetailView(meal: meal)) {
                                    Text(meal.strMeal)
                                        .font(.headline)
                                }
                            }
                            .onAppear {
                                MealFetcher(ind: ingredientsName).fetchMeals { fetchedMeals in
                                    if let fetchedMeals = fetchedMeals {
                                        DispatchQueue.main.async {
                                            meals = fetchedMeals
                                        }
                                    }
                                }
                            }
                            
                        }
                        
                    }.clipShape(RoundedRectangle(cornerRadius: 30))
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.9)
                        .position(x: geometry.size.width/2 , y: geometry.size.height * 0.63)
                    
                    
               
                
            }.ignoresSafeArea()
        }
        
    }
    
    
    
    
    
}


struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(isShowingRecipeList: .constant(true), ingredientsName: .constant("beef"))
        
    }
}

struct RecipeDetailView: View {
    let meal: Meal
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView{
                Text(meal.strMeal)
                    .font(.headline)
                    .padding(.bottom,10)
                
                Text(meal.strCategory)
                    .font(.subheadline)
                    .padding(.bottom,10)
         
                Text(meal.strInstructions)
                    .font(.body)
               
            }
            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.9)
            .position(x: geometry.size.width / 2, y: geometry.size.height * 0.5)
        }
        .navigationBarTitle(meal.strMeal)
    }
}
