<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd" var="nowDate"/>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Stream :: 할인 관리</title>
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

#supernav_admin_content {
	width: 70px;
}

.dc_detail {
	margin-bottom: 10px;
	margin-top: 5px;
}

</style>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js" />
<!-- 다른 라이브러리와 충돌 방지를 위해 사용 -->
<script type="text/javascript"> /* $J =  */jQuery.noConflict();</script>
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
		
		
		/*할인 수정 모달(다이얼로그 - div) close*/
		$('.newmodal_close').on('click', function(){
			closeDiscount();
			closeDiscountEdit();
		});
		
		$('.discount_cancel_btn').on('click', function(){
			closeDiscount();
			closeDiscountEdit();
		});
		
		
		/*할인 수정하기*/
		$(document).on('click', '.editDiscount', function(){
			var dcId = $(this).parent().find('.dc_id').val();
			var dc_gameName = $(this).parent().parent().find('.gameListRowItemName').text();
			$('#discount_dNum').val(dcId);
			
			$.ajax({	
				url: '/StreamAjax/searchDiscountGameNum',
				type: 'post',
				dataType: 'json',
				data: 'searchDiscountGame=' + dcId,
				success: function(data){
					$('#discount_percent_edit').val(data.percent);
					$('#discount_start_edit').val(data.start_date);
					$('#discount_end_edit').val(data.end_date);
					$('#dc_game_num').val(data.g_idx);
					
					//화면 설정
					$('#DiscountEditModal').css('position', 'fixed');
					$('#DiscountEditModal').css('z-index', '1000');
					$('#DiscountEditModal').css('display', 'block');
					
					$('.newmodal_header > .ellipsis').text(dc_gameName + ' 할인 수정');
					$('.newmodal_background').css('display', 'block');
				},
				error : function(){
					alert('error');
				}
			});
		});
	
	});
	
	
	//할인 수정버튼
	$(document).on('click', '#discount_edit_ok_btn', function(){
		var dcNum = $(this).parent().parent().find('#discount_dNum').val();
		discountEditGo(dcNum);
	});
	
	//할인 삭제버튼
	$(document).on('click', '.delDiscount', function(){
		var dcNum = $(this).parent().find('.dc_id').val();
		var g_Num = $(this).parent().parent().parent().attr('id');
		var dc_gameName = $(this).parent().parent().find('.gameListRowItemName').text();
		if(confirm(dc_gameName + '의 할인을 정말 삭제하시겠습니까?') == true){
			discountDelete(dcNum, g_Num);
		}
	});
	
	function numkeyCheck(e) { 
		var keyValue = event.keyCode; 
		if( ((keyValue >= 48) && (keyValue <= 57)) ) {
			return true; 
		}
		
		else {
			return false; 
		}
	}
	
	
	function discountEditGo(dcNum) {
		$.ajax({
			url: '/StreamAjax/editDiscountGame',
			type: 'post',
			dataType: 'text', //json
			data: $('#discount_edit_form').serialize(),
			success: function(data){
				closeDiscount();
				var editStart = ($('#discount_start_edit').val()).split('-');
				var startDate = editStart[0] + '년' + editStart[1] + '월' + editStart[2] + '일';
				
				var editEnd = ($('#discount_end_edit').val()).split('-');
				var endDate = editEnd[0] + '년' + editEnd[1] + '월' + editEnd[2] + '일';
				
				var dc_id = $('#dc_game_num').val();
				$('#'+ dc_id + ' > .gameListRowItem > h5').text(startDate + '~' + endDate);
				alert('할인 정보가 수정되었습니다.');
			},
			error : function(){
				alert('error');
			}
		});
	}
	
	function discountDelete(dcNum, g_Num) {
		$.ajax({
			url: '/StreamAjax/deleteDiscountGame',
			type: 'post',
			dataType: 'text', //json
			data:  'd_idx=' + dcNum,
			success: function(data){
				var gNum = $('#dc_game_num').val();
				
				closeDiscount();
				$('#' + g_Num).remove();
				alert('할인이 삭제되었습니다.');
			},
			error : function(){
				alert('error');
			}
		});
	}
	
	function closeDiscount(){
		$('.newmodal_background').css('display', 'none'); //속성 추가
		$('#DiscountModal').css('display', 'none'); //할인 등록
		$('#DiscountEditModal').css('display', 'none'); //할인 수정
		
		$('#discount_percent').val('');
		$('#discount_start').val('');
		$('#discount_end').val('');	
	}
	
	function closeDiscountEdit(){
		$('.newmodal_background').css('display', 'none'); //속성 추가
		$('#DiscountEditModal').css('display', 'none'); //할인 수정
		
		$('#discount_percent_edit').val('');
		$('#discount_start_edit').val('');
		$('#discount_end_edit').val('');
		$('#discount_dNum').val('');
	}
	
</script>

</head>
<%-- 
<c:choose>
	<c:when test="${!login_chk}">
		<script>
			alert('로그인을 먼저해주세요.\n로그인 페이지로 이동합니다.');
		</script>
		<body onload="javascript:location.href='login.do'">
			<h2>로그인 페이지로 이동합니다.</h2>
		</body>
	</c:when>
</c:choose>
 --%>
