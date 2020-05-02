package com.stream.mybatis;

public class GameVO {
	private String g_idx, g_name, cover, detail_img, content_summary, content, release_date, price, age, game_exp_file, game_file, count, state;
	private String tag_idx;
	
	//시작 페이지 & 끝 페이지
	private String startPage, endPage;
	
	//정렬 방법
	private String orderBy, orderType;
	
	//검색어
	private String term, tags;
	
	//할인
	private String d_idx, percent, start_date, end_date;
	
	//리뷰 갯수, 리뷰 총점
	private String review_count, review_score;
	
	
	public String getTag_idx() {
		return tag_idx;
	}

	public void setTag_idx(String tag_idx) {
		this.tag_idx = tag_idx;
	}

	
	
	public String getG_idx() {
		return g_idx;
	}

	public void setG_idx(String g_idx) {
		this.g_idx = g_idx;
	}

	public String getG_name() {
		return g_name;
	}

	public void setG_name(String g_name) {
		this.g_name = g_name;
	}

	public String getCover() {
		return cover;
	}

	public void setCover(String cover) {
		this.cover = cover;
	}

	public String getDetail_img() {
		return detail_img;
	}

	public void setDetail_img(String detail_img) {
		this.detail_img = detail_img;
	}

	public String getContent_summary() {
		return content_summary;
	}

	public void setContent_summary(String content_summary) {
		this.content_summary = content_summary;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}
	
	public String getGame_exp_file() {
		return game_exp_file;
	}

	public void setGame_exp_file(String game_exp_file) {
		this.game_exp_file = game_exp_file;
	}

	public String getGame_file() {
		return game_file;
	}

	public void setGame_file(String game_file) {
		this.game_file = game_file;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
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

	public String getTerm() {
		return term;
	}

	public void setTerm(String term) {
		this.term = term;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
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
