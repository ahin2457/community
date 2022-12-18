package com.community.posts;

import java.util.Map;

import com.community.util.SqlMapper;

public class CommentDao {

	private static CommentDao instance = new CommentDao();
	private CommentDao() {}
	public static CommentDao getInstance() {
		return instance;
	}
	
	public int getAllTotalRows(Map<String, Object> param) {
		return (Integer) SqlMapper.selectOne("post-comments.getAllTotalRows", param);
	}
}