<body class="flat_page migrated_profile_page responsive_page">

	<div class="responsive_page_frame with_header">
		<div class="responsive_page_content">
			<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp" />
		
			<div class="responsive_page_template_content">

				<div class="pagecontent no_header">
					
					<!-- main body -->
					<div id="BG_bottom" class="maincontent" style="margin-top: 30px;">
						<div id="mainContents">
							
							<div class="sectionTabs item responsive_hidden">
								<a href="manageGame.do"
									class="sectionTab"><span>게임 관리</span></a>
									<a href="manageSale.do"
									class="sectionTab active"><span>할인 관리</span></a>
							</div>

							<div id="tabs_baseline" class="responsive_tab_baseline"></div>

							<div style="clear: left"></div>
							<div class="sectionTabsHR ">
								<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/default/trans.gif"/>">
							</div>

							<div id="tabs_basebg" class="games_list">
								<div id="gameslist_controls">
									<div id="gameslist_sort_options" class="sort_options">
										정렬 순서 &nbsp;<span class="selected_sort">이름순</span> &nbsp;
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
											<c:when test="${empty gvoSaleList}">
												<p>할인 등록된 게임이 없습니다.</p>
											</c:when>
											<c:otherwise>
												<!-- 게임 1 -->
												<c:forEach var="k" items="${gvoSaleList}" varStatus="vs">
													<div class="gameListRow" id="${k.g_idx}">
														<div class="gameListRowLogo" style="z-index: 1">
															<a href="gameDetail.do?g_idx=${k.g_idx}">
																<img src="<c:url value="${pageContext.request.contextPath}/resources/public/game/game_image/${k.cover}"/>">
															</a>
														</div>
														<div class="gameListRowItem">
															<div class="gameListRowItemName ellipsis">${k.g_name}</div>
															<h5 class="ellipsis hours_played">${k.start_date} ~ ${k.end_date}</h5>
															<div class="bottom_controls">
																<a class="pullup_item" href="" style="padding: 3px 8px 3px 8px;">
																	추천 등록
																</a>
																<a class="editDiscount pullup_item" style="padding: 3px 8px 3px 8px;">
																	할인 수정
																	<input type="hidden" class="dc_id" value="${k.d_idx}">
																</a>
																<a class="delDiscount pullup_item" style="padding: 3px 8px 3px 8px;">
																	할인 삭제
																	<input type="hidden" class="dc_id" value="${k.d_idx}">
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
	
	
	
	<!-- 할인 모달(등록) -->
	<div class="newmodal" id="DiscountModal" style="display: none; max-width: 1280px; left: 430px; top: 215px;">
		<div class="newmodal_header_border">
			<div class="newmodal_header">
				<div class="newmodal_close"></div>
				<div class="ellipsis">할인 등록</div>
			</div>
		</div>
		<div class="newmodal_content_border">
			<div class="newmodal_content" style="max-height: 475px;">
				<form id="discount_form">
					<div>
						<div id="DcModal" style="display: block;">
							<div class="dc">&nbsp;
								<div class="dc_detail" style="margin-top: -10px;">
									<span>할인율</span>&nbsp;&nbsp;
									<input type="text" size="2" maxlength="3" name="percent" id="discount_percent" onKeyPress="return numkeyCheck(event)">
									<span>%</span>
								</div>
								<div class="dc_detail">
									<span>할인 시작 날짜</span>&nbsp;&nbsp;
									<input type="date" id="discount_start" name="start_date">
								</div>
								<div class="dc_detail">
									<span>할인 마지막 날짜</span>&nbsp;&nbsp;
									<input type="date" id="discount_end" name="end_date">
								</div>
								<div style="text-align: center; margin-top: 25px;">
									<a class="btnv6_blue_hoverfade btn_medium" id="discount_ok_btn">
										<span>할인 등록</span>
									</a>&nbsp;&nbsp;
									<a class="btn_grey_white_innerfade btn_medium discount_cancel_btn">
										<span>취소</span>
									</a>
								</div>
								<input type="hidden" name="g_idx" id="discount_gNum">
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	
	
	
	<!-- 할인 모달(수정) -->
	<div class="newmodal" id="DiscountEditModal" style="display: none; max-width: 1280px; left: 430px; top: 215px;">
		<div class="newmodal_header_border">
			<div class="newmodal_header">
				<div class="newmodal_close"></div>
				<div class="ellipsis">할인 수정</div>
			</div>
		</div>
		<div class="newmodal_content_border">
			<div class="newmodal_content" style="max-height: 475px;">
				<form id="discount_edit_form">
					<div>
						<div id="DcEditModal" style="display: block;">
							<div class="dc">&nbsp;
								<div class="dc_detail" style="margin-top: -10px;">
									<span>할인율</span>&nbsp;&nbsp;
									<input type="text" size="2" maxlength="3" name="percent" id="discount_percent_edit" onKeyPress="return numkeyCheck(event)">
									<span>%</span>
								</div>
								<div class="dc_detail">
									<span>할인 시작 날짜</span>&nbsp;&nbsp;
									<input type="date" id="discount_start_edit" name="start_date">
								</div>
								<div class="dc_detail">
									<span>할인 마지막 날짜</span>&nbsp;&nbsp;
									<input type="date" id="discount_end_edit" name="end_date">
								</div>
								<div style="text-align: center; margin-top: 25px;">
									<a class="btnv6_blue_hoverfade btn_medium" id="discount_edit_ok_btn">
										<span>할인 수정</span>
									</a>&nbsp;&nbsp;
									
									<a class="btn_grey_white_innerfade btn_medium discount_cancel_btn">
										<span>취소</span>
									</a>
								</div>
								<input type="hidden" name="d_idx" id="discount_dNum">
								<input type="hidden" name="g_idx" id="dc_game_num">
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<!-- 태그 추천 창 띄우기 위해 배경 검게 display에 따라 보이고 안보이고.. -->
	<div class="newmodal_background" style="opacity: 0.8; display: none;"></div>
</body>
</html>
