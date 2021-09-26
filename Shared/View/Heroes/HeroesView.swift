//
//  HeroView.swift
//  ProjectCombineKC (iOS)
//
//  Created by Alberto Alegre Bravo on 24/9/21.
//

import SwiftUI

struct HeroesView: View {
    
    @EnvironmentObject var viewModel: ViewModelHeros

    
    var body: some View {
        NavigationView{
            List{
                if let heros = viewModel.heros?.data.results {
                    ForEach(heros){ data in
                        NavigationLink(
                            destination: SeriesHeroView(heroFilter: data),
                            label: {
                                //Detalle Row
                                HerosRowView(hero: data)
                                
                            })
                    }
                }
            }
            .navigationBarTitle(Text("HEROS"))
            .foregroundColor(.blue)
            
        }
    }
}

struct HeroesView_Previews: PreviewProvider {
    static var previews: some View {
        HeroesView()
            .environmentObject(ViewModelHeros(testing: true))
    }
}
