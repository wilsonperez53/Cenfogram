//
//  PostCard.swift
//  Cenfogram
//
//  Created by Estudiantes on 4/17/21.
//

import SwiftUI

struct PostCard: View {
    
    @ObservedObject var postCardService = PostCardService()
    @State private var animate = false
    private let duration: Double = 0.3
    private var animationScale: CGFloat{
        postCardService.isLiked ? 0.5 : 2.0
    }
    
    init(post: PostModel){
        self.postCardService.post = post
        self.postCardService.hasLikedPost()
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 15){
                Button(action: {}) {
                    Image(systemName: (self.postCardService.isLiked) ? "heart.fill" : "heart")
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor((self.postCardService.isLiked) ? .red : .black)
                }.padding().scaleEffect(animate ? animationScale : 1)
                .animation(.easeIn(duration: duration))
                
                Image(systemName: "bubble.right")
                    .frame(width: 25, height: 25, alignment: .center)
                Spacer()
            }.padding(.leading,16)
            if(self.postCardService.post.likeCount > 0) {
                Text("\(self.postCardService.post.likeCount) likes")
            }
        }
    }
}

struct PostCard_Previews: PreviewProvider {
    static var previews: some View {
        PostCard()
    }
}
