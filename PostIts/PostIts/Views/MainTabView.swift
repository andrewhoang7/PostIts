//
//  MainTabView.swift
//  PostIts
//
//  Created by Andrew Hoang on 3/29/24.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var factory: ViewModelFactory
    
    var body: some View {
        TabView {
            PostsList(viewModel: factory.makePostsViewModel())
                .tabItem {
                    Label("Posts", systemImage: "list.dash")
                }
            PostsList(viewModel: factory.makePostsViewModel(filter: .favorites))
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(ViewModelFactory.preview)
    }
}
