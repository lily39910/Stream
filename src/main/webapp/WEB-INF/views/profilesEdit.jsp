<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Stream :: 프로필 수정</title>
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
<link href="${pageContext.request.contextPath}/resources/css/groupv2.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/shared_responsive.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/globalv2.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/profilev2.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/groupadmin.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/profile_editv2.css" rel="stylesheet" type="text/css">
	
<!-- 	
<link
	href="http://steamcommunity-a.akamaihd.net/public/css/skin_1/modalContent.css?v=.TP5s6TzX6LLh"
	rel="stylesheet" type="text/css">	

<link
	href="http://steamcommunity-a.akamaihd.net/public/css/skin_1/header.css?v=tZYBxDBV1D4c"
	rel="stylesheet" type="text/css">
 -->

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js"/>
<!-- 다른 라이브러리와 충돌 방지를 위해 사용 -->
<script type="text/javascript">/* $J =  */jQuery.noConflict();</script>
<script>
	$(document).ready(function(){
		if($('#profile_image_origin').val() == ''){
			$('#avatar_full_img').removeAttr('src');
			$('#avatarBlockFull').css('display', 'none');
			$('#avatar_del_button').css('display', 'none');
			$('#img_exist').text('이미지를 업로드하세요.');
		}else {
			$('#avatarBlockFull').css('display', 'block');
			$('#avatar_del_button').css('display', 'block');
			$('#img_exist').text('');
		}
		
		//이미지 제거 버튼
		$('#avatar_del_button').on('click', function(){
			$('#avatar_full_img').removeAttr('src');
			$('#profile_image_origin').val('');
			$('#avatarBlockFull').css('display', 'none');
			$('#avatar_del_button').css('display', 'none');
			$('#img_exist').text('이미지를 업로드하세요.');
		});
		
		//변경 사항 수정
		$('#updateProfileBtn').on('click', function(){
			$('#editForm').attr('action', 'profilesUpdate.do').submit();
			alert('프로필이 수정되었습니다.');
		});
	});
	
	//fakefile 해결(게임 설명 요약)
	function readProfileImgURL(input) {
		if (input.files && input.files[0]) { 
 			var reader = new FileReader();
			reader.onload = function (e) { 
				$('#avatar_full_img').attr('src', e.target.result); 
				
				var is_Img = $('#avatar_full_img').attr('src');
				if(is_Img == undefined) {
					$('#avatarBlockFull').css('display', 'none');
					$('#avatar_del_button').css('display', 'none');ss
					$('#img_exist').text('이미지를 업로드하세요.');
				}
				else {
					$('#avatarBlockFull').css('display', 'block');
					$('#avatar_del_button').css('display', 'block');
					$('#img_exist').text('');
				}
			} 
			reader.readAsDataURL(input.files[0]);
		}
 	}
	/*
	function imgAlert(){
		var is_Img = $('#avatar_full_img').attr('src');
		if(is_Img == undefined) {
			$('#avatarBlockFull').css('display', 'none');
			$('#avatar_del_button').css('display', 'none');
			$('#img_exist').text('이미지를 업로드하세요.');
		}
		else {
			$('#avatarBlockFull').css('display', 'block');
			$('#avatar_del_button').css('display', 'block');
			$('#img_exist').text('');
		}
	}
	*/
</script>

