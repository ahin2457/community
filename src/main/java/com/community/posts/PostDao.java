package com.community.posts;

import java.util.List;
import java.util.Map;

import com.community.util.SqlMapper;

public class PostDao {

	private static PostDao instance = new PostDao();
	private PostDao() {}
	public static PostDao getInstance() {
		return instance;
	}
	
	public void insertPost(Post post) {
		SqlMapper.insert("posts.insertPost", post);
	}
	
	public int getAllTotalRows(Map<String, Object> param) {
		return (Integer) SqlMapper.selectOne("posts.getAllTotalRows", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<PostListDto> getAllPosts(Map<String, Object> param) {
		return (List<PostListDto>) SqlMapper.selectList("posts.getAllPosts", param);
	}
	
	public Post getPostByNo(int postNo) {
		return (Post) SqlMapper.selectOne("posts.getPostByNo", postNo);
	} 
	
}
