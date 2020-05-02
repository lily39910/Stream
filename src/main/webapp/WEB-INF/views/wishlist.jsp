<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Stream ::찜 목록</title>
<link href="${pageContext.request.contextPath}/resources/css/motiva_sans.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/shared_global.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/buttons.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/store.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/game.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/wishlist.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/shared_responsive.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js"/>
<!-- 다른 라이브러리와 충돌 방지를 위해 사용 -->
<script type="text/javascript">/* $J = */ jQuery.noConflict();</script>
<!-- 크롬 툴바 색상 변경(tab 부분 색상 변경) -->
<meta name="theme-color" content="#171a21">
<!-- 홈페이지 탭 부분 로고 -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/default/icon.ico" type="image/x-icon">
<script>
	$(document).ready(function(){
		//대소문자 구분 x
		$.extend($.expr[":"], {
			"containsIN": function(elem, i, match, array) {
			return (elem.textContent || elem.innerText || "").toLowerCase().indexOf((match[3] || "").toLowerCase()) >= 0;
		}});
		
		//이름 OR 태그 검색
		$('#wishlist_search').keyup(function(){
			var wishGame = $('#wishlist_search').val();
			if(wishGame === ''){
				$('#wishlist_ctn > .wishlist_row').css('display', '');
			}else {
				$('#wishlist_ctn > .wishlist_row').css('display', 'none');
				
				//게임 이름
				$('#wishlist_ctn > .wishlist_row > .content > .title:containsIN("' + wishGame + '")').parent().parent().css('display', '');
				
				//게임 태그
				$('#wishlist_ctn > .wishlist_row > .content > .tags[value*="' + wishGame + '"]').parent().parent().css('display', '');
			}
		});
		
		
	});
	
	
	$(document).on('click', '.addCart', function(){
		var gNum = $(this).parent().parent().parent().parent().parent().attr('data-app-id');
		
		$.ajax({
			url: '/StreamAjax/check_cart',
			type: 'post',
			dataType: 'text',
			data: 'g_idx=' + gNum + '&game_id=' + gNum ,
			success: function(data){
				if(data == 0){
					//alert('장바구니에 담았습니다.\n장바구니로 이동합니다.');
					location.href='cart_add.do';
				}else {
					alert('이미 장바구니에 존재하는 게임입니다.\n장바구니로 이동합니다.');	
					location.href='cart.do';
				}
			},
			error: function(){
				alert('error');
			}
		});
		
	});
	
	
	//찜목록 제거
	function delWish(Widx, gName){
		var wishGame = $('[data-app-id=' + gName +']');
		//$('[data-app-id=' + gName +']').remove(); //css("background-color", "yellow");
		$.ajax({
			url: '/StreamAjax/del_wishlist',
			type: 'post',
			dataType: 'text',
			data: 'w_idx=' + Widx,
			success: function(data){
				if(data == 0){
					$('#wishlist_link').css('display', 'none');
					$('#wishlist_item_count_value').empty();
				} else {
					$('#wishlist_link').css('display', 'block');
					$('#wishlist_item_count_value').empty();
					$('#wishlist_item_count_value').append(data);
					//reload_wishlist
				}
				alert(wishGame.find('.title').text() + '이(가) 찜목록에서 제거되었습니다.');
				$('#wishlist_ctn > .wishlist_row').remove();
				reload_wishlist();
			},
			error: function(){
				//alert('error');
			}
		});
	}
	
	function reload_wishlist(){
		$.ajax({
			url: '/StreamAjax/reload_wishlist',
			success: function(data){
				var refreshWishlist = '';
				$.each(data, function(index, data) {
					refreshWishlist += '<div class=\"wishlist_row\" data-app-id=\"' + this['g_idx'] + '\" style=\"top:' + index * 87 + 'px;\">';
					refreshWishlist += '<div class=\"hover_handle\"><div><div class=\"order\">';
					refreshWishlist += '<input class=\"order_input\" type=\"text\" value=\"' + (index + 1) + '\"></div></div></div>';
					refreshWishlist += '<a class=\"capsule\" href=\"gameDetail.do?g_idx=' + this['g_idx'] + '\">';
					refreshWishlist += '<img src=\"${pageContext.request.contextPath}/resources/public/game/game_image/' + this['cover'] + '\" style=\"width: 162px; height: 75px;\"></a>';
					refreshWishlist += '<div class=\"content\">';
					refreshWishlist += '<a href=\"gameDetail.do?g_idx=' + this['g_idx'] + '\" class=\"title\">' + this['g_name'] + '</a>';
					refreshWishlist += '<div class=\"mid_container\"><div class=\"stats\"><div class=\"label\">종합 평가:</div>';
					refreshWishlist += '<div class=\"value game_review_summary positive\">압도적으로 긍정적</div>';
					refreshWishlist += '<div class=\"label\">출시 날짜:</div>';
					refreshWishlist += '<div class=\"value release_date\">' + this['release_date'] + '</div></div>';
					refreshWishlist += '<div class=\"purchase_container\"><div class=\"purchase_area\">';
					
					if(this['percent'] == null){
						refreshWishlist += '<div class=\"discount_block discount_block_large no_discount\">';
						refreshWishlist += '<div class=\"discount_prices\">';
						refreshWishlist += '<div class=\"discount_final_price\">₩ ' + this['price'] + '</div></div></div>';
					}
					else {
						refreshWishlist += '<div class=\"discount_block discount_block_large\">';
						refreshWishlist += '<div class=\"discount_pct\">-' + this['percent'] + '%</div>';
						refreshWishlist += '<div class=\"discount_prices\">';
						refreshWishlist += '<div class=\"discount_original_price\">₩ ' + this['price'] + '</div>';
						refreshWishlist += '<div class=\"discount_final_price\">₩ ' + this['price']*(0.01*(100-this['percent'])) + '</div></div></div>';
					}
					
					if(this['c_idx'] == null){
						refreshWishlist += '<a class=\"addCart btnv6_green_white_innerfade btn_medium noicon\">';
						refreshWishlist += '<span>장바구니에 추가</span></a>';
					}
					else {
						refreshWishlist += '<a href="cart.do" class=\"btnv6_green_white_innerfade btn_medium noicon\">';
						refreshWishlist += '<span>이미 장바구니에 있음</span></a>';
					}
					
					refreshWishlist += '</div></div></div> <div class=\"lower_container\"><div class=\"lower_columns\">';
					refreshWishlist += '<div class=\"addedon\">';
					refreshWishlist += '찜한 날짜: ' + this['saved_date'] + '(<div class=\"delete\" onclick=\"delWish($(this).children(\'.w_idx\').val(), \'' + this['g_idx'] + '\')\">삭제';
					refreshWishlist += '<input type=\"hidden\" class=\"w_idx\" value=\"' + this['w_idx'] + '\"></div>)</div></div></div></div></div>';
				});
				
				$('#wishlist_ctn').html(refreshWishlist);
				
			},
			error: function(){
				//alert('error');
			}
		});
	}
