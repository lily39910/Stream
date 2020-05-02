<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Stream 게임 수정</title>
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
<link href="${pageContext.request.contextPath}/resources/css/store_game_shared.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/apphub.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/shared_responsive.css" rel="stylesheet" type="text/css">

<link href="${pageContext.request.contextPath}/resources/css/groupadmin.css" rel="stylesheet" type="text/css">
<%-- 
<link
	href="${pageContext.request.contextPath}/resources/css/globalv2.css"
	rel="stylesheet" type="text/css">
 --%>
 
 <link href="${pageContext.request.contextPath}/resources/css/stream_admin.css" rel="stylesheet" type="text/css">


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js" />
<!-- 다른 라이브러리와 충돌 방지를 위해 사용 -->
<script type="text/javascript">
	/* $J =  */jQuery.noConflict();
</script>


<script>
	$(document).ready(function() {
		/*태그 추가 모달(다이얼로그 - div) close */
		$('.newmodal_close').on('click', function() {
			$('.app_tag_modal_frame').css('position', '');
			$('.app_tag_modal_frame').css('z-index', '');
			$('.app_tag_modal_frame').css('display', 'none');

			$('.newmodal_background').css('display', 'none'); //태그 추가
		});

		/*태그 추가 모달(다이얼로그 - div) close */
		$('.btn_grey_white_innerfade > span').on('click', function() {
			$('.app_tag_modal_frame').css('position', '');
			$('.app_tag_modal_frame').css('z-index', '');
			$('.app_tag_modal_frame').css('display', 'none');

			$('.newmodal_background').css('display', 'none');
		});

		/*태그 추가 모달(다이얼로그 - div) open */
		$('.add_button').on('click', function() {
			$('.app_tag_modal_frame').css('position', 'fixed');
			$('.app_tag_modal_frame').css('z-index', '1000');
			$('.app_tag_modal_frame').css('display', 'block');

			$('.newmodal_background').css('display', 'block');
		});

		/*시스템 요구 사항 */
		$('#osInfoSmall').on('click', function() {
			$('#systemRequire').addClass('expanded');
			$('#systemRequire > .sys_req').css('max-height', 'none');
			$('#osInfoSmall').parent().css('display', 'none');

		});

		/*시스템 탭 */
		$('.sysreq_tab').on('click', function() {
			$('.sysreq_tab').removeClass('active');
			//탭 변경
			$(this).addClass('active');
			var os = $(this).attr('data-os'); //운영체제

			//밑에 보여지는 설명 div 변경
			$('.sysreq_content').removeClass('active');
			if (os === 'win') {
				$('.sysreq_content[data-os="win"]').addClass('active');
			} else if (os === 'mac') {
				$('.sysreq_content[data-os="mac"]').addClass('active');
			} else if (os === 'linux') {
				$('.sysreq_content[data-os="linux"]').addClass('active');
			}
		});

		
		/*div 제거 버튼 - 동적으로 생성된 경우 이벤트 주려면 앞에 (document) 필요 */
		$(document).on('click', '.btn', function(){
			if($(this).hasClass('remove_genre') === true){
				//장르 제거
				var del_genre_num = $(this).parent().find('[type=hidden]').val(); 
				var remove_genre = '<input type=\"hidden\" name=\"del_gn_idx\" value=\"' + del_genre_num + '\">'; 
				$('#del_Genre').append(remove_genre);
			}else if($(this).hasClass('remove_developer') === true){
				//개발자 제거
				var del_developer_num = $(this).parent().find('[type=hidden]').val(); 
				var remove_developer = '<input type=\"hidden\" name=\"del_dvl_idx\" value=\"' + del_developer_num + '\">'; 
				$('#del_Developer').append(remove_developer);
			}else if($(this).hasClass('remove_publisher') === true){
				//배급사 제거
				var del_publisher_num = $(this).parent().find('[type=hidden]').val(); 
				var remove_publisher = '<input type=\"hidden\" name=\"del_pc_idx\" value=\"' + del_publisher_num + '\">'; 
				$('#del_Publisher').append(remove_publisher);
			}else {
			}
			$(this).parent().remove();
		});
		
		/*개발자 추가 */
		$('#developerbtn').on('click', function(){
			if($('#developer').val() !== ''){
				addDeveloperDiv();				
			}
			
		});
		
		function addDeveloperDiv(){
			var developerName = $('#developer').val();
			var add = '<div class=\"searchtag\" data-developer_param=\"developers\">' +
					'<span class=\"label\">'+ developerName + 
					'</span> <a class=\"btn\"></a>' +
					'<input type=\"hidden\" name=\"d_name\" value=\"' + developerName + '\">' + 
					'</div>';
			$('#addedDeveloper').append(add);
			$('#developer').val('');
		}
		/* end 개발자 추가 */
		
		
		
		/*배급사 추가 */
		$('#publisherbtn').on('click', function(){
			if($('#publisher').val() !== ''){
				addPublisherDiv();				
			}
		});
		
		function addPublisherDiv(){
			var publisherName = $('#publisher').val();
			var add = '<div class=\"searchtag\" data-publisher_param=\"publishers\" data-publisher_value=\"pc_idx\">' +
					'<span class=\"label\">'+ publisherName + 
					'</span> <a class=\"btn\"></a>' + 
					'<input type=\"hidden\" name=\"p_name\" value=\"' + publisherName + '\">' + 
					'</div>';
			$('#addedPublisher').append(add);
			$('#publisher').val('');
		}
		/* end 배급사 추가 */
		
		
		/* 존재하는 태그 검색 */
		$('#tagsearch').keyup(function(){
			if($('#tagsearch').val() === ''){
				$(".search_tags").empty();
			}
			else {
				//장르 검색
				$(".search_tags").empty(); //div 제거
				$('.search_tags_wrapper').css('display','block');
				
				$.ajax({
					url: '/StreamAjax/SearchTag',
					type: 'get',
					dataType: 'json',
					data: 'searchTag=' + $('#tagsearch').val(),
					success: function(data){
						var tag = '';
						$.each(data, function(index, data) {
							if(index < 3){
								tag += '<a class="searched_tag" tagid="' + this['tag_idx'] + '" data-tag-options="0">';
								tag += '<div class="searched_tag_name">' + this['tag_name'] + '</div></a>';
							}
						});
						$('.search_tags').append(tag);//html은 기본으로 초기화 됨/append는 기존 데이터에 추가로...
					},
					error: function(){
						//alert('error');
					}
				});
			}
		});
		/* end 존재하는 태그 검색 */
		
		
		
		/* 검색된 태그 선택 시 */
		$(document).on('click', '.searched_tag', function(){
			var genreName = $(this).children('div').html();
			var genreNum = $(this).attr('tagid');
			
			var add = '<div class=\"searchtag\" data-tag_param=\"tags\" data-tag_value=\" " + genreNum + "\">' +
					'<span class=\"label\">'+ genreName +  '</span> <a class=\"btn\"></a>' +
					'<input type=\"hidden\" name=\"tag_idx\" value=\"' + genreNum + '\">' +
					'</div>';
			$('#addedGenre').append(add);
			$('#tagsearch').val('');
			$('.search_tags_wrapper').css('display','none');
		});
		
		
		$('#editGameBtn').on('click', function(){
			var screenshot_count = $('.game_screenshot_div > [type=file]').size();
			
			var go = 0;
			for(var i=0; i < screenshot_count; i++){
				if($('.game_screenshot_div > [type=file]').eq(i).val() == ''){
					go++;
				}
			}
			
			if($('#game_file_div > [type=file]').val() == '' && $('#game_file_origin').length == 0){
				alert('게임 파일을 등록해주세요.');
			}
			else{
				if (screenshot_count == 0 || go == 0) {
					$('#editGame').attr('action', 'editGame_ok.do').submit();
					alert('게임 수정이 완료되었습니다.');
				} else {
					alert('게임 스크린샷 공백을 채우거나 제거해주세요.');
	            }
			}
		});	
		
		//파일 제거 후 새로 등록
		$(document).on('click', '.saved_game_file_div_btn', function(){
			$(this).parent().parent().find('div').eq(0).css('display', 'block');
			$(this).parent().remove();
		});
		
		
		//스크린샷 이미지 제거
		$(document).on('click', '.game_screenshot_div_btn', function(){
			$(this).parent().parent().remove();
		});
		
		//저장되어 있는 스크린샷 이미지 제거
		$(document).on('click', '.saved_game_screenshot_div_btn', function(){
			var del_screenshot_num = $(this).parent().find('[type=hidden]').val();
			
			var remove_screenshot = '<input type=\"hidden\" name=\"del_v_idx\" value=\"' + del_screenshot_num + '\">'
			$('#del_screenshots').append(remove_screenshot);
			$(this).parent().remove();
			
		});
		
		//스크린샷 이미지 추가
		$('#screenshotAddbtn').on('click', function(){
			var addScreenshot = '';
			
			addScreenshot += '<div class=\"formRowFields\">';
			addScreenshot += '<div class=\"gray_bevel_textarea game_screenshot_div\">';
			addScreenshot += '<input type=\"file\" name=\"view_context\">';
			addScreenshot += '<button class=\"game_screenshot_div_btn\" type=\"button\">';
			addScreenshot += '<span>x</span></button></div></div>';
			
			$('#screenshots').append(addScreenshot);
		});
	});
	
	
	
	//fakefile 해결(게임 설명 요약)
	function readDetailImgURL(input) {
		if (input.files && input.files[0]) { 
 			var reader = new FileReader();
			reader.onload = function (e) { 
				$('#detail_img_preview').attr('src', e.target.result); 
			} 
			reader.readAsDataURL(input.files[0]);
			$('#detail_img_origin').val('');
		}
 	}
	
	//fakefile 해결(대표 이미지)
	function readCoverImgURL(input) {
		if (input.files && input.files[0]) { 
 			var reader = new FileReader();
			reader.onload = function (e) { 
				$('#cover_img_preview').attr('src', e.target.result); 
			} 
			reader.readAsDataURL(input.files[0]);
			$('#cover_origin').val('');
		}
	}
	
	
	function checkLetter(){
		var objEv = event.srcElement;
		var num ="{}[]<>?|~`!@#$%^&*,-+\"'\\";    //입력을 막을 특수문자 기재.
		event.returnValue = true;
	  
		for (var i=0;i<objEv.value.length;i++) {
			if(-1 != num.indexOf(objEv.value.charAt(i)))
			event.returnValue = false;
		}
		  
		if (!event.returnValue) {
			 alert("특수문자는 입력하실 수 없습니다.");
			 objEv.value="";
		}
	} 
	
