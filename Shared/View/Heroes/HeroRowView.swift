//
//  HerosRowView.swift
//  AppHerosCombine (iOS)
//
//  Created by Alberto Alegre Bravo on 20/9/21.
//

import SwiftUI

struct HerosRowView: View {
    
    @ObservedObject private var viewModel = PhotoViewModel()

    var hero: Results // Nos pasa la padre

    var body: some View {
        VStack{
            if let photo = viewModel.photo {
                photo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
                                        
            }else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
                    
            }
            
            HStack{
                Text("\(hero.name!)")
                .font(.title)
                .foregroundColor(.gray)
                .bold()
            }
        }
        .onAppear{
            let imagenUrl = hero.thumbnail.path + ".\(hero.thumbnail.thumbnailExtension)"
            self.viewModel.loadImage(url: imagenUrl)
        }
    }
}

struct HerosRowView_Previews: PreviewProvider {
    static var previews: some View {
        HerosRowView(hero: Results(id: 1, name: "Hulk", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0/portrait_incredible.", thumbnailExtension: .jpg), title: "los vengadores"))
    }
}
