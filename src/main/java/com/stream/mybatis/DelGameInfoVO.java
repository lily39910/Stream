package com.stream.mybatis;

public class DelGameInfoVO {
	private String g_idx; //게임 번호
	private String del_v_idx; //스크린샷 번호
	private String del_gn_idx; //장르 번호
	private String del_dvl_idx; //개발자 번호
	private String del_pc_idx; //배급사 번호
	
	public String getG_idx() {
		return g_idx;
	}
	public void setG_idx(String g_idx) {
		this.g_idx = g_idx;
	}
	public String getDel_v_idx() {
		return del_v_idx;
	}
	public void setDel_v_idx(String del_v_idx) {
		this.del_v_idx = del_v_idx;
	}
	public String getDel_gn_idx() {
		return del_gn_idx;
	}
	public void setDel_gn_idx(String del_gn_idx) {
		this.del_gn_idx = del_gn_idx;
	}
	public String getDel_dvl_idx() {
		return del_dvl_idx;
	}
	public void setDel_dvl_idx(String del_dvl_idx) {
		this.del_dvl_idx = del_dvl_idx;
	}
	public String getDel_pc_idx() {
		return del_pc_idx;
	}
	public void setDel_pc_idx(String del_pc_idx) {
		this.del_pc_idx = del_pc_idx;
	}
}
