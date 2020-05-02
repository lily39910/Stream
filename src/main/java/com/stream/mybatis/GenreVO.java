package com.stream.mybatis;

public class GenreVO {
	private String gn_idx, g_idx, tag_idx;
	private String tag_name;

	public String getGn_idx() {
		return gn_idx;
	}

	public void setGn_idx(String gn_idx) {
		this.gn_idx = gn_idx;
	}

	public String getG_idx() {
		return g_idx;
	}

	public void setG_idx(String g_idx) {
		this.g_idx = g_idx;
	}

	public String getTag_idx() {
		return tag_idx;
	}

	public void setTag_idx(String tag_idx) {
		this.tag_idx = tag_idx;
	}

	public String getTag_name() {
		return tag_name;
	}

	public void setTag_name(String tag_name) {
		this.tag_name = tag_name;
	}
	
}
