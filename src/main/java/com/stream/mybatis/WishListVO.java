package com.stream.mybatis;

public class WishListVO {
	private String w_idx, id, g_idx, saved_date;
	private String g_name, price, release_date, cover, count;
	
	//태그
	private String tag_idx, tag_name;
	//할인
	private String d_dix, percent, start_date, end_date, endroll_date;
	
	//장바구니
	private String c_idx, cart_date;
	
	
	public String getW_idx() {
		return w_idx;
	}

	public void setW_idx(String w_idx) {
		this.w_idx = w_idx;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getG_idx() {
		return g_idx;
	}

	public void setG_idx(String g_idx) {
		this.g_idx = g_idx;
	}

	public String getSaved_date() {
		return saved_date;
	}

	public void setSaved_date(String saved_date) {
		this.saved_date = saved_date;
	}

	public String getG_name() {
		return g_name;
	}

	public void setG_name(String g_name) {
		this.g_name = g_name;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getRelease_date() {
		return release_date;
	}

	public void setRelease_date(String release_date) {
		this.release_date = release_date;
	}

	public String getCover() {
		return cover;
	}

	public void setCover(String cover) {
		this.cover = cover;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	/////////////////////////////////////
	
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

	public String getD_dix() {
		return d_dix;
	}

	public void setD_dix(String d_dix) {
		this.d_dix = d_dix;
	}

	public String getPercent() {
		return percent;
	}

	public void setPercent(String percent) {
		this.percent = percent;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getEndroll_date() {
		return endroll_date;
	}

	public void setEndroll_date(String endroll_date) {
		this.endroll_date = endroll_date;
	}

	public String getC_idx() {
		return c_idx;
	}

	public void setC_idx(String c_idx) {
		this.c_idx = c_idx;
	}

	public String getCart_date() {
		return cart_date;
	}

	public void setCart_date(String cart_date) {
		this.cart_date = cart_date;
	}

	
}
