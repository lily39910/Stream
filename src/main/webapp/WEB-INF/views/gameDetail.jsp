<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" var="nowDate"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Stream의 ${gvo.g_name}</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <meta name="viewport" content="width=device-width,initial-scale=1"> -->
<!-- 크롬 툴바 색상 변경(tab 부분 색상 변경) -->
<meta name="theme-color" content="#171a21">
<!-- 홈페이지 탭 부분 로고 -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/default/icon.ico" type="image/x-icon">

<!-- 사이트 링크 시 보이는 정보? -->
<!-- <meta property="og:site" content="Stream"> -->

<!-- 대표 url주소를 검색엔진에 알려주는 역할 -->
<!-- <link rel="canonical" href="/main.do"> -->

<link href="${pageContext.request.contextPath}/resources/css/motiva_sans.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/shared_global.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/buttons.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/store.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/game.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/recommended.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/user_reviews.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/store_game_shared.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/broadcast_watch.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/apphub.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/shared_responsive.css" rel="stylesheet" type="text/css">


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js" />
<!-- 다른 라이브러리와 충돌 방지를 위해 사용 -->
<script type="text/javascript">/* $J =  */jQuery.noConflict();</script>


<script>
	$(document).ready(function(){
		/*시작 시 동영상 플레이 or select*/
		$('.highlight_player_item').eq(0).css({'display':'block', 'opacity':'1'});
		$('.highlight_player_item').eq(0).addClass('focus');
		$('.highlight_player_item').eq(0).find('video').trigger('play');
		//선택된 동영상 or 이미지																
		$('.highlight_strip_item').eq(0).addClass('focus');
		
		
		/*이미지 select*/
		$('.highlight_strip_item').on('click', function(){
			//$('.highlight_selector').css('left', '');
			$('.highlight_strip_item').removeClass('focus');
			$(this).addClass('focus');
			var view_child = $('.highlight_strip_item').index(this);
			
			//index는 0부터
			//처음 시작 지점 1.5px, 121.5px씩 이동
			var border_location = ((120 * view_child) + 1.5) + 'px';
			$('.highlight_selector').css('left', border_location);
			
			//alert($(this).index());
			$('video').trigger('pause');
			$('#highlight_player_area > .highlight_player_item').css({'display':'none', 'opacity':'0'});
			$('#highlight_player_area > .highlight_player_item').removeClass('focus');
			
			var slideImg = $('#highlight_player_area > .highlight_player_item').eq($(this).index()-1);
			$(slideImg).css({'display':'block', 'opacity':'1'});
			$(slideImg).addClass('focus');
			$(slideImg).find('video').trigger('play');
			
		});
		
		
		/*동영상 일시정지, 플레이*/
		$(document).on('click', 'video', function(){
			if (this.paused) {
				this.play();
			} else {
				this.pause();
			}
		});
		
		
		/*태그 추가 모달(다이얼로그 - div) close*/
		$('.newmodal_close').on('click', function(){
			$('.app_tag_modal_frame').css('position', '');
			$('.app_tag_modal_frame').css('z-index', '');
			$('.app_tag_modal_frame').css('display', 'none');
			
			$('.newmodal_background').css('display', 'none'); //태그 추가
			$('#shareModal').css('display', 'none'); //공유
		});
		
		/*태그 추가 모달(다이얼로그 - div) close*/
		$('.btn_grey_white_innerfade > span').on('click', function(){
			$('.app_tag_modal_frame').css('position', '');
			$('.app_tag_modal_frame').css('z-index', '');
			$('.app_tag_modal_frame').css('display', 'none');
			
			$('.newmodal_background').css('display', 'none');
		});
		
		/*태그 추가 모달(다이얼로그 - div) open*/
		$('.add_button').on('click', function(){
			$('.app_tag_modal_frame').css('position', 'fixed');
			$('.app_tag_modal_frame').css('z-index', '1000');
			$('.app_tag_modal_frame').css('display', 'block');
			
			$('.newmodal_background').css('display', 'block');
		});
		
		/*지원하는 모든 언어 보기*/
		$('.all_languages').on('click', function(){
			$('#backup_language').css('height', '');
			$('.all_languages').css('display', 'none');
			$('.game_language_options tr').css('display','block');
		});
		
		/*게임에 대해 더 보기*/
		$('#detail_content').on('click', function(){
			$('#game_detail_content').addClass('expanded');
			$('#game_detail_content > .game_page_autocollapse').css('max-height', 'none');
			$('#game_detail_content > .game_page_autocollapse_fade').css('display', 'none');
		});
		
		
		
		/*공유하기*/
		$('#shareGameInfo').on('click', function(){
			$('#shareModal').css('position', 'fixed');
			$('#shareModal').css('z-index', '1000');
			$('#shareModal').css('display', 'block');
			
			$('.newmodal_background').css('display', 'block');
		});
		
		
		/*시스템 요구 사항*/
		$('#osInfoSmall').on('click', function(){
			$('#systemRequire').addClass('expanded');
			$('#systemRequire > .sys_req').css('max-height','none');
			$('#osInfoSmall').parent().css('display', 'none');
			/* 
			$('#systemRequire > .sys_req').animate({'max-height' : 'none'}, 0, function(){
				$(this).css('max-height', 300).css('max-height', 'none');
				$('#osInfoSmall').parent().css('display', 'none');
			});
			 */
		});
		
		
		/*시스템 탭*/
		$('.sysreq_tab').on('click', function(){
			$('.sysreq_tab').removeClass('active');
			//탭 변경
			$(this).addClass('active');
			var os = $(this).attr('data-os'); //운영체제
			
			//밑에 보여지는 설명 div 변경
			$('.sysreq_content').removeClass('active');
			if(os === 'win'){
				$('.sysreq_content[data-os="win"]').addClass('active');
			}else if(os === 'mac'){
				$('.sysreq_content[data-os="mac"]').addClass('active');
			}else if(os === 'linux'){
				$('.sysreq_content[data-os="linux"]').addClass('active');
			}
		});
			
	});
	
	
	//평가 검색 조건
	function ShowFilteredReviews(score){
		$('#reviews_active_filters > .active_filter').remove();
		if(score !== 'all'){
			var btn = '<div id=\"reviews_filter_type\" class=\"active_filter\">';
			if(score === '100'){
				btn += '긍정적';
			}else if(score === '0'){
				btn += '부정적';															
			}
			btn += '<input type=\"hidden\" id=\"e_opinion\" name=\"e_opinion\" value=\"' + score + '\"></div>';
				
			$('#reviews_active_filters').append(btn);
		}
		refreshReview();
	}
	
	//평가 검색 조건 버튼
	$(document).on('click', '#reviews_filter_type', function(){
		$(this).remove();
		$('#review_type_all').attr('checked', true);
		refreshReview();
	});
	
	//평가 order_by
	function ShowFilteredOrderBy(order){
		if($('#review_context').val() === 'recent'){
			$('#order').val('desc');			
		}else {
			$('#order').val('asc');			
		}
		refreshReview();
	}

</script>


