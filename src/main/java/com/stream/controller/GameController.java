package com.stream.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.tagext.TagInfo;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.stream.mybatis.CartVO;
import com.stream.mybatis.DAO;
import com.stream.mybatis.DelGameInfoVO;
import com.stream.mybatis.DeveloperVO;
import com.stream.mybatis.EvaluationVO;
import com.stream.mybatis.GameVO;
import com.stream.mybatis.GenreVO;
import com.stream.mybatis.MemberVO;
import com.stream.mybatis.PublisherVO;
import com.stream.mybatis.PurchaseVO;
import com.stream.mybatis.SystemRequirementVO;
import com.stream.mybatis.TagVO;
import com.stream.mybatis.ViewDataVO;
import com.stream.mybatis.WishListVO;
import com.stream.service.GamePaging;

@Controller
public class GameController {
	@Inject
	DAO dao;

	public void setDao(DAO dao) {
		this.dao = dao;
	}
	
	/*
	@RequestMapping("/main.do")
	public ModelAndView goMain() {
		return new ModelAndView("main");
	}
	*/
	
	
	
	@RequestMapping("/main.do")
	public ModelAndView goMain(HttpServletRequest req) {
		HttpSession session = req.getSession();
		//ModelAndView mv = new ModelAndView("main");
		
		try {
			int countDiscountNow = dao.getCountDiscountGameNow();
			session.setAttribute("countDiscountNow", countDiscountNow);
			//mv.addObject("countDiscountNow", countDiscountNow);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return new ModelAndView("main");
	}
	
	
	@RequestMapping("/login.do")
	public ModelAndView goLogin(HttpServletRequest req) {
		HttpSession session = req.getSession();
		ModelAndView mv = null;
		
		if((session.getAttribute("login_chk")) == null || (!(Boolean) session.getAttribute("login_chk"))) {
			mv = new ModelAndView("login");
		}
		else {
			mv = new ModelAndView("redirect:/main.do");			
		}
		return mv;
	}
	
	//로그아웃
	@RequestMapping("/logout.do")
	public ModelAndView goLogout(HttpServletRequest req) {
		HttpSession session = req.getSession();
		session.invalidate();
		return new ModelAndView("redirect:/main.do");
	}
	
	//회원 가입 페이지로
	@RequestMapping("/join.do")
	public ModelAndView goJoin(HttpServletRequest req) {
		HttpSession session = req.getSession();
		ModelAndView mv = null;
		
		if((session.getAttribute("login_chk")) == null || (!(Boolean) session.getAttribute("login_chk"))) {
			mv = new ModelAndView("join");
		}
		else {
			mv = new ModelAndView("redirect:/main.do");			
		}
		return mv;
	}
	
	//회원 가입
	@RequestMapping("/join_ok.do")
	public ModelAndView goJoinOk(MemberVO mvo) {
		ModelAndView mv = new ModelAndView("redirect:/login.do");
		try {
			dao.getJoin(mvo);
		} catch (Exception e) {
		}
		return mv;
	}
	
	//게임 상세 페이지
	@RequestMapping("/gameDetail.do")
	public ModelAndView goGameDetail(@RequestParam("g_idx") String g_idx, HttpServletRequest req) {
		ModelAndView mv = new ModelAndView("gameDetail");
		HttpSession session = req.getSession();
		
		try {
			GameVO gvo = dao.getGameDetail(g_idx);
			List<GenreVO> gnrvo = dao.getGameDetailGenre(g_idx);
			List<DeveloperVO> dvo = dao.getGameDetailDeveloper(g_idx);
			List<PublisherVO> pvo = dao.getGameDetailPublisher(g_idx);
			
			//파일 확장자명
			String type = null;
			
			//확장자명 cut 후 변수에 저장
			if(gvo.getCover() != null) {
				String file_name[] = gvo.getCover().split("\\.");
				type = file_name[(file_name.length)-1];
			}
			String r_date = gvo.getRelease_date();
			String conv_r_date = "";
			conv_r_date = r_date.substring(0, 4) + "년 ";
			conv_r_date += r_date.substring(5, 7) + "월 ";
			conv_r_date += r_date.substring(8, 10) + "일";
			gvo.setRelease_date(conv_r_date);
			
			session.setAttribute("game_id", gvo.getG_idx());
			
			//게임별 댓글 호출
			List<EvaluationVO> evo = dao.getGameDetailReviews(g_idx);
			
			//스크린샷 호출
			List<ViewDataVO> vvo = dao.getScreenshots(g_idx);

			mv.addObject("gvo", gvo); //게임 정보
			mv.addObject("gnrvo", gnrvo); //게임 장르
			mv.addObject("dvo", dvo); //게임 개발자
			mv.addObject("pvo", pvo); //게임 배급사
			mv.addObject("vvo", vvo); //게임 스크린샷
			mv.addObject("evo", evo);//댓글(평가)
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return mv;
	}
	
	//찜목록 페이지로
	@RequestMapping("/wishlist.do")
	public ModelAndView goWishList(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView("wishlist");
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("user");
		
		if(mvo != null) {
			String user = mvo.getId();
			List<WishListVO> wvo;
			
			try {
				wvo = dao.getWishList(user);
				
				mv.addObject("wvo", wvo);
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		}
		return mv;
	}
	
	//장바구니 페이지로
	@RequestMapping("/cart.do")
	public ModelAndView goCart(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView("cart");
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("user");
		
		List<GameVO> gvoList = new ArrayList<GameVO>();
		GameVO gvo = null;
		String g_idx = null;
		int total = 0;
		
		if(mvo != null) {	
			String user = mvo.getId();
			List<CartVO> cvo;
			try {
				cvo = dao.getCartList(user);
				
				for(int i = 0; i < cvo.size(); i++) {
					g_idx = cvo.get(i).getG_idx();
					gvo = dao.getGameDetail(g_idx);
					if(gvo.getPercent() != null) {
						int dcPrice = (int) (Integer.parseInt(gvo.getPrice())*((100-Integer.parseInt(gvo.getPercent()))*0.01));
						total += dcPrice;
					}else {
						total += Integer.parseInt(gvo.getPrice());
					}
					//total += Integer.parseInt(gvo.getPrice());
					gvoList.add(gvo);
				}
				
				mv.addObject("cvo", cvo);
				mv.addObject("gvoList", gvoList);
				mv.addObject("total_p", total);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return mv;
	}
	
	//장바구니에 추가
	@RequestMapping("/cart_add.do")
	public ModelAndView goCartAdd(HttpServletRequest req) {
		ModelAndView mv = null;
		HttpSession session = req.getSession();
		
		String g_idx = (String) session.getAttribute("game_id");
		boolean login_chk = (Boolean) session.getAttribute("login_chk");
		String userType = (String) session.getAttribute("userType");
		MemberVO mvo = (MemberVO) session.getAttribute("user");
		
		
		if(String.valueOf(login_chk).equals("true")) {
			if(userType.equals("user")) {			
				mv = new ModelAndView("redirect:/cart.do");
				CartVO cvo = new CartVO();
				cvo.setG_idx(g_idx);
				cvo.setId(mvo.getId());
				
				try {
					dao.getAddCart(cvo);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				int cartCount = (Integer) session.getAttribute("cart_count");
				session.setAttribute("cart_count", cartCount+1);
			}
			else { //관리자
				mv = new ModelAndView("redirect:/cart.do");
			}
		}
		return mv;
	}
	
	//장바구니에 담긴 제품 구매
	@RequestMapping("/purchase.do")
	public ModelAndView goPurchase(HttpServletRequest req, PurchaseVO pvo) {
		ModelAndView mv = new ModelAndView("main");
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("user");
		String id = mvo.getId();
		
		try {
			List<GameVO> gvoList = dao.getPurchaseGame(id, pvo);
			dao.getDelCartAll(id);
			
			for(int i=0; i < gvoList.size(); i++) {
				String g_idx = gvoList.get(i).getG_idx();
				dao.getUpdateGameCount(g_idx);
			}
			
			
			session.setAttribute("cart_count", 0);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return mv;
	}
	
	
	/*개인 정보 수정 페이지*/
	@RequestMapping("/profilesEdit.do")
	public ModelAndView goProfilesEdit() {
		ModelAndView mv = new ModelAndView("profilesEdit");
		return mv;
	}

	/*개인 정보 수정 적용*/
	@RequestMapping("/profilesUpdate.do")
	public ModelAndView goProfilesUpdate(HttpServletRequest req, @RequestParam("profile_image") MultipartFile profile_image, MemberVO mvo) {
		//ModelAndView mv = new ModelAndView("redirect:/main.do");
		ModelAndView mv = new ModelAndView("redirect:/profilesEdit.do");
		HttpSession session = req.getSession();
		MemberVO user = (MemberVO) session.getAttribute("user");
		String id = user.getId();
		String ori_img = user.getProfile_image();
		
		//프로필 이미지 저장 경로
		String profileImg = req.getSession().getServletContext().getRealPath("/resources/personal/profile");
		//프로필 이미지
		if(profile_image.getOriginalFilename() == null) {
			mvo.setProfile_image("");
		}else {
			mvo.setProfile_image(profile_image.getOriginalFilename());
		}

		try {
			mvo.setId(id);
			String origin = req.getParameter("profile_image_origin");
			
			if(origin != null && mvo.getProfile_image().equals("")) {
				mvo.setProfile_image(origin);
			}
			int result = dao.getUpdateProfiles(mvo);
			session.setAttribute("user", mvo);
			//System.out.println(mvo.getProfile_image());
			
			if(result > 0) {
				//if(!mvo.getProfile_image().equals("")) {
				if(!mvo.getProfile_image().equals(ori_img)) {
					//System.out.println("파일 저장");
					byte[] in = profile_image.getBytes();
					File out = new File(profileImg, mvo.getProfile_image());
					FileCopyUtils.copy(in, out);
				}else {
					//System.out.println("파일 저장 x");
				}
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return mv;
	}
	
	/*Stream 검색(인기 상품, 발매예정, 특별할인)*/
	@RequestMapping("/gameSearchSpecial.do")
	//public ModelAndView goSearchSpecial(@RequestParam(value = "filter", required = false) String filter) {
	public ModelAndView goSearchSpecial(ServletRequest req) {
		ModelAndView mv = new ModelAndView("gameSearch1");

		String filter = req.getParameter("filter");
		String term = req.getParameter("term");
		String tags = req.getParameter("tags");
		String page = req.getParameter("page");
		
		/* 페이징 시작 */
		GamePaging gpvo = new GamePaging();
		
		// 1. 전체 게시물의 수 구하기
		try {
			gpvo.setTotalRecord(dao.getTotalCount(term, tags));
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			System.out.println("failed to counting game");
		}
				
		// 2. 전체 페이지의 수 구하기
		gpvo.setTotalPage();
				
		// 3. 현재 페이지를 구하기
		if(page != null) {
			//null이 아니면 cPage가 nowPage가 된다.
			gpvo.setNowPage(Integer.parseInt(page));
		}
		//null이면 그냥 pvo에 존재하는 nowPage 사용
				
		// 4. 각 페이지의 시작번호과 끝번호 구하기
		gpvo.setBegin((gpvo.getNowPage()-1) * gpvo.getNumPerPage()+1);
		gpvo.setEnd((gpvo.getBegin()-1) + gpvo.getNumPerPage());
				
		// 5.시작번호와 끝번호를 이용해서 select 문 실행
		Map<String, Integer> map = new HashMap<>();
		map.put("begin", gpvo.getBegin());
		map.put("end", gpvo.getEnd());
		
		// 6. 블록시작번호와 블록끝번호를 구하기
		gpvo.setBeginPage(((gpvo.getNowPage()-1) / gpvo.getPagePerBlock()) * gpvo.getPagePerBlock()+1);
		gpvo.setEndPage(gpvo.getBeginPage() + gpvo.getPagePerBlock()-1);
			
		// 주의 사항 : endPage가 totalPage보다 클 경우 존재.. ---> endPage를 totalPage에 맞춘다.
		if(gpvo.getEndPage() > gpvo.getTotalPage()) {
			gpvo.setEndPage(gpvo.getTotalPage());
		}
		
		/* 페이징 끝 */
		
		try {
			//filter - topsellers(인기 상품)
			String orderType = "";
			String orderBy = "";
			
			if(filter != null) {
				//최고 인기 상품(판매순)
				if(filter.equals("topsellers")) {
					//orderBy null이면 asc로 판단
					orderType = "count";
					orderBy = "desc";
				}
				else if(filter.equals("new")) {
					orderType = "release_date";
					orderBy = "desc";
				}
			}
			else {
				orderType = "";
				orderBy = "";
			}
			
			List<TagVO> selectTag = new ArrayList<TagVO>();
			
			if(tags != null) {
				String tagIdx[] = tags.split(",");
				
				for(int i=0; i < tagIdx.length; i++) {
					selectTag.add(dao.getTagName(tagIdx[i]));
				}
			}	
			//List<GameVO> gvo = dao.getNewGameList(orderType, orderBy, term, tags);
			List<GameVO> gvo = dao.getNewGameList(map, orderType, orderBy, term, tags);
			List<TagVO> tvo = dao.getTag(); //태그 목록			
			mv.addObject("gvo", gvo);
			mv.addObject("tvo", tvo);
			mv.addObject("pvo", gpvo);
			mv.addObject("cPage", page);
			mv.addObject("selectedTag", selectTag);
			
			//정렬 기준
			mv.addObject("orderType", orderType);
			mv.addObject("term", term);
			mv.addObject("tags", tags);
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}
	
	
	//태그 페이지로 이동
	@RequestMapping("/tag.do")
	public ModelAndView goTags() {
		ModelAndView mv = new ModelAndView("tag");
		try {
			List<TagVO> tvo = dao.getTag();
			mv.addObject("tvo", tvo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}
	
	//구매 목록 페이지
	@RequestMapping("/purchasedlist.do")
	public ModelAndView goPurchaseList(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView("purchasedlist");
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("user");
		
		try {
			if(mvo != null) {
				String id = mvo.getId();
				List<PurchaseVO> pvo = dao.getMyPurchasedList(id);
				mv.addObject("pvo", pvo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return mv;
	}
	
	//평가 등록 페이지
	@RequestMapping("/review.do")
	public ModelAndView goReview(HttpServletRequest req) {
		ModelAndView mv = null; 
		HttpSession session = req.getSession();
		String p_idx = req.getParameter("p_idx");
		
		try {
			MemberVO mvo = (MemberVO) session.getAttribute("user");
			if(mvo != null) {
				String user = mvo.getId();
				
				EvaluationVO evo = dao.getPurchasedInfo(p_idx);
				
				EvaluationVO chkevo = dao.getChkEvaluate(evo);
				if(chkevo == null) {
					if(user.equals(evo.getId())) {
						mv = new ModelAndView("review");
						mv.addObject("evo", evo);
					}
				}else {				
					mv = new ModelAndView("reviewedDetail");
					mv.addObject("evo", chkevo);
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}
	
	
	//평가 등록
	@RequestMapping("/review_ok.do")
	public ModelAndView goReviewOk(HttpServletRequest req, EvaluationVO evo) {
		ModelAndView mv = new ModelAndView("redirect:/reviewList.do");
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("user");
		String id = mvo.getId();
		evo.setId(id);
		try {
			dao.setInsertEvaluation(evo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(e);
		}
		
		return mv;
	}
	
	//평가 수정
	@RequestMapping("/reviewUpdate_ok.do")
	public ModelAndView goReviewUpdateOk(EvaluationVO evo) {
		ModelAndView mv = new ModelAndView("redirect:/myReviewDetail.do?p_idx=" + evo.getP_idx());
		try {
			dao.updateEvaluation(evo);
			mv.addObject("evo", evo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}
	
	//평가 삭제
	@RequestMapping("/reviewDelete.do")
	public ModelAndView goReviewDelete(String e_idx) {
		ModelAndView mv = new ModelAndView("redirect:/reviewList.do");
		try {
			dao.deleteEvaluation(e_idx);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}
	
	//등록한 평가 상세 페이지
	@RequestMapping("/myReviewDetail.do")
	public ModelAndView gomyReviewDetail(HttpServletRequest req, EvaluationVO evo) {
		ModelAndView mv = new ModelAndView("reviewedDetail");
		String p_idx = req.getParameter("p_idx");
		evo.setP_idx(p_idx);
		try {
			EvaluationVO revo = dao.getChkEvaluate(evo);
			
			mv.addObject("evo", revo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}
	
	
	//평가 목록 페이지
	@RequestMapping("/reviewList")
	public ModelAndView goReviewList(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView("reviewList");
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("user");
		
		if(mvo != null) {
			String user = mvo.getId();
			try {
				List<EvaluationVO> evoList = dao.getReviewList(user);
				int countGame = dao.getCountMyGame(user);
				mv.addObject("evoList", evoList);
				mv.addObject("countGame", countGame);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return mv;
	}

	
	
	//테스트
	@RequestMapping("/test.do")
	public ModelAndView goTest() {
		ModelAndView mv = new ModelAndView("test");
		return mv;
	}
	
	
	//방문자 통계 페이지
	@RequestMapping("/stats.do")
	public ModelAndView goTest1() {
		ModelAndView mv = new ModelAndView("stats");
		try {
			int totalCount = dao.getTotalVisitorCount();
			mv.addObject("totalCount", totalCount);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return mv;
	}
	
	
	
	//관리자
	@RequestMapping("/newGame.do")
	public ModelAndView goNewGame() {
		ModelAndView mv = new ModelAndView("newGame");
		return mv;
	}
	
	//게임 등록
	@RequestMapping(value="/newGame_ok.do", method= RequestMethod.POST, headers = ("content-type=multipart/*"))
	public ModelAndView goNewGameOK(GameVO gvo, GenreVO gnvo, DeveloperVO dvo, PublisherVO pvo, SystemRequirementVO srvo,
			HttpServletRequest req, @RequestParam("cover") MultipartFile titleCover,
			@RequestParam("detail_img") MultipartFile detailImg, @RequestParam("view_context") MultipartFile[] screenshot, 
			@RequestParam("game_file") MultipartFile gameExe, @RequestParam("game_exp_file") MultipartFile gameExpExe)
	{
		
		ModelAndView mv = new ModelAndView("redirect:/manageGame.do");
		String gameNum;
		
		//이미지 저장 경로
		String gameImg = req.getSession().getServletContext().getRealPath("/resources/public/game/game_image");
		//게임 스크린샷 저장 경로
		String gameScreenshotImg = req.getSession().getServletContext().getRealPath("/resources/public/game/game_screenshot");
		//게임 파일 저장 경로
		String gamefileStorage = req.getSession().getServletContext().getRealPath("/resources/public/game/game_file");
		//체험판 파일 저장 경로
		String gameExpfileStorage = req.getSession().getServletContext().getRealPath("/resources/public/game/game_experience");
		
		//대표 이미지
		if(titleCover.getOriginalFilename() == null || titleCover.getOriginalFilename().equals("")) {
			gvo.setCover("");
		}else {
			//gvo.setCover(titleCover.getOriginalFilename());
			gvo.setCover(gvo.getG_name() + "_cover_" + titleCover.getOriginalFilename());
		}
		
		//상세 이미지
		if(detailImg.getOriginalFilename() == null || detailImg.getOriginalFilename().equals("")) {
			gvo.setDetail_img("");
		}else {
			//gvo.setDetail_img(detailImg.getOriginalFilename());
			gvo.setDetail_img(gvo.getG_name() + "_detail_" + detailImg.getOriginalFilename());
		}
		
		//스크린샷 이미지
		List<ViewDataVO> vvoList = new ArrayList<ViewDataVO>();
		for(int i=0; i < screenshot.length; i++) {
			if(screenshot[i].getOriginalFilename() == null || screenshot[i].getOriginalFilename().equals("")) {
				//vvo.setView_context("");
				//값이 없을 경우 값 저장 x
			}
			else {
				ViewDataVO vvo = new ViewDataVO();
				//vvo.setView_context(screenshot[i].getOriginalFilename());
				vvo.setView_context(gvo.getG_name() + "_" + screenshot[i].getOriginalFilename());
				vvoList.add(vvo);
			}
		}

		//게임 파일
		if(gameExe.getOriginalFilename() == null || gameExe.getOriginalFilename().equals("")) {
			gvo.setGame_file("");
		}else {
			//gvo.setGame_file(gameExe.getOriginalFilename());
			gvo.setGame_file(gvo.getG_name() + "_" + gameExe.getOriginalFilename());
		}
		
		//체험판 게임 파일
		if(gameExpExe.getOriginalFilename() == null || gameExpExe.getOriginalFilename().equals("")) {
			gvo.setGame_exp_file("");
		}else {
			//gvo.setGame_exp_file(gameExpExe.getOriginalFilename());
			gvo.setGame_exp_file(gvo.getG_name() + "_" + gameExpExe.getOriginalFilename());
		}
		
		
		try {
			int result = dao.getInsertGame(gvo);
			
			if(result > 0 && !gvo.getCover().equals("")) {
				byte[] in = titleCover.getBytes();
				File out = new File(gameImg, gvo.getCover());
				FileCopyUtils.copy(in, out);
			}
			
			if(result > 0 && !gvo.getDetail_img().equals("")) {
				byte[] in = detailImg.getBytes();
				File out = new File(gameImg, gvo.getDetail_img());
				FileCopyUtils.copy(in, out);
			}
			
			if(result > 0 && !vvoList.isEmpty()) {
				for(int i=0; i < screenshot.length; i++) {
					if(screenshot[i].getOriginalFilename() == null || screenshot[i].getOriginalFilename().equals("")) {
						//값이 빈 경우... 실행 x
					}
					else {
						byte[] in = screenshot[i].getBytes();
						File out = new File(gameScreenshotImg, vvoList.get(i).getView_context());
						FileCopyUtils.copy(in, out);
					}
				}
			}
			
			
			if(result > 0 && !gvo.getGame_file().equals("")) {
				byte[] in = gameExe.getBytes();
				File out = new File(gamefileStorage, gvo.getGame_file());
				FileCopyUtils.copy(in, out);
			}

			if(result > 0 && !gvo.getGame_exp_file().equals("")) {
				byte[] in = gameExpExe.getBytes();
				File out = new File(gameExpfileStorage, gvo.getGame_exp_file());
				FileCopyUtils.copy(in, out);
			}
			
			if(result == 1) {//게임 Db 등록 성공 시
				gameNum = dao.getNewGameNum(gvo.getG_name()); //등록한 게임 번호 가져오기
				
				//스크린샷 등록
				ViewDataVO vvo = new ViewDataVO();
				if(vvoList.size() != 0) {
					for(int i=0; i < vvoList.size(); i++) {
						vvo.setView_context(vvoList.get(i).getView_context());
						dao.getInsertNewGameScreenshot(gameNum, vvo);
					}
				}
				
				//장르 등록
				dao.getInsertNewGameGenre(gameNum, gnvo);
				//개발자 등록
				dao.getInsertNewGameDeveloper(gameNum, dvo);
				//배급사 등록
				dao.getInsertNewGamePublisher(gameNum, pvo);
				
				//시스템 요구사항 등록
				dao.getInsertNewGameSystemRequirement(gameNum, srvo);
			}
			else {
				//게임 등록 실패
			}
		} catch (Exception e) {
		}
		return mv;
	}
	
	
	//게임 수정 페이지
	@RequestMapping("/editGame")
	public ModelAndView getEditGame(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView("editGame");
		String g_idx = req.getParameter("g_idx");
		HttpSession session = req.getSession();
		
		try {
			GameVO gvo = dao.getGameDetail(g_idx);
			String r_date = gvo.getRelease_date().substring(0, 4) + "-" + gvo.getRelease_date().substring(5, 7) + "-" + gvo.getRelease_date().substring(8, 10);
			gvo.setRelease_date(r_date);
			session.setAttribute("preGVO", gvo);
			
			List<GenreVO> gnrvo = dao.getGameDetailGenre(g_idx);
			List<DeveloperVO> dvo = dao.getGameDetailDeveloper(g_idx);
			List<PublisherVO> pvo = dao.getGameDetailPublisher(g_idx);
			List<ViewDataVO> vvo = dao.getScreenshots(g_idx);
			
			mv.addObject("gvo", gvo);
			mv.addObject("gnrvo", gnrvo);
			mv.addObject("dvo", dvo);
			mv.addObject("pvo", pvo);
			mv.addObject("vvo", vvo);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}
	
	//게임 수정
	@RequestMapping(value="/editGame_ok.do", method= RequestMethod.POST, headers = ("content-type=multipart/*"))
	public ModelAndView goEditGameOK(GameVO gvo, GenreVO gnvo, DeveloperVO dvo, PublisherVO pvo, SystemRequirementVO srvo, DelGameInfoVO delvo,
			HttpServletRequest req, @RequestParam("cover") MultipartFile titleCover,
			@RequestParam("detail_img") MultipartFile detailImg, @RequestParam("view_context") MultipartFile[] screenshot, 
			@RequestParam("game_file") MultipartFile gameExe, @RequestParam("game_exp_file") MultipartFile gameExpExe)
	{
		ModelAndView mv = new ModelAndView("redirect:/manageGame.do");
		HttpSession session = req.getSession();
		GameVO preGVO = (GameVO) session.getAttribute("preGVO");
		
		String gameNum = preGVO.getG_idx();
		
		//이미지 저장 경로
		String gameImg = req.getSession().getServletContext().getRealPath("/resources/public/game/game_image");
		//게임 스크린샷 저장 경로
		String gameScreenshotImg = req.getSession().getServletContext().getRealPath("/resources/public/game/game_screenshot");
		//게임 파일 저장 경로
		String gamefileStorage = req.getSession().getServletContext().getRealPath("/resources/public/game/game_file");
		//체험판 파일 저장 경로
		String gameExpfileStorage = req.getSession().getServletContext().getRealPath("/resources/public/game/game_experience");
		
		
		//원래 대표 이미지
		String cover_origin = req.getParameter("cover_origin");
		//원래 상세 이미지
		String detail_img_origin = req.getParameter("detail_img_origin");
		//게임 파일
		String game_file_origin = req.getParameter("game_file_origin");
		//게임 체험판 파일
		String game_exp_file_origin = req.getParameter("game_exp_file_origin");
		
		//대표 이미지
		if(cover_origin == null || cover_origin.equals("")) {
			if(titleCover.getOriginalFilename() == null || titleCover.getOriginalFilename().equals("")) {
				gvo.setCover("");
			}else {
				gvo.setCover(gvo.getG_name() + "_cover_" + titleCover.getOriginalFilename());
			}
		}
		else {
			gvo.setCover(cover_origin);
		}
		
		
		//상세 이미지
		if(detail_img_origin == null || detail_img_origin.equals("")) {
			if(detailImg.getOriginalFilename() == null || detailImg.getOriginalFilename().equals("")) {
				gvo.setDetail_img("");
			}else {
				gvo.setDetail_img(gvo.getG_name() + "_detail_" + detailImg.getOriginalFilename());
			}
		}
		else {
			gvo.setDetail_img(detail_img_origin);
		}
		
		//게임 파일
		if(game_file_origin == null || game_file_origin.equals("")) {
			if(gameExe.getOriginalFilename() == null || gameExe.getOriginalFilename().equals("")) {
				gvo.setGame_file("");
			}else {
				gvo.setGame_file(gvo.getG_name() + "_" + gameExe.getOriginalFilename());
			}
		}
		else {
			gvo.setGame_file(game_file_origin);
		}
		
		//체험판 게임 파일
		if(game_exp_file_origin == null || game_exp_file_origin.equals("")) {
			if(gameExpExe.getOriginalFilename() == null || gameExpExe.getOriginalFilename().equals("")) {
				gvo.setGame_exp_file("");
			}else {
				gvo.setGame_exp_file(gvo.getG_name() + "_" + gameExpExe.getOriginalFilename());
			}
		}
		else {
			gvo.setGame_exp_file(game_exp_file_origin);
		}
		
		//스크린샷 이미지
		List<ViewDataVO> vvoList = new ArrayList<ViewDataVO>();
		for(int i=0; i < screenshot.length; i++) {
			if(screenshot[i].getOriginalFilename() == null || screenshot[i].getOriginalFilename().equals("")) {
				//vvo.setView_context("");
				//값이 없을 경우 값 저장 x
			}
			else {
				ViewDataVO vvo = new ViewDataVO();
				vvo.setView_context(gvo.getG_name() + "_" + screenshot[i].getOriginalFilename());
				vvoList.add(vvo);
			}
		}
		
		
		
		try {
			//게임 수정
			dao.getUpdateGame(gvo);
			
			//장르 등록
			if(gnvo.getTag_idx() != null) {
				dao.getInsertNewGameGenre(gvo.getG_idx(), gnvo);
			}
			//개발자 등록
			if(dvo.getD_name() != null) {
				dao.getInsertNewGameDeveloper(gvo.getG_idx(), dvo);
			}
			//배급사 등록
			if(pvo.getP_name() != null) {
				dao.getInsertNewGamePublisher(gvo.getG_idx(), pvo);				
			}
			
			//장르 제거
			if(delvo.getDel_gn_idx() != null) {			
				dao.getDeleteGameGenre(delvo);
			}
			
			//개발자 제거
			if(delvo.getDel_dvl_idx() != null) {
				dao.getDeleteGameDeveloper(delvo);
			}
			
			//배급사 제거
			if(delvo.getDel_pc_idx() != null) {
				dao.getDeleteGamePublisher(delvo);
			}
			
			
			//스크린샷 등록
			ViewDataVO vvo = new ViewDataVO();
			if(vvoList.size() != 0) {
				for(int i=0; i < vvoList.size(); i++) {
					vvo.setView_context(vvoList.get(i).getView_context());
					dao.getInsertNewGameScreenshot(gvo.getG_idx(), vvo);
				}
			}
			
			//스크린샷 제거
			if(delvo.getDel_v_idx() != null) {
				ViewDataVO delVvo = dao.getDeleteGameScreenshotFileName(delvo);
				String path= gameScreenshotImg + "\\" + delVvo.getView_context();
				File file = new File(path);

				if(file.exists() == true){
					file.delete();
				}
				dao.getDeleteGameScreenshot(delvo);
			}
			
			
			//대표 이미지 저장
			if(!gvo.getCover().equals("") && cover_origin.equals("")) {
				byte[] in = titleCover.getBytes();
				File out = new File(gameImg, gvo.getCover());
				FileCopyUtils.copy(in, out);
			}
			
			//상세 이미지
			if(!gvo.getDetail_img().equals("") && detail_img_origin.equals("")) {
				byte[] in = detailImg.getBytes();
				File out = new File(gameImg, gvo.getDetail_img());
				FileCopyUtils.copy(in, out);
			}
			
			//게임 파일
			if(!gvo.getGame_file().equals("") && game_file_origin == null) {
				byte[] in = gameExe.getBytes();
				File out = new File(gamefileStorage, gvo.getGame_file());
				FileCopyUtils.copy(in, out);
			}
			//체험판 파일
			if(game_exp_file_origin == null && !gvo.getGame_exp_file().equals("")) {
				byte[] in = gameExpExe.getBytes();
				File out = new File(gameExpfileStorage, gvo.getGame_exp_file());
				FileCopyUtils.copy(in, out);
			}
			
			//스크린샷 이미지 저장
			if(!vvoList.isEmpty()) {
				for(int i=0; i < screenshot.length; i++) {
					if(screenshot[i].getOriginalFilename() == null || screenshot[i].getOriginalFilename().equals("")) {
						//값이 빈 경우... 실행 x
					}
					else {
						byte[] in = screenshot[i].getBytes();
						File out = new File(gameScreenshotImg, vvoList.get(i).getView_context());
						FileCopyUtils.copy(in, out);
					}
				}
			}
		
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return mv;
	}
	
	//게임 관리 페이지
	@RequestMapping("/manageGame.do")
	public ModelAndView goManageGame() {
		ModelAndView mv = new ModelAndView("manageGame");
		
		try {
			List<GameVO> gvolist = dao.getAdminGameList();
			mv.addObject("gvolist", gvolist);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}
	
	
	//할인 관리 페이지
		@RequestMapping("/manageSale.do")
		public ModelAndView goManageSale() {
			ModelAndView mv = new ModelAndView("manageSale");
			
			try {
				List<GameVO> gvoSaleList = dao.getAdminSaleList();
				mv.addObject("gvoSaleList", gvoSaleList);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return mv;
		}
		
	
	
	//게임 체험판 다운 //experience.do?g_idx=${gvo.g_idx}
	@RequestMapping("/experience.do")
	public void getDownExperience(HttpServletRequest req, HttpServletResponse res, String file_name) {
		String path = req.getSession().getServletContext().getRealPath("/resources/public/game/game_experience");
		try {
			//한글 처리
			String encode_path = URLEncoder.encode(file_name, "utf-8");
			//브라우저 설정
			res.setContentType("application/x-msdownload");
			res.setHeader("Content-Disposition", "attachment; filename=" + encode_path);
			
			//실제 I/O
			File file = new File(path + "/" + new String(file_name.getBytes("utf-8")));
			
			FileInputStream fis = new FileInputStream(file);
			BufferedInputStream bis = new BufferedInputStream(fis);
			
			OutputStream out = res.getOutputStream();
			BufferedOutputStream bos = new BufferedOutputStream(out);
			
			int b = 0;
			while((b=bis.read()) != -1) {
				bos.write(b);
				bos.flush();
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.out.println(e);
		}
	}

	//게임 파일 다운
	@RequestMapping("/gameDown.do")
	public void getDownGameFile(HttpServletRequest req, HttpServletResponse res, String file_name) {
		String path = req.getSession().getServletContext().getRealPath("/resources/public/game/game_file");
		try {
			//한글 처리
			String encode_path = URLEncoder.encode(file_name, "utf-8");
			//브라우저 설정
			res.setContentType("application/x-msdownload");
			res.setHeader("Content-Disposition", "attachment; filename=" + encode_path);
			
			//실제 I/O
			File file = new File(path + "/" + new String(file_name.getBytes("utf-8")));
			
			FileInputStream fis = new FileInputStream(file);
			BufferedInputStream bis = new BufferedInputStream(fis);
			
			OutputStream out = res.getOutputStream();
			BufferedOutputStream bos = new BufferedOutputStream(out);
			
			int b = 0;
			while((b=bis.read()) != -1) {
				bos.write(b);
				bos.flush();
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.out.println(e);
		}
	}
}