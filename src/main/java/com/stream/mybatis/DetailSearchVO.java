package com.stream.mybatis;

public class DetailSearchVO {
	private String tag_idx, tag_name, game_exp_file, g_name;
	private String g_idx, release_date, price, count, cover;
	private String orderBy, orderType;
	
	//할인
	private String d_idx, percent, start_date, end_date;
	
	//리뷰 갯수, 리뷰 총점
	private String review_count, review_score;

	//페이지
	private String startPage, endPage;
	
	
	
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

	public String getGame_exp_file() {
		return game_exp_file;
	}

	public void setGame_exp_file(String game_exp_file) {
		this.game_exp_file = game_exp_file;
	}

	public String getG_name() {
		return g_name;
	}

	public void setG_name(String g_name) {
		this.g_name = g_name;
	}

	public String getG_idx() {
		return g_idx;
	}

	public void setG_idx(String g_idx) {
		this.g_idx = g_idx;
	}

	public String getRelease_date() {
		return release_date;
	}

	public void setRelease_date(String release_date) {
		this.release_date = release_date;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	public String getCover() {
		return cover;
	}

	public void setCover(String cover) {
		this.cover = cover;
	}

	public String getD_idx() {
		return d_idx;
	}

	public void setD_idx(String d_idx) {
		this.d_idx = d_idx;
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

	public String getReview_count() {
		return review_count;
	}

	public void setReview_count(String review_count) {
		this.review_count = review_count;
	}

	public String getReview_score() {
		return review_score;
	}

	public void setReview_score(String review_score) {
		this.review_score = review_score;
	}

	public String getStartPage() {
		return startPage;
	}

	public void setStartPage(Object object) {
		this.startPage = String.valueOf((int) object);
	}

	public String getEndPage() {
		return endPage;
	}

	public void setEndPage(Object object) {
		this.endPage = String.valueOf((int) object);
	}
	
}
