//
//  ViewModelHeros.swift
//  AppHerosCombine (iOS)
//
//  Created by Alberto Alegre Bravo on 19/9/21.
//

import Foundation
import Combine

class ViewModelHeros: ObservableObject{
    
    @Published var heros: [Heros]?
    @Published var status = Status.none
    var suscritors = Set<AnyCancellable>()
    
    init(testing: Bool = false) {
        if (testing) {
            //getHerosTesting()
        } else {
            getHeros(filter: "")
        }
    }
    
    
    func getHeros(filter: String){
        
        self.status = Status.loading
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSessionHeroes(filter: filter))
            .tryMap{
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                //el JSON
                //let jsonString = String(bytes: $0.data, encoding: .utf8)
                
                return $0.data
            }
            .decode(type: [Heros].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure:
                    self.status = Status.error(error: "error al buscar los heroes")
                case .finished:
                    self.status = Status.loaded
                }
            } receiveValue: { data in
                self.heros = data
            }
            .store(in: &suscritors) //VER ESTO
        
    }
    
    /*/Testing y diseño
    
    func getHerosTesting(){
        self.status = Status.loading
        
        let hero1 = Heroes(id: UUID(), name: "Hulk", thumbnail: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0/portrait_incredible.jpg")
        
        let hero2 = Heroes(id: UUID(), name: "Captain Marvel", thumbnail: "http://i.annihil.us/u/prod/marvel/i/mg/6/80/5269608c1be7a/portrait_incredible.jpg")
        
        let hero3 = Heroes(id: UUID(), name: "Spider-Man",thumbnail: "http://i.annihil.us/u/prod/marvel/i/mg/3/50/526548a343e4b/portrait_incredible.jpg")
        
        let hero4 = Heroes(id: UUID(), name: "Avengers" , thumbnail: "http://i.annihil.us/u/prod/marvel/i/mg/9/20/5102c774ebae7/portrait_incredible.jpg")
        
        self.heros = [hero1, hero2, hero3, hero4]
        self.status = Status.loaded
        
    }
    
}
 */
}
