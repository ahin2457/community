package com.community.util;

public class StringUtils {

	public static int stringToNumber(String text) {
		return StringUtils.stringToNumber(text, 0);
	}
	
	public static int stringToNumber(String text, int value) {
		if (text == null) {
			return value;
		}
		
		try {
			return Integer.parseInt(text);
		} catch (NumberFormatException e) {
			return value;
		}
	}
}
