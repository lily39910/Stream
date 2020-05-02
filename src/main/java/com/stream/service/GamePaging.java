package com.stream.service;

public class GamePaging {
	// 전체 게시물의 수 구하기
	// 각 페이지시작번호와 페이지끝번호 구하기
	// 페이지의 묶음인 블록시작번호와 블록끝번호 구하기
	int nowPage = 1; // 현재페이지
	int nowBlock = 1; // 현재 블록
	int totalRecord = 0; // 전체 게시물의 수(원글의 수)
	int numPerPage = 5; // 한페이지에 존재하는 원글의 수
	int pagePerBlock = 5; // 블록당 페이지의 수
	int totalPage = 0; // 전체 페이지의 수
	int totalBlock = 0; // 전체블록의 수

	int begin = 0; // 시작페이지
	int end = 0; // 끝페이지
	int beginPage = 0;// 블록의 시작번호
	int endPage = 0; // 블록의 끝번호

	// 전체게시물의 수를 가지고 전체 페이지의 수를 구하자
	// totalPage = totalRecord / numPerPage;
	// 주의 사항 : 나머지가 존재하면 totalPage 1 증가
	public void setTotalPage() {
		totalPage = totalRecord / numPerPage;
		if (totalRecord % numPerPage != 0) {
			totalPage++;
		}
	}

	public int getNowPage() {
		return nowPage;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}

	public int getNowBlock() {
		return nowBlock;
	}

	public void setNowBlock(int nowBlock) {
		this.nowBlock = nowBlock;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public int getNumPerPage() {
		return numPerPage;
	}

	public void setNumPerPage(int numPerPage) {
		this.numPerPage = numPerPage;
	}

	public int getPagePerBlock() {
		return pagePerBlock;
	}

	public void setPagePerBlock(int pagePerBlock) {
		this.pagePerBlock = pagePerBlock;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotalBlock() {
		return totalBlock;
	}

	public void setTotalBlock(int totalBlock) {
		this.totalBlock = totalBlock;
	}

	public int getBegin() {
		return begin;
	}

	public void setBegin(int begin) {
		this.begin = begin;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public int getBeginPage() {
		return beginPage;
	}

	public void setBeginPage(int beginPage) {
		this.beginPage = beginPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
}
