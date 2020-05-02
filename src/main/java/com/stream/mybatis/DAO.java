package com.stream.mybatis;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionException;

public interface DAO {
	//방문자 숫자 저장 공간 있는지 확인
	public int getCheckConnCountStore() throws SQLException;
	//방문자 저장 공간 생성 && 방문자 1 증가
	public void setInsertConnCountStore() throws SQLException;
	//방문자 수 증가
	public void setUpdateConnCount() throws SQLException;
	
	//7일간 방문자 수
	public List<ConnectedCountVO> getWeekVisitAverage() throws SQLException;
	//총 방문자 수
	public int getTotalVisitorCount() throws SQLException;
	
	
	//AJAX
	//아이디 중복 체크
	public int getJoinIdOverlapCheck(String id) throws SQLException;
	//게임 등록(태그 검색)
	public List<TagVO> getSearchTag(String tag) throws SQLException;
	//로그인
	public MemberVO getLoginOk(MemberVO mvo) throws SQLException;
	//게임 이름 검색(searchGameNameOnContentTop)
	public List<GameVO> getSearchGameNameOnContentTop(String gameName) throws SQLException;
	//마지막 접속 시간 변경(로그인 시)
	public void setLastConnect(String id) throws SQLException;
	//태그에 따라 게임 검색
	public List<GameVO> getSearchGamebyTag(String tag) throws SQLException;
	//태그로 게임 검색(이름, 정렬 방법 ...)
	public List<DetailSearchVO> getSearchOptions(String term, String tag, String hasExpFile, String playerCount, String vrsupport, String os, String sortBy) throws SQLException;
	//평가 옵션에 따라 검색
	public List<EvaluationVO> getSearchReviewByOptions(EvaluationVO evo) throws SQLException;
	//관리자 할인 등록된 게임 번호
	public int getAddedDiscountGameNum(DiscountGameVO dgvo) throws SQLException;
	//관리자 해당 게임 할인 정보 호출
	public DiscountGameVO getDiscountGameInfo(String d_idx) throws SQLException;
	//관리자 할인 정보 수정
	public int getEditDiscountGame(DiscountGameVO dgvo) throws SQLException;
	//관리자 할인 삭제
	public int getDeleteDiscountGame(String d_idx) throws SQLException;
	
	
	//Controller
	//회원 가입
	public int getJoin(MemberVO mvo) throws SQLException;
	
	//개인 정보 수정
	public int getUpdateProfiles(MemberVO mvo) throws SQLException;

	//태그 가져오기
	public List<TagVO> getTag() throws SQLException;
	
	//태그 idx에 따라 이름 가져오기
	public TagVO getTagName(String tagIdx) throws SQLException;
	
	
	//게임 등록
	public int getInsertGame(GameVO gvo) throws SQLException;

	//최근에 등록한 게임 번호 가져오기
	public String getNewGameNum(String gameName) throws SQLException;
	
	//등록한 게임의 장르 등록
	public void getInsertNewGameGenre(String gameNum, GenreVO gnvo) throws SQLException;
	
	//등록한 게임의 개발자 등록
	public void getInsertNewGameDeveloper(String gameNum, DeveloperVO dvo) throws SQLException;
	
	//등록한 게임의 배급사 등록
	public void getInsertNewGamePublisher(String gameNum, PublisherVO pvo) throws SQLException;
	
	//등록한 게임의 스크린샷 등록
	public void getInsertNewGameScreenshot(String gameNum, ViewDataVO vvo) throws SQLException;
	
	//등록한 게임의 시스템 사양 등록
	public void getInsertNewGameSystemRequirement(String gameNum, SystemRequirementVO srvo) throws SQLException;
	
	//게임 수정
	public int getUpdateGame(GameVO gvo) throws SQLException;
	
	//등록된 게임의 장르 제거
	public void getDeleteGameGenre(DelGameInfoVO delvo) throws SQLException;
	
	//등록된 게임의 개발자 제거
	public void getDeleteGameDeveloper(DelGameInfoVO delvo) throws SQLException;
	
	//등록된 게임의 배급사 제거
	public void getDeleteGamePublisher(DelGameInfoVO delvo) throws SQLException;
	
