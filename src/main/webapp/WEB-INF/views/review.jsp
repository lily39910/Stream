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
<link href="${pageContext.request.contextPath}/resources/css/shared_global.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/buttons.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/store.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/game.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/recommended.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js" />
<!-- 다른 라이브러리와 충돌 방지를 위해 사용 -->
<script type="text/javascript"> /* $J = */jQuery.noConflict(); </script>

<script type="text/javascript">
	function SetOwnerRatingPositive() {
		$('#VoteUpBtn').addClass('btn_active');
		$('#VoteDownBtn').removeClass('btn_active');
		$('#e_opinion').val('100');
		return false;
	}

	function SetOwnerRatingNegative() {
		$('#VoteUpBtn').removeClass('btn_active');
		$('#VoteDownBtn').addClass('btn_active');
		$('#e_opinion').val('0');
		return false;
	}
	
	$(document).ready(function(){
		$('#recommendation_submit').on('click', function(){
			if($('#game_recommendation').val() === ''){
				alert('평가 내용을 입력해주세요.')
			}
			else if($('#e_opinion').val() === ''){
				alert('추천 여부를 선택해주세요.');
			}
			else {
				$("#evaluation").attr('action', 'review_ok.do');
				$("#evaluation").attr('method', 'post');
				$( "#evaluation" ).submit();	
			}
		});
	});
</script>
</head>
<html>
<body class="v6 recommendgame">
	<!-- header -->
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp" />
	<!-- end header -->

	<div class="page_header_ctn">
		<!-- contextTopMenu -->
		<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/contentTopMenu.jsp" />
		<!-- end contextTopMenu -->

		<div class="page_content">
			<div class="breadcrumbs">
				<a href="main.do">모든 제품</a> &gt; <a href="#">평가 쓰기</a>
			</div>
			<h2 class="pageheader">${evo.g_name} 게임을 평가하는 중</h2>
		</div>
	</div>


	<!-- 평가 등록 부분 -->
	<div class="page_content_ctn">
		<div class="page_content">
			<div id="review_container">
				<form id="evaluation">
					<div id="review_create">
						<h1>${evo.g_name} 제품에 대한 평가 작성</h1>
						<p id="review_describe">
							이 게임의 좋았던 점 또는 싫었던 점, 그리고 이를 다른 사람들에게 추천하는지 여부에 대해 써주세요. <br>정중하게
							써주셔야 하며 <a style="cursor: pointer;">규칙 및 기준</a>을 지키셔야 합니다.
						</p>
						<div class="avatar_block">
	
							<a href="profilesEdit.do">
								<div class="avatar avatar_block_status_offline">
									<c:if test="${user.profile_image ne null}">											
										<c:if test="${user.profile_image ne ''}">
											<img src="<c:url value="${pageContext.request.contextPath}/resources/personal/profile/${user.profile_image}"/>">
										</c:if>
									</c:if>
								</div>
							</a>
	
						</div>
	
						<div class="content">
							<div class="error_message" id="recommendation_error"
								style="display: none;">평가 등록에 문제가 생겼습니다. 잠시 후에 다시 시도해 주세요.
							</div>
	
							<textarea class="input_box" id="game_recommendation" maxlength="8000" name="e_content"></textarea>
							<div class="controls">
								
								<div class="review_controls_left">
									<div class="review_control_didyouenjoy">이 게임을 추천하십니까?</div>
									<div class="controlblock review_create_vote_controls" id="VoteUpDownBtnCtn">
										<a class="btnv6_blue_hoverfade  btn_medium ico_hover" href="#"
											id="VoteUpBtn" onclick="return SetOwnerRatingPositive()">
											<span><i class="ico18 thumb_up"></i> 예</span></a> 
										<a class="btnv6_blue_hoverfade  btn_medium ico_hover" href="#"
											id="VoteDownBtn" onclick="return SetOwnerRatingNegative()">
											<span><i class="ico18 thumb_down"></i> 아니요</span></a>
										<input type="hidden" id="e_opinion" name="e_opinion">
									</div>
								</div>
								<div class="review_controls_right">
									<div class="review_submit_ctn"
										style="clear: right; float: right;">
										<a class="btnv6_lightblue_blue btnv6_border_2px btn_medium"
											style="float: right" href="#"
											id="recommendation_submit"><span>평가 게시</span></a>
										 
										 <!-- 
										<button 
											class="btnv6_lightblue_blue btnv6_border_2px btn_medium"
											id="recommendation_submit"		
										type="button"><span>평가 게시</span></button> 
										-->
									</div>
								</div>
								<div style="clear: both"></div>
							</div>
						</div>
						<div style="clear: both"></div>
						<input type="hidden" name="p_idx" value="${evo.p_idx}">
						<input type="hidden" name="g_idx" value="${evo.g_idx}">
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- end 평가 등록 부분 -->

	<!-- Footer -->
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/footer.jsp" />
	<!-- End Footer -->

</body>
</html>