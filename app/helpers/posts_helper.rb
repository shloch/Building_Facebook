module PostsHelper
    def count_post_likes(postID)
        return LikePost.where(post_id: postID).count
    end
end
