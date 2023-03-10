//
//  Home.swift
//  BookAppUI
//
//  Created by 山本響 on 2023/03/07.
//

import SwiftUI

struct Home: View {
    /// View Properties
    @State private var activeTag: String = "Biography"
    /// For Matched Geometry Effect
    @Namespace private var animation
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Browse")
                    .font(.largeTitle.bold())
                
                Text("Recommended")
                    .fontWeight(.semibold)
                    .padding(.leading, 15)
                    .foregroundColor(.gray)
                    .offset(y: 2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            
            TagsView()
        }
    }
    
    /// Tags View
    @ViewBuilder
    func TagsView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background {
                            if activeTag == tag {
                                Capsule()
                                    .fill(Color(.systemBlue))
//                                    .matchedGeometryEffect(id: "ACTIVETAG", in: animation)
                            } else {
                                Capsule()
                                    .fill(.gray.opacity(0.2))
                            }
                        }
                        .foregroundColor(activeTag == tag ? .white : .gray)
                        /// Changing Active Tag when tapped one of the tag
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7)) {
                                activeTag = tag
                            }
                        }
                }
            }
        }
    }
}

/// Sample Tags
var tags: [String] = [
    "History", "Classical", "Biography", "Cartoon", "Adventure", "Fairy tales", "Fantasy"
]

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
