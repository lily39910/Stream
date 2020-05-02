<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
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
<link href="${pageContext.request.contextPath}/resources/css/cart.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/streamaccount.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/shared_responsive.css" rel="stylesheet" type="text/css">


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js"/>
<!-- 다른 라이브러리와 충돌 방지를 위해 사용 -->
<script type="text/javascript">/* $J =  */jQuery.noConflict();</script>

<script>
	$(document).ready(function(){
		//삭제 버튼
		$(document).on('click', '.cart_item_price > .remove_link', function(){
			var c_idx = $(this).attr('data-cartnum');
			if(confirm('정말 제거하시겠습니까?') == true){
				var price = $('#cart_estimated_total').text();
				var totalPrice = price.split(' ');
				
				//var game_price = $(this).parent().children('.price').text();
				var game_price = $(this).parent().children('.purchase_price').text();
				var del_game_price = game_price.split(' ');
				
				var result_price = parseInt(totalPrice[1]) - parseInt(del_game_price[1])

				$.ajax({
					url: '/StreamAjax/del_cart',
					type: 'post',
					dataType: 'text',
					data: 'c_idx=' + c_idx +'&total_p=' + result_price,
					success: function(data){
					},
					error: function(){
						//alert('error');
					}
				});
				
				$(this).parents('.odd').remove(); //선택한 장바구니 제품 제거
				$('#cart_estimated_total').empty();
				$('#cart_estimated_total').append('₩ ' + result_price);
				if(result_price == '0'){
					$('#del_all').css('display', 'none');
				}else {
					$('#del_all').css('display', 'block');
				}
				
				var cartCount = $('#cart_item_count_value').text();
				var resultCartCount = parseInt(cartCount) - 1;
				if(resultCartCount > 0){
					$('#cart_item_count_value').empty();
					$('#cart_item_count_value').append(resultCartCount);
				}
				else {
					$('.cart_status_message_area').css('display', 'none');
					$('#btn_purchase_self').css('display', 'none');
					$('#cart_link').remove();					
				}
				$('.cart_status_message_ctn > .cart_status_message').text('아이템이 삭제되었습니다.')
			}
			else { //취소				
			}
		});
		
		$(document).on('click', '#del_all', function(){
			if(confirm('모든 항목을 제거하시겠습니까?') == true){
				$.ajax({
					url: '/StreamAjax/del_cartAll',
					type: 'post',
					dataType: 'text',
					success: function(data){
					},
					error: function(){
						alert('error');
					}
				});
				$('#cart_row').children().remove(); //선택한 장바구니 제품 제거
				$('#cart_estimated_total').empty();
				$('#cart_estimated_total').append('₩ ' + 0);
				$('#del_all').css('display', 'none');
				$('#btn_purchase_self').css('display', 'none');
				
				$('#cart_link').remove();
			}
			else { //취소				
			}
		});
		
		//구매 버튼
		$('#btn_purchase_self').on('click', function(){
			$('#purchase').attr('action', 'purchase.do').submit();
			alert('장바구니의 제품이 구매되었습니다.');
		});
		
		
		
		var gamefNum; //게임 번호(찜목록 저장용)
		var exist;
		//찜목록 추가 버튼 div 위치 지정
		$('.ds_options > div').click(function(e){
			if($(this).children().html() === ''){ //이미 찜목록에 존재
				var offset = $(this).offset();
				var tool_t = offset.top - 3;
				var tool_l = offset.left - 81;
				
				exist = 1;
				$('#existwish').css('display', 'block');
				$('.ds_options_tooltip').css('top', tool_t + "px");
				$('.ds_options_tooltip').css('left', tool_l + "px");
			}
			else{ //찜목록에 담기
				var offset = $(this).offset();
				var tool_t = offset.top - 3;
				var tool_l = offset.left - 45;
				
				exist = 0;
				$('#addwish').css('display', 'block');
				$('.ds_options_tooltip').css('top', tool_t + "px");
				$('.ds_options_tooltip').css('left', tool_l + "px");
				gamefNum = $(this).parent().parent('.odd').children('.cart_item').children('.cart_item_price_container').children('.hidden_g_idx').val();
	
			}
		
		});
			
		
		$(document).on('mouseover', '.ds_options_tooltip, .ds_options_tooltip > .option', function(){
			//$('.ds_options_tooltip').css('display', 'block');				
			if(exist == 0){
				$('#addwish').css('display', 'block');				
			}
			else {
				$('#existwish').css('display', 'block');				
			}
		});
		
		$(document).on('mouseout', '.ds_options_tooltip, .ds_options_tooltip > .option ', function(){
			//$('.ds_options_tooltip').css('display', 'none');
			if(exist == 0){
				$('#addwish').css('display', 'none');				
			}
			else {
				$('#existwish').css('display', 'none');				
			}
		});

		//찜목록 추가
		$(document).on('click', '#addwish > .option', function(){
			change = $('.hidden_g_idx[value='+ gamefNum +']').parent().parent().parent().children('.ds_options');
			$.ajax({
				url: '/StreamAjax/add_wishList',
				type: 'post',
				dataType: 'text',
				data: 'g_idx=' + gamefNum,
				success: function(data){
					if(data > 0){
						change.children().append('<span></span>');
						$('#addwish').css('display', 'none');
						
						var wishCount = $('#wishlist_item_count_value').text();
						if(wishCount == 0){
							$('#wishlist_link').css('display', 'block');
						}
						
						var resultWishCount = parseInt(wishCount) + 1;
						$('#wishlist_item_count_value').empty();
						$('#wishlist_item_count_value').append(resultWishCount);
						alert('찜목록에 등록되었습니다.');
						
					}else {
						alert('오류가 발생되어 작업을 진행할 수 없습니다.\n관리자에게 문의해주세요.');
					}
				},
				error: function(){
					alert('error');
				}
			});
		});
		
		$(document).on('click', '#existwish > .option', function(){
			if(confirm('확인을 누르면 찜목록 페이지로 이동합니다.') == true){
				setTimeout(location.href='wishlist.do',1000);
			}
		});
		
		if($('#cart_estimated_total').text() == '₩ 0'){
			$('#btn_purchase_self').css('display', 'none');
		}
		else {
			$('#btn_purchase_self').css('display', 'block');
		}
		
	});
