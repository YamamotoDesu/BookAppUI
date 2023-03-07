# BookAppUI
[SwiftUI Book App UI With Complex Animation | Carousel | Matched Geometry Effect | Part 1 | Xcode 14](https://www.youtube.com/watch?v=GFV6dIhXFHQ)

<img width="300" alt="スクリーンショット 2023-03-07 20 37 49" src="https://user-images.githubusercontent.com/47273077/223411590-0604a106-c782-492d-a815-038773967bc7.png">

```swift
struct Home: View {
    /// View Properties
    @State private var activeTag: String = "Biography"
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

```

## matchedGeometryEffect
<table>
  <tr>
       <td valign="top"><img width="300" alt="スクリーンショット 2023-03-07 20 37 49" src="https://user-images.githubusercontent.com/47273077/223412386-0ebc81e3-6869-4182-9455-5c91bb7570aa.gif"></td>
    <td valign="top"><img width="300" alt="スクリーンショット 2023-03-07 20 37 49" src="https://user-images.githubusercontent.com/47273077/223414305-7ea2fb6c-d41b-4b62-97ca-95e744f7b9c5.gif"></td>
  </tr>
</table>


```swift
struct Home: View {
    /// View Properties
    @State private var activeTag: String = "Biography"
    /// For Matched Geometry Effect
    @Namespace private var animation // Added
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
                                    .matchedGeometryEffect(id: "ACTIVETAG", in: animation) // Added
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
```

## rotation3DEffect
<img width="300" alt="スクリーンショット 2023-03-07 23 45 52" src="https://github.com/YamamotoDesu/BookAppUI/blob/main/2023-03-07%2023.47.14.gif">


```swift
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
            
            ScrollView(.vertical, showsIndicators: false) {
                /// Books Card View
                VStack(spacing: 35) {
                    ForEach(sampleBooks) {
                        BookCardView($0)
                    }
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 20)
            }
            .coordinateSpace(name: "SCROLLVIEW")
            .padding(.top, 15)
        }
    }
    
    /// Book Card View
    @ViewBuilder
    func BookCardView(_ book: Book) -> some View {
        GeometryReader {
            let size = $0.size
            let rect = $0.frame(in: .named("SCROLLVIEW"))
            
            HStack(spacing: -25) {
                /// Book Detail Card
                ///  Placing this card above the cover image
                VStack(alignment: .leading, spacing: 6) {
                    Text(book.title)
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text("By \(book.author)")
                        .font(.caption)
                    
                    RatingView(rating: book.rating)
                        .padding(.top, 10)
                    
                    Spacer(minLength: 10)
                    
                    HStack(spacing: 4) {
                        Text("\(book.bookViews)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                        
                        Text("Views")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(20)
                .frame(width: size.width / 2, height: size.height * 0.8)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                        // Applying Shadow
                        .shadow(color: .black.opacity(0.08), radius: 8, x: 5, y: 5)
                        .shadow(color: .black.opacity(0.08), radius: 8, x: -5, y: -5)
                }
                .zIndex(1)
                
                // Book Card Image
                ZStack {
                    Image(book.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width / 2, height: size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        // Applying Shadow
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 5, y: 5)
                        .shadow(color: .black.opacity(0.1), radius: 8, x: -5, y: -5)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: size.width)
            .rotation3DEffect(.init(degrees: convertOffsetToRotation(rect)), axis: (x: 1, y: 0, z: 0), anchor: .center, anchorZ: 1, perspective: 1)
        }
        .frame(height: 220)
    }
    
    func convertOffsetToRotation(_ rect: CGRect) -> CGFloat {
        let cardHeight = rect.height
        let minY = rect.minY - 20
        let progress = minY < 0 ? (minY / cardHeight) : 0
        let constrainedProgress = min(-progress, 1.0)
        return constrainedProgress * 90
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
                                    .fill(Color("Blue"))
                                    .matchedGeometryEffect(id: "ACTIVETAG", in: animation)
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
            .padding(.horizontal, 10)
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

struct RatingView: View {
    var rating: Int
    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: "star.fill")
                    .font(.caption2)
                    .foregroundColor(index <= rating ? .yellow : .gray.opacity(0.5))
            }
            
            Text("(\(rating))")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.yellow)
                .padding(.leading, 5)
        }
    }
}

```
