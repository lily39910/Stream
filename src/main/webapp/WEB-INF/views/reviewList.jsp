<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<!DOCTYPE html>
<html>
<head>
<title>Stream :: 내 평가 목록</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 크롬 툴바 색상 변경(tab 부분 색상 변경) -->
<meta name="theme-color" content="#171a21">
<!-- 홈페이지 탭 부분 로고 -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/default/icon.ico" type="image/x-icon">
	

<link href="${pageContext.request.contextPath}/resources/css/motiva_sans.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/buttons.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/shared_global.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/globalv2.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/profilev2.css" rel="stylesheet" type="text/css">



<link href="${pageContext.request.contextPath}/resources/css/profile_sharedfiles.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/profile_reviews.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/shared_responsive.css" rel="stylesheet" type="text/css">	
<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js" />
<!-- 다른 라이브러리와 충돌 방지를 위해 사용 -->
<script type="text/javascript"> /* $J = */jQuery.noConflict(); </script>

</head>
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
									<span
									class="profile_small_header_arrow">&raquo;</span> <a
									class="whiteLink"
									href="reviewList.do"><span
									class="profile_small_header_location">평가</span></a>
							</div>
									
									

							<a href="profilesEdit.do">
								<div class="profile_small_header_avatar">
									<div class="playerAvatar medium offline">
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
								<a
									href="purchasedlist.do"
									class="sectionTab "><span>구매 목록</span></a> <a
									href="wishlist.do"
									class="sectionTab "><span>찜 목록</span></a> <a
									href="reviewList.do"
									class="sectionTab  active"><span>평가</span></a>
							</div>


							<div id="tabs_baseline" class="responsive_tab_baseline"></div>

							<div style="clear: left"></div>
							<div class="sectionTabsHR ">
								<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/default/trans.gif"/>">
							</div>

							<div id="tabs_basebg" class="review_list">

								<div id="rightContents">
									<div class="box">
										<div>
											<div class="review_stat">
												<div class="giantNumber ellipsis">${fn:length(evoList)}</div>
												<div class="giantNumberSubhead ellipsis">
													평가한<br>제품
												</div>
											</div>
											<div class="review_stat">
												<div class="giantNumber ellipsis">${countGame}</div>
												<div class="giantNumberSubhead ellipsis">
													계정에 있는<br>제품
												</div>
											</div>
										</div>
										<div style="clear: left;"></div>
									</div>
									
									<div style="clear: left;"></div>
								</div>

								<div id="leftContents">

									<h1>${user.nickname} 님이 작성한 평가</h1>


									<div class="workshopBrowsePaging">
										<div class="workshopBrowsePagingControls"></div>
										<!-- <div class="workshopBrowsePagingInfo">1-1/1개 항목을 표시 중</div> -->
									</div>

									
									<c:forEach var="k" items="${evoList}">
									<div class="review_box" style="margin-bottom: 10px;">
										<!-- <div class="header">아직 아무도 이 평가가 유용하다고 하지 않음</div> -->
										<div style="clear: left;"></div>
										
										<div class="review_box_content">
											<div class="leftcol">
												<a href="myReviewDetail.do?p_idx=${k.p_idx}"> <img
													src="<c:url value="${pageContext.request.contextPath}/resources/public/game/game_image/${k.detail_img}"/>">
												</a>
											</div>
	
											<div class="rightcol">
												<div class="vote_header">
													<c:choose>
														<c:when test="${k.e_opinion eq '100'}">
															<div class="thumb">
																<a>
																	<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/store/icon_thumbsUp.png"/>"
																	width="44" height="44">
																</a>
															</div>
															<div class="title">
																<a>추천</a>
															</div>								
														</c:when>
														<c:otherwise>
															<div class="thumb">
																<a>
																	<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/store/icon_thumbsDown.png"/>"
																	width="44" height="44">
																</a>
															</div>
															<div class="title">
																<a>비추천</a>
															</div>			
														</c:otherwise>
													</c:choose>
													
												</div>
												<div class="content">
													${k.e_content}
												</div>
												<div class="posted">20${k.e_date}에 게시되었습니다.</div>
												<div class="hr"></div>
											</div>
											<div style="clear: left;"></div>
										</div>										
									</div>
									</c:forEach>

									<div class="workshopBrowsePaging">
										<div class="workshopBrowsePagingControls"></div>
										<!-- <div class="workshopBrowsePagingInfo">1-1/1개 항목을 표시 중</div> -->
									</div>
								</div>
							</div>
							<br clear="all" /> <br />
						</div>
					</div>
				</div>

				<div id="footer_spacer"></div>
				<div id="footer_responsive_optin_spacer"></div>
				<div id="footer_spacer"></div>
				<div id="footer_responsive_optin_spacer"></div>
				<div id="footer">
					<div class="footer_content">
						<span id="footerLogo">
						<img
							src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/footer/logo_valve_footer.png"/>"
							width="96" height="26" border="0" alt="Valve 로고" /></span> 
						<span id="footerText"> &copy; Valve Corporation. 모든 권리 보유. 모든
							상표는 미국 및 기타 국가에서 각각 해당 소유자의 재산입니다. 이 웹사이트의 일부 지역 정보 데이터는 <a>geonames.org</a>에서
							제공합니다.<br> <span class="valve_links"> <a>Privacy
									Policy</a> &nbsp; | &nbsp;<a>Legal</a> &nbsp;| &nbsp; <a>Stream
									Subscriber Agreement</a></span>
						</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>