</script>
</head>
<html>
<c:choose>
	<c:when test="${!login_chk}">
		<script>
			alert('장바구니 이용을 위해 로그인을 먼저 해주세요.\n로그인 페이지로 이동합니다.');
		</script>
		<body onload="javascript:location.href='login.do'">
			<h2>메인 페이지로 이동합니다.</h2>
		</body>
	</c:when>
</c:choose>

<body class="v6 login responsive_page">

	<div class="responsive_page_frame with_header">

		<div class="responsive_page_content">
			<jsp:include
				page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp" />

			<div id="responsive_store_nav_ctn"></div>
			<div class="responsive_page_template_content">


				<div class="page_background">

					<div class="page_header_ctn search">

						<!-- contextTopMenu -->
						<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/contentTopMenu.jsp" />
						<!-- end contextTopMenu -->


						<div class="page_content">
							<div class="breadcrumbs">
								<a href="main.do">모든 제품</a> &gt; 장바구니
							</div>
							<h2 class="pageheader">장바구니</h2>
						</div>
					</div>
					

					<div class="page_content">
						<div class="leftcol cart_status_message_area" style="display: none;">
							<div class="cart_status_message_ctn">
								<div class="cart_status_message_left"></div>
								<div class="cart_status_message"></div><!-- 변경 사항 보여줌 -->
								<div class="cart_status_message_right"></div>
								
								<div class="cart_status_message_arrow_holder" style="display: none">
									<div class="cart_status_message_arrow"></div>
								</div>
							</div>
						</div>
						<div style="clear: left;"></div>
						
						
						
						<div style="clear: left;"></div>
						
						<div class="leftcol">
							<!-- 장바구니에 담긴 내용 -->
							<form id="purchase" method="post">
								<div class="cart_area_body checkout_content_box">
									<div class="cart_item_list">
										<!-- cart item blocks -->
										
										<div class="cart_row even" id="cart_row">
											
											<!-- 게임 하나의 정보 -->
											<c:forEach var="k" items="${gvoList}" varStatus="vs">
												<div class="cart_row odd ds_flagged ds_incart app_impression_tracked">
													<div class="cart_item">
														<div class="cart_item_price_container">
															<input type="hidden" class="hidden_g_idx" name="g_idx" value="${k.g_idx}">
															<%-- <input type="hidden" name="purchased_price" value="${k.price}"> --%>
															
															<c:choose>
																<c:when test="${k.d_idx eq null}">
																	<input type="hidden" name="purchased_price" value="${k.price}">
																	<div class="cart_item_price ">
																		<div class="price purchase_price">₩ ${k.price}</div>
																		<a class="remove_link" data-cartnum="${cvo[vs.index].c_idx}">제거</a>
																	</div>
																</c:when>
																<c:otherwise>
																	<fmt:parseNumber var="discountPrice" integerOnly="true" value="${k.price*((100-k.percent)*0.01)}"/>
																	<input type="hidden" name="purchased_price" value="${discountPrice}">
																	<div class="cart_item_price with_discount">
																		<div class="original_price price">₩ ${k.price}</div>
																		<div class="price purchase_price">₩ ${discountPrice}</div>
																		<a class="remove_link" data-cartnum="${cvo[vs.index].c_idx}">제거</a>
																	</div>
																</c:otherwise>
															</c:choose>
														</div>
														
														<!-- 게임 이미지 -->
														<div class="cart_item_img ">
															<a href="gameDetail.do?g_idx=${k.g_idx}">
																<img src="<c:url value="${pageContext.request.contextPath}/resources/public/game/game_image/${k.cover}"/>" border="0" style="height: 100%; width: 100%;">
															</a>
														</div>
														<!-- end 게임 이미지 -->
														
														<!-- 이미지를 제외한 게임 정보(옆에 상세 정보 팝업 띄우기 위해 필요) -->
														<div class="cart_item_desc">
															<!-- 게임이 지원하는 운영체제 -->
															<div class="cart_item_platform">
																<span class="platform_img win"></span><span
																	class="platform_img mac"></span><span
																	class="platform_img linux"></span>
															</div>
															<a href="gameDetail.do?g_idx=${k.g_idx}">${k.g_name}</a><br />
														</div>
														<div style="clear: left"></div>
													</div>
													
													<div class="ds_options">
															<!-- 이미 찜목록에 있을 경우 div 내에 span 추가 -->
														<div>
															<c:if test="${cvo[vs.index].w_idx ne null}"><span></span></c:if>
														</div> 
													</div>
												</div>
												
											</c:forEach>
											<!-- end 게임 하나의 정보 -->
										</div>
									</div>
	
									<div class="checkout_content cart">
										<div class="cart_totals_area">
											<div id="cart_estimated_total_text" class="cart_total_row">
												<div id="cart_estimated_total" class="price">₩ ${total_p}</div>
												예상 합계<sup>1</sup>
											</div>
										</div>
	
										<div class="rule"></div>
										<div style="clear: left;"></div>
	
										<div class="cart_bodycopy highlight">
											<div class="cart_bodycopy_highlight"><sup>1</sup></div>
											<div class="cart_bodycopy_highlight_desc">모든 가격은 VAT 포함(해당되는 경우)</div>
											<div style="clear: left;"></div>
										</div>
										<br>
										<div class="cart_bodycopy">결제 단계로 넘어가려면 구매 버튼을 누르세요.</div>
	
										<div class="cart_checkout_buttons">
											 <a id="btn_purchase_self" class="btnv6_green_white_innerfade btn_medium continue"> <!-- href="purchase.do" -->
												<span> 구매하기 </span>
											</a>
											<div style="clear: right;"></div>
										</div>
									</div>
								</div>
							</form>
							<!-- end 장바구니에 담긴 내용 -->

							<div class="checkout_notes">
								<div style="float: right;">
									<c:if test="${total_p ne '0'}">
										<a class="remove_link" id="del_all" data-cartnum="all">모든 항목 제거</a>
									</c:if>
								</div>

							</div>
							<br>
							<br>
							<div class="cart_digital_notice_ctn">
								<h2>배송</h2>
								<div class="cart_digital_notice">
									<div class="cart_digital_notice_stream_logo">
										<img height="57" width="68" src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v5/ico_steam_cart.png"/>">
									</div>
									<div class="cart_digital_notice_content">
										<h4>모든 제품은 Stream 클라이언트를 통해 이용하실 수 있습니다.</h4>
										<p>Stream과 귀하의 게임들은 구매를 마친 후 다운로드할 수 있습니다.</p>
									</div>
									<div style="clear: right;"></div>
								</div>
							</div>
							<div class="continue_shopping_ctn">
								<a href="main.do" class="btn_medium btnv6_blue_hoverfade">
									<span> 쇼핑 계속하기 </span>
								</a>
							</div>


						</div>

						<!-- End Center Column -->


						<!-- 다른 게임 추천 및 광고(Right Column) -->
						<div class="rightcol cart_rightcol">

							<!-- 오늘의 할인 게임 -->
							<div class="dailydeal_ctn">
								<!-- mouse 올릴 경우 게임 정보 옆에 보여짐 -->
								<div class="dailydeal_cap"
									onmouseover="GameHover( this, event, 'global_hover', {&quot;type&quot;:&quot;app&quot;,&quot;id&quot;:235380,&quot;public&quot;:1,&quot;v6&quot;:1} );"
									onmouseout="HideGameHover( this, event, 'global_hover' )">
									<a href="해당 게임 페이지">
										<img src="<c:url value="${pageContext.request.contextPath}/resources/public/test/header_koreana.jpg"/>">
									</a>
								</div>

								
								<div class="discount_block daily_deal_discount discount_block_large"> 
									<div class="discount_pct">-40%
									<!-- /div와 div 간격 떨어뜨리면 공백 생김... -->
									</div><div class="discount_prices">
										<div class="discount_original_price">₩ 21,500</div>
										<div class="discount_final_price">₩ 12,900</div>
									</div>
								</div>
								
								<div class="dailydeal_desc">
									<div>오늘의 할인!</div>
									<div class="dailydeal_countdown timer ttip" id="dailydeal_timer" data-store-tooltip="할인 종료까지 남은 시간">30:54:21</div>
								</div>
							</div>
							
							


							<h2>집중 조명 제품</h2>
							<div class="spotlight_block">
								<div class="spotlight_scroll_ctn home_block	" id="spotlight_scroll">
									<div class="home_area_spotlight underlined_links" id="spotlight_0" style="">
										<a href="#이번 주 할인 목록">
											<div class="spotlight_weeklong_ctn">
												<div class="spotlight_text_overlay"
													style="background-image: url('../../resources/public/shared/images/default/weeklong_spotlight_text_overlay.png')"></div>
												<span class="spotlight_count">count 할인 목록</span>
											</div>
											<div class="spotlight_weeklong_subtitle">매주 월요일에 새로운 특가</div>
										</a>
									</div>
									<div class="home_area_spotlight underlined_links"
										id="spotlight_1" style="display: none;" data-ds-appid="476600">
										<div class="spotlight_img">
											<a href="#게임 상세 페이지">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/게임이미지"/>" alt="#label_free_weekend" border="0">
											</a>
										</div>

										<div class="spotlight_content">
											<h2>주말 무료 플레이</h2>
											<div class="spotlight_body">(게임 설명)태평양 시간을 기준으로 일요일 오후 1시까지 무료로 플레이하세요.</div>
											<div class="spotlight_body spotlight_price price">
												<div class="discount_block discount_block_spotlight discount_block_large">
													<div class="discount_pct">-35%</div>
													<div class="discount_prices">
														<div class="discount_original_price">₩ 75,700</div>
														<div class="discount_final_price">₩ 49,200</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="home_area_spotlight underlined_links"
										id="spotlight_2" style="display: none;" data-ds-appid="373930">
										<div class="spotlight_img">
											<a
												href="http://store.steampowered.com/app/373930/Sudden_Strike_4/?snr=1_8_4__40_2">
												<img
												src="http://cdn.akamai.steamstatic.com/steam/spotlights/38b8b1d0090fd0d966564dec/spotlight_image_english.jpg?t=1519320338"
												alt="#spotlight_weekend_deal" border="0">
											</a>
										</div>

										<div class="spotlight_content">
											<h2>주말 특가</h2>
											<div class="spotlight_body">할인 혜택은 태평양 시간을 기준으로 월요일 오전
												10시까지입니다.</div>
											<div class="spotlight_body spotlight_price price">
												<div
													class="discount_block discount_block_spotlight discount_block_large">
													<div class="discount_pct">-65%</div>
													<div class="discount_prices">
														<div class="discount_original_price">₩ 54,000</div>
														<div class="discount_final_price">₩ 18,900</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="home_area_spotlight underlined_links"
										id="spotlight_3" style="display: none;" data-ds-appid="281990">
										<div class="spotlight_img">
											<a
												href="http://store.steampowered.com/app/281990/Stellaris/?snr=1_8_4__40_3">
												<img
												src="http://cdn.akamai.steamstatic.com/steam/spotlights/9bd01495bd1bdcb2dcc44059/spotlight_image_english.jpg?t=1519269826"
												alt="#spotlight_weekend_deal" border="0">
											</a>
										</div>

										<div class="spotlight_content">
											<h2>주말 특가</h2>
											<div class="spotlight_body">할인 혜택은 태평양 시간을 기준으로 월요일 오전
												10시까지입니다.</div>
											<div class="spotlight_body spotlight_price price">
												<div
													class="discount_block discount_block_spotlight discount_block_large">
													<div class="discount_pct">-60%</div>
													<div class="discount_prices">
														<div class="discount_original_price">₩ 43,000</div>
														<div class="discount_final_price">₩ 17,200</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="slider_ctn spotlight">
									<div class="slider_left disabled" id="spotlight_scroll_prev"
										onclick="javascript:PrevSpotlight( 4 );">
										<span></span>
									</div>
									<div class="slider_right" id="spotlight_scroll_next"
										onclick="javascript:NextSpotlight( 4 );">
										<span></span>
									</div>
									<div class="slider slider_text">
										<span id="spotlight_scroll_count_total">4</span>개 중 <span
											id="spotlight_scroll_count_cur">1</span>개 표시
									</div>
								</div>
							</div>
							
							
							<h2>맞춤 추천</h2>
							<div class="recommended_grid">
								<!-- 마우스 올릴 경우 게임 정보 옆으로 보여줌 -->
								<c:forEach var="k" begin="0" end="3" step="1">  <!-- 나중엔 items="" -->
									<a class="special special_img_ctn ds_collapse_flag" data-ds-appid="게임번호"
										href="#게임 페이지로"
										onmouseover="GameHover( this, event, 'global_hover', {&quot;type&quot;:&quot;app&quot;,&quot;id&quot;:8930,&quot;public&quot;:1,&quot;v6&quot;:1} );"
										onmouseout="HideGameHover( this, event, 'global_hover' )">
										<img src="<c:url value="${pageContext.request.contextPath}/resources/public/test/capsule_sm_rome.jpg"/>">
										<div class="special_discount">
											<!-- 세일 안할 경우(여기는 할인 안하는 제품 추천) -->
											<div class="discount_block discount_block_inline no_discount">
												<div class="discount_prices">
													<div class="discount_final_price">₩ 32,000</div>
												</div>
											</div>
											
											<!-- 세일 할 경우 -->
										</div>
									</a>
								</c:forEach>


								<div style="clear: left;"></div>
							</div>


						</div>
						<!-- end 다른 게임 추천 및 광고(Right Column) -->

						<div style="clear: both;"></diV>
					</div>
				</div>
				<!-- End Main Background -->

				<div id="coupon_selector_bg" style="display: none;"></div>

			</div>

			<!-- footer -->
			<jsp:include
				page="${pageContext.request.contextPath}/WEB-INF/views/common/footer.jsp" />
			<!-- end footer -->
		</div>
	</div>
	
	<!-- tooltip 찜목록 추가 -->
	<div id="addwish" class="ds_options_tooltip" style="position: absolute; z-index: 1500; opacity: 1; pointer-events: auto; display: none;">
		<div class="option">찜하기</div>
	</div>
	
	<!-- tooltip 찜목록에 이미 있음 -->
	<div id="existwish" class="ds_options_tooltip" style="position: absolute; z-index: 1500; opacity: 1; pointer-events: auto; display: none;">
		<div class="option">찜목록에 존재</div>
	</div>
</body>
</html>