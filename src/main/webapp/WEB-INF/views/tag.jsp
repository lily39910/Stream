<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Stream의 인기 태그</title>
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
<link href="${pageContext.request.contextPath}/resources/css/tags.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/browse.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/recommended.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/shared_responsive.css" rel="stylesheet" type="text/css">


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js"/>
<!-- 다른 라이브러리와 충돌 방지를 위해 사용 -->
<script type="text/javascript">/* $J = */ jQuery.noConflict();</script>

<script>
	$(document).ready(function(){
		$('#tag_browse_global > .tag_browse_tag').on('click',function(){
			$('.tag_browse_tag').removeClass('active');
			$(this).addClass('active');
			//$(this).attr('data-tagid');
			//$('.browse_tag_games > h3').html();
			var t_idx = $(this).attr('data-tagid');
			var t_name = $(this).text();
			
			$('.browse_tag_games').empty();
			
			$.ajax({
				url: '/StreamAjax/searchGamebyTag',
				type: 'get',
				dataType: 'json',
				data: 'tag=' + t_idx,
				success: function(data){
					var tagGame = '<h3>' + t_name +'</h3>';
					
					if(JSON.stringify(data) === '[]'){ //검색된 데이터가 없을 경우
						tagGame += '<br><p>해당 태그에 대한 검색 결과가 없습니다.</p>';
					}
					else {
						$.each(data, function(index, data) {
							if(index < 9){
								tagGame += '<div class=\"browse_tag_game\">';
								tagGame += '<div class=\"browse_tag_game_cap app_impression_tracked\" data-ds-appid=\"' + this['g_idx']+ '\">';	
								tagGame += '<a href=\"gameDetail.do?g_idx=' + this['g_idx'] + '\">';
								tagGame += '<img src=\"${pageContext.request.contextPath}/resources/public/game/game_image/' + this['cover'] + '\"></a></div>';
								tagGame += '<div class=\"browse_tag_game_name\">' + this['g_name'] + '</div>';
								tagGame += '<div class=\"browse_tag_game_price\">₩ ' + this['price'] + '</div></div>';
							}
						});
					}
					tagGame += '<div style=\"clear: left;\"></div>';
					var count = data.length;
					$('.browse_tag_game_total').empty();
					var moreBtn = '';
					if(count > 0){
						moreBtn += '<a class=\"btnv6_blue_hoverfade btn_small_tall\" href=\"gameSearchSpecial.do?tags=' + t_idx + '\">';
						moreBtn += '<span>' + count +' 개 모두 검색</span></a>';
					}
					$('.browse_tag_games').append(tagGame);
					$('.browse_tag_game_total').append(moreBtn);
				},
				error: function(){
					//alert('error');
				}
			});
			
			
			
			$('#tag_browse_games_ctn').css('display', 'block');
			
		});
		
	});
</script>
</head>
<html>
<body class="v6 tag_page responsive_page">

	<div class="responsive_page_frame with_header">

		<div class="responsive_page_content">
			<!-- header -->
			<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp"/>
			<!-- end header -->
			
			<div id="responsive_store_nav_ctn"></div>
			<div class="responsive_page_template_content">

				<div class="page_header_ctn tabs">

					<!-- contextTopMenu -->
					<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/contentTopMenu.jsp"/>
					<!-- end contextTopMenu -->

					<div class="page_content">

						<div class="tag_browse_header_area">
							<h2 class="pageheader tag_browseheader">인기 태그</h2>
							<div class="tag_browse_header_desc">가장 많이 달린 태그를 검색하고, 자주 달린 순서대로 정렬하세요.</div>
							<div class="tag_browse_header_desc">
							</div>
						</div>

					</div>
				</div>


				<div class="page_content_ctn friend_activity">
					<div class="page_content">
						<div class="tag_browse_description">
							<div id="tag_browse_description_global">이 태그들은 Stream 전체 제품을 통틀어 가장 많이 붙은 태그들을 많은 순서로 나열한 것입니다.</div>
								
							<div id="tag_browse_description_yours" style="display: none;">
								이 태그들은 귀하가 최소 한 번 이상 붙인 태그들을 횟수가 많은 순으로 나열한 것입니다. 태그를 선택하시면 커뮤니티
								내의 다른 사람이 붙인 것을 포함한 해당 태그가 붙은 제품들이 나열됩니다.</div>
							<div id="tag_browse_description_recommended" style="display: none;">
								이 태그들은 귀하가 최근에 Stream에서 플레이한 게임이나
								사용한 소프트웨어를 기반으로 추천된 태그입니다.</div>
						</div>

						<div class="tag_browse_ctn">

							<div class="tag_browse_tags" id="tag_browse_global">
								<c:forEach var="k" items="${tvo}">
									<div class="tag_browse_tag" data-tagid="${k.tag_idx}">${k.tag_name}</div>
								</c:forEach>
							
							</div>


							<div class="tag_browse_right_ctn">
								<!-- 스크롤 움직일 경우 style="position: fixed;" -->
								<div class="tag_browse_games_ctn" id="tag_browse_games_ctn" style="position: absolute; display: none;">
									<!-- 태그 선택 하기 전에는 값 x -->
									<div class="tag_browse_games_results">
										<div class="browse_tag_games">
											<h3>선택한 태그명</h3>
											<!-- 게임 정보들 -->
											
											<div style="clear: left;"></div>	
										</div>
										
										<div class="browse_tag_game_total">
											<a class="btnv6_blue_hoverfade btn_small_tall" href="#게임 검색">
												<span>(개임 갯수) 개 모두 검색</span>
											</a>
										</div>
										
										
									</div>
								</div>
							</div>

							<div style="clear: both;"></div>
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
				</div>

				<!-- footer -->
				<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/footer.jsp"/>
				<!-- end footer -->
			</div>
		</div>
	</div>
</body>
</html>