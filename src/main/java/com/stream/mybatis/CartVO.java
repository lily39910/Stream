package com.stream.mybatis;

public class CartVO {
	private String c_idx, id, g_idx, cart_date;
	private String w_idx;
	
	public String getW_idx() {
		return w_idx;
	}

	public void setW_idx(String w_idx) {
		this.w_idx = w_idx;
	}
	

	public String getC_idx() {
		return c_idx;
	}

	public void setC_idx(String c_idx) {
		this.c_idx = c_idx;
	}

	public String getG_idx() {
		return g_idx;
	}

	public void setG_idx(String g_idx) {
		this.g_idx = g_idx;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCart_date() {
		return cart_date;
	}

	public void setCart_date(String cart_date) {
		this.cart_date = cart_date;
	}
	
}
