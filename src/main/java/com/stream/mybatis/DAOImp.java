package com.stream.mybatis;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSessionException;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class DAOImp implements DAO {
	@Inject
	SqlSessionTemplate template;
	
	public void setTemplate(SqlSessionTemplate template) {
		this.template = template;
	}
	
	//방문자 숫자 저장 공간 있는지 확인
	@Override
	public int getCheckConnCountStore() throws SQLException {
		// TODO Auto-generated method stub
		return template.selectOne("checkConnCountStore");
	}
	
	//방문자 저장 공간 생성 && 방문자 1 증가
	@Override
	public void setInsertConnCountStore() throws SQLException {
		// TODO Auto-generated method stub
		template.insert("insertConnCountStore");			
		
	}

	//방문자 수 증가
	@Override
	public void setUpdateConnCount() throws SQLException {
		// TODO Auto-generated method stub
		template.update("updateConnCount");
	}
	
	//7일간 방문자 수
	@Override
	public List<ConnectedCountVO> getWeekVisitAverage() throws SQLException {
		// TODO Auto-generated method stub
		return template.selectList("weekVisitAverage");
	}
	
	//총 방문자 수
	@Override
	public int getTotalVisitorCount() throws SQLException {
		// TODO Auto-generated method stub
		return template.selectOne("totalVisitorCount");
	}
		
	//id 중복 체크
	@Override
	public int getJoinIdOverlapCheck(String id) throws SQLException {
		// TODO Auto-generated method stub
		List<MemberVO> mvo = template.selectList("joinIdOverlapCheck", id);
		int result = 0;
		if(!mvo.isEmpty()) {
			result = 1;
		}
		return result;
	}

	//게임 등록 - 게임 장르 검색
	@Override
	public List<TagVO> getSearchTag(String tag) throws SQLException {
		// TODO Auto-generated method stub
		List<TagVO> tvo = template.selectList("searchTag", tag);
		
		return tvo;
	}

	//회원가입
	@Override
	public int getJoin(MemberVO mvo) throws SQLException {
		// TODO Auto-generated method stub
		return template.insert("join", mvo);
	}
	
	//개인 정보 수정
	@Override
	public int getUpdateProfiles(MemberVO mvo) throws SQLException {
		// TODO Auto-generated method stub
		return template.update("updateProfiles", mvo);
	}

	//로그인
	@Override
	public MemberVO getLoginOk(MemberVO mvo) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectOne("login", mvo);
	}

	//게임 등록
	@Override
	public int getInsertGame(GameVO gvo) throws SQLException {
		// TODO Auto-generated method stub
		return template.insert("insertGame", gvo);		
	}

	//최근 등록한 게임 번호 가져오기
	@Override
	public String getNewGameNum(String gameName) throws SQLException {
		// TODO Auto-generated method stub
		List<GameVO> gvo = template.selectList("getNewGameNum", gameName);
		String result = gvo.get(0).getG_idx();
		return result;
	}

	
	//등록한 게임의 장르 등록
	@Override
	public void getInsertNewGameGenre(String gameNum, GenreVO gnvo) throws SQLException {
		// TODO Auto-generated method stub
		String tagNum[] = gnvo.getTag_idx().split(",");
		
		for(int i=0; i < tagNum.length; i++) {
			gnvo.setG_idx(gameNum);
			gnvo.setTag_idx(tagNum[i]);
			template.insert("insertGameGenre", gnvo);
		}
	}

	//등록한 게임의 개발자 등록
	@Override
	public void getInsertNewGameDeveloper(String gameNum, DeveloperVO dvo) throws SQLException {
		// TODO Auto-generated method stub
		String developerName[] = dvo.getD_name().split(",");
		
		for(int i=0; i < developerName.length; i++) {
			dvo.setG_idx(gameNum);
			dvo.setD_name(developerName[i]);
			template.insert("insertGameDeveloper", dvo);
		}
	}

	//등록한 게임의 배급사 등록
	@Override
	public void getInsertNewGamePublisher(String gameNum, PublisherVO pvo) throws SQLException {
		// TODO Auto-generated method stub
		String publisherCompanyName[] = pvo.getP_name().split(",");
		
		for(int i=0; i < publisherCompanyName.length; i++) {
			pvo.setG_idx(gameNum);
			pvo.setP_name(publisherCompanyName[i]);
			template.insert("insertGamePublisher", pvo);
		}
	}
	
	//등록한 게임의 스크린샷 등록
	@Override
	public void getInsertNewGameScreenshot(String gameNum, ViewDataVO vvo) throws SQLException {
		// TODO Auto-generated method stub
		//String screenshotImg[] = vvo.getView_context().split(",");
		try {
			vvo.setG_idx(gameNum);
			template.insert("insertGameScreenshot", vvo);			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
	}
	
	
	//등록한 게임의 시스템 사양 등록
	@Override
	public void getInsertNewGameSystemRequirement(String gameNum, SystemRequirementVO srvo) throws SQLException {
		// TODO Auto-generated method stub
		String pcLevel[] = srvo.getPc_level().split(",");
		String osGroup[] = srvo.getOs_group().split(",");
		String osType[] = srvo.getOs_type().split(",");
		String processor[] = srvo.getProcessor().split(",");
		String memory[] = srvo.getMemory().split(",");
		String graphic[] = srvo.getGraphic().split(",");
		String directx[] = srvo.getDirectx().split(",");
		String storage[] = srvo.getStorage_space().split(",");
		String sound[] = srvo.getSound_card().split(",");
		String network[] = srvo.getNetwork().split(",");
		String note[] = srvo.getNote().split(",");
		
		for(int i=0; i < pcLevel.length; i++) {
			srvo.setG_idx(gameNum);
			
			if(pcLevel.length != 0) {
				srvo.setPc_level(pcLevel[i]);
			}else {
				srvo.setPc_level("");
			}
			
			if(osGroup.length != 0) {
				srvo.setOs_group(osGroup[i]);
			}else {
				srvo.setOs_group("");
			}
			
			if(osType.length != 0) {
				srvo.setOs_type(osType[i]);
			}else {
				srvo.setOs_type("");
			}
			
			if(processor.length != 0) {
				srvo.setProcessor(processor[i]);
			}else {
				srvo.setProcessor("");
			}
			
			if(memory.length != 0) {
				srvo.setMemory(memory[i]);
			}else {
				srvo.setMemory("");
			}
			
			if(graphic.length != 0) {
				srvo.setGraphic(graphic[i]);
			}else {
				srvo.setGraphic("");
			}
			
			if(directx.length != 0) {
				srvo.setDirectx(directx[i]);
			}else {
				srvo.setDirectx("");
			}
			
			if(storage.length != 0) {
				srvo.setStorage_space(storage[i]);
			}else {
				srvo.setStorage_space("");
			}

			if(sound.length != 0) {
				srvo.setSound_card(sound[i]);
			}else {
				srvo.setSound_card("");
			}
			
			if(network.length != 0) {
				srvo.setNetwork(network[i]);
			}else {
				srvo.setNetwork("");
			}
			
			if(note.length != 0) {
				srvo.setNote(note[i]);
			}else {
				srvo.setNote("");
			}
			
			try {
				template.insert("insertGameSystemRequirement", srvo);
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e);
			}
		}
	}
	
	//게임 수정
	@Override
	public int getUpdateGame(GameVO gvo) throws SQLException {
		// TODO Auto-generated method stub
		return template.update("updateGame", gvo);
	}
	
	//등록된 게임의 장르 제거
	@Override
	public void getDeleteGameGenre(DelGameInfoVO delvo) throws SQLException {
		// TODO Auto-generated method stub
		String gnNum[] = delvo.getDel_gn_idx().split(",");
		
		for(int i=0; i < gnNum.length; i++) {
			delvo.setDel_gn_idx(gnNum[i]);
			template.delete("deleteGameGenre", delvo);
		}
	}

	//등록된 게임의 개발자 제거
	@Override
	public void getDeleteGameDeveloper(DelGameInfoVO delvo) throws SQLException {
		// TODO Auto-generated method stub
		String dvlNum[] = delvo.getDel_dvl_idx().split(",");
		
		for(int i=0; i < dvlNum.length; i++) {
			delvo.setDel_dvl_idx(dvlNum[i]);
			template.delete("deleteGameDeveloper", delvo);
		}
	}
	
	//등록된 게임의 배급사 제거
	@Override
	public void getDeleteGamePublisher(DelGameInfoVO delvo) throws SQLException {
		// TODO Auto-generated method stub
		String pbNum[] = delvo.getDel_pc_idx().split(",");
			
		for(int i=0; i < pbNum.length; i++) {
			delvo.setDel_pc_idx(pbNum[i]);
			template.delete("deleteGamePublisher", delvo);
		}
	}
	
	//등록된 게임의 스크린샷 파일명 가져오기(제거)
	@Override
	public ViewDataVO getDeleteGameScreenshotFileName(DelGameInfoVO delvo) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectOne("deleteGameScreenshotFileName", delvo);
	}
	
	//등록된 게임의 스크린샷 제거
	public void getDeleteGameScreenshot(DelGameInfoVO delvo) {
		String vNum[] = delvo.getDel_v_idx().split(",");
			
		for(int i=0; i < vNum.length; i++) {
			delvo.setDel_v_idx(vNum[i]);
			template.delete("deleteGameScreenshot", delvo);
		}
	}
	
	//태그 가져오기
	@Override
	public List<TagVO> getTag() throws SQLException {
		// TODO Auto-generated method stub
		List<TagVO> tvo =  template.selectList("getTag");
		return tvo;
	}
	
	//태그 idx에 해당하는 태그 이름 가져오기
	@Override
	public TagVO getTagName(String tagIdx) throws SQLException {
		return template.selectOne("getTagName", tagIdx);
	}

	//게임 이름 검색(contentTop)
	@Override
	public List<GameVO> getSearchGameNameOnContentTop(String gameName) throws SQLException {
		// TODO Auto-generated method stub
		List<GameVO> gvo = template.selectList("searchGameNameOnContentTop", gameName);
		return gvo;
	}

	//게임 상세 페이지(게임 정보)
	@Override
	public GameVO getGameDetail(String g_idx) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectOne("gameDetail", g_idx);
	}

	//게임 상세 페이지(게임 장르)
	@Override
	public List<GenreVO> getGameDetailGenre(String g_idx) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectList("gameDetailGenre", g_idx);
	}

	//게임 상세 페이지(게임 개발자)
	@Override
	public List<DeveloperVO> getGameDetailDeveloper(String g_idx) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectList("gameDetailDeveloper", g_idx);
	}

	//게임 상세 페이지(게임 배급사)
	@Override
	public List<PublisherVO> getGameDetailPublisher(String g_idx) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectList("gameDetailPublisher", g_idx);
	}
	
	//게임 스크린샷(게임 상세 보기)
	@Override
	public List<ViewDataVO> getScreenshots(String g_idx) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectList("screenshots", g_idx);
	}
	
	//게임 장바구니에 담기
	@Override
	public void getAddCart(CartVO cvo) throws SQLException {
		// TODO Auto-generated method stub
		template.insert("addCart", cvo);
	}

	//게임 장바구니에서 제거
	@Override
	public void getDelCart(String c_idx) throws SQLException {
		// TODO Auto-generated method stub
		template.delete("delCart", c_idx);
	}
	
	//게임 장바구니에서 모두 제거
	@Override
	public void getDelCartAll(String id) throws SQLException {
		// TODO Auto-generated method stub
		template.delete("delCartAll", id);
	}

	//장바구니 목록 가져오기
	@Override
	public List<CartVO> getCartList(String id) throws SQLException {
		// TODO Auto-generated method stub
		List<CartVO> cvo = null;
		return template.selectList("cartList", id);
	}

	//장바구니에 존재하는지 체크
	@Override
	public int getCheckCart(CartVO cvo) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectOne("checkCart", cvo);
	}
	
	//이미 구매한 제품인지 체크
	@Override
	public int getCheckPurchase(PurchaseVO pvo) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectOne("checkPurchase", pvo);
	}

	//장바구니에 담긴 갯수
	@Override
	public int getCountCartList(String id) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectOne("countCartList", id);
	}

	//장바구니에 담긴 제품 구매
	@Override
	public List<GameVO> getPurchaseGame(String id, PurchaseVO pvo) throws SQLException {
		// TODO Auto-generated method stub
		String gameNum[] = pvo.getG_idx().split(",");
		String purchasedPrice[] = pvo.getPurchased_price().split(",");
		
		List<GameVO> gvoList = new ArrayList<GameVO>();
		
		
		for(int i=0; i < gameNum.length; i++) {
			pvo.setId(id);
			pvo.setG_idx(gameNum[i]);
			pvo.setPurchased_price(purchasedPrice[i]);
			template.insert("purchaseGame", pvo);
			
			GameVO gvo = new GameVO();
			gvo.setG_idx(gameNum[i]);
			
			gvoList.add(gvo);
		}
		
		return gvoList;
	}
	
	//구매한 게임의 판매량 증가
	@Override
	public void getUpdateGameCount(String g_idx) throws SQLException {
		// TODO Auto-generated method stub
		template.update("updateGameCount", g_idx);
	}
	
	//찜목록 호출
	@Override
	public List<WishListVO> getWishList(String id) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectList("wishList", id);
	}

	//찜목록 추가
	@Override
	public int getAddWishList(WishListVO wvo) throws SQLException {
		// TODO Auto-generated method stub
		return template.insert("addWishList", wvo);
	}
	

	//찜목록에서 삭제
	@Override
	public int getDelWishList(WishListVO wvo) throws SQLException {
		// TODO Auto-generated method stub
		return template.delete("delWishList", wvo);
	}

	//찜목록에 담긴 갯수
	@Override
	public int getCountWishList(String id) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectOne("countWishList", id);
	}

	//마지막 접속 시간 변경(로그인 시)
	@Override
	public void setLastConnect(String id) throws SQLException {
		// TODO Auto-generated method stub
		template.update("lastConnect", id);
	}

	//신규 게임 목록(신규 순)
	@Override
	public List<GameVO> getNewGameList(Map map, String orderType, String orderBy, String term, String tags) throws SQLException {
		// TODO Auto-generated method stub
		GameVO gvo = new GameVO();
		gvo.setStartPage(map.get("begin"));
		gvo.setEndPage(map.get("end"));
		
		System.out.println(gvo.getStartPage());
		System.out.println(gvo.getEndPage());
		
		gvo.setOrderType(orderType);
		gvo.setOrderBy(orderBy);
		gvo.setTerm(term);
		
		if(tags != null) {
			//태그 오름차순 정렬
			String tagFinal[] = tags.split(",");
			
			for(int i = 0; i < tagFinal.length; i++) {
				if(!tagFinal[i].equals("")) {
					for(int j = i + 1; j < tagFinal.length; j++) {
						if(Integer.parseInt(tagFinal[i]) > Integer.parseInt(tagFinal[j])) {
							String tmep = tagFinal[i];
			                tagFinal[i] = tagFinal[j];
			                tagFinal[j] = tmep;
			            }
			        }
				}
			}
			
			//태그 검색할 수 있도록 문자열로 전달
			String goSearchTag = "";
			for(int i=0; i < tagFinal.length; i++) {
				if(tagFinal[i].equals("")) {
					goSearchTag = "";	
				} else {
					if(i == 0) {
						goSearchTag = tagFinal[i];
					}else {
						//ex) 게임 tag 361,362,363일 때, 검색을 361, 363만 할 경우 해당 게임이 출력 x
						//그래서 % 추가함
						goSearchTag += ",%" + tagFinal[i];
					}
				}
			}
			gvo.setTag_idx(goSearchTag);
		}
		else {
			gvo.setTag_idx("");
		}
		
		return template.selectList("newGameList", gvo);			
	}

	//태그에 따라 게임 검색
	@Override
	public List<GameVO> getSearchGamebyTag(String tag) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectList("searchGameByTag", tag);
	}
	
	//내 구매내역 조회
	@Override
	public List<PurchaseVO> getMyPurchasedList(String id) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectList("myPurchasedList", id);
	}
	
		
	
	
	
	
	//선택한 옵션들에 해당하는 게임 검색 
	@Override
	public List<DetailSearchVO> getSearchOptions(String term, String tag, String hasExpFile, String playerCount, String vrsupport,
			String os, String sortBy) throws SQLException {
		// TODO Auto-generated method stub
		DetailSearchVO dsvo = new DetailSearchVO();
		
		String searchOs[] = os.split(",");
		String total = tag + "," + playerCount + "," + vrsupport;
		
		String totalOverlapChk[] = total.split(",");
		String overlapChked = "";
	
		//System.out.println("before length=" + totalOverlapChk.length);
		 
		totalOverlapChk = new HashSet<String>(Arrays.asList(totalOverlapChk)).toArray(new String[0]);
		 
		for(int i=0; i < totalOverlapChk.length; i++) {
			if(i == 0) {
				overlapChked =  totalOverlapChk[i];
			}else {
				overlapChked += "," + totalOverlapChk[i];
			}
		}
		
		
		//태그 오름차순 정렬
		String totalFinal[] = overlapChked.split(",");
		for(int i = 0; i < totalFinal.length; i++) {
			if(!totalFinal[i].equals("")) {
	            for(int j = i + 1; j < totalFinal.length; j++) {
	                if(Integer.parseInt(totalFinal[i]) > Integer.parseInt(totalFinal[j])) {
	                    String tmep = totalFinal[i];
	                    totalFinal[i] = totalFinal[j];
	                    totalFinal[j] = tmep;
	                }
	            }
			}
        }
		
		//태그 검색할 수 있도록 문자열로 전달
		String goSearchTag = "";
		for(int i=0; i < totalFinal.length; i++) {
			if(totalFinal[i].equals("")) {
				goSearchTag = "";	
			} else {
				if(i == 0) {
					goSearchTag = totalFinal[i];
				}else {
					//ex) 게임 tag 361,362,363일 때, 검색을 361, 363만 할 경우 해당 게임이 출력 x
					//그래서 % 추가함
					goSearchTag += ",%" + totalFinal[i];
				}
			}
		}
		
		if(!hasExpFile.equals("")) {
			dsvo.setGame_exp_file("exist");
		}
		
		if(sortBy.equals("byName")) {
			dsvo.setOrderType("g_name");
		}
		else if(sortBy.equals("byReleasedate")) {
			dsvo.setOrderType("release_date");
			dsvo.setOrderBy("desc");
		}
		else if(sortBy.equals("byLowprice")) {
			dsvo.setOrderType("price");
		}
		else if(sortBy.equals("byHighprice")) {
			dsvo.setOrderType("price");
			dsvo.setOrderBy("desc");
		}
		else if(sortBy.equals("byCount")) {
			dsvo.setOrderType("count");
			dsvo.setOrderBy("desc");
		}
		
		dsvo.setTag_idx(goSearchTag);
		dsvo.setG_name(term);
		
		
		return template.selectList("searchGame", dsvo);
		
		/*
		for(int i=0; i < ds.size(); i++) {
			String s = ds.get(i).getG_idx();
			System.out.println(s);
		}
		*/
	}

	
	//평가 등록 페이지로 이동
	@Override
	public EvaluationVO getPurchasedInfo(String p_idx) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectOne("evaluate", p_idx);
	}

	//평가 등록
	@Override
	public void setInsertEvaluation(EvaluationVO evo) throws SQLException {
		// TODO Auto-generated method stub
		template.insert("insertEvaluation", evo);
	}

	//등록된 평가 있는지 확인
	@Override
	public EvaluationVO getChkEvaluate(EvaluationVO evo) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectOne("chkEvaluate", evo);
	}

	//평가 수정
	@Override
	public void updateEvaluation(EvaluationVO evo) throws SQLException {
		// TODO Auto-generated method stub
		template.update("updateEvaluation", evo);
	}

	//평가 삭제
	@Override
	public void deleteEvaluation(String e_idx) throws SQLException {
		// TODO Auto-generated method stub
		template.delete("deleteEvaluation", e_idx);
		
	}

	//내 평가 목록 가져오기
	@Override
	public List<EvaluationVO> getReviewList(String id) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectList("selectReviewList", id);
	}

	//내 게임 갯수 가져오기
	@Override
	public int getCountMyGame(String id) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectOne("countMyGame", id);
	}

	//게임 상세 리뷰
	@Override
	public List<EvaluationVO> getGameDetailReviews(String g_id) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectList("gameDetailReviews", g_id);
	}

	//평가 옵션에 따라 검색
	@Override
	public List<EvaluationVO> getSearchReviewByOptions(EvaluationVO evo) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectList("searchReviewByOptions", evo);
	}

	
	
	
	
	//관리자 게임 목록
	@Override
	public List<GameVO> getAdminGameList() throws SQLException {
		// TODO Auto-generated method stub
		return template.selectList("adminGameList");
	}
	
	//관리자 할인 목록
	@Override
	public List<GameVO> getAdminSaleList() throws SQLException {
		// TODO Auto-generated method stub
		return template.selectList("adminSaleList");
	}
	
	//게임 할인 갯수
	@Override
	public int getCountDiscountGameNow() throws SQLException {
		// TODO Auto-generated method stub
		return template.selectOne("countDiscountGameNow");
	}
	

	//관리자 게임 할인 등록
	public int getAddDiscountGame(DiscountGameVO dgvo) throws SQLException {
		return template.insert("addDiscountGame", dgvo);
	}

	//관리자 할인 등록된 게임 번호
	@Override
	public int getAddedDiscountGameNum(DiscountGameVO dgvo) throws SQLException {
		// TODO Auto-generated method stub
		DiscountGameVO result = template.selectOne("addedDiscountGameNum", dgvo);
		int dc_idx = Integer.parseInt(result.getD_idx());
		return dc_idx;
	}

	//관리자 해당 게임 할인 정보 호출
	@Override
	public DiscountGameVO getDiscountGameInfo(String d_idx) throws SQLException {
		// TODO Auto-generated method stub
		return template.selectOne("discountGameInfo", d_idx);
	}

	//관리자 할인 정보 수정
	@Override
	public int getEditDiscountGame(DiscountGameVO dgvo) throws SQLException {
		// TODO Auto-generated method stub
		return template.update("editDiscountGame", dgvo);
	}

	//관리자 할인 삭제
	@Override
	public int getDeleteDiscountGame(String d_idx) throws SQLException {
		// TODO Auto-generated method stub
		return template.delete("deleteDiscountGame", d_idx);
	}

	
	/* 페이징 Start*/
	//게임 총 갯수
	@Override
	public int getTotalCount(String term, String tags) throws Exception {
		// TODO Auto-generated method stub
		GameVO gvo = new GameVO();
		
		if(tags != null) {
			//태그 오름차순 정렬
			String tagFinal[] = tags.split(",");
			
			for(int i = 0; i < tagFinal.length; i++) {
				if(!tagFinal[i].equals("")) {
					for(int j = i + 1; j < tagFinal.length; j++) {
						if(Integer.parseInt(tagFinal[i]) > Integer.parseInt(tagFinal[j])) {
							String tmep = tagFinal[i];
			                tagFinal[i] = tagFinal[j];
			                tagFinal[j] = tmep;
			            }
			        }
				}
			}
			
			//태그 검색할 수 있도록 문자열로 전달
			String goSearchTag = "";
			for(int i=0; i < tagFinal.length; i++) {
				if(tagFinal[i].equals("")) {
					goSearchTag = "";	
				} else {
					if(i == 0) {
						goSearchTag = tagFinal[i];
					}else {
						//ex) 게임 tag 361,362,363일 때, 검색을 361, 363만 할 경우 해당 게임이 출력 x
						//그래서 % 추가함
						goSearchTag += ",%" + tagFinal[i];
					}
				}
			}
			gvo.setTag_idx(goSearchTag);
		}
		else {
			gvo.setTag_idx("");
		}
		gvo.setTerm(term);			
		
		return template.selectOne("totalcount", gvo);
	}

	

	/* 페이징 End*/
	

	

	

	


	
	

	
	

	




	
	
}