</head>
<html>
<body class="v6 app game_bg responsive_page">
	<div class="responsive_page_frame with_header">
		<div class="responsive_page_content">
			<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp" />

			<div id="responsive_store_nav_ctn"></div>
			<div class="responsive_page_template_content">


				<div class="game_page_background game">
					<!-- contentTopMenu -->
					<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/contentTopMenu.jsp" />

						<div class="page_title_area game_title_area page_content">
							<div class="breadcrumbs">
								<c:if test="${userType eq 'admin'}">
									<div class="blockbg" style="text-align: right;">
										<a href="editGame.do?g_idx=${gvo.g_idx}">수정</a>
									</div>
								</c:if>
								<div class="blockbg">
									<a href="main.do">모든 게임</a> &gt; <a
										href="#">전략 게임</a> &gt; <a href="gameDetail.do?g_idx=${gvo.g_idx}"><span>${gvo.g_name}</span></a>
								</div>
								<div style="clear: left;"></div>
							</div>

							<div class="apphub_HomeHeaderContent">
								<div class="apphub_HeaderStandardTop">
									<div class="apphub_AppName">${gvo.g_name}</div>
									<div style="clear: both"></div>
								</div>
							</div>

						</div>
						<div style="clear: left;"></div>

						<div class="block">
							<div class="game_background_glow">
								<div class="block_content page_content" id="game_highlights">
									<div class="rightcol">
										<div class="glance_ctn">
											<div class="game_header_image_ctn">
												<img class="game_header_image_full" src="<c:url value="${pageContext.request.contextPath}/resources/public/game/game_image/${gvo.detail_img}"/>">
											</div>
											<div class="game_description_snippet">${gvo.content_summary}</div>

											<div class="glance_ctn_responsive_left">
												<div class="user_reviews">
													
													<div class="user_reviews_summary_row" onclick="window.location='#app_reviews_hash'" style="cursor: pointer;"
														data-store-tooltip="이 게임에 대한 사용자 평가 ..개 중 ..개 가 긍정적입니다.">
														<div class="subtitle column all">모든 평가</div>
														<div class="summary column">
															<c:choose>
																<c:when test="${empty evo}">
																	사용자 평가 없음
																</c:when>
																<c:otherwise>
																	<%-- jstl 내 변수 선언  --%>
																	<c:set var="totalEvalScore" value="0"/>
																	<c:set var="evalCount" value="${fn:length(evo)}"/>
																	
																	<%-- 댓글 Count --%>
																	<c:set var="evalPositive" value="0"/>
																	<c:set var="evalNegative" value="0"/>
																	
																	<c:forEach var="k" items="${evo}">
																		<fmt:parseNumber var="t" value="${k.e_opinion}" />
																		<c:set var="totalEvalScore" value="${totalEvalScore + t}"/>
																		
																		<c:choose>
																			<c:when test="${t eq 100}"><c:set var="evalPositive" value="${evalPositive + 1}"/></c:when>
																			<c:otherwise><c:set var="evalNegative" value="${evalNegative + 1}"/></c:otherwise>
																		</c:choose>															
																	</c:forEach>
																	
																	<%-- 평점 --%>
																	<c:set var="avgEval" value="${totalEvalScore/evalCount}"/>
																	
																	<%-- 긍정 평가 --%>
																	<c:if test="${avgEval >= 70}">
																		<span class="game_review_summary positive">
																			<c:if test="${avgEval >= 90}">압도적으로 긍정적<!-- (90% 이상) --></c:if>
																			<c:if test="${avgEval >= 80 && avgEval < 90}">매우 긍정적<!-- (80% 이상) --></c:if>
																			<c:if test="${avgEval >= 70 && avgEval < 80}">대체로 긍정적<!-- (70% 이상) --></c:if>																			
																		</span>
																	</c:if>
																	
																	
																	<%-- 복합 평가 --%>
																	<c:if test="${avgEval < 70 && avgEval >= 40}">
																		<span class="game_review_summary mixed">
																			복합적(<fmt:parseNumber value="${avgEval}"/> %)
																		</span> 
																	</c:if>
																	
																	
																	<%-- 부정 평가 --%>
																	<c:if test="${avgEval < 40}">
																		<span class="game_review_summary" itemprop="description">
																			<c:choose>
																				<c:when test="${avgEval >= 20}">대체로 부정적<!-- (40% 미만~20%이상) --></c:when>
																				<c:otherwise>부정적<!-- (20% 미만) --></c:otherwise>
																			</c:choose>
																		</span>
																	</c:if>
																	
																	<span class="responsive_hidden"> (${evalCount}) </span> 
																	<span class="nonresponsive_hidden responsive_reviewdesc">
																		- 이 게임에 대한 사용자 평가 ....입니다. 
																	</span>
																</c:otherwise>
															</c:choose>
														</div>
													</div>

													<div class="release_date">
														<div class="subtitle column">출시 날짜:</div>
														<div class="date">${gvo.release_date}</div>
													</div>

													<div class="dev_row">
														<div class="subtitle column">개발자:</div>
														<div class="summary column" id="developers_list">
															<c:forEach var="k" items="${dvo}" varStatus="vs">
																<a href="#${k.d_name}">${k.d_name}</a><c:if test="${!vs.last}">,</c:if>
															</c:forEach>
														</div>
													</div>

													<div class="dev_row">
														<div class="subtitle column">배급사:</div>
														<div class="summary column">
															<c:forEach var="k" items="${pvo}" varStatus="vs">
																<a href="#${k.p_name}">${k.p_name}</a><c:if test="${!vs.last}">,</c:if>
															</c:forEach>
														</div>
													</div>
												</div>
											</div>


											
											<div class="glance_ctn_responsive_right">
												<div class="glance_tags_ctn popular_tags_ctn">
													<%--
													<div class="glance_tags_label">이 제품의 인기 태그:</div>
													<div class="glance_tags popular_tags" data-appid="${gvo.g_idx}">
														<!-- 유저들이 추가해준 태그 -->
														<a href="#태그 검색" class="app_tag"> 전략 </a>
														<!-- end 유저들이 추가해준 태그 -->
														<div class="app_tag add_button"">+</div>
													</div>
													--%>
													<div class="glance_tags_label">이 제품의 태그:</div>
													<div class="glance_tags popular_tags" data-appid="${gvo.g_idx}">
														<c:forEach var="k" items="${gnrvo}" varStatus="vs">
															<a href="#${k.tag_idx}" class="app_tag">${k.tag_name}</a>
														</c:forEach>
														
													</div>
												</div>
											</div>
											<div style="clear: both;"></div>
										</div>
									</div>

									<div class="leftcol">
										<div class="highlight_ctn">
											<div class="highlight_overflow">

												<!-- 슬라이드 사진 및 영상 보여지는 곳 -->
												<div id="highlight_player_area">
													<div class="highlight_player_area_spacer">
														<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/game/game_highlight_image_spacer.gif"/>">
													</div>
													
													

													<!-- 다른 거 선택 시 display: none으로.. (동영상) -->
													
													<!-- controls -->
													<c:forEach var="k" items="${vvo}" varStatus="vs">
														<c:choose>
															<c:when test="${fn:contains(k.view_context, '.webm')}">
																<div class="highlight_player_item highlight_movie"
																  id="highlight_movie_${k.v_idx}" style="display: none; opacity: 0;">
																	<video controls controlsList="nodownload"
																	  class="highlight_player_item highlight_movie"
																	  preload="none" id="movie_${k.v_idx}"
																	  onended="videoEnd()" >
																	  <source src="<c:url value="${pageContext.request.contextPath}/resources/public/game/game_screenshot/${k.view_context}"/>" type="video/mp4">
																	  <source src="<c:url value="${pageContext.request.contextPath}/resources/public/game/game_screenshot/${k.view_context}"/>" type="video/webm">
																	  Your browser does not support HTML5 video.
																	</video>
																</div>
															</c:when>
															<c:otherwise>
																<div class="highlight_player_item highlight_screenshot" 
																  id="highlight_screenshot_${k.v_idx}" style="display: none; opacity: 0;">
																	<div class="screenshot_holder">
																		<a class="highlight_screenshot_link" data-screenshotid="${k.v_idx}"
																			href="이미지 다른 화면에서 보기"
																			target="_blank" rel="noreferrer"> 
																			<img src="<c:url value="${pageContext.request.contextPath}/resources/public/game/game_screenshot/${k.view_context}"/>">
																		</a>
																	</div>
																</div>
															</c:otherwise>
														</c:choose>
													</c:forEach>
													
													<script>
													
													function videoEnd(){
														alert('Thank you for watching');
														
														//var location = $('.highlight_selector').css('left');
														//alert(location);
														//location - 1.5
													 }
										
													</script>
													
												</div>

												
												<script>
												$(document).ready(function(){
													$('#highlight_slider_right').on('click', function(){
														var slide_count = $('#highlight_strip_scroll > .highlight_strip_item').length;
														var max_locate = -(parseInt(slide_count)*120)+600;
														
														var slide_obj = '';
														slide_obj = $('#highlight_strip_scroll').css('left').replace(/[^-\d\.]/g, '');
														
														if(max_locate < slide_obj){
															$('#highlight_strip_scroll').css('left', slide_obj-120 + 'px');															
														}
														else{
															alert('nono');
														}
													});
													
													$('#highlight_slider_left').on('click', function(){
														var slide_obj = '';
														slide_obj = $('#highlight_strip_scroll').css('left').replace(/[^-\d\.]/g, '');
														if(slide_obj != 0){
															$('#highlight_strip_scroll').css('left', parseInt(slide_obj)+120 + 'px');															
														}
													});
												});
													
												</script>

												<div id="highlight_strip">
													<div id="highlight_strip_scroll" style="left:0px; width: ${fn:length(vvo)*120}px">
														<div class="highlight_selector" style="left: 1.5px"></div>

														<!-- div 하나가 이미지 or 동영상 -->
														<!-- 동영상일 경우 아니면 이미지 -->
														<c:forEach var="k" items="${vvo}">
															<c:choose>
																<c:when test="${fn:contains(k.view_context, '.webm')}">
																	<div class="highlight_strip_item highlight_strip_movie" id="thumb_movie_${k.v_idx}">
																		<img class="movie_thumb" src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/screenshot/movie_film_184x123.png"/>">
																		<div class="highlight_movie_marker"></div>
																	</div>
																</c:when>
																<c:otherwise>
																	<div class="highlight_strip_item highlight_strip_screenshot"
																		id="thumb_screenshot_${k.v_idx}">
																		<img src="<c:url value="${pageContext.request.contextPath}/resources/public/game/game_screenshot/${k.view_context}"/>" style="height: 100%; width: 100%; object-fit: contain">
																	</div>
																</c:otherwise>
															</c:choose>
														</c:forEach>
														
													</div>
												</div>
												
												<!-- 참고 - http://www.w3big.com/try/try.php?filename=jqueryui-example-slider-scroll -->
													
												
												<div class="slider_ctn">
													<div id="highlight_slider_left" class="slider_left">
														<span></span>
													</div>
													<div class="slider" id="highlight_slider">
														<div class="slider_bg"></div>
														<div class="handle" style="position: absolute; left: 0px;"></div>
													</div>
													<div id="highlight_slider_right" class="slider_right">
														<span></span>
													</div>
												</div>
												
											</div>
										</div>
									</div>
									<div style="clear: both;"></div>
								</div>
							</div>



							
							<div class="queue_overflow_ctn">
								<div class="queue_ctn">
									<div class="queue_actions_ctn">
										<c:if test="${!login_chk}">
											<p><a href="login.do">로그인</a>하셔서 게임을 찜 목록에 추가하거나, 관심 없음으로 표시하세요.</p>
										</c:if>
										
										<c:if test="${login_chk}">
											<!-- 찜하기 -->
											<%-- 
											<div id="add_to_wishlist_area">
												<a class="btnv6_blue_hoverfade btn_medium" href="#"><span>찜하기</span></a>
											</div>
											<div id="add_to_wishlist_area_success" style="display: block;">
												<a href="#" class="btnv6_blue_hoverfade btn_medium queue_btn_active">
													<span>
														<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_selected.png"/>">찜 목록에 있음
													</span>
												</a>
											</div>
											
											<div class="queue_control_button queue_btn_ignore" >
												<div class="btnv6_blue_hoverfade btn_medium queue_btn_inactive" style="display: inline-block;">
													<span>관심 없음</span>
												</div>
												
												<div class="btnv6_blue_hoverfade btn_medium queue_btn_active" style="display: block;">
													<span><img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_selected.png"/>">관심 없음</span>
												</div>
											</div>
											 --%>
											
										</c:if>
									</div>
								</div>
							</div>
							
							
						</div>



						<div class="page_content">

							<!-- Right Column -->
							<div class="rightcol game_meta_data">
								<div id="responsive_apppage_details_left_ctn"></div>
								<div id="responsive_apppage_details_right_ctn"></div>
								<div style="clear: both;"></div>

								<div class="block responsive_apppage_details_right heading">이 게임에 관심이 있나요?</div>
								<c:choose>
									<c:when test="${!login_chk}">
										<div class="block responsive_apppage_details_right recommendation_noinfo">
											<p>Stream에 로그인하여 저희가 선정한 게임들을 확인해 보세요.</p>
											<br> <a class="btnv6_blue_hoverfade btn_medium" href="login.do"><span>로그인</span></a>
										</div>
									</c:when>
									<c:otherwise>
										<div class="block responsive_appage_details_right recommendation_reasons">
											<p class="reason for"></p>
											<div id="add_to_wishlist_area" style="margin-top: -20px; margin-left: 3px;">
												<a class="btnv6_blue_hoverfade btn_medium" href="#"><span>찜하기</span></a>
											</div>
										</div>
									</c:otherwise>
								</c:choose>
								
								<c:if test="${gvo.game_exp_file ne null}">
									<div class="block responsive_apppage_details_left">
										<div>
											<c:if test="${login_chk}">
												<a class="btnv6_blue_hoverfade btn_medium" href="experience.do?file_name=${gvo.game_exp_file}">
													<span>PC 체험판 다운로드</span>
												</a>
												
											</c:if>
											<c:if test="${!login_chk}">
												<p>체험판을 다운 받으려면 <a href="login.do">로그인</a>하세요</p>
											</c:if>
										</div>
									</div>
								</c:if>
								

								<div class="block responsive_apppage_details_left" id="category_block">

									<div class="game_area_details_specs">
										<div class="icon">
											<a href="#카테고리 검색 페이지">
												<img class="category_icon" src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_singlePlayer.png"/>">
											</a>
										</div>
										<a class="name" href="#카테고리 검색 페이지">싱글 플레이어</a>
									</div>
									<div class="game_area_details_specs">
										<div class="icon">
											<a href="#카테고리 검색 페이지">
												<img class="category_icon" src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_multiPlayer.png"/>">
											</a>
										</div>
										<a class="name" href="#카테고리 검색 페이지">멀티플레이어</a>
									</div>


									<!-- 그 때 그 때 다름 -->
									<div class="DRM_notice">
										<div>타사 EULA에 동의해야 함</div>
									</div>
								</div>
								
								
								<div class="block responsive_apppage_details_right" id="backup_language">
									<div class="block_title">언어:</div>


									<table class="game_language_options" cellpadding="0" cellspacing="0">
										<tr>
											<th style="width: 94px;"></th>
											<th class="checkcol">인터페이스</th>
											<th class="checkcol">음성 지원</th>
											<th class="checkcol">자막</th>
										</tr>

										<tr style="" class="">
											<td style="width: 94px; text-align: left" class="ellipsis">한국어</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
										</tr>
										<tr style="" class="">
											<td style="width: 94px; text-align: left" class="ellipsis">영어</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
										</tr>
										<tr style="" class="">
											<td style="width: 94px; text-align: left" class="ellipsis">프랑스어</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
										</tr>
										<tr style="" class="">
											<td style="width: 94px; text-align: left" class="ellipsis">이탈리아어</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
										</tr>
										<tr style="" class="">
											<td style="width: 94px; text-align: left" class="ellipsis">독일어</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
										</tr>
										<tr style="display: none;" class="">
											<td style="width: 94px; text-align: left" class="ellipsis">스페인어</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
										</tr>
										<tr style="display: none;" class="">
											<td style="width: 94px; text-align: left" class="ellipsis">일본어</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
										</tr>
										<tr style="display: none;" class="">
											<td style="width: 94px; text-align: left" class="ellipsis">폴란드어</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
											<td class="checkcol">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_bluecheck.png"/>" />
											</td>
										</tr>
										<!--  
										<tr style="display: none;" class="">
											<td style="width: 94px; text-align: left" class="ellipsis">
												포르투갈어-브라질</td>
											<td class="checkcol"><img
												src="http://store.akamai.steamstatic.com/public/images/v6/ico/ico_bluecheck.png" />
											</td>
											<td class="checkcol"></td>
											<td class="checkcol"><img
												src="http://store.akamai.steamstatic.com/public/images/v6/ico/ico_bluecheck.png" />
											</td>
										</tr>
										<tr style="display: none;" class="">
											<td style="width: 94px; text-align: left" class="ellipsis">
												러시아어</td>
											<td class="checkcol"><img
												src="http://store.akamai.steamstatic.com/public/images/v6/ico/ico_bluecheck.png" />
											</td>
											<td class="checkcol"><img
												src="http://store.akamai.steamstatic.com/public/images/v6/ico/ico_bluecheck.png" />
											</td>
											<td class="checkcol"><img
												src="http://store.akamai.steamstatic.com/public/images/v6/ico/ico_bluecheck.png" />
											</td>
										</tr>
										<tr style="display: none;" class="">
											<td style="width: 94px; text-align: left" class="ellipsis">
												중국어 간체</td>
											<td class="checkcol"><img
												src="http://store.akamai.steamstatic.com/public/images/v6/ico/ico_bluecheck.png" />
											</td>
											<td class="checkcol"><img
												src="http://store.akamai.steamstatic.com/public/images/v6/ico/ico_bluecheck.png" />
											</td>
											<td class="checkcol"><img
												src="http://store.akamai.steamstatic.com/public/images/v6/ico/ico_bluecheck.png" />
											</td>
										</tr>
										<tr style="display: none;" class="">
											<td style="width: 94px; text-align: left" class="ellipsis">
												중국어 번체</td>
											<td class="checkcol"><img
												src="http://store.akamai.steamstatic.com/public/images/v6/ico/ico_bluecheck.png" />
											</td>
											<td class="checkcol"><img
												src="http://store.akamai.steamstatic.com/public/images/v6/ico/ico_bluecheck.png" />
											</td>
											<td class="checkcol"><img
												src="http://store.akamai.steamstatic.com/public/images/v6/ico/ico_bluecheck.png" />
											</td>
										</tr>
										-->
									</table>
									<a class="all_languages">지원하는 언어 모두 보기</a>
								</div>

								<!-- 게임 연령층 -->
								<div class="block responsive_apppage_details_right">
									<p>
										<c:if test="${gvo.age eq 'all'}">
											<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/limitAge/age_all.gif"/>">
										</c:if>
										<c:if test="${gvo.age eq '12'}">
											<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/limitAge/age_12.gif"/>">
										</c:if>
										<c:if test="${gvo.age eq '15'}">
											<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/limitAge/age_15.gif"/>">
										</c:if>
										<c:if test="${gvo.age eq '18'}">
											<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/limitAge/age_18.gif"/>">
										</c:if>
									</p>
								</div>
								
								<div class="block responsive_apppage_details_left game_details underlined_links">
									<div class="block_content">
										<div class="block_content_inner">
											<div class="details_block">
												<input type="hidden" value="${gvo.g_idx}" id="gameNum">
												<b>제목:</b> ${gvo.g_name}<br> <b>장르:</b>
												<c:forEach var="k" items="${gnrvo}" varStatus="vs">
													<a href="#${k.tag_idx}">${k.tag_name}</a><c:if test="${!vs.last}">,</c:if> 
												</c:forEach>
												<br>
												<b>개발자:</b> 
												<c:forEach var="k" items="${dvo}" varStatus="vs">
													<a href="#${k.d_name}">${k.d_name}</a><c:if test="${!vs.last}">,</c:if>
												</c:forEach>
												<br> 
												<b>배급사:</b> 
												<c:forEach var="k" items="${pvo}" varStatus="vs">
													<a href="#${k.p_name}">${k.p_name}</a><c:if test="${!vs.last}">,</c:if>
												</c:forEach>
												<br> 
												<b>출시 날짜:</b> ${gvo.release_date}<br>

											</div>

										</div>
									</div>
								</div>

								<div class="block responsive_apppage_details_left">
									<a class="btnv6_blue_hoverfade btn_medium" id="shareGameInfo"><span>공유하기</span></a>
									<a id="ReportAppBtn" class="btnv6_blue_hoverfade btn_medium">
										<span><i class="ico16 reportv6"></i>&nbsp;&nbsp;<span>신고하기</span>&nbsp;</span></a>
								</div>

								<div class="block responsive_apppage_reviewblock">
									<div id="game_area_metascore">
										<div class="score high">88</div>
										<div class="logo"></div>
										<div class="wordmark">
											<div class="metacritic">metacritic</div>
											<div id="game_area_metalink">
												<a >게임 비평</a> 
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/iconExternalLink.gif"/>" border="0" align="bottom">
											</div>
										</div>
									</div>
									<div style="clear: both"></div>
								</div>
							</div>
							<!-- End Right Column -->
							

							<div class="leftcol game_description_column">


								<!-- 추가로 구매 가능한 제품 -->
								<div id="game_area_purchase">
									<!-- 게임 1개 -->
									<div class="game_area_purchase_game_wrapper">
										<div class="game_area_purchase_game">
											<form name="add_to_cart_123215" action="cart.do" method="POST">
												<!-- 게임 정보 hidden으로 넘기기 -->
											</form>
											<!-- 지원 운영체제 -->
											<div class="game_area_purchase_platform">
												<span class="platform_img win"></span>
												<span class="platform_img mac"></span>
												<span class="platform_img linux"></span>
											</div>
											<h1>${gvo.g_name} 구매</h1>

											<div class="game_purchase_action">
												<div class="game_purchase_action_bg">
													<c:choose>
														<c:when test="${gvo.start_date >= nowDate || gvo.start_date ne null}">
															<div class="discount_block game_purchase_discount">
																<div class="discount_pct">-${gvo.percent}%</div>
																<div class="discount_prices">
																	<div class="discount_original_price">₩ ${gvo.price}</div>
																	<fmt:parseNumber var="discountPrice" integerOnly="true" value="${gvo.price*(0.01*(100-gvo.percent))}"/>
																	<div class="discount_final_price">₩ ${discountPrice}</div>
																</div>
															</div>
														</c:when>
														<c:otherwise>
															<div class="game_purchase_price price">₩ ${gvo.price}</div>	
														</c:otherwise>
													</c:choose>
													
													<div class="btn_addtocart">
														<c:if test="${!login_chk}">
															<script>
																$(document).on('click', '#toCart', function(){
																	alert('장바구니 이용을 위해 로그인을 페이지로 이동합니다.');
																	$("#toCart").attr("href", "login.do");
																});
															</script>
														</c:if>
														<c:if test="${login_chk}">
															<script>
																$(document).on('click', '#toCart', function(){
																	$.ajax({
																		url: '/StreamAjax/check_cart',
																		type: 'post',
																		dataType: 'text',
																		data: 'g_idx=' + $('#gameNum').val(),
																		success: function(data){
																			if(data == 0){
																				setTimeout(location.href='cart_add.do',1000);
																			}
																			else if(data == 1){
																				if(confirm('이미 장바구니에 존재합니다.\n확인을 누르면 장바구니로 이동합니다.') == true){
																					//$("#toCart").attr("href", "cart.do");
																					setTimeout(location.href='cart.do',1000);
																				}
																			}
																			else {
																				if(confirm('이미 구매한 게임입니다.\n확인을 누르면 구매내역으로 이동합니다.') == true){
																					setTimeout(location.href='purchasedlist.do',1000);
																				}
																			}
																		},
																		error: function(){
																			alert('error');
																		}
																	});
																});
															</script>
														
														</c:if>
														<a id="toCart" class="btnv6_green_white_innerfade btn_medium"> <span>장바구니에 추가</span></a>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- game_area_purchase -->


								<div class="purchase_area_spacer">&nbsp;</div>


																
								<!-- 다른 홈페이지 평가 -->
								<div id="game_area_reviews" class="game_area_description">
									<h2>평가</h2>
									<p>
										“I’ll never need another Civ game in my life besides this one”<br>93
										/ 100 – <a href="#" target="_blank" rel="noreferrer">PC Gamer</a></a><br>
										<br>
										“Possibly the biggest and deepest game in the series' 25-year history.”<br>9.4
										/ 10 – <a href="#" target="_blank" rel="noreferrer">IGN</a></a><br> 
										<br>
										“One of the most rewarding 4X experiences to date”<br>9.5 / 10
										– <a href="#" target="_blank" rel="noopener">Game Informer</a></a><br>
									</p>
								</div>
								<!-- end 다른 홈페이지 평가 -->


								<!-- 분할 시 collapsed 추가 필요 -->
								<div class="game_page_autocollapse_ctn collapsed" id="game_detail_content">
									<div class="game_page_autocollapse" style="max-height: 800px;">
										<div id="game_area_description" class="game_area_description">
											<h2>게임에 대해</h2>
											${gvo.content}
										</div>
									</div>
									<div class="game_page_autocollapse_fade">
										<div id="detail_content" class="game_page_autocollapse_readmore">더 읽어보기</div>
									</div>
								</div>

								<!-- 시스템 요구 사항 -->
								<!-- 더보기 클릭 시 game_page_autocollapse_ctn expanded로 클래스 변경 하위 div style = "max-height: none;" -->
								<div class="game_page_autocollapse_ctn collapsed" id="systemRequire">
									<div class="game_page_autocollapse sys_req" style="max-height: 300px;">
										<h2>시스템 요구 사항</h2>
										<div class="sysreq_tabs">
											<div class="sysreq_tab active" data-os="win" id="os_win">Windows</div>
											<div class="sysreq_tab " data-os="mac" id="os_mac">Mac OS X</div>
											<div class="sysreq_tab " data-os="linux" id="os_linux">StreamOS + Linux</div>
											<div style="clear: left;"></div>
										</div>
										<div class="sysreq_contents">
											<div class="game_area_sys_req sysreq_content active" data-os="win">
												<div class="game_area_sys_req_leftCol">
													<ul>
														<strong>최소:</strong>
														<br>
														<ul class="bb_ul">
															<!-- <li>64비트 프로세서와 운영 체제가 필요합니다<br></li> -->
															<li><strong>운영체제:</strong> Windows 7x64 / Windows
																8.1x64 / Windows 10x64<br></li>
															<li><strong>프로세서:</strong> Intel Core i3 2.5 Ghz or
																AMD Phenom II 2.6 Ghz or greater<br></li>
															<li><strong>메모리:</strong> 4 GB RAM<br></li>
															<li><strong>그래픽:</strong> 1 GB &amp; AMD 5570 or
																nVidia 450<br></li>
															<li><strong>DirectX:</strong> 버전 11<br></li>
															<li><strong>저장공간:</strong> 12 GB 사용 가능 공간<br></li>
															<li><strong>사운드카드:</strong> DirectX Compatible Sound
																Device<br></li>
															<li><strong>추가 사항:</strong> Initial installation
																requires one-time Internet connection for Stream
																authentication; software installations required
																(included with the game) include Stream Client, Microsoft
																Visual C++ 2012 and 2015 Runtime Libraries, and
																Microsoft DirectX. Internet connection and acceptance of
																Stream™ Subscriber Agreement required for activation. See
																<a href="#"
																target="_blank" rel="noreferrer">www.streampowered.com/agreement</a>
																for details.</li>
														</ul>
													</ul>
												</div>
												<div class="game_area_sys_req_rightCol">
													<ul>
														<strong>권장:</strong>
														<br>
														<ul class="bb_ul">
															<li>64비트 프로세서와 운영 체제가 필요합니다<br></li>
															<li><strong>운영체제:</strong> Windows 7x64 / Windows
																8.1x64 / Windows 10x64<br></li>
															<li><strong>프로세서:</strong> Fourth Generation Intel
																Core i5 2.5 Ghz or AMD FX8350 4.0 Ghz or greater<br></li>
															<li><strong>메모리:</strong> 8 GB RAM<br></li>
															<li><strong>그래픽:</strong> 2GB &amp; AMD 7970 or
																nVidia 770 or greater<br></li>
															<li><strong>DirectX:</strong> 버전 11<br></li>
															<li><strong>저장공간:</strong> 12 GB 사용 가능 공간<br></li>
															<li><strong>사운드카드:</strong> DirectX Compatible Sound
																Device</li>
														</ul>
													</ul>
												</div>
												<div style="clear: both;"></div>
											</div>
											<div class="game_area_sys_req sysreq_content " data-os="mac">
												<div class="game_area_sys_req_leftCol">
													<ul>
														<strong>최소:</strong>
														<br>
														<ul class="bb_ul">
															<li>64비트 프로세서와 운영 체제가 필요합니다<br></li>
															<li><strong>운영체제:</strong> 10.11 (El Capitan) or
																10.12 (Sierra)<br></li>
															<li><strong>프로세서:</strong> Intel Core i5 2.7Ghz<br></li>
															<li><strong>메모리:</strong> 6 GB RAM<br></li>
															<li><strong>그래픽:</strong> 1 GB GPU Minimum - GeForce
																775M | Radeon HD 6970 | Intel Iris Pro<br></li>
															<li><strong>저장공간:</strong> 15 GB 사용 가능 공간<br></li>
															<li><strong>추가 사항:</strong> <strong>NOTICE:</strong>
																It is possible for Mac and PC to become out of sync
																(which is currently the case) during updates or patches.
																Within this short time period, Mac users will only be
																able to play other Mac users.</li>
														</ul>
													</ul>
												</div>
												<div class="game_area_sys_req_rightCol">
													<ul>
														<strong>권장:</strong>
														<br>
														<ul class="bb_ul">
															<li>64비트 프로세서와 운영 체제가 필요합니다</li>
														</ul>
													</ul>
												</div>
												<div style="clear: both;"></div>
											</div>
											<div class="game_area_sys_req sysreq_content "
												data-os="linux">
												<div class="game_area_sys_req_leftCol">
													<ul>
														<strong>최소:</strong>
														<br>
														<ul class="bb_ul">
															<li>64비트 프로세서와 운영 체제가 필요합니다<br></li>
															<li><strong>운영체제:</strong> StreamOS, Ubuntu 16.04
																(64bit)<br></li>
															<li><strong>프로세서:</strong> Intel Core i3 530 or AMD
																A8-3870<br></li>
															<li><strong>메모리:</strong> 6 GB RAM<br></li>
															<li><strong>그래픽:</strong> 1 GB VRAM Minimum - NVIDIA
																GeForce 650<br></li>
															<li><strong>저장공간:</strong> 15 GB 사용 가능 공간<br></li>
															<li><strong>추가 사항:</strong> IMPORTANT NOTICE: ATI
																and INTEL chipsets are NOT supported to run Civilization
																VI LINUX. <strong> Don't meet the above
																	requirements? Running on a unique distro? That doesn't
																	mean your configuration wont run Civ VI! Visit the
																	Civilization VI community page to share your experience
																	with other Linux players and learn about how to send
																	bugs to Aspyr. Your feedback will help us improve Civ
																	VI Linux and future AAA Linux releases!</strong></li>
														</ul>
													</ul>
												</div>
												<div class="game_area_sys_req_rightCol">
													<ul>
														<strong>권장:</strong>
														<br>
														<ul class="bb_ul">
															<li>64비트 프로세서와 운영 체제가 필요합니다</li>
														</ul>
													</ul>
												</div>
												<div style="clear: both;"></div>
											</div>
										</div>
									</div>
									<div class="game_page_autocollapse_fade">
										<div class="game_page_autocollapse_readmore" id="osInfoSmall">더 읽어보기</div>
									</div>
								</div>
								
								<div class="game_page_autocollapse_ctn">
									<div class="game_page_autocollapse" style="max-height: none;">
										<div id="game_area_legal">
											<p>©2017 Take-Two Interactive Software and its
												subsidiaries. All other marks and trademarks are the
												property of their respective owners. All rights reserved.
											</p>
										</div>
									</div>
								
									<!-- 
									<div class="game_page_autocollapse_fade">
										<div class="game_page_autocollapse_readmore" id="osInfoBig">더 읽어보기</div>
									</div>
									 -->
								</div>


								<!-- 비슷한 제품 더 보기 -->
								<div class="block" id="recommended_block">
									<div class="block_header">
										<div class="right">
											<a href="#">모두 보기</a>
										</div>
										<h4>비슷한 제품 더 보기</h4>
									</div>

									<!-- 비슷한 제품 3개 이상일 경우  style="overflow-x: scroll;" 아니면 style none-->
									<!-- <div class="store_horizontal_autoslider_ctn" style="height: 132px;">
										<div class="block_responsive_horizontal_scroll store_horizontal_autoslider block_content nopad" id="recommended_block_content"
										style="overflow-x: scroll;">
											<a class="small_cap app_impression_tracked" data-ds-appid="게임 번호" href="#">
												<img src="게임 이미지 184x69" class="small_cap_img">
												<h4>게임 이름</h4>
												<div class="discount_block  no_discount discount_block_inline">
													게임 가격
													<div class="discount_prices">
														<div class="discount_final_price">₩ 32,000</div>
													</div>
												</div>
											</a>
										</div>
									</div> -->

									<div class="store_horizontal_autoslider_ctn"
										style="height: 130px;">
										<div
											class="block_responsive_horizontal_scroll store_horizontal_autoslider block_content nopad"
											id="recommended_block_content" style="overflow-x: scroll;">
											<a class="small_cap app_impression_tracked"
												data-ds-appid="게임 번호" href="#"> <img src="게임 이미지 184x69"
												class="small_cap_img">
												<h4>게임 이름</h4>
												<div
													class="discount_block  no_discount discount_block_inline">
													게임 가격
													<div class="discount_prices">
														<div class="discount_final_price">₩ 32,000</div>
													</div>
												</div>
											</a>

										</div>
									</div>

									<div class="slider_ctn store_autoslider">
										<div class="slider_left">
											<span></span>
										</div>
										<div class="slider_right">
											<span></span>
										</div>
										<div class="slider_bg"></div>
										<!-- 게임 갯수 3개 이상일 경우만 보이게 -->
										<div class="slider">
											<div class="handle" style="position: absolute; left: 0px;"></div>
										</div>
									</div>

								</div>

								<div id="responsive_apppage_reviewblock_ctn"
									class="rightcol game_meta_data"></div>




							</div>

							<div style="clear: both;"></div>
						</div>


						<div class="review_ctn">
							<div class="page_content">
								<c:choose>
									<c:when test="${empty evo}">
										<!-- 평가가 없을 경우 -->
										<div id="app_reviews_hash" class="app_reviews_area">
											<div class="review_box">
												<div class="noReviewsYetTitle">이 제품에는 아직 평가가 없습니다.</div>
		
												<div id="noReviewsWriteOne">
													<div class="noReviewsYetSub">
														<p>이 제품의 평가를 직접 써서 자신의 경험을 공유할 수 있습니다.
														구매 후 플레이 해보시고 자신만의 평가를 써 보세요.</p>
													</div>
												</div>
		
												<div style="clear: left; height: 40px;"></div>
											</div>
										</div>
										<!-- end 평가가 없을 경우 -->
									</c:when>
									<c:otherwise>
										<!-- 평가 부분 -->
										<div id="app_reviews_hash" class="app_reviews_area">
											<div class="user_reviews_header no_bottom_margin">고객 평가</div>
											
											<!-- 종합 평가, 최근 평가 -->
											<div id="review_histograms_container" class="collapsed">
												<!-- 종합 평가 -->
												<div id="review_histogram_rollup_section" class="review_histogram_section" style="width: 940px;">
													<div class="user_reviews_summary_bar">
														<div class="summary_section" >
															<div class="title">종합 평가:</div>
															
															<%-- 긍정 평가 --%>
															<c:if test="${avgEval >= 70}">
																<span class="game_review_summary positive">
																	<c:if test="${avgEval >= 90}">
																		<span class="game_review_summary positive" data-store-tooltip="이 게임에 대한 사용자 평가 ${evalCount}개 중 ...% 가 긍정적입니다.">압도적으로 긍정적<!-- (90% 이상) --></span>
																	</c:if>
																	
																	<c:if test="${avgEval >= 80 && avgEval < 90}">
																		<span class="game_review_summary positive" data-store-tooltip="이 게임에 대한 사용자 평가 ${evalCount}개 중 ...% 가 긍정적입니다.">매우 긍정적<!-- (80% 이상) --></span>
																	</c:if>
																	
																	<c:if test="${avgEval >= 70 && avgEval < 80}">
																		<span class="game_review_summary positive" data-store-tooltip="이 게임에 대한 사용자 평가 ${evalCount}개 중 ...% 가 긍정적입니다.">대체로 긍정적<!-- (70% 이상) --></span>
																	</c:if>																			
																</span>
															</c:if>
																	
																	
															<%-- 복합 평가 --%>
															<c:if test="${avgEval < 70 && avgEval >= 40}">
																<span class="game_review_summary mixed" data-store-tooltip="이 게임에 대한 사용자 평가 ${evalCount}개 중 ...% 가 긍정적입니다.">복합적(<fmt:parseNumber value="${avgEval}"/> %)</span>
															</c:if>
																	
																	
															<%-- 부정 평가 --%>
															<c:if test="${avgEval < 40}">
																<span class="game_review_summary " data-store-tooltip="이 게임에 대한 사용자 평가 ${evalCount}개 중 ...% 가 긍정적입니다.">
																	<c:choose>
																		<c:when test="${avgEval >= 20}">대체로 부정적<!-- (40% 미만~20%이상) --></c:when>
																		<c:otherwise>부정적<!-- (20% 미만) --></c:otherwise>
																	</c:choose>
																</span>
															</c:if>
															
															
															<span>(평가 ${evalCount} 개)</span>
															<a class="tooltip" data-tooltip-content="Stream에서 직접 게임을 구매한 고객의 평가만 반영되어 있습니다.">
																<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/default/icon_questionmark.png"/>">
															</a>
														</div>
													</div>
												</div>
											</div>
											
											
		 									
		 									<!-- 평가 유형으로 정렬 -->
											<div id="reviews_filter_options" class="user_reviews_filter_options flyout graph_collapsed">
												<div class="user_reviews_filter_menu">
													<div class="title">평가 유형</div>
													<div class="user_reviews_filter_menu_flyout">
														<div class="user_reviews_filter_menu_flyout_content">
															<input type="radio" name="review_type" value="all" id="review_type_all" checked
																onchange="ShowFilteredReviews('all')"> 
															<label for="review_type_all">전체&nbsp;
																<span class="user_reviews_count">(${fn:length(evo)})</span>
															</label><br> 
															
															<input type="radio" name="review_type" value="100"
																id="review_type_positive" onchange="ShowFilteredReviews('100')">
															<label for="review_type_positive">긍정적&nbsp;
																<span class="user_reviews_count">(${evalPositive})</span>
															</label><br> 
															
															<input type="radio" name="review_type" value="0"
																id="review_type_negative" onchange="ShowFilteredReviews('0')">
															<label for="review_type_negative">부정적&nbsp;
																<span class="user_reviews_count">(${evalNegative})</span>
															</label>
														</div>
													</div>
												</div>
												
												<!-- 검색 조건 -->
												<div class="user_reviews_filter_display_as">
													<span class="title">검색 조건: </span>
													<select id="review_context" onchange="ShowFilteredOrderBy()">
														<option value="recent">최근</option>
														<!-- <option value="all">매우 유용함</option> -->
														<option value="old">오래됨</option>
														<!-- <option value="funny">재미있음</option> -->
													</select>
												</div>
												
												<div style="clear: both"></div>
											</div>
											
											<script>
											function refreshReview(){
												$.ajax({
													url: '/StreamAjax/searchReviews',
													type: 'post',
													dataType: 'json',
													data: $('#s_Review').serialize(),
													success: function(data){
														$('#Reviews_summary').empty();
														var detailReview = '';
														//LoadingMoreReviewsall
														$('#LoadingMoreReviewsall').css('display','block');
														$('#Reviews_summary').css('display','none');
														
														if(data.length == 0){ //검색된 데이터가 없을 경우
															detailReview += '<div class=\"review_box\" id=\"noSearched\">';
															detailReview += '<div class=\"noReviewsYetTitle\">위 조건에 맞는 평가가 더 이상 없습니다</div>';
															detailReview += '<div class=\"noReviewsYetSub\">다른 평가를 보려면 위에서 조건을 조정해주세요</div>';
															detailReview += '<div style=\"clear: left; height: 40px;\"></div></div>';
														}
														else {
															$.each(data, function(index, data) {
																detailReview += '<div class=\"review_box partial\">';
																detailReview += '<div id=\"Reviewssummary' + this['e_idx'] + '\">';
																detailReview += '<div class=\"leftcol\"><div class=\"avatar\"><a>';
																detailReview += '<div class=\"playerAvatar offline\">';
																if(this['profile_image'] != null){
																	detailReview += '<img src=\"${pageContext.request.contextPath}/resources/personal/profile/' + this['profile_image'] + '\">';
																}
																detailReview += '</div></a></div>';
																detailReview += '<div class=\"persona_name\"><a>' + this['id'] + '</a></div></div><div class=\"rightcol\">';
																detailReview += '<a class=\"vote_header tooltip\">';
																if(this['e_opinion'] === '100'){
																	detailReview += '<div class=\"thumb\">';
																	detailReview += '<img src=\"${pageContext.request.contextPath}/resources/public/shared/images/store/icon_thumbsUp.png\" width=\"40\" height=\"40\"/></div>';
																	detailReview += '<img class=\"review_source tooltip\" src=\"${pageContext.request.contextPath}/resources/public/shared/images/store/icon_review_stream.png\"/>';
																	detailReview += '<div class=\"title ellipsis\">추천</div>';
																}
																else {
																	detailReview += '<div class=\"thumb\">';
																	detailReview += '<img src=\"${pageContext.request.contextPath}/resources/public/shared/images/store/icon_thumbsDown.png\" width=\"40\" height=\"40\"/></div>';
																	detailReview += '<img class=\"review_source tooltip\" src=\"${pageContext.request.contextPath}/resources/public/shared/images/store/icon_review_stream.png\"/>';
																	detailReview += '<div class=\"title ellipsis\">비추천</div>'
																}
																detailReview += '</a><div class=\"postedDate\">20' + this['e_date'] + '</div>';
																detailReview += '<div class=\"content\">' + this['e_content'] + '</div><div class=\"posted\"></div>';
																detailReview += '</div><div style=\"clear: left\"></div></div></div>';
															});
														}
														$('#Reviews_summary').html(detailReview);
														
														setTimeout(
															function(){
																$('#LoadingMoreReviewsall').css('display','none');
																$('#Reviews_summary').css('display','block');
															}, 300);
													},
													error: function(){
														//alert('error');
													}
												});	
											}
											</script>
											
											
											<!-- 적용된 필터 보여줌 -->
											<div class="reviews_info_ctn">
												<form id="s_Review">
													<div id="reviews_active_filters" class="user_reviews_active_filters">
														<div id="reviews_filter_title" class="title">필터</div>
														<input type="hidden" name="g_idx" id="game_num" value="${gvo.g_idx}">
														<input type="hidden" name="order" id="order" value="desc">
													</div>
												</form>
												
											</div>
										</div>
										
										<div id="review_selected_filters"></div>

										<div id="LoadingMoreReviewsall" style="display: none;" class="loading_more_reviews">
											<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/default/throbber.gif"/>" class="loading_more_reviews_throbber"> 평가 불러오는 중...
										</div>
										
										<!-- 평가 부분  -->
										
										<div id="Reviews_summary" class="user_reviews_container" style="min-height:auto;">
											<c:forEach var="k" items="${evo}">
												<div class="review_box partial">
													<div id="Reviewssummary${k.e_idx}">
														<div class="leftcol">
															<div class="avatar">
																<a>
																	<div class="playerAvatar offline">
																		<c:if test="${k.profile_image ne null}">											
																			<img src="<c:url value="${pageContext.request.contextPath}/resources/personal/profile/${k.profile_image}"/>">
																		</c:if>
																	</div>
																</a>
															</div>
															<div class="persona_name"><a>${k.id}</a></div>	
														</div>
														<div class="rightcol">
															<a class="vote_header tooltip" data-tooltip-content="평가 전체 보기">
																<c:choose>
																<c:when test="${k.e_opinion eq '100'}">
																	<div class="thumb">
																		<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/store/icon_thumbsUp.png"/>" width="40" height="40">
																	</div>
																	<img class="review_source tooltip" src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/store/icon_review_stream.png"/>">
																	<div class="title ellipsis">추천</div>
																</c:when>
																<c:otherwise>
																	<div class="thumb">
																		<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/store/icon_thumbsDown.png"/>" width="40" height="40">
																	</div>
																	<img class="review_source tooltip" src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/store/icon_review_stream.png"/>">
																	<div class="title ellipsis">비추천</div>
																</c:otherwise>
																
																</c:choose>
															
															</a>
															<div class="postedDate">20${k.e_date}</div>
															<div class="content">${k.e_content}</div>
															<!-- 
															<div class="posted">
																<div class="view_more">
																	<a href="#" onclick="return false;">더보기</a>
																</div>
															</div>
															-->
														</div>
														<div style="clear: left"></div>
													</div>
												</div>
											</c:forEach>
										</div>
										<!-- end 평가 부분 -->
									</c:otherwise>
									
								</c:choose>
				
								
								<!-- 평가 로딩 중.. -->
								<!-- 
								<div id="Reviews_loading" class="user_reviews_container" style="display: none;">
									<div class="LoadingWrapper">
										<div class="LoadingThrobber">
											<div class="Bar Bar1"></div>
											<div class="Bar Bar2"></div>
											<div class="Bar Bar3"></div>
										</div>
										<div class="LoadingText">평가 불러오는 중...</div>
									</div>
								</div>
								<div style="clear: left"></div>
								-->
							</div>
						</div>

				</div>
			</div>

			<div class="hover game_hover" id="global_hover"
				style="display: none; left: 0; top: 0;">
				<div class="game_hover_box hover_box">
					<div class="content" id="global_hover_content"></div>
				</div>
				<div class="hover_arrow_left"></div>
				<div class="hover_arrow_right"></div>
			</div>

		</div>
		<!-- responsive_page_legacy_content -->


		<!-- footer -->
		<jsp:include
			page="${pageContext.request.contextPath}/WEB-INF/views/common/footer.jsp" />
		<!-- end footer -->

	</div>



	<!-- 태그 모달 -->
	<div class="newmodal app_tag_modal_frame" style="display: none; max-width: 1280px; left: 377px; top: 21px;">
		<div class="newmodal_header_border">
			<div class="newmodal_header">
				<div class="newmodal_close"></div>
				<div class="ellipsis">이 제품의 태그 보기 및 수정</div>
			</div>
		</div>
		<div class="newmodal_content_border">
			<div class="newmodal_content" style="max-height: 475px;">
				<div>
					<div id="app_tagging_modal" class="app_tag_modal nologin" style="display: block;">
						<div class="app_tag_modal_content">
							<div class="app_tag_modal_seperator"></div>
							<div class="app_tag_modal_left">
								<h2>이 제품의 인기 태그:
									<span class="app_tag_modal_tooltip" data-store-tooltip="이 태그들은 이 제품에 가장 많은 사용자들이 붙인 태그입니다. 태그를 클릭하시면 그 태그가 붙은 다른 제품을 찾아보실 수 있습니다. 또는, 제품에 이미 붙어있는 태그에 + 를 눌러 해당 태그의 인기도를 증가시킬 수 있습니다.">(?)</span>	
								</h2> 
								
								<!-- 이 게임에 달린 태그들 -->
								<div class="app_tags popular_tags">
									<div class="app_tag_control popular" data-tagid="태그 번호">
										<div data-store-tooltip class="app_tag_checkbox"></div>
										<a class="app_tag" href="태그 검색">태그 이름</a>
									</div>
								</div>
							</div>
							<div class="app_tag_modal_right">
								<c:if test="${!login_chk}">
									<h2>로그인</h2>
									<p>이 제품에 자신만의 태그를 붙이려면 로그인 하세요.</p>
									<p>
										<a class="btnv6_blue_hoverfade btn_medium" href="login.do">
											<span>로그인</span>
										</a>
									</p>
								</c:if>
							</div>
							
							<div style="clear: both;"></div>
						</div>
					</div>
				</div>
				<div class="newmodal_buttons">
					<div class="btn_grey_white_innerfade btn_medium">
						<span>닫기</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- 공유 모달 -->
	<div class="newmodal" id="shareModal" style="display: none; max-width: 1280px; left: 430px; top: 215px;">
		<div class="newmodal_header_border">
			<div class="newmodal_header">
				<div class="newmodal_close"></div>
				<div class="ellipsis">공유하기</div>
			</div>
		</div>
		<div class="newmodal_content_border">
			<div class="newmodal_content" style="max-height: 475px;">
				<div>
					<div id="ShareModal" style="display: block;">
						<div class="share">&nbsp;
							<a href="#facebook" target="_blank" rel="noreferrer" title="페이스북에 공유">
								<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/social/facebook.png"/>">
							</a>&nbsp;
							<a href="#twitter" target="_blank" rel="noreferrer" title="트위터에 공유">
								<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/social/twitter.png"/>">
							</a>&nbsp;
							<a href="#reddit" target="_blank" rel="noreferrer" title="Reddit에서 나누세요">
								<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/social/reddit.png"/>">
							</a>
						</div>
					</div>
				</div>
				<div class="newmodal_buttons"></div>
			</div>
		</div>
	</div>
	
	
	<!-- 태그 추천 창 띄우기 위해 배경 검게 display에 따라 보이고 안보이고.. -->
	<div class="newmodal_background" style="opacity: 0.8; display: none;"></div>
</body>
</html>