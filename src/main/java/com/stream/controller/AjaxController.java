package com.stream.controller;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.MvcNamespaceHandler;

import com.stream.mybatis.CartVO;
import com.stream.mybatis.ConnectedCountVO;
import com.stream.mybatis.DAO;
import com.stream.mybatis.DetailSearchVO;
import com.stream.mybatis.DiscountGameVO;
import com.stream.mybatis.EvaluationVO;
import com.stream.mybatis.GameVO;
import com.stream.mybatis.MemberVO;
import com.stream.mybatis.PurchaseVO;
import com.stream.mybatis.TagVO;
import com.stream.mybatis.WishListVO;

@RestController
@RequestMapping("/StreamAjax")
public class AjaxController {
	@Inject
	DAO dao;
	
	public void setDao(DAO dao) {
		this.dao = dao;
	}

	/*아이디 중복체크*/
	@RequestMapping("/joinIdOverlapCheck")
	public int joinIdOverlapCheck(HttpServletRequest req) {
		String id_overlap_chk = req.getParameter("id_overlap_chk");
		int result = 0;
		
		try {
			result = dao.getJoinIdOverlapCheck(id_overlap_chk);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}
	
	
	/*장르 검색*/
	@RequestMapping("/SearchTag")
	public List<TagVO> searchTag(HttpServletRequest req){
		String searchTag = req.getParameter("searchTag");
		List<TagVO> result = null;
		try {
			result = dao.getSearchTag(searchTag);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}
	
	/* 로그인 */
	@RequestMapping("/loginOk")
	public MemberVO loginOk(HttpServletRequest req) {
		//세션
		HttpSession session = req.getSession();
		
		MemberVO user = null;
		MemberVO mvo = new MemberVO();
		String id = req.getParameter("id");
		String pwd = req.getParameter("pwd");
		mvo.setId(id);
		mvo.setPwd(pwd);
		
		try {
			user = dao.getLoginOk(mvo);
			
			if(user != null) {
				String lastConn = null;
				if(user.getLast_conn() != null) {
					lastConn = user.getLast_conn().substring(0, 8);
				}

				SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ("yy-MM-dd", Locale.KOREA);
				Date currentTime = new Date();
				String mTime = mSimpleDateFormat.format (currentTime);
				int todayStore = dao.getCheckConnCountStore();
				if(todayStore == 0) {
					//저장 공간 생성 && 접속 수 1 증가
					dao.setInsertConnCountStore();
				}
				else { //저장 공간 존재
					//오늘 날짜와 비교
					if(lastConn == null || !lastConn.equals(mTime)) {
						dao.setUpdateConnCount();
					}
				}
				dao.setLastConnect(id); //접속 날짜 업데이트
				//장바구니 갯수
				int cartCount = dao.getCountCartList(id);
				session.setAttribute("cart_count", cartCount);
				int wishCount = dao.getCountWishList(id);
				session.setAttribute("wish_count", wishCount);
				
				
				session.setAttribute("login_chk", true);
				session.setAttribute("user", user);
				session.setAttribute("userType", user.getType());	
			} else {
				session.setAttribute("login_chk", false);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return user;
	}
	
	
	/* 7일간 방문자 수 */
	@RequestMapping("/weekVistCount")
	public List<ConnectedCountVO> WeekVistAverage(){
		List<ConnectedCountVO> cncvo = null;
		try {
			cncvo = dao.getWeekVisitAverage();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return cncvo;
	}
	
	
	/*contentTopMenu - 게임 검색*/
	@RequestMapping("/searchGameNameOnContentTop")
	public List<GameVO> SearchGameOnContentTop(HttpServletRequest req){
		String gameName = req.getParameter("searchGameNameOnContentTop");
		List<GameVO> searchedGameVO = null;
		
		try {
			searchedGameVO = dao.getSearchGameNameOnContentTop(gameName);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return searchedGameVO;
	}
	
	
	/*장바구니에서 제거(하나)*/
	@RequestMapping("/del_cart")
	public void goCartDelete(HttpServletRequest req) {
		String c_idx = req.getParameter("c_idx");
		String total_p = req.getParameter("total_p");
		
		HttpSession session = req.getSession();
		
		try {
			dao.getDelCart(c_idx);
			session.setAttribute("total_p", total_p);
			int cartCount = (Integer) session.getAttribute("cart_count");
			session.setAttribute("cart_count", cartCount-1);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	
	/*장바구니에서 제거(전체)*/
	@RequestMapping("/del_cartAll")
	public void goCartDeleteAll(HttpServletRequest req) {
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("user");
		String user = mvo.getId();
		try {
			dao.getDelCartAll(user);
			session.setAttribute("total_p", 0);
			session.setAttribute("cart_count", 0);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
	}
	
	/*장바구니에 존재하는지, 구매한 제품인지 체크*/
	@RequestMapping("/check_cart")
	public int goCheckCart(HttpServletRequest req) {
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("user");
		int result = 0;
		
		if(mvo != null) {
			String id = mvo.getId();
			String g_idx = req.getParameter("g_idx");
			//장바구니 체크
			CartVO cvo = new CartVO();
			cvo.setId(id);
			cvo.setG_idx(g_idx);
			
			//구매 목록 체크
			PurchaseVO pvo = new PurchaseVO();
			pvo.setId(id);
			pvo.setG_idx(g_idx);
			
			try {
				int p = dao.getCheckPurchase(pvo);
				
				if(p != 0) {
					result = p + 1; //이미 구매한 경우 2를 반환
				} else {
					result = dao.getCheckCart(cvo); //장바구니에 존재할 경우 1 반환
												//(장바구니에 동일 제품 여러개일 경우 error 가능성 있음)
				}
				//장바구니 담기 가능한 경우는 0 반환

			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e);
			}
		}
		return result;
	}
	
	/*장바구니에 추가*/
	/*
	@RequestMapping("/add_cart")
	public void goAddCart(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String g_idx = req.getParameter("g_idx");
		MemberVO mvo = (MemberVO) session.getAttribute("user");
		String id = mvo.getId();
		CartVO cvo = new CartVO();
		cvo.setId(id);
		cvo.setG_idx(g_idx);
		try {
			dao.getAddCart(cvo);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	*/
	
	/*찜목록에 추가*/
	@RequestMapping("/add_wishList")
	public int goAddWishList(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String g_idx = req.getParameter("g_idx");
		MemberVO mvo = (MemberVO) session.getAttribute("user");
		String id = mvo.getId();
		WishListVO wvo = new WishListVO();
		wvo.setG_idx(g_idx);
		wvo.setId(id);
		
		int result = 0;
		try {
			result = dao.getAddWishList(wvo);
			int wishCount = (Integer) session.getAttribute("wish_count");
			session.setAttribute("wish_count", wishCount+1);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}
	
	/*찜목록에서 제거*/
	@RequestMapping("/del_wishlist")
	public int goDelWishList(HttpServletRequest req, WishListVO wvo) {
		HttpSession session = req.getSession();
		int wishCount =  (Integer) session.getAttribute("wish_count");
		
		try {
			if(wishCount != 0) {
				wishCount = wishCount-1;
				session.setAttribute("wish_count", wishCount);
				dao.getDelWishList(wvo);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return wishCount;
	}
	
	
	/*찜목록 가져오기*/
	@RequestMapping("/reload_wishlist")
	public List<WishListVO> goReloadWishList(HttpServletRequest req) {
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("user");
		String id = mvo.getId();
		List<WishListVO> wvolist = null;
		try {
			wvolist = dao.getWishList(id);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return wvolist;
	}
	
	
	
	
	/*gameSearchSpecial - 게임 이름 검색*/
	@RequestMapping("/searchGameName")
	public List<GameVO> searchGameName(HttpServletRequest req){
		String gameName = req.getParameter("searchGameName");
		List<GameVO> searchedGameVO = null;
		
		try {
			searchedGameVO = dao.getSearchGameNameOnContentTop(gameName);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return searchedGameVO;
	}
	
	/* searchGamebyTag - 태그로 검색(tag 페이지) */
	@RequestMapping("/searchGamebyTag")
	public List<GameVO> searchGamebyTag(HttpServletRequest req){
		String tag = req.getParameter("tag");
		List<GameVO> resultBytag = null;
		try {
			resultBytag = dao.getSearchGamebyTag(tag);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return resultBytag;
	}
	
	
	/* 게임 평가 옵션에 따라 검색 */
	@RequestMapping("/searchReviews")
	public List<EvaluationVO> searchReviews(HttpServletRequest req){
		String g_idx = req.getParameter("g_idx");
		String e_opinion = req.getParameter("e_opinion");
		String orderBy = req.getParameter("order");
		
		EvaluationVO evo = new EvaluationVO();
		evo.setE_opinion(e_opinion);
		evo.setOrderBy(orderBy);
		evo.setG_idx(g_idx);
		
		List<EvaluationVO> evoList = null;
		
		try {
			evoList = dao.getSearchReviewByOptions(evo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e);
		}
		
		return evoList;
		
	}
	
	
	/*gameSearchSpecial - 선택한 옵션들에 해당하는 게임 검색 */
	@RequestMapping("/searchOptions")
	public List<DetailSearchVO> searchOptions(HttpServletRequest req){
		String term = req.getParameter("term"); //게임 이름
		String tag = req.getParameter("tags"); //게임 태그hasExpFile
		String hasExpFile = req.getParameter("category1"); //게임 체험판 유무
		String playerCount = req.getParameter("category3"); //게임 플레이어 수
		String vrsupport = req.getParameter("vrsupport"); //vr
		String os = req.getParameter("os"); //운영체제
		String sortBy = req.getParameter("sortBy"); //정렬 방법
		List<DetailSearchVO> dsvo = null;
		
		try {
			dsvo = dao.getSearchOptions(term, tag, hasExpFile, playerCount, vrsupport, os, sortBy);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return dsvo; 
	}
	
	
	/*게임 할인 등록*/
	@RequestMapping("/addDiscountGame")
	public int addDiscountGame(DiscountGameVO dgvo) {
		int result = 0;
		try {
			result = dao.getAddDiscountGame(dgvo);
			System.out.println("1");
			
			if(result == 1) {
				result = dao.getAddedDiscountGameNum(dgvo);
				System.out.println("2");
			}else {
				//에러
				result = 0;
				System.out.println("3");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("errr");
		}
		return result;
	}
	
	/*해당 게임 할인 정보 검색*/
	@RequestMapping("/searchDiscountGameNum")
	public DiscountGameVO searchDiscountGameNum(HttpServletRequest req) {
		String d_idx = req.getParameter("searchDiscountGame");
		DiscountGameVO dgvo = null;
		try {
			dgvo = dao.getDiscountGameInfo(d_idx);
			dgvo.setStart_date(dgvo.getStart_date().substring(0, 10));
			dgvo.setEnd_date(dgvo.getEnd_date().substring(0, 10));
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dgvo;
	}
	
	/*할인 정보 수정*/
	@RequestMapping("/editDiscountGame")
	public int editDiscountGame(DiscountGameVO dgvo) {
		int result = 0;
		try {
			result = dao.getEditDiscountGame(dgvo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	/*할인 삭제*/
	@RequestMapping("/deleteDiscountGame")
	public int deleteDiscountGame(DiscountGameVO dgvo) {
		int result = 0;
		
		String d_idx = dgvo.getD_idx();
		try {
			result = dao.getDeleteDiscountGame(d_idx);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}
