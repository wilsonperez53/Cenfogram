//
//  PostCardService.swift
//  Cenfogram
//
//  Created by Estudiantes on 4/17/21.
//

import Foundation
import Firebase
import SwiftUI

class PostCardService: ObservableObject {
    @Published var post: PostModel!
    @Published var isLiked = false
    
    //Revisar todos los posts en busca de cuales les di like
    //para pintar el corazon de rojo
    func hasLikedPost(){
        isLiked = (post.likes["\(Auth.auth().currentUser!.uid)"] == true) ? true : false
        
    }
    
    //Recorrer el arreglo de post para contar cuantos likes tiene y poner el contador
    func like(){
        post.likeCount += 1
        isLiked = true
        
        PostService.PostsUserId(userId: post.ownerId).collection("posts").document(post.postId)
            .updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
        
        PostService.AllPost.document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
        
        PostService.TimelineUserId(userId: post.ownerId).collection("timeline").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
    }
    func unLike(){
        post.likeCount += 1
        isLiked = false
        
        PostService.PostsUserId(userId: post.ownerId).collection("posts").document(post.postId)
            .updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": false])
        
        PostService.AllPost.document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": false])
        
        PostService.TimelineUserId(userId: post.ownerId).collection("timeline").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": false])
    }
}