</script>

</head>
<body class="v6 wishlist game_bg responsive_page">

	<div class="responsive_page_frame with_header">
		<div class="responsive_page_content">

			<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp" />

			<div id="responsive_store_nav_ctn"></div>
			<div class="responsive_page_template_content">

				
				<div class="game_page_background game" style="background-image: url('../../resources/public/shared/images/v6/wishlist/page_bg_generated_v6b.jpg'); min-height: 810px">

					<div id="store_header" class="dlc">
						<div class="content">
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
						</div>
					</div>

					<div class="page_content_ctn">
						<div class="page_content" style="position: relative;">

							<div class="wishlist_header">
								<c:if test="${user.profile_image ne null}">											
									<c:if test="${user.profile_image ne ''}">
										<img src="<c:url value="${pageContext.request.contextPath}/resources/personal/profile/${user.profile_image}"/>">
									</c:if>
								</c:if>
								<h2>${user.nickname}'님의 찜 목록</h2>
							</div>

							<div class="controls">
								<div class="filter_tab dropdown" id="dropdown_sort" data-tooltip-content="
									&lt;div class=&quot;item&quot; data-dropdown-value=&quot;order&quot; onclick=&quot;g_Wishlist.SetFilterFromDropdown('sort', this)&quot;&gt;인기&lt;/div&gt;
									&lt;div class=&quot;item&quot; data-dropdown-value=&quot;name&quot; onclick=&quot;g_Wishlist.SetFilterFromDropdown('sort', this)&quot;&gt;이름&lt;/div&gt;		
									&lt;div class=&quot;item&quot; data-dropdown-value=&quot;price&quot; onclick=&quot;g_Wishlist.SetFilterFromDropdown('sort', this)&quot;&gt;가격&lt;/div&gt;				
									&lt;div class=&quot;item&quot; data-dropdown-value=&quot;discount&quot; onclick=&quot;g_Wishlist.SetFilterFromDropdown('sort', this)&quot;&gt;할인&lt;/div&gt;				
									&lt;div class=&quot;item&quot; data-dropdown-value=&quot;dateadded&quot; onclick=&quot;g_Wishlist.SetFilterFromDropdown('sort', this)&quot;&gt;찜한 날짜&lt;/div&gt;
									&lt;div class=&quot;item&quot; data-dropdown-value=&quot;releasedate&quot; onclick=&quot;g_Wishlist.SetFilterFromDropdown('sort', this)&quot;&gt;출시 날짜&lt;/div&gt;
									&lt;div class=&quot;item&quot; data-dropdown-value=&quot;reviewscore&quot; onclick=&quot;g_Wishlist.SetFilterFromDropdown('sort', this)&quot;&gt;평가 점수&lt;/div&gt;				
									">정렬 기준: <span id="label_sort">인기</span> <img
										src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/default/btn_arrow_down_padded_white.png"/>">
										
								</div>
								
								<div id="tab_filters" class="filter_tab"></div>
								<div class="search"></div>
								
								
								<div class="search">
									<input type="text" id="wishlist_search" placeholder="이름 또는 태그로 검색">
								</div>
							</div>
							
							<!-- 
							<div id="section_filters" class="filter_section">
								<div class="wrapper">
									<div class="category" id="price_brackets_container"><h3>가격</h3></div>
									<div class="category">
										<h3>할인</h3>
										<label><input class="filter_check" type="checkbox"
											name="discount_any"> 할인 중</label> <label><input
											class="filter_check" type="checkbox" name="discount_50">
											50% 이상</label> <label><input class="filter_check"
											type="checkbox" name="discount_75"> 75% 이상</label>

									</div>
									<div class="category">
										<h3>제외</h3>
										<label><input class="filter_check" type="checkbox"
											name="ex_earlyaccess"> 앞서 해보기</label> <label><input
											class="filter_check" type="checkbox" name="ex_prerelease">
											시험판</label> <label><input class="filter_check"
											type="checkbox" name="ex_vr"> VR-Only</label>
									</div>
									<div class="category">
										<h3>Only show</h3>
										<label><input class="filter_check" type="checkbox"
											name="platform_windows"> Windows</label> <label><input
											class="filter_check" type="checkbox" name="platform_mac">
											Mac OS X</label> <label><input class="filter_check"
											type="checkbox" name="platform_linux"> SteamOS +
											Linux</label>
									</div>
								</div>
							</div>
							-->
							
							
							<div class="hr"></div>
							<div id="filters_container"></div>
							
							<div id="wishlist_ctn" class="sort_order compact">
								<!-- wishlist 있을 경우 -->
								<c:forEach var="k" items="${wvo}" varStatus="vs">
									<div class="wishlist_row" data-app-id="${k.g_idx}" style="top:${vs.index * 87}px;">
										<div class="hover_handle">
											<div>
												<div class="order">
													<input class="order_input" type="text" value="${vs.count}">
												</div>
											</div>
										</div>
										
										<a class="capsule" href="gameDetail.do?g_idx=${k.g_idx}">
											<img src="<c:url value="${pageContext.request.contextPath}/resources/public/game/game_image/${k.cover}"/>" style="width: 162px; height: 75px;">
										</a>
										<div class="content">
											<a href="gameDetail.do?g_idx=${k.g_idx}" class="title">${k.g_name}</a>
											<input type="hidden" class="tags" value="${k.tag_name}">
											<div class="mid_container">
												<div class="stats">
													<div class="label">종합 평가:</div>
													<div class="value game_review_summary positive" data-tooltip-content="이 게임에 대한 사용자 평가 4,037개 중 96% 가 긍정적입니다.">
														압도적으로 긍정적
													</div>
													<div class="label">출시 날짜:</div>
													<div class="value release_date">${k.release_date}</div>
												</div>
												<div class="purchase_container">
													<div class="purchase_area">
														<c:choose>
															<c:when test="${k.percent ne null}">
																<div class="discount_block discount_block_large">
																	<div class="discount_pct">-${k.percent}%</div>
																	<div class="discount_prices">
																		<div class="discount_original_price">₩ ${k.price}</div>
																		<fmt:parseNumber var="discountPrice" integerOnly="true" value="${k.price*(0.01*(100-k.percent))}"/>
																		<div class="discount_final_price">₩ ${discountPrice}</div>
																	</div>
																</div>
															</c:when>
															<c:otherwise>
																<div class="discount_block discount_block_large no_discount">
																	<div class="discount_prices">
																		<div class="discount_final_price">₩ ${k.price}</div>
																	</div>
																</div>
															</c:otherwise>
														</c:choose>
														
														
														<c:choose>
															<c:when test="${k.c_idx ne null}">
																<a href="cart.do"  class="btnv6_green_white_innerfade btn_medium noicon">
																	<span>이미 장바구니에 있음</span>
																</a>
															</c:when>
															<c:otherwise>
																<a class="addCart btnv6_green_white_innerfade btn_medium noicon">
																	<span>장바구니에 추가</span>
																</a>
															</c:otherwise>
														</c:choose>
													</div>
												</div>
											</div>
											<div class="lower_container">
												<div class="lower_columns">
													<div class="addedon">
														찜한 날짜: ${k.saved_date}(<div class="delete" onclick="delWish($(this).children('.w_idx').val(), '${k.g_idx}')">삭제<input type="hidden" class="w_idx" value="${k.w_idx}"></div>)
													</div>
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
								<!-- end wishlist 있을 경우 -->
							</div>
							
							<div id="nothing_to_see_here" style="display: none">
								<h2>여기에 표시할 내용이 없습니다.</h2>
								<p>
									There are <span id="total_num_games"></span> items on your
									wishlist, but none of them match the filters you have applied
									above
								</p>
							</div>
							
							<!-- 로딩 중.. -->
							<!-- 
							<div id="throbber">
								<div class="LoadingWrapper">
									<div class="LoadingThrobber">
										<div class="Bar Bar1"></div>
										<div class="Bar Bar2"></div>
										<div class="Bar Bar3"></div>
									</div>
								</div>
							</div>
							 -->
							<!-- end 로딩 중.. -->
							
						</div>

					</div>

				</div>
			</div>
		</div>
	</div>
	
	<!-- Footer -->
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/footer.jsp"/>
	<!-- End Footer -->

</body>
</html>