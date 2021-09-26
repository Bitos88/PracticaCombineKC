//
//  PhotoViewModel.swift
//  AppHerosCombine (iOS)
//
//  Created by Alberto Alegre Bravo on 20/9/21.
//

import Foundation
import Combine
import SwiftUI

class PhotoViewModel: ObservableObject {
    
    @Published var photo: Image?
    
    var suscriptor = Set<AnyCancellable>()
    
    func loadImage(url: String) {
                    
        let urlDownload = URL(string: url)!
        
        URLSession.shared
            .dataTaskPublisher(for: urlDownload)
            .map{
                UIImage(data: $0.data)
            }
//            .map({ imagen in
//                UIImage(data: imagen.data)
//            })
            .map{ image -> Image in
                
                if let image = image{
                    return Image(uiImage: image)
                } else {
                    return Image(systemName: "person.fill")
                }

            }
            .replaceError(with: Image(systemName: "person.fill"))
            .replaceNil(with: Image(systemName: "person.fill"))
            .receive(on: DispatchQueue.main)
            .sink { image in
                self.photo = image
            }
            .store(in: &suscriptor)
    }
}

