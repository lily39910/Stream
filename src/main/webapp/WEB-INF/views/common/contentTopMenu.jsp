<%@page language="java" contentType="text/html; charset=UTF-8;" 
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<body>
	<script type="text/javascript">
		$(document).ready(function(){
			var foryou_menu_view, game_menu_view, hard_menu_view;
			
			//상점 메뉴
			$('#foryou_tab').mouseenter(function(){
				$('#foryou_flyout').css("display", "block");
			});
			
			$('#foryou_flyout').mouseenter(function(){
				foryou_menu_view = true;
				$('#foryou_flyout').css("display", "block");
			});
		
			$('#foryou_flyout').mouseleave(function(){
				foryou_menu_view = false;
				$('#foryou_flyout').css("display", "none");
			});
			
			$('#foryou_tab').mouseleave(function(){
				if(foryou_menu_view === true){
					$('#foryou_flyout').css("display", "block");				
				}
				else {
					$('#foryou_flyout').css("display", "none");								
				}
			});
			
			
			//게임 메뉴
			
			
			//하드웨어 메뉴
			$('#hardware_tab').mouseenter(function(){
				$('#hardware_flyout').css("display", "block");
			});
			
			$('#hardware_flyout').mouseenter(function(){
				hard_menu_view = true;
				$('#hardware_flyout').css("display", "block");
			});
		
			$('#hardware_flyout').mouseleave(function(){
				hard_menu_view = false;
				$('#hardware_flyout').css("display", "none");
			});
			
			$('#hardware_tab').mouseleave(function(){
				if(hard_menu_view === true){
					$('#hardware_flyout').css("display", "block");				
				}
				else {
					$('#hardware_flyout').css("display", "none");								
				}
			});
			
			
			var searchedGame = ''; //검색된 게임이 있는지 체크를 위한 변수
			//게임 검색
			$('#store_nav_search_term').keyup(function(){
				if($('#store_nav_search_term').val() === ''){
					$('#search_suggestion_contents').empty();
					$('#searchterm_options').css('display', 'none');
				}
				else {
					$('#search_suggestion_contents').empty();
					$.ajax({
						url: '/StreamAjax/searchGameNameOnContentTop',
						type: 'get',
						dataType: 'json',
						data: 'searchGameNameOnContentTop=' + $('#store_nav_search_term').val(),
						success: function(data){
							var game = '';
							
							if(JSON.stringify(data) === '[]'){ //검색된 데이터가 없을 경우
								$('#searchterm_options').css('display', 'none');
								searchedGame = '';
							}
							else {
								$('#searchterm_options').css('display', 'block');
								
								$.each(data, function(index, data) {
									if(index < 5){
										game += '<a class="match ds_collapse_flag app_impression_tracked" appid="' + this['g_idx'] + '" href="gameDetail.do?g_idx=' + this['g_idx'] +  '" data-ds-options="0">';
										game += '<div class="match_name">' + this['g_name'] + '</div>';
										game += '<div class="match_img">';
										game += '<img src=\"${pageContext.request.contextPath}/resources/public/game/game_image/' + this['cover'] + '\">';
										game += '</div>';
										if(this['percent'] == null){
											game += '<div class="match_price">' + '₩ ' + this['price'] + '</div>';
										}else {
											var discountPrice = this['price']*(0.01*(100-this['percent']));
											game += '<div class="match_price">' + '₩ ' + discountPrice + '</div>';									
										}
										game += '</a>';
									}
								});
								$('#search_suggestion_contents').append(game);//html은 기본으로 초기화 됨/append는 기존 데이터에 추가로...
								
								searchedGame = 'exist';
							}
							
						},
						error: function(){
							//alert('error');
						}
					});
				}
			});
			
			
			$('#store_nav_search_term').focusout(function(){
				setTimeout(function() {
					$('#searchterm_options').css('display', 'none');
				}, 150);
			});
			
			
			$('#store_nav_search_term').focus(function(){
				if($('#store_nav_search_term').val() !== '' && searchedGame !== ''){
					$('#searchterm_options').css('display', 'block');					
				}
			});
			
			/*
			$(document).on('click', '#search_suggestion_contents', function(){
				$(this > 'a')
			});
			*/
			//match ds_collapse_flag
			
			$(document).on('mouseover', '#search_suggestion_contents > .ds_collapse_flag', function(){
				$(this).addClass('focus');
			});
			
			$(document).on('mouseout', '#search_suggestion_contents > .ds_collapse_flag', function(){
				$(this).removeClass('focus');
			});
			
			
			
		});
	</script>
	
	
	<!-- content top 메뉴 -->
	<div id="store_header" class="">
		<!-- 장바구니 & 찜목록 -->
		<div class="content">
			<c:if test="${login_chk}">
				<div id="store_controls">
					<div id="cart_status_data">
						<div class="store_header_btn_gray store_header_btn">
							<div class="store_header_btn_caps store_header_btn_leftcap"></div>
							<div class="store_header_btn_caps store_header_btn_rightcap"></div>
							<c:if test="${wish_count ne null && wish_count > 0}">
								<a id="wishlist_link" class="store_header_btn_content" href="wishlist.do">
									찜한 상품 목록(<span id="wishlist_item_count_value">${wish_count}</span>)
								</a>
							</c:if>
							<c:if test="${wish_count eq '0'}">
								<a id="wishlist_link" class="store_header_btn_content" style="display:none;" href="wishlist.do">
									찜한 상품 목록(<span id="wishlist_item_count_value">${wish_count}</span>)
								</a>
							</c:if>
						</div>
					
					
						<div class="store_header_btn_green store_header_btn" id="store_header_cart_btn" style="display: block;">
							<div class="store_header_btn_caps store_header_btn_leftcap"></div>
							<div class="store_header_btn_caps store_header_btn_rightcap"></div>
							<c:if test="${cart_count ne null && cart_count > 0}">
								<a id="cart_link" class="store_header_btn_content" href="cart.do">장바구니
									(<span id="cart_item_count_value">${cart_count}</span>)
								</a>
							</c:if>
						</div>
					</div>
				</div>
			</c:if>
			<!-- end 장바구니 & 찜목록 -->
		
			<div id="store_nav_area">
				<div class="store_nav_leftcap"></div>
				<div class="store_nav_bg">
					<div class="store_nav">
		
						<div class="tab  flyout_tab " id="foryou_tab" data-flyout="foryou_flyout" data-flyout-align="left"
						 data-flyout-valign="bottom">
							<span class="pulldown">
								<a class="pulldown_desktop" href="main.do">내 상점</a>
								<span></span>
							</span>
						</div>
					
						<div class="popup_block_new flyout_tab_flyout responsive_slidedown" id="foryou_flyout" 
							style="visibility: visible; top: 42.0002px; left: 0px; display: none; opacity: 1;">
							<div class="popup_body popup_menu">
								<a class="popup_menu_item" href="main.do">
									상점 홈
								</a>
								<div class="hr"></div>
								<a class="popup_menu_item" href="#">
									최근에 본 항목
								</a>
								<a class="popup_menu_item" href="#">
									최근에 업데이트됨
								</a>
							</div>
						</div>
	
	
						<div class="tab  flyout_tab " id="genre_tab" data-flyout="genre_flyout" data-flyout-align="left" data-flyout-valign="bottom">
							<span class="pulldown">
								<a class="pulldown_desktop" href="#">
									게임
								</a>
								<a class="pulldown_mobile" href="#">게임</a><span></span>
							</span>
						</div>
						
						<div class="popup_block_new flyout_tab_flyout responsive_slidedown" id="genre_flyout" 
							style="visibility: visible; top: 42px; left: 95.6418px; display: none; opacity: 1;">
							<div class="popup_body popup_menu">
								<!-- 게임 팝업 메뉴 넣기 -->
		
		
							</div>
						</div>
	
	
						<!-- 하드웨어 -->
						<div class="tab  flyout_tab " id="hardware_tab" data-flyout="hardware_flyout" data-flyout-align="left" data-flyout-valign="bottom">
							<span class="pulldown">
								<a class="pulldown_desktop" href="#">
									하드웨어
								</a>
								<a class="pulldown_mobile" href="#">하드웨어</a> <span></span>
							</span>
						</div>
						<div class="popup_block_new flyout_tab_flyout responsive_slidedown" id="hardware_flyout" 
							style="visibility: visible; top: 41.9963px; left: 174.448px; display: none; opacity: 1;">
							<div class="popup_body popup_menu">
								<a class="popup_menu_item" href="#">
									Stream Controller
								</a>
								<a class="popup_menu_item" href="#">
									Stream Link
								</a>
								<a class="popup_menu_item" href="#">
									Stream Machine
								</a>
								<a class="popup_menu_item" href="#">
									HTC Vive
								</a>
							</div>
						</div>
					
						<!-- <a class="tab  "href="news.do"> -->
						<a class="tab  href="javascript:void(0);" onclick="alert('준비 중인 컨텐츠입니다.');">
							<span>뉴스</span>
						</a>
	
						<div class="search_area">
							<div id="store_search">
								<form id="searchform" name="searchform" method="get" action="gameSearchSpecial.do"> <!-- onsubmit="return SearchSuggestCheckTerm(this);"> -->
									<!-- <input type="hidden" name="snr" value="1_4_4__12"> -->
									<div class="searchbox">
										<input id="store_nav_search_term" name="term" type="text" class="default" placeholder="상점 검색" size="22" autocomplete="off">
										<a href="#" id="store_search_link" onclick="document.getElementById('searchform').submit();">
											<img src="${pageContext.request.contextPath}/resources/public/shared/images/default/blank.gif">
										</a>
									</div>
								</form>
							</div>
							
							<!-- 검색 내용 있을 경우 display block -->
							<div id="searchterm_options" class="search_suggest popup_block_new" style="opacity: 1; display: none;">
								<div class="popup_body" style="border-top: none;">
									<div id="search_suggestion_contents">
										<!-- 게임 하나 당 a 태그 하나(최대 5개 보여줌) -->
										<!-- 마우스 올리면 focus class 추가 -->
										<!-- 
										<a class="match ds_collapse_flag app_impression_tracked" appid="게임 번호"
											href="#게임 상세 페이지" data-ds-options="0">
											<div class="match_name">게임 명</div>
											<div class="match_img">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/test/search_imge.jpg"/>">
											</div>
											<div class="match_price">₩ 18,500</div>
										</a>
										
										<a class="match ds_collapse_flag app_impression_tracked" appid="게임 번호"
											href="#게임 상세 페이지" data-ds-options="0">
											<div class="match_name">게임 명</div>
											<div class="match_img">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/test/search_imge.jpg"/>">
											</div>
											<div class="match_price">₩ 18,500</div>
										</a>
										 -->
										 
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="store_nav_rightcap"></div>
			</div>
		</div>
	</div>
	<!-- end content top 메뉴 -->
</body>
</html>