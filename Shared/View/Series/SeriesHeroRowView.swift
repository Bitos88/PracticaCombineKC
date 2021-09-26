//
//  SeriesHeroRowView.swift
//  ProjectCombineKC (iOS)
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 26/9/21.
//

import SwiftUI

struct SeriesHeroRowView: View {
    
    @ObservedObject private var viewModel = PhotoViewModel()
    
    var serie : Results //viene la serie
    //viewModel de la photo (como tienes en lops heroes). ObserverdObject
    
    var body: some View {
        
        VStack{
            if let photo = viewModel.photo {
                photo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100, alignment: .center)
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
                Text("\(serie.title!)")
                .font(.title)
                .foregroundColor(.gray)
                .bold()
            }
        }
        .onAppear{
            let imagenUrl = serie.thumbnail.path + ".\(serie.thumbnail.thumbnailExtension)"
            self.viewModel.loadImage(url: imagenUrl)
        }
    }
}

struct SeriesHeroRowView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesHeroRowView(serie: Results(id: 1, name: "errorString", thumbnail: Thumbnail(path: "", thumbnailExtension: Extension.gif), title: ""))
    }
}
