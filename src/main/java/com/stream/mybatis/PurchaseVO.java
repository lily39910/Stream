package com.stream.mybatis;

public class PurchaseVO {
	private String p_idx, id, g_idx, purchased_price, purchase_date, purchase_state;
	private String g_name, cover, game_file;
	
	public String getP_idx() {
		return p_idx;
	}

	public void setP_idx(String p_idx) {
		this.p_idx = p_idx;
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

	public String getPurchased_price() {
		return purchased_price;
	}

	public void setPurchased_price(String purchased_price) {
		this.purchased_price = purchased_price;
	}

	public String getPurchase_date() {
		return purchase_date;
	}

	public void setPurchase_date(String purchase_date) {
		this.purchase_date = purchase_date;
	}

	public String getPurchase_state() {
		return purchase_state;
	}

	public void setPurchase_state(String purchase_state) {
		this.purchase_state = purchase_state;
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

	public String getGame_file() {
		return game_file;
	}

	public void setGame_file(String game_file) {
		this.game_file = game_file;
	}
	
	
}