	//등록된 게임의 스크린샷 파일명 가져오기(제거)
	public ViewDataVO getDeleteGameScreenshotFileName(DelGameInfoVO delvo) throws SQLException;
	
	//등록된 게임의 스크린샷 제거
	public void getDeleteGameScreenshot(DelGameInfoVO delvo) throws SQLException;
	
	//게임 정보(게임 상세 보기)
	public GameVO getGameDetail(String g_idx) throws SQLException;

	//게임 장르(게임 상세 보기)
	public List<GenreVO> getGameDetailGenre(String g_idx) throws SQLException;

	//게임 개발자(게임 상세 보기)
	public List<DeveloperVO> getGameDetailDeveloper(String g_idx) throws SQLException;
	
	//게임 배급사(게임 상세 보기)
	public List<PublisherVO> getGameDetailPublisher(String g_idx) throws SQLException;
	
	//게임 스크린샷(게임 상세 보기)
	public List<ViewDataVO> getScreenshots(String g_idx) throws SQLException;
	
	//게임 장바구니에 담기
	public void getAddCart(CartVO cvo) throws SQLException;
	
	//게임 장바구니에서 제거
	public void getDelCart(String c_idx) throws SQLException;
	
	//게임 장바구니에서 모두 제거
	public void getDelCartAll(String id) throws SQLException;
	
	//장바구니 목록 가져오기
	public List<CartVO> getCartList(String id) throws SQLException;
	
	//장바구니에 존재하는지 체크
	public int getCheckCart(CartVO cvo) throws SQLException;
	
	//이미 구매한 제품인지 체크
	public int getCheckPurchase(PurchaseVO pvo) throws SQLException;
	
	//장바구니에 담긴 갯수
	public int getCountCartList(String id) throws SQLException;
	
	//장바구니에 담긴 제품 구매
	public List<GameVO> getPurchaseGame(String id, PurchaseVO pvo) throws SQLException;
	
	//구매한 게임의 판매량 증가
	public void getUpdateGameCount(String g_idx) throws SQLException;
	
	//찜목록 가져오기
	public List<WishListVO> getWishList(String id) throws SQLException;
	
	//찜목록에 추가
	public int getAddWishList(WishListVO wvo) throws SQLException;

	//찜목록에서 제거
	public int getDelWishList(WishListVO wvo) throws SQLException;
	
	//찜목록 갯수 
	public int getCountWishList(String id) throws SQLException;
	
	//신규 게임 목록(신규 순)
	public List<GameVO> getNewGameList(Map map, String orderType, String orderBy, String term, String tags) throws SQLException;
	
	//내 구매 목록
	public List<PurchaseVO> getMyPurchasedList(String id) throws SQLException;
	
	//평가 등록 페이지 이동
	public EvaluationVO getPurchasedInfo(String p_idx) throws SQLException;
	
	//평가 등록
	public void setInsertEvaluation(EvaluationVO evo) throws SQLException;
	
	//등록된 평가 있는지 확인
	public EvaluationVO getChkEvaluate(EvaluationVO evo) throws SQLException;

	//평가 수정
	public void updateEvaluation(EvaluationVO evo) throws SQLException;
	
	//평가 삭제
	public void deleteEvaluation(String e_idx) throws SQLException;
	
	//내 평가 목록 가져오기
	public List<EvaluationVO> getReviewList(String id) throws SQLException;
	
	//내 게임 갯수 가져오기
	public int getCountMyGame(String id) throws SQLException;
	
	//게임 상세 리뷰
	public List<EvaluationVO> getGameDetailReviews(String g_id) throws SQLException;


	
	
	
	
	//관리자 게임 목록
	public List<GameVO> getAdminGameList() throws SQLException;
	
	//게임 할인 갯수
	public int getCountDiscountGameNow() throws SQLException;
	
	//관리자 할인 목록
	public List<GameVO> getAdminSaleList() throws SQLException;
	
	//관리자 게임 할인 등록
	public int getAddDiscountGame(DiscountGameVO dgvo) throws SQLException;
	
	
	
	/* 페이징 Start */
	//총 게임 갯수
	public int getTotalCount(String term, String tags) throws Exception;
	
	/* 페이징 End */
}