</head>
<html>
<c:choose>
	<c:when test="${!login_chk}">
		<script>
			alert('로그인이 되어있지 않아 프로필로 이동 불가능합니다.\n메인 페이지로 이동합니다.');
		</script>
		<body onload="javascript:location.href='main.do'">
			<h2>메인 페이지로 이동합니다.</h2>
		</body>
	</c:when>
	
	<c:otherwise>
		<body class="flat_page responsive_page">
			<div class="responsive_page_frame with_header">
				<div class="responsive_page_content">
					<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp" />
		
					<div class="pagecontent ">
						<div class="profile_small_header_bg">
							<div class="profile_small_header_texture">
		
								<div class="profile_small_header_text">
									<span class="profile_small_header_name"><a href="profilesEdit.do"
										class="whiteLink">${user.nickname}</a></span> <span
										class="profile_small_header_arrow">&raquo;</span> <a
										class="whiteLink" href="profilesEdit.do"><span
										class="profile_small_header_location">프로필 수정</span></a>
		
								</div>
								<a href="profilesEdit.do">
									<div class="profile_small_header_avatar">
										<div class="playerAvatar medium offline">
											<%--<c:url value="${pageContext.request.contextPath}/resources/personal/profile/${user.profile_image}"/> --%>
											<c:choose>
												<c:when test="${user.profile_image ne null}">
													<c:if test="${user.profile_image ne ''}">
														<img src="<c:url value="${pageContext.request.contextPath}/resources/personal/profile/${user.profile_image}"/>">													
													</c:if>
												</c:when>
											</c:choose>
										</div>
									</div>
								</a>
							</div>
						</div>
						<div class="grouppage_content_area groupadmin_content">
							<div class="maincontent">
		
		
								<div class="leftcol hasContentBoxes">
									<form class="smallForm" id="editForm" name="editForm" method="POST" enctype="multipart/form-data">
		
										<div class="group_content group_summary">
											<div class="formRow">
												<div class="formRowTitle">프로필 이름</div>
												<div class="formRowFields">
													<div class="gray_bevel for_text_input">
														<input class="dynInput" type="text" name="nickname" id="personaName" size="30" value="${user.nickname}">
													</div>
												</div>
											</div>
											<div class="formRow">
												<div class="formRowTitle">비밀번호</div>
												<div class="formRowFields">
													<div class="gray_bevel for_text_input">
														<input class="dynInput" type="password" name="pwd" id="pwd" size="30">
													</div>
												</div>
											</div>
											<div class="formRow">
												<div class="formRowTitle">비밀번호 확인</div>
												<div class="formRowFields">
													<div class="gray_bevel for_text_input">
														<input class="dynInput" type="password" name="pwd_chk" id="pwd_chk" size="30">
													</div>
												</div>
											</div>
										</div>
		
		
		
										<div class="group_content group_summary">
											<div class="formRow">
												<div class="formRowTitle noPadding">아바타</div>
												<div class="formRowDesc">&nbsp;</div>
												<div class="formRowFields">
													<div class="avatar_previews">
														<div id="avatarBlockFull" class="avatar_edit_block full" style="display: block;">
															<img id="avatar_full_img" height="64" width="64" border="0" src="<c:url value="${pageContext.request.contextPath}/resources/personal/profile/${user.profile_image}"/>">
															<input type="hidden" value="${user.profile_image}" name="profile_image_origin" id="profile_image_origin"/>
														</div>
													</div>
		
													<div class="avatar_upload_ctn" id="avatar_upload_ctn">
														<div class="gray_bevel">
															<div class="upload_controls">
																
																<button id="avatar_del_button" type="button"
																	class="upload_btn btnv6_blue_hoverfade btn_small">
																	<span>제거</span>
																</button>
																
																<div class="avatar_upload_input_ctn">
																	<input type="file" id="avatar_upload_input" name="profile_image" size="16" onchange="readProfileImgURL(this);">
																</div>
		
															</div>
															<div class="avatar_upload_throbber">
																<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/login/throbber.gif"/>">
															</div>
														</div>
													</div>
													<p id="img_exist" style="margin-top: 0px;"></p>
												</div>
											</div>
											<div class="formRow">
												<div class="formRowFields"></div>
											</div>
										</div>
		
		
		
										<div class="group_content_bodytext">
											<div class="forum_manage_actions">
												<a href="main.do" class="btn_grey_white_innerfade btn_medium">
													<span>취소</span>
												</a>
												<button id="updateProfileBtn" type="submit" class="btn_green_white_innerfade btn_medium">
													<span>변경 내용 저장</span>
												</button>
											</div>
										</div>
		
									</form>
								</div>
		
								<div class="rightcol responsive_hidden">
									<div class="rightbox_header"></div>
									<div class="rightbox">
										<div class="rightbox_content_header" style="display: none;">MyPage</div>
										<div class="content" style="display: none;">
											<!-- 선택된 경우 selected 클래스 주기  -->
											<div class="rightbox_list_option selected">
												<div class="rightbox_list_selection_background"></div>
												<div class="rightbox_list_option_content">
													<a href="#profilesEdit"> 내 프로필 </a>
												</div>
											</div>
											<div class="rightbox_list_option">
												<div class="rightbox_list_selection_background"></div>
												<div class="rightbox_list_option_content">
													<a href="purchasedlist.do">구매 목록</a>
												</div>
											</div>
											<div class="rightbox_list_option">
												<div class="rightbox_list_selection_background"></div>
												<div class="rightbox_list_option_content">
													<a href="cart.do">내 평가</a>
												</div>
											</div>
										</div>
									</div>
									<div class="rightbox_footer"></div>
								</div>
		
								<div style="clear: both;"></div>
							</div>
						</div>
		
					</div>
		
					
				</div>
				<!-- responsive_page_legacy_content -->
		
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
		</body>
	</c:otherwise>
</c:choose>

</html>