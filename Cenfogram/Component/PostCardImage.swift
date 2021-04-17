//
//  PostCardImage.swift
//  Cenfogram
//
//  Created by Estudiantes on 4/17/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostCardImage: View {
    var post : PostModel
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                WebImage(url: URL(string: post.profile)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                VStack(alignment: .leading, spacing: 4){
                    Text(post.userName).font(.headline)
                    Text((Date(timeIntervalSince1970: post.date)).timeAgo() + " ago").font(.subheadline)
                        .foregroundColor(.black)
                }.padding(.leading, 10)
                
            }.padding(.leading)
            .padding(.top, 16)
            
            Text(post.caption)
                .lineLimit(nil)
                .padding(.leading, 16)
                .padding(.trailing, 32)
            
            WebImage(url: URL(string: post.mediaUrl)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.size.width, height: 400, alignment: .center)
                .clipped()
        }
    }
}

struct PostCardImage_Previews: PreviewProvider {
    static var previews: some View {
        PostCardImage()
    }
}
