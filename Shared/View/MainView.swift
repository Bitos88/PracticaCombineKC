//
//  MainView.swift
//  ProjectCombineKC (iOS)
//
//  Created by Alberto Alegre Bravo on 26/9/21.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var herosViewModel : ViewModelHeros
    
    var body: some View {
        
        switch herosViewModel.status {
        case Status.none:
            Text("estado None")
        case Status.loading:
            Text("estado loading")

        case Status.loaded:
            HeroesView()

        case Status.error(error: let errorcadena):
            Text("Error: \(errorcadena)" )

        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ViewModelHeros())
    }
}
