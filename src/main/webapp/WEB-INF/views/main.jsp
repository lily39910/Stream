<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Stream에 오신 것을 환영합니다</title>
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
<link href="${pageContext.request.contextPath}/resources/css/shared_responsive.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/home.css" rel="stylesheet" type="text/css">

<style type="text/css">
/* 
@media all and (min-width: 1208px) {
	div#global_header .content {
		position: relative;
		right: -90px;
	}
}
 */
body.v6 .home_rightcol h2 {
	margin-bottom: 2px;
	margin-top: 1px;
}

.spotlight_weeklong_subtitle {
	margin-top: 14px;
}

</style>


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js"/>
<!-- 다른 라이브러리와 충돌 방지를 위해 사용 -->
<script type="text/javascript">/* $J =  */jQuery.noConflict();</script>

<!-- 

 -->


</head>

<body class="v6 infinite_scrolling responsive_page">
	<div class="responsive_page_frame with_header">
		<div class="responsive_page_content">
			<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp"/>
		</div>
	</div>



	<!-- heaer를 제외한 홈페이지 부분 -->
	<div id="responsive_store_nav_ctn"></div>
	<div class="responsive_page_template_content">


		<!-- 홈페이지의 주된 부분, 로그인 권장 위까지 -->
		<div class="home_page_body_ctn ">
			<div class="home_page_content" style="padding-left: 234px;">
				<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/leftSideMenu.jsp"/>
				<div class="responsive_store_nav_ctn_spacer">
					<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/contentTopMenu.jsp"/>
				</div>
			</div>

			<!-- the header opened a <div class="home_page_body_ctn"> --> 


			<!-- 슬라이드 쇼 부분 -->
			<div class="home_cluster_ctn home_ctn">
				<div class="home_page_content" style="padding-left: 234px;">
					<h2>특집 및 추천 제품</h2>
					<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/mainSlide.jsp"/>
				</div>
			</div>
			<!-- end 슬라이드 쇼 부분 -->
			
			
			
				

			<div class="home_ctn" style="padding-left: 234px;">
				<div class="home_page_content special_offers">
					<h2>특별 할인 
						<span class="right">
							<a class="btnv6_white_transparent btn_small btn_uppercase" href="gameSearchSpecial.do">
								<span>모두 보기</span>
							</a>
						</span>
					</h2>

					<div class="carousel_container spotlight" id="spotlight_carousel">
						<div class="carousel_items">
							<!-- 보여질 슬라이드 class="focus" -->
							<div class="focus">
								<!-- 월요일 세일 상품 소개 -->
								<div class="home_area_spotlight underlined_links">
									<a href="#(주간 할인)">
										<div class="spotlight_weeklong_ctn">
											<div class="spotlight_text_overlay" style="background-image: url('../../resources/public/shared/images/default/weeklong_spotlight_text_overlay.png')"></div>
											<span class="spotlight_count">${countDiscountNow}</span>
										</div>
										<div class="spotlight_weeklong_subtitle">매주 월요일에 새로운 특가</div>
									</a>
								</div>
								
								
								<!-- 두번째줄 제품 추천 -->
								<div>
									<div class="specials_target">
										<a class="store_capsule app_impression_tracked" data-ds-appid="게임 번호" href="#">
											<div class="capsule header">
												<img src="해당 게임 이미지">
											</div>
											<div>
												<!-- 게임 할인 x -->
												<div class="discount_block  no_discount daily_deal_discount discount_block_large">
													<div class="discount_prices">
														<div class="discount_final_price">₩ 18,500(판매가)</div>
													</div>
												</div>
											</div>
										</a>
									</div>
									<div class="specials_target">
										<a class="store_capsule app_impression_tracked"
											data-ds-appid="게임 번호" href="#">
											<div class="capsule header">
												<img src="해당 게임 이미지">
											</div>
											<div>
												<!-- 게임 할인 o -->
												<div
													class="discount_block  daily_deal_discount discount_block_large">
													<div class="discount_pct">-60%</div>
													<div class="discount_prices">
														<div class="discount_original_price">₩ 21,000(정가)</div>
														<div class="discount_final_price">₩ 8,400(할인가)</div>
													</div>
												</div>
											</div>
										</a>
									</div>
								</div>

								<!-- 세번째줄 제품 추천 -->
								<div>
									<div class="specials_target">
										<a class="store_capsule app_impression_tracked" data-ds-appid="게임 번호" href="#">
											<div class="capsule header">
												<img src="해당 게임 이미지">
											</div>
											<div>
												<!-- 게임 할인 x -->
												<div class="discount_block  daily_deal_discount discount_block_large">
													<div class="discount_pct">-30%(할인률)</div>
													<div class="discount_prices">
														<div class="discount_original_price"> ₩ 64,900(원가)</div>
														<div class="discount_final_price">₩ 45,430(할인가)</div>
													</div>
												</div>
											</div>
										</a>
									</div>

									<div class="specials_target">
										<a class="store_capsule app_impression_tracked" data-ds-appid="게임 번호" href="#">
											<div class="capsule header">
												<img src="해당 게임 이미지">
											</div>
											<div>
												<!-- 게임 할인 x -->
												<div class="discount_block  daily_deal_discount discount_block_large">
													<div class="discount_pct">-30%(할인률)</div>
													<div class="discount_prices">
														<div class="discount_original_price"> ₩ 64,900(원가)</div>
														<div class="discount_final_price">₩ 45,430(할인가)</div>
													</div>
												</div>
											</div>
										</a>
									</div>
								</div>
							</div>
							
							<!-- 다음 슬라이드 -->
							<div>
								<div>
									<div class="specials_target"></div>
									<div class="specials_target"></div>
								</div>
								<div>
									<div class="specials_target"></div>
									<div class="specials_target"></div>
								</div>
								<div>
									<div class="specials_target"></div>
									<div class="specials_target"></div>
								</div>
							</div>
						</div>
						<div class="carousel_thumbs" data-usability="2">
							<div class="focus"></div>
							<div></div>
						</div>
						<div class="arrow left" data-usability="2">
							<div></div>
						</div>
						<div class="arrow right" data-usability="2">
							<div></div>
						</div>

					</div>

				</div>
			</div>



			<!-- 로그인 한 경우에만 보이게 -->
			<!-- 
			<div class="discovery_queue_ctn home_ctn" style="display: none;">
				<div class="home_page_content">
					<div class="discovery_queue_ctn" style="display: none;">
						<h2>
							내 맞춤 대기열 <span class="right"> <a
								class="btnv6_white_transparent btn_small btn_uppercase"
								href="http://store.steampowered.com/explore/"
								data-store-tooltip="Click to learn more about your queue"><span>자세히
										알아보기</span></a>
							</span>
						</h2>

						<div class="home_page_sign_in_ctn"
							id="discovery_queue_not_logged_in" style="display: none">
							<p>로그인 하셔서 귀하를 위한 탐색 대기열을 확인하세요!</p>
							<div class="signin_buttons_ctn">
								<a class="btn_green_white_innerfade btn_border_2px btn_medium"
									href="https://store.steampowered.com/login/"> <span>로그인</span>
								</a> <br> <br> 아직 가입하지 않으셨다면 먼저 <a
									href="https://store.steampowered.com/join/">가입</a>하신 후 무료로
								Steam을 이용하세요.
							</div>
						</div>
						<div class="discovery_queue_static" id="discovery_queue_static">
							<a id="discovery_queue_start_link"
								class="discovery_queue_overlay"
								onclick="BeginDiscoveryQueue( 0, this); return false;"
								href="http://store.steampowered.com/explore/">
								<div class="begin_exploring">대기열을 확인하려면 여기를 클릭하세요</div>
							</a>
							<div class="discovery_queue" id="discovery_queue"></div>
						</div>
						<div class="discover_queue_empty" id="discovery_queue_empty"
							style="display: none">
							<h3>
								오늘 귀하의 맞춤 대기열에 있는<br>모든 제품을 확인하셨습니다.
							</h3>
							<p>오늘 목록을 모두 확인하셨습니다. 더 많은 제품을 확인하기 위해 아래 단추를 누르세요.</p>
							<div class="discover_queue_empty_refresh_btn">
								<a href="http://store.steampowered.com/explore/startnew"> <span
									class="btnv6_lightblue_blue btn_medium" id="refresh_queue_btn">
										<span>다른 대기열 시작하기 >></span>
								</span>
								</a>
							</div>
						</div>
					</div>
					<div data-usability-scroll="20"></div>
				</div>
			</div>
			-->


			<div class="home_ctn" style="padding-left: 234px;">
				<div class="big_buttons home_page_content">
					<h2>Stream 탐색하기</h2>
					<div class="button_container">
						<div class="btn_wrapper">
							<a href="#" class="big_button"> 신규 출시 </a>
						</div>
						<div class="btn_wrapper">
							<a href="gameSearchSpecial.do" class="big_button"> 특별 할인 </a>
						</div>
						<div class="btn_wrapper">
							<a href="#" class="big_button"> 무료 게임 </a>
						</div>
						<div class="btn_wrapper">
							<a href="tag.do" class="big_button"> 사용자 태그 </a>
						</div>
					</div>
				</div>
			</div>


			<div data-usability-scroll="40"></div>


			<div class="home_ctn " style="padding-left: 234px;">
				<div class="home_page_content recently_updated_block"
					style="display: none">

					<div
						class="carousel_container paging_capsules recently_updated_apps">
						<h2>
							최근에 업데이트된 제품 <span class="right"> 
							<a class="btnv6_white_transparent btn_small btn_uppercase"
								href="#" data-store-tooltip="최근에 업데이트된 제품을 모두 볼 수 있습니다."><span>모두 보기</span>
							</a>
							</span>
						</h2>

						<div
							class="recently_updated carousel_items store_capsule_container"></div>
						<div class="carousel_thumbs" data-usability="4"
							data-usability-scroll="60"></div>
						<div class="arrow left" data-usability="4">
							<div></div>
						</div>
						<div class="arrow right" data-usability="4">
							<div></div>
						</div>
					</div>
				</div>
			</div>




			<!-- 탭 부분 -->
			<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/gameListTab.jsp"/>
			<!-- end 탭 부분 -->



			<!-- 가격대 별로 보여주는 리스트 -->
			<div class="home_ctn " style="padding-left: 234px;">
				<div class="home_page_content ">

					<div class="carousel_container paging_capsules specials_under10">
						<h2>
							₩ 10,000 미만 <span class="right"> 
							<a class="btnv6_white_transparent btn_small_tall btn_uppercase"
								href="gameSearchSpecial.do">
									<span>₩ 10,000 미만</span>
							</a> 
							<a class="btnv6_white_transparent btn_small_tall btn_uppercase"
								href="gameSearchSpecial.d0">
									<span>₩ 5,000 미만</span>
							</a>
							</span>
						</h2>

						<div class="carousel_items store_capsule_container">
							<div class="focus">
								<!-- a태그 4번 반복 -->
								<c:forEach begin="0" end="3">
									<a class="store_capsule app_impression_tracked" data-ds-appid="게임 번호" href="게임 경로">
										<div class="capsule headerv5">
											<img src="<c:url value="${pageContext.request.contextPath}/resources/public/test/paperplez.jpg"/>">
										</div>
										<!-- 가격  -->
										<div>
											<div class="discount_block  no_discount discount_block_inline">
												<div class="discount_prices">
													<div class="discount_final_price">₩ 5,500</div>
												</div>
											</div>
										</div>
									</a>
								</c:forEach>
							</div>
						</div>
						<div class="carousel_thumbs" data-usability="9" data-usability-scroll="100">
							<div class="focus"></div>
						</div>
						
						<!-- 
						<div class="arrow left" data-usability="9">
							<div></div>
						</div>
						<div class="arrow right" data-usability="9">
							<div></div>
						</div>
						 -->
					</div>
				</div>
			</div>
			<!-- end 가격대 별로 보여주는 리스트 -->




			<div class="home_ctn marketingmessage_area" style="display: none">
				<div class="home_page_content">
					<h2>업데이트 및 할인</h2>
					<div class="marketingmessage_container"></div>
				</div>
			</div>


		</div>
		<!-- end 홈페이지의 주된 부분 -->



		<!-- 로그인 추천 -->
		<c:if test="${!login_chk}">
			<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/recommandLogin.jsp"/>
		</c:if>
		<!-- end 로그인 추천  -->
		
		
		<!-- footer 회사 정보 -->
		<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/footer.jsp"/>
		<!-- end footer 회사 정보 -->




		<div class="home_ctn home_content_ctn">
			<input id="content_seed" type="hidden" value="">

			<div id="content_more"></div>

			<div id="content_out" class="page_content_ctn dark"
				style="display: none;">
				<div class="home_page_content">
					<div class="more_content">귀하를 위한 추천 제품들이 더이상 없습니다.</div>
					<div class="more_content_desc">더 많은 게임을 플레이하신 다음 다양한 제품들을 추천해
						드릴 수 있습니다.</div>
					<br>
					<div class="more_content">
						더 많은 제품을 찾고 계신다고요? <a
							href="#">무작위 게임</a>을 한번 확인해 보시지요?
					</div>
				</div>
			</div>

			<div id="content_none" class="page_content_ctn dark"
				style="display: none;">
				<div class="home_page_content">
					<div class="more_content">표시할 추천 제품들이 없습니다.</div>
					<div class="more_content_desc">
						오류 또는 귀하께서 게임을 플레이한 시간이 없어서 발생할 수 있습니다.<br>새로 고침을 누르시든 게임을
						플레이하신 다음 다시 확인해 주십시오.
					</div>
					<br>
					<div class="more_content">
						<a href="#">무작위 게임</a>을 한번 확인해 보시지요?
					</div>
				</div>
			</div>

			<div id="content_loading" class="page_content_ctn dark">
				<div class="home_page_content more_content" id="LoadingContent">
					<div class="LoadingWrapper" style="display: none;">
						<div class="LoadingThrobber">
							<div class="Bar Bar1"></div>
							<div class="Bar Bar2"></div>
							<div class="Bar Bar3"></div>
						</div>
						<div class="LoadingText">더 많은 콘텐츠 불러오는 중...</div>
					</div>
				</div>
			</div>
		</div>


	</div>

	</div>
	<!-- end heaer를 제외한 홈페이지 부분 -->

	</div>
</body>
</html>