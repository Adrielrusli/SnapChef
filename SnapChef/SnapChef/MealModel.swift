//
//  MealModel.swift
//  SnapChef
//
//  Created by Adriel Bernard Rusli on 25/05/23.
//

import Foundation

struct MealsResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strInstructions: String
    // Add other properties as needed
    
    var id: String { idMeal }
}
