//
//  ViewModelHeros.swift
//  AppHerosCombine (iOS)
//
//  Created by Alberto Alegre Bravo on 19/9/21.
//

import Combine
import SwiftUI

class ViewModelSeries: ObservableObject{
    
    @Published var series: MarvelJson?
    @Published var status = Status.none
    var suscritors = Set<AnyCancellable>()
    
    init(testing: Bool = false) {
        if (testing) {
            getSeriesTesting()
        } 
    }
    
    
    func getSeries(filter: Int){ //aqui le dices el id de heroew
        
        
        self.status = Status.loading
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getHeroSerie(filter: filter))
            .tryMap{
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return $0.data
            }
            .decode(type: MarvelJson.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure(let errorString):
                    print("error: \(errorString)")
                    self.status = Status.error(error: "se ha producido un error")
                case .finished:
                    self.status = Status.loaded
                }
            } receiveValue: { data in
                self.series = data
            }
            .store(in: &suscritors)
         
         
        
    }
    
    //Testing y diseño
    
    func getSeriesTesting(){
        self.status = Status.loading
        
        let hero5 = Results(id: 5, name: "pepe", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0/portrait_incredible", thumbnailExtension: Extension.jpg), title: "los vengadores")
        let hero4 = Results(id: 4, name: "mari", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0/portrait_incredible", thumbnailExtension: Extension.jpg), title: "los vengadores")
        let hero3 = Results(id: 3, name: "eva", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0/portrait_incredible", thumbnailExtension: Extension.jpg), title: "los vengadores")
        let hero2 = Results(id: 2, name: "sofia", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0/portrait_incredible", thumbnailExtension: Extension.jpg), title: "los vengadores")
        
        
        let data = DataClass(offset: 0, limit: 0, total: 4, count: 4, results: [hero2, hero3, hero4, hero5])
        self.series = MarvelJson(data: data)
        self.status = Status.loaded
        
    }
    
}


