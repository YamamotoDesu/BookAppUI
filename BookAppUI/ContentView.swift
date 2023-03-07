//
//  ContentView.swift
//  BookAppUI
//
//  Created by 山本響 on 2023/03/07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