</script>


</head>
<html>
<body class="v6 app game_bg responsive_page">


	<div class="responsive_page_frame with_header">

		<div class="responsive_page_content">
			<jsp:include
				page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp" />

			<div id="responsive_store_nav_ctn"></div>
			<div class="responsive_page_template_content">

				<!-- contentTopMenu -->
				<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/contentTopMenu.jsp" />

				

				<form id="editGame" method="post" enctype="multipart/form-data">
				<div class="page_content">
					<div style="margin-bottom: 20px; margin-top: 40px;">
						<div class="apphub_AppName">게임 - ${gvo.g_name} 수정</div>
					</div>
					
					<input type="hidden" name="g_idx" value="${gvo.g_idx}">
					
					<div class="group_content group_summary addForm" style="background-color: #12374e">
						<div class="formRow">
							<div class="formRowTitle">게임 이름</div>
							<div class="formRowFields">
								<div class="gray_bevel for_text_input">
									<input id="gamename" class="dynInput" type="text" name="g_name" autocomplete="no" size="40" value="${gvo.g_name}" readonly="readonly">
								</div>
							</div>
						</div>
						
						
						<div class="rule"></div>
						
						<!-- 대표 이미지 등록 -->
						<div class="formRow">
							<div class="formRowTitle">대표 이미지</div>
							<div class="formRowFields">
								<div class="avatar_upload_ctn">
									<div class="gray_bevel">
										<div class="upload_controls">
											<div class="avatar_upload_input_ctn">
												<input type="file" id="cover_img" name="cover" size="16" onchange="readCoverImgURL(this);">
												<input type="hidden" value="${gvo.cover}" name="cover_origin" id="cover_origin">
											</div>
										</div>
										<div class="avatar_upload_throbber">
											<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/login/throbber.gif"/>">
										</div>
									</div>
								</div>
								
								<div class="avatar_upload_ctn">
									<div>
										<div class="upload_controls">
											<div class="avatar_edit_block full">
												<img src="<c:url value="${pageContext.request.contextPath}/resources/public/game/game_image/${gvo.cover}"/>" id="cover_img_preview">
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- end 대표 이미지 등록 -->
						
						<div class="rule"></div>
						
						<div class="formRow">
							<div class="formRowTitle">게임 발매일</div>
							<div class="formRowFields">
								<div class="gray_bevel for_text_input">
									<input type="date" name="release_date" value="${gvo.release_date}">
								</div>
							</div>
						</div>
						
						<div class="rule"></div>
						
						<!-- 장르 추가 -->
						<div class="formRow">
							<div class="formRowTitle">장르</div>
							<div class="formRowFields">
								<div class="gray_bevel for_text_input">
									<input class="dynInput" id="tagsearch" type="text" autocomplete="no" onKeyUp="checkLetter();">
									
									<div class="search_tags_wrapper">
										<div class="popup_search_tags" style="border-top: none;">
											<div class="search_tags">
												<!-- 태그 검색된 결과 -->
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="formRowFields addedContent" id="addedGenre">
								<!-- 추가된 장르 표시 -->
								<c:forEach var="k" items="${gnrvo}">
									<div class="searchtag" data-tag_param="tags" data-tag_value="${k.gn_idx}">
										<span class="label">${k.tag_name}</span>
										<input type="hidden" name="saved_gn_idx" value="${k.gn_idx}">
										<a class="btn remove_genre"></a>
									</div>
								</c:forEach>
								<!-- end 추가된 장르 표시 -->
							</div>
							
							<div id="del_Genre">
								
							</div>
						</div>
						<!-- end 장르 추가 -->
						
						<div class="rule"></div>
						
						<!-- 개발자 등록 -->
						<div class="formRow">
							<div class="formRowTitle">개발자</div>
							<div class="formRowFields">
								<div class="gray_bevel for_text_input">
									<input class="dynInput" type="text" autocomplete="no" id="developer" onKeyUp="checkLetter();">
									<button class="game_add_div_btn" type="button" id="developerbtn">
										<span>추가</span>
									</button>
								</div>
							</div>
							
							<div class="formRowFields addedContent" id="addedDeveloper">
								<c:forEach var="k" items="${dvo}">
									<div class="searchtag" data-developer_param="developers" data-developer_value="${k.dvl_idx}">
										<span class="label">${k.d_name}</span>
										<input type="hidden" name="saved_dvl_idx" value="${k.dvl_idx}">
										<a class="btn remove_developer"></a>
									</div>	
								</c:forEach>
							</div>
							<div id="del_Developer"></div>
						</div>
						<!-- end 개발자 등록 -->
						
						<div class="rule"></div>
						
						<!-- 배급사 등록 -->
						<div class="formRow">
							<div class="formRowTitle">배급사</div>
							<div class="formRowFields">
								<div class="gray_bevel for_text_input">
									<input class="dynInput" type="text" autocomplete="no" id="publisher" onKeyUp="checkLetter();">
									<button class="game_add_div_btn" type="button" id="publisherbtn">
										<span>추가</span>
									</button>
								</div>
							</div>
							
							<div class="formRowFields addedContent" id="addedPublisher">
								<c:forEach var="k" items="${pvo}">
									<div class="searchtag" data-publisher_param="publishers" data-publisher_value="${k.pc_idx}">
										<span class="label">${k.p_name}</span>
										<input type="hidden" name="saved_pc_idx" value="${k.pc_idx}">
										<a class="btn remove_publisher"></a>
									</div>
								</c:forEach>
							</div>
							<div id="del_Publisher"></div>
						</div>
						<!-- end 배급사 등록 -->
						
						<div class="rule"></div>
						
						<div class="formRow">
							<div class="formRowTitle">게임 연령 등급</div>
							<div class="formRowFields">
								<div class="gray_bevel for_text_input">
									<select name="age">
										<c:if test="${gvo.age eq 'all'}">
											<option value="all" selected="selected">All</option>
											<option value="12">12</option>
											<option value="15">15</option>
											<option value="18">18</option>
										</c:if>
										
										<c:if test="${gvo.age eq '12'}">
											<option value="all">All</option>
											<option value="12" selected="selected">12</option>
											<option value="15">15</option>
											<option value="18">18</option>
										</c:if>
											
										<c:if test="${gvo.age eq '15'}">
											<option value="all">All</option>
											<option value="12">12</option>
											<option value="15" selected="selected">15</option>
											<option value="18">18</option>
										</c:if>
											
										<c:if test="${gvo.age eq '18'}">
											<option value="all">All</option>
											<option value="12">12</option>
											<option value="15">15</option>
											<option value="18" selected="selected">18</option>
										</c:if>
									</select>
								</div>
							</div>
						</div>
						
						<div class="rule"></div>
						
						
						<div class="formRow">
							<div class="formRowTitle">게임 가격</div>
							<div class="formRowFields">
								<div class="gray_bevel for_text_input">
									<input type="text" name="price" value="${gvo.price}"><span>원</span>
								</div>
							</div>
						</div>
						
						<div class="rule"></div>
						
						<div class="formRow">
							<div class="formRowTitle">게임 설명 요약</div>
							<div class="formRowFields">
								<!-- 게임 설명 이미지 -->
								<div class="avatar_upload_ctn">
									<div>
										<div class="upload_controls">
											<div class="avatar_edit_block full">
												<!-- 상세 이미지 미리 보기 -->
												<img id="detail_img_preview" src="<c:url value="${pageContext.request.contextPath}/resources/public/game/game_image/${gvo.detail_img}"/>">
											</div>
										</div>
										<div class="avatar_upload_throbber">
											<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/login/throbber.gif"/>">
										</div>
									</div>
								</div>
								
								<div class="avatar_upload_ctn">
									<div class="gray_bevel">
										<div class="upload_controls">
											<div class="avatar_upload_input_ctn">
												<input type="file" id="detail_img" name="detail_img" size="16" onchange="readDetailImgURL(this);">
												<input type="hidden" id="detail_img_origin" name="detail_img_origin" value="${gvo.detail_img}">
											</div>
										</div>
										<div class="avatar_upload_throbber">
											<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/login/throbber.gif"/>">
										</div>
									</div>
								</div>
								<!-- end 게임 설명 이미지 -->
							</div>
							
							<div class="formRowFields">
								<div class="gray_bevel_textarea">
									<textarea rows="3" cols="100" name="content_summary">${gvo.content_summary}</textarea>
								</div>
							</div>
						</div>
						
						
						<div class="rule"></div>
						
						<div class="formRow">
							<div class="formRowTitle">게임 스크린샷</div>
							<div class="formRowFields">
								<button class="game_add_div_btn" type="button" id="screenshotAddbtn" style="padding: 3px 1px 3px 1px;">
										<span>+</span>
								</button>
							</div>
							
							<div id="screenshots">
								<c:forEach var="k" items="${vvo}">
									<div class="saved_game_screenshot_div gray_bevel for_text_input">							
										<input type="text" style="width: 500px;" readonly="readonly" value="${k.view_context}">
										<input type="hidden" name="saved_screenshot" value="${k.v_idx}">
										<button class="saved_game_screenshot_div_btn" type="button"><span>x</span></button>
									</div>
								</c:forEach>
							</div>
							<div id="del_screenshots">
								
							</div>
						</div>
						
						
						<div class="rule"></div>
						
						<div class="formRow">
							<div class="formRowTitle">게임 상세 설명</div>
							<div class="formRowFields">
								<!-- <div class="gray_bevel_textarea"> -->
								<div class="gray_bevel_textarea">
									<textarea rows="10" cols="100" name="content">${gvo.content}</textarea>
								</div>
							</div>
						</div>
						
						
						<div class="rule"></div>
						
						<div class="formRow">
							<div class="formRowTitle">게임 파일</div>
							<div class="formRowFields">
								<div class="gray_bevel_textarea" style="display: none;" id="game_file_div">
									<input type="file" name="game_file">
								</div>
								

								 <div class="gray_bevel gray_bevel_textarea">							
									<input class="dynInput" id="game_file_origin" name="game_file_origin" type="text" style="width: 693px;" readonly="readonly" value="${gvo.game_file}">
									<button class="saved_game_file_div_btn" type="button" style="margin-left:0px;"><span>x</span></button>
								</div>
								 
							</div>
						</div>
						
						<div class="formRow">
							<div class="formRowTitle">체험판 게임 파일</div>
							<div class="formRowFields">
								<c:choose>
									<c:when test="${empty gvo.game_exp_file}">
										<div class="gray_bevel_textarea">
											<input type="file" name="game_exp_file">
										</div>
									</c:when>
									<c:otherwise>
										<div class="gray_bevel_textarea" style="display: none;">
											<input type="file" name="game_exp_file">
										</div>
										<div class="gray_bevel gray_bevel_textarea">							
											<input class="dynInput" name="game_exp_file_origin" type="text" style="width: 693px;" readonly="readonly" value="${gvo.game_exp_file}">
											<button class="saved_game_file_div_btn" type="button" style="margin-left:0px;"><span>x</span></button>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						
						
						<div style="margin-left: 20px; margin-right: 20px;">
							<div class="game_page_autocollapse_ctn" id="systemRequire">
								<div class="game_page_autocollapse sys_req">
									<h2>시스템 요구 사항</h2>
									<div class="sysreq_tabs">
										<div class="sysreq_tab active" data-os="win" id="os_win">Windows</div>
										<div class="sysreq_tab " data-os="mac" id="os_mac">Mac OS X</div>
										<div class="sysreq_tab " data-os="linux" id="os_linux">SteamOS + Linux</div>
										<div style="clear: left;"></div>
									</div>
									<div class="sysreq_contents">
										<div class="game_area_sys_req sysreq_content active" data-os="win">
											<div class="game_area_sys_req_leftCol" style="width: 430px;">
												<ul>
													<strong>최소:</strong>
													<input type="hidden" name="pc_level" value="least">
													<input type="hidden" name="os_group" value="win">
													<br>
													<ul class="bb_ul">
														
														<div class="systemFormRow">
															<div class="systemFormRowTitle"><li>운영체제:&nbsp;</li></div>
															<div class="systemFormRowFields">
																<div class="gray_bevel for_text_input">
																	<input type="text" size="46" name="os_type">
																</div>
															</div>
														</div>
														
														<div class="systemFormRow">
															<div class="systemFormRowTitle"><li>프로세서:&nbsp;</li></div>
															<div class="systemFormRowFields">
																<div class="gray_bevel for_text_input">
																	<input type="text" size="46" name="processor">
																</div>
															</div>
														</div>
														
														<div class="systemFormRow">
															<div class="systemFormRowTitle"><li>메모리:&nbsp;</li></div>
															<div class="systemFormRowFields">
																<div class="gray_bevel for_text_input">
																	<input type="text" size="3" name="memory"><span>GB RAM</span>
																</div>
															</div>
														</div>
														
														<div class="systemFormRow">
															<div class="systemFormRowTitle"><li>그래픽:&nbsp;</li></div>
															<div class="systemFormRowFields">
																<div class="gray_bevel for_text_input">
																	<input type="text" size="30" name="graphic">
																</div>
															</div>
														</div>
														
														<div class="systemFormRow">
															<div class="systemFormRowTitle"><li>DirectX:&nbsp;</li></div>
															<div class="systemFormRowFields">
																<div class="gray_bevel for_text_input">
																	<input type="text" size="10" name="directx">
																</div>
															</div>
														</div>
														
														<div class="systemFormRow">
															<div class="systemFormRowTitle"><li>저장공간:&nbsp;</li></div>
															<div class="systemFormRowFields">
																<div class="gray_bevel for_text_input">
																	<input type="text" size="3" name="storage_space"><span>GB 사용 가능 공간</span>
																</div>
															</div>
														</div>
														
														<div class="systemFormRow">
															<div class="systemFormRowTitle"><li>사운드카드:&nbsp;</li></div>
															<div class="systemFormRowFields">
																<div class="gray_bevel for_text_input">
																	<input type="text" size="30" name="sound_card">
																</div>
															</div>
														</div>
														
														<div class="systemFormRow">
															<div class="systemFormRowTitle"><li>네트워크:&nbsp;</li></div>
															<div class="systemFormRowFields">
																<div class="gray_bevel for_text_input">
																	<input type="text" size="18" name="network">
																</div>
															</div>
														</div>
														
														<div class="systemFormRow">
															<div class="systemFormRowTitle"><li>추가 사항:&nbsp;</li></div>
															<div class="systemFormRowFields">
																<div class="gray_bevel_textarea" style="margin-right: 10px;">
																	<textarea rows="7" cols="44" name="note"></textarea>
																</div>
															</div>
														</div>
													</ul>
												</ul>
											</div>
											<div class="sys_req_divide"></div>
											<div class="game_area_sys_req_rightCol">
												<ul>
													<strong>권장:</strong>
													<input type="hidden" name="pc_level" value="recommend">
													<input type="hidden" name="os_group" value="win">
													<br>
													<ul class="bb_ul">
														
														<div class="systemFormRow">
															<div class="systemFormRowTitle"><li>운영체제:&nbsp;</li></div>
															<div class="systemFormRowFields">
																<div class="gray_bevel for_text_input">
																	<input type="text" size="46" name="os_type">
																</div>
															</div>
														</div>
														
														<div class="systemFormRow">
															<div class="systemFormRowTitle"><li>프로세서:&nbsp;</li></div>
															<div class="systemFormRowFields">
																<div class="gray_bevel for_text_input">
																	<input type="text" size="46" name="processor">
																</div>
															</div>
														</div>
														
														<div class="systemFormRow">
															<div class="systemFormRowTitle"><li>메모리:&nbsp;</li></div>
															<div class="systemFormRowFields">
																<div class="gray_bevel for_text_input">
																	<input type="text" size="3" name="memory"><span>GB RAM</span>
																</div>
															</div>
														</div>
														
														<div class="systemFormRow">
															<div class="systemFormRowTitle"><li>그래픽:&nbsp;</li></div>
															<div class="systemFormRowFields">
																<div class="gray_bevel for_text_input">
																	<input type="text" size="30" name="graphic">
																</div>
															</div>
														</div>
														
														<div class="systemFormRow">
															<div class="systemFormRowTitle"><li>DirectX:&nbsp;</li></div>
															<div class="systemFormRowFields">
																<div class="gray_bevel for_text_input">
																	<input type="text" size="10" name="directx">
																</div>
															</div>
														</div>
														
														<div class="systemFormRow">
															<div class="systemFormRowTitle"><li>저장공간:&nbsp;</li></div>
															<div class="systemFormRowFields">
																<div class="gray_bevel for_text_input">
																	<input type="text" size="3" name="storage_space"><span>GB 사용 가능 공간</span>
																</div>
															</div>
														</div>
														
														<div class="systemFormRow">
															<div class="systemFormRowTitle"><li>사운드카드:&nbsp;</li></div>
															<div class="systemFormRowFields">
																<div class="gray_bevel for_text_input">
																	<input type="text" size="30" name="sound_card">
																</div>
															</div>
														</div>
														
														<div class="systemFormRow">
															<div class="systemFormRowTitle"><li>네트워크:&nbsp;</li></div>
															<div class="systemFormRowFields">
																<div class="gray_bevel for_text_input">
																	<input type="text" size="18" name="network">
																</div>
															</div>
														</div>
														
														<div class="systemFormRow">
															<div class="systemFormRowTitle"><li>추가 사항:&nbsp;</li></div>
															<div class="systemFormRowFields">
																<div class="gray_bevel_textarea" style="width: 326px;">
																	<textarea rows="7" cols="44" name="note"></textarea>
																</div>
															</div>
														</div>
													</ul>
												</ul>
											</div>
											<div style="clear: both;"></div>
										</div>
										<div class="game_area_sys_req sysreq_content " data-os="mac">
											<div class="game_area_sys_req_leftCol">
												<ul>
													<strong>최소:</strong>
													<br>
													<ul class="bb_ul">
														<li>64비트 프로세서와 운영 체제가 필요합니다<br></li>
														<li><strong>운영체제:</strong> 10.11 (El Capitan) or 10.12
															(Sierra)<br></li>
														<li><strong>프로세서:</strong> Intel Core i5 2.7Ghz<br></li>
														<li><strong>메모리:</strong> 6 GB RAM<br></li>
														<li><strong>그래픽:</strong> 1 GB GPU Minimum - GeForce
															775M | Radeon HD 6970 | Intel Iris Pro<br></li>
														<li><strong>저장공간:</strong> 15 GB 사용 가능 공간<br></li>
														<li><strong>추가 사항:</strong> <strong>NOTICE:</strong> It
															is possible for Mac and PC to become out of sync (which is
															currently the case) during updates or patches. Within this
															short time period, Mac users will only be able to play
															other Mac users.</li>
													</ul>
												</ul>
											</div>
											<div class="game_area_sys_req_rightCol">
												<ul>
													<strong>권장:</strong>
													<br>
													<ul class="bb_ul">
														<li>64비트 프로세서와 운영 체제가 필요합니다</li>
													</ul>
												</ul>
											</div>
											<div style="clear: both;"></div>
										</div>
										<div class="game_area_sys_req sysreq_content " data-os="linux">
											<div class="game_area_sys_req_leftCol">
												<ul>
													<strong>최소:</strong>
													<br>
													<ul class="bb_ul">
														<li>64비트 프로세서와 운영 체제가 필요합니다<br></li>
														<li><strong>운영체제:</strong> SteamOS, Ubuntu 16.04
															(64bit)<br></li>
														<li><strong>프로세서:</strong> Intel Core i3 530 or AMD
															A8-3870<br></li>
														<li><strong>메모리:</strong> 6 GB RAM<br></li>
														<li><strong>그래픽:</strong> 1 GB VRAM Minimum - NVIDIA
															GeForce 650<br></li>
														<li><strong>저장공간:</strong> 15 GB 사용 가능 공간<br></li>
														<li><strong>추가 사항:</strong> IMPORTANT NOTICE: ATI and
															INTEL chipsets are NOT supported to run Civilization VI
															LINUX. <strong> Don't meet the above requirements?
																Running on a unique distro? That doesn't mean your
																configuration wont run Civ VI! Visit the Civilization VI
																community page to share your experience with other Linux
																players and learn about how to send bugs to Aspyr. Your
																feedback will help us improve Civ VI Linux and future AAA
																Linux releases!</strong>
														</li>
													</ul>
												</ul>
											</div>
											<div class="game_area_sys_req_rightCol">
												<ul>
													<strong>권장:</strong>
													<br>
													<ul class="bb_ul">
														<li>64비트 프로세서와 운영 체제가 필요합니다</li>
													</ul>
												</ul>
											</div>
											<div style="clear: both;"></div>
										</div>
									</div>
								</div>
									<!-- 
									<div class="game_page_autocollapse_fade">
										<div class="game_page_autocollapse_readmore" id="osInfoSmall">더
											읽어보기</div>
									</div> -->
							</div>
						</div>
						
						<div class="btnDiv">
							<!-- 게임 등록 버튼 -->
							<a href="main.do" class="btn_grey_white_innerfade btn_medium">
								<span>취소</span>
							</a>
							<button id="editGameBtn" type="button" class="btn_green_white_innerfade btn_medium">
								<span>게임 수정</span>
							</button>
						</div>
					</div>
					
					
					
					<br>
					
				</div>
				
				
				</form>
				
									
			</div>
		</div>
	</div>


	<!-- footer -->
	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/common/footer.jsp" />
	<!-- end footer -->

	<!-- 태그 모달 -->
	<div class="newmodal app_tag_modal_frame"
		style="display: none; max-width: 1280px; left: 377px; top: 21px;">
		<div class="newmodal_header_border">
			<div class="newmodal_header">
				<div class="newmodal_close"></div>
				<div class="ellipsis">이 제품의 태그 보기 및 수정</div>
			</div>
		</div>
		<div class="newmodal_content_border">
			<div class="newmodal_content" style="max-height: 475px;">
				<div>
					<div id="app_tagging_modal" class="app_tag_modal nologin"
						style="display: block;">
						<div class="app_tag_modal_content">
							<div class="app_tag_modal_seperator"></div>
							<div class="app_tag_modal_left">
								<h2>
									이 제품의 인기 태그: <span class="app_tag_modal_tooltip"
										data-store-tooltip="이 태그들은 이 제품에 가장 많은 사용자들이 붙인 태그입니다. 태그를 클릭하시면 그 태그가 붙은 다른 제품을 찾아보실 수 있습니다. 또는, 제품에 이미 붙어있는 태그에 + 를 눌러 해당 태그의 인기도를 증가시킬 수 있습니다.">(?)</span>
								</h2>

								<!-- 이 게임에 달린 태그들 -->
								<div class="app_tags popular_tags">
									<div class="app_tag_control popular" data-tagid="태그 번호">
										<div data-store-tooltip class="app_tag_checkbox"></div>
										<a class="app_tag" href="태그 검색">태그 이름</a>
									</div>
								</div>
							</div>
							<div class="app_tag_modal_right">
								<h2>로그인</h2>
								<p>이 제품에 자신만의 태그를 붙이려면 로그인 하세요.</p>
								<p>
									<a class="btnv6_blue_hoverfade btn_medium" href="login.do">
										<span>로그인</span>
									</a>
								</p>
							</div>

							<div style="clear: both;"></div>
						</div>
					</div>
				</div>
				<div class="newmodal_buttons">
					<div class="btn_grey_white_innerfade btn_medium">
						<span>닫기</span>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- 태그 추천 창 띄우기 위해 배경 검게 display에 따라 보이고 안보이고.. -->
	<div class="newmodal_background" style="opacity: 0.8; display: none;"></div>
</body>
</html>