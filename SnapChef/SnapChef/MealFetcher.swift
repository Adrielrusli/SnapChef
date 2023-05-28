//
//  MealFetcher.swift
//  SnapChef
//
//  Created by Adriel Bernard Rusli on 25/05/23.
//

import Foundation

struct MealFetcher {
    
    var ingredientsName = ""
    
    init(ind: String) {
        self.ingredientsName = ind
    }
    
    func fetchMeals(completion: @escaping ([Meal]?) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(ingredientsName)") else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching meals: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MealsResponse.self, from: data)
                let meals = response.meals
                completion(meals)
            } catch {
                print("Error decoding meals response: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}
