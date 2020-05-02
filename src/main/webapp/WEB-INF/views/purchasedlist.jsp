<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Stream :: 구매 목록</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <meta name="viewport" content="width=device-width,initial-scale=1"> -->
<!-- 크롬 툴바 색상 변경(tab 부분 색상 변경) -->
<meta name="theme-color" content="#171a21">
<!-- 홈페이지 탭 부분 로고 -->
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/default/icon.ico"
	type="image/x-icon">

<!-- 사이트 링크 시 보이는 정보? -->
<!-- <meta property="og:site" content="Stream"> -->

<!-- 대표 url주소를 검색엔진에 알려주는 역할 -->
<!-- <link rel="canonical" href="/main.do"> -->


<link href="${pageContext.request.contextPath}/resources/css/motiva_sans.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/shared_global.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/buttons.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/globalv2.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/profilev2.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/profile_sharedfiles.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/profile_games_list.css" rel="stylesheet" type="text/css">	
<link href="${pageContext.request.contextPath}/resources/css/shared_responsive.css" rel="stylesheet" type="text/css">	
<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">

<style>
#supernav_store_content {
	width : 65px;
	padding-bottom: 10px;
}

</style>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery.min.js" />
<!-- 다른 라이브러리와 충돌 방지를 위해 사용 -->
<script type="text/javascript">
	/* $J =  */jQuery.noConflict();
</script>
<script>
	$(document).ready(function() {
		//대소문자 구분 x
		$.extend($.expr[":"], {
			"containsIN": function(elem, i, match, array) {
			return (elem.textContent || elem.innerText || "").toLowerCase().indexOf((match[3] || "").toLowerCase()) >= 0;
		}});
		
		
		$('#gameFilter').keyup(function(){
			var searchGame = $('#gameFilter').val();
			if(searchGame === ''){
				$('#games_list_rows > .gameListRow').css('display', 'block');
			}else {				
				$('#games_list_rows > .gameListRow').css('display', 'none');
	
				//$('#games_list_rows > .gameListRow > .gameListRowItem > .gameListRowItemName').
				$('.gameListRowItemName:containsIN("' + searchGame + '")').parent().parent().css('display', 'block');
				//$('#games_list_rows > .tab_filter_control:contains("' + searchGame + '")').css('display', 'block');
			}
		});

		
	
	});
</script>

</head>

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
<body class="flat_page migrated_profile_page responsive_page">

	<div class="responsive_page_frame with_header">
		<div class="responsive_page_content">
			<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp" />
		
			<div class="responsive_page_template_content">

				<div class="pagecontent no_header">

					<div class="profile_small_header_bg">
						<div class="profile_small_header_texture">		
							<div class="profile_small_header_text">
								<span class="profile_small_header_name"><a href="profilesEdit.do"
									class="whiteLink">${user.nickname}</a></span> <span
									class="profile_small_header_arrow">&raquo;</span> <a
									class="whiteLink" href="purchasedlist.do"><span
									class="profile_small_header_location">내 게임</span></a>
		
							</div>
							<a href="profilesEdit.do">
								<div class="profile_small_header_avatar">
									<div class="playerAvatar medium offline">
										<%--<c:url value="${pageContext.request.contextPath}/resources/personal/profile/${user.profile_image}"/> --%>
										<c:if test="${user.profile_image ne null}">											
											<c:if test="${user.profile_image ne ''}">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/personal/profile/${user.profile_image}"/>">
											</c:if>
										</c:if>
									</div>
								</div>
							</a>
						</div>
					</div>
					
					<!-- main body -->
					<div id="BG_bottom" class="maincontent">
						<div id="mainContents">
							
							<div class="sectionTabs item responsive_hidden">
								<a href="purchasedlist.do"
									class="sectionTab  active"><span>구매 목록</span></a> <a
									href="wishlist.do"
									class="sectionTab "><span>찜 목록</span></a> <a
									href="reviewList.do"
									class="sectionTab "><span>평가</span></a>
							</div>

							<div id="tabs_baseline" class="responsive_tab_baseline"></div>

							<div style="clear: left"></div>
							<div class="sectionTabsHR ">
								<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/default/trans.gif"/>">
							</div>

							<div id="tabs_basebg" class="games_list">
								<div id="gameslist_controls">
									<div id="gameslist_sort_options" class="sort_options">
										정렬 순서 &nbsp;<span class="selected_sort">구매일순</span> &nbsp;
									</div>
									게임 검색
									<div class="gray_bevel for_text_input">
										<input type="text" id="gameFilter" name="gameFilter"/>
									</div>
									<br />
									<div style="clear: right;"></div>
								</div>


								<div id="games_list_row_container">
									<div id="games_list_rows" style="position: relative">
										<c:choose>
											<c:when test="${empty pvo}">
												<p>구매한 게임이 없습니다.</p>
											</c:when>
											<c:otherwise>
												<!-- 게임 1 -->
												<c:forEach var="k" items="${pvo}" varStatus="vs">
													<div class="gameListRow" id="${k.g_idx}">
														<div class="gameListRowLogo">
															<a href="gameDetail.do?g_idx=${k.g_idx}">
																<img src="<c:url value="${pageContext.request.contextPath}/resources/public/game/game_image/${k.cover}"/>">
															</a>
														</div>
														<div class="gameListRowItem">
															<div class="gameListRowItemName ellipsis">${k.g_name}</div>
															<h5 class="ellipsis hours_played">${k.purchase_date}</h5>
															<div class="bottom_controls">
																<a class="pullup_item" href="gameDetail.do?g_idx=${k.g_idx}">
																	<div class="menu_ico">
																		<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/skin_1/ico_www.png"/>" width="16" height="16" border="0">
																	</div>
																	상점 페이지 방문
																</a>
																<a class="pullup_item" href="gameDown.do?file_name=${k.game_file}">
																	<div class="menu_ico">
																		<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/skin_1/ico_downfile.png"/>" width="16" height="16" border="0">
																	</div>
																	다운로드
																</a>
																<a class="pullup_item" href="review.do?p_idx=${k.p_idx}">
																	<div class="menu_ico">
																		<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/skin_1/icon_rate.png"/>" width="16" height="16" border="0">
																	</div>
																	평가
																</a>
															</div>
														</div>
													</div>
												</c:forEach>
												<!-- end 게임 1 -->
											</c:otherwise>
										</c:choose>
									</div>
								</div>

							</div>

						</div>

						<br clear="all" /> <br />

					</div>

				</div>
			</div>
			<!-- responsive_page_legacy_content -->

			<div id="footer_spacer"></div>
			<div id="footer_responsive_optin_spacer"></div>
			<div id="footer_spacer"></div>
			<div id="footer_responsive_optin_spacer"></div>
			<div id="footer">
				<div class="footer_content">
					<span id="footerLogo"><img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/footer/logo_valve_footer.png"/>" width="96" height="26" border="0" alt="Valve 로고" /></span>
					<span id="footerText">
						&copy; Valve Corporation. 모든 권리 보유. 모든 상표는 미국 및 기타 국가에서 각각 해당 소유자의 재산입니다. 이 웹사이트의 일부 지역 정보 데이터는 <a>geonames.org</a>에서 제공합니다.<br>
							<span class="valve_links">
								<a>Privacy Policy</a> &nbsp; | &nbsp;<a>Legal</a> &nbsp;| &nbsp; <a>Stream Subscriber Agreement</a>
							</span>
					</span>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
