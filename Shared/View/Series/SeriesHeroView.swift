//
//  SeriesHeroView.swift
//  ProjectCombineKC (iOS)
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 26/9/21.
//

import SwiftUI

struct SeriesHeroView: View {
    var hero:Results //El hero que queremos cargar las series
    //el view model
    @StateObject private var viewModelSeries = ViewModelSeries() //queda instanciado asi...
    
    //inicializador ....
    init(heroFilter: Results){
        self.hero = heroFilter //asigno el modelo
   
    }
    
    var body: some View {
        List{
        if let series = viewModelSeries.series?.data.results {
            
            ForEach(series){data in
                
                //crear una subView denominada SeriesHeroRowView
                SeriesHeroRowView(serie: data)
            }
            
            
            
        } else{
            Text("No data")
        }
        }
        .onAppear{
            //llamo a la carga de las series
            viewModelSeries.getSeries(filter: self.hero.id)
        }
        
    }
}

struct SeriesHeroView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesHeroView(heroFilter: Results(id: 1, name: "", thumbnail: Thumbnail(path: "", thumbnailExtension: Extension.gif), title: ""))
    }
}
