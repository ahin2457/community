package com.community.posts;

import java.util.Map;

import com.community.util.SqlMapper;

public class NotificationDao {

	private static NotificationDao instance = new NotificationDao();
	private NotificationDao() {}
	public static NotificationDao getInstance() {
		return instance;
	}
	
	public int getAllTotalRows(Map<String, Object> param) {
		return (Integer) SqlMapper.selectOne("post-notifications.getAllTotalRows", param);
	}
}
