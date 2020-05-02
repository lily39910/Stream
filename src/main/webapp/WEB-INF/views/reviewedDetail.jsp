<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>평가 등록</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <meta name="viewport" content="width=device-width,initial-scale=1"> -->
<!-- 크롬 툴바 색상 변경(tab 부분 색상 변경) -->
<meta name="theme-color" content="#171a21">
<!-- 홈페이지 탭 부분 로고 -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/default/icon.ico" type="image/x-icon">


<link href="${pageContext.request.contextPath}/resources/css/motiva_sans.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/buttons.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/shared_global.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/globalv2.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/workshop.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/profilev2.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/profile_recommended.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/user_reviews.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/shared_responsive.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js" />
<!-- 다른 라이브러리와 충돌 방지를 위해 사용 -->
<script type="text/javascript"> /* $J = */jQuery.noConflict(); </script>


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
	<c:otherwise>
		<body class="flat_page migrated_profile_page responsive_page">
			<div class="responsive_page_frame with_header">
				<div class="responsive_page_content">
					<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp"/>
					<div class="responsive_page_template_content">
		
						<script>
							function EditReview() {
								$('#ReviewText').hide();
								$('#ReviewEdit').show();
								$('#ReviewTitle').hide();
							}
		
							
							function CancelEdits() {
								$('#ReviewEditTextArea').val($('#ReviewText').text());
								
								if($('#ReviewTitle > .ratingSummary').text() === '추천'){
									$('#OwnerVoteUpBtn').removeClass('active');
									$('#OwnerVoteDownBtn').removeClass('active');
									$('#OwnerVoteUpBtn').addClass('active');
									$('#e_opinion').val('100');
															
								}else {
									$('#OwnerVoteUpBtn').removeClass('active');
									$('#OwnerVoteDownBtn').removeClass('active');
									$('#OwnerVoteDownBtn').addClass('active');
									$('#e_opinion').val('0');
								}
								$('#ReviewText').show();
								$('#ReviewEdit').hide();
								$('#ReviewTitle').show();
							}
		
							function SetOwnerRatingPositive() {
								$('#OwnerVoteUpBtn').addClass('active');
								$('#OwnerVoteDownBtn').removeClass('active');
								$('#e_opinion').val('100');
							}
		
							function SetOwnerRatingNegative() {
								$('#OwnerVoteUpBtn').removeClass('active');
								$('#OwnerVoteDownBtn').addClass('active');
								$('#e_opinion').val('0');
							}
		
							
							function SaveReview() {
								if($('#ReviewEditTextArea').val().length == 0){
									alert('평가 내용을 입력해주세요.');
								}
								else {
									$("#updateReview").attr('action', 'reviewUpdate_ok.do');
									$("#updateReview").attr('method', 'post');
									$( "#updateReview" ).submit();
								}
							}
		
							
							function DeleteReview() {
								var result = confirm('평가를 삭제할까요?'); 
								if(result) { 
									//yes 
									var e_idx = $('#e_idx').val();
									location.replace('reviewDelete.do?e_idx='+e_idx); 
								} 
								else { 
									//no
								} 
							}
						</script>
		
						<div class="pagecontent no_header profile_subpage_column">
							<div class="profile_small_header_bg">
								<div class="profile_small_header_texture">
		
									<div class="profile_small_header_text">
										<span class="profile_small_header_name"><a
											class="whiteLink"
											href="profilesEdit.do">${user.id}</a></span>
										<span class="profile_small_header_arrow">&raquo;</span> <a
											class="whiteLink"
											href="reviewList.do"><span
											class="profile_small_header_location">평가</span></a> <span
											class="profile_small_header_arrow">&raquo;</span> <a
											class="whiteLink"><span
											class="profile_small_header_location">${evo.g_name}</span></a>
		
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
							<div class="maincontent" id="BG_bottom">
								<div class="bluefade">
									<div class="review_page_content">
										<div id="rightContents" class="responsive_local_menu">
		
											<div class="review_app_actions responsive_hidden">
		
												<div class="gameLogoHolder_default">
													<a href="gameDetail.do?g_idx=${evo.g_idx}"> 
														<img src="<c:url value="${pageContext.request.contextPath}/resources/public/game/game_image/${evo.detail_img}"/>">											
													</a>
												</div>
		
												<a class="general_btn panel_btn"
													href="gameDetail.do?g_idx=${evo.g_idx}"><img
													class="toolsIcon"
													src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/store/icon_store.png"/>">상점 페이지 보기</a> 
											</div>
		
											<div class="panel owner">
												<div class="title">소유자 컨트롤</div>
												<a class="general_btn panel_btn" href="javascript:void(0);"
													onclick="EditReview();"><img class="toolsIcon"
													src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/store/icon_edit.png"/>">평가
													수정</a>
												<div class="hr padded"></div>
		
												<span class="general_btn panel_btn" onclick="DeleteReview()">
													<img class="toolsIcon" src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/store/icon_delete.png"/>">삭제
												</span>
													
			
												<div class="hr padded"></div>
		
												
											</div>
		
		
										</div>
		
										<div id="leftContents">
											<!-- <div class="ratingBar">아직 아무도 이 평가가 유용하다고 하지 않음</div> -->
											<div class="ratingBar">${evo.g_name} 평가</div>
											<div class="ratingSummaryBlock" id="ReviewTitle">
												
												<c:choose>
													<c:when test="${evo.e_opinion eq '100'}">
														<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/store/icon_thumbsUp.png"/>" align="left">
														<div class="ratingSummary">추천</div>	
													</c:when>
													<c:otherwise>
														<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/store/icon_thumbsDown.png"/>" align="left">
														<div class="ratingSummary">비추천</div>	
													</c:otherwise>
												</c:choose>
												
												<div class="recommendation_date">게시 일시: 20${evo.e_date}</div>
											</div>
											<br clear="all" />
		
											<div class="review_area">
												<div class="review_area_content">
													<div id="ReviewText">${evo.e_content}</div>
													
													<div id="ReviewEdit" style="display: none">
														<form id="updateReview">
															<textarea id="ReviewEditTextArea" name="e_content" class="review_edit_text_area" maxlength="8000" rows="2" cols="80" style="width: 572px;">${evo.e_content}</textarea>
															<div style="float: left">
																이 게임을 추천하시겠습니까? 
																<c:choose>
																	<c:when test="${evo.e_opinion eq '100'}">
																		<span
																			class="btn_grey_grey btn_small_thin ico_hover active"
																			onclick="SetOwnerRatingPositive();" id="OwnerVoteUpBtn">
																			<span><i class="ico16 thumb_up"></i> 네</span>
																		</span> 
																		<span class="btn_grey_grey btn_small_thin ico_hover "
																			onclick="SetOwnerRatingNegative();" id="OwnerVoteDownBtn">
																			<span><i class="ico16 thumb_down"></i>아니요</span>
																		</span>
																	</c:when>
																	<c:otherwise>
																		<span
																			class="btn_grey_grey btn_small_thin ico_hover"
																			onclick="SetOwnerRatingPositive();" id="OwnerVoteUpBtn">
																			<span><i class="ico16 thumb_up"></i> 네</span>
																		</span> 
																		<span class="btn_grey_grey btn_small_thin ico_hover active"
																			onclick="SetOwnerRatingNegative();" id="OwnerVoteDownBtn">
																			<span><i class="ico16 thumb_down"></i>아니요</span>
																		</span>
																	</c:otherwise>
																</c:choose>
																<input type="hidden" name="e_opinion" id="e_opinion" value="${evo.e_opinion}">
																<input type="hidden" name="e_idx" id="e_idx" value="${evo.e_idx}">
																<input type="hidden" name="p_idx" id="p_idx" value="${evo.p_idx}">
															</div>
															<div style="float: right">
																<span class="btn_small_thin btn_grey_white_innerfade"
																	onclick="CancelEdits();" id="CancelEditsBtn"> <span>취소</span>
																</span> <span class="btn_small_thin btn_blue_white_innerfade"
																	onclick="SaveReview();" id="SaveReviewBtn"> <span>변경사항 저장</span>
																</span>
															</div>
															<div style="clear: both"></div>
															
														</form>
													</div>
												</div>
		
											</div>
										</div>
										<div style="clear: both;"></div>
		
									</div>
								</div>
							</div>
						</div>
						<!-- footer -->
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
						<!-- end footer -->
					</div>
				</div>
			</div>
		</body>
	</c:otherwise>
</c:choose>
</html>