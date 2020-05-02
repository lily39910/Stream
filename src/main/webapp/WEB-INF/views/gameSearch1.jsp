<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Stream 검색(인기 상품, 발매예정, 특별할인, 태그, 검색)</title>
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
<link href="${pageContext.request.contextPath}/resources/css/store.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/browse.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/search.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/shared_responsive.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js" />
<!-- 다른 라이브러리와 충돌 방지를 위해 사용 -->
<script type="text/javascript">/* $J =  */jQuery.noConflict();</script>
<script>
	$(document).ready(function(){
		//대소문자 구분 x
		$.extend($.expr[":"], {
			"containsIN": function(elem, i, match, array) {
			return (elem.textContent || elem.innerText || "").toLowerCase().indexOf((match[3] || "").toLowerCase()) >= 0;
		}});
		
		function createSearchBtn(filterType, filterNum, filterName) {
			var createSearch = '<div class=\"searchtag tag_dynamic\" id=\"searchtag_tmpl\" ';
			createSearch += 'style=\"display: inline-block;\" data-tag_param=\"' + filterType + '\" data-tag_value=\"' + filterNum + '\">';
			createSearch += '<span class=\"label\">' + filterName + '</span> <a class=\"btn\"></a></div>';
			$('.termcontainer').append(createSearch);
			createSearch = '';
		}
		
		
		//url(term)에 검색한 값이 있을 경우
		if('${term}' != ''){
			$('#term').val('${term}');
		}
		
		
		/*
		//태그로 좁히기(체크박스)
		$('#TagFilter_Container > .tab_filter_control').on('click', function(){
			if($(this).hasClass('checked')){
				$(this).removeClass('checked');
				//$( 'div[data-tag_value="' + tagValue + '"]' ).remove();
			}else {
				$(this).addClass('checked');
				
				var createSearch = '<div class=\"searchtag tag_dynamic\" id=\"searchtag_tmpl\" ';
				createSearch += 'style=\"display: inline-block;\" data-tag_param=\"tags\" data-tag_value=\"' + filterNum + '\">';
				createSearch += '<span class=\"label\">' + filterName + '</span> <a href=\"#\" class=\"btn\"></a></div>';
				$('.termcontainer').append(createSearch);
				createSearch = '';
				
			}
		});

		//선택한 형식 보기 ~ OS로 좁히기(체크박스)
		$('.block_content_inner > .tab_filter_control').on('click', function(){
			if($(this).hasClass('checked')){
				var tagValue = $(this).attr('data-value');
				
				$( 'div[data-tag_value="' + tagValue + '"]' ).remove();
				$(this).removeClass('checked');
			
			}else {
				$(this).addClass('checked');
				createSearchBtn($(this).attr('data-param'), $(this).attr('data-value'),$(this).attr('data-loc'));
			}
		});
		*/
		
		/* 
		//이동 시 페이지 값 가져오기
		function SearchPage(pageNum){
			alert('page');
			$('#page').val(pageNum);
		}
		 */
		
		$('.search_pagination_right > a').on('click', function(){
			var addr = window.location.href; //주소
			var findStr1 = '&page=';
			var findStr2 = '?page=';
			var pageNum = $(this).text(); //이동할 페이지
			
			$('#page').val(pageNum);
			
			searchGo();
			/* 
			 alert(pageNum);
			if (addr.lastIndexOf(findStr1) != -1) {
				//alert(addr.lastIndexOf(findStr1) + '&');
				var endAddrIndex = addr.lastIndexOf(findStr1);
				var refrseh_addr = addr.substring(0, endAddrIndex);
				alert(refrseh_addr);
			}
			else if(addr.lastIndexOf(findStr2) != -1){
				alert(addr.lastIndexOf(findStr2) + '?');
			}
			else {
				alert("Not Found!!"); 
			}
			 */
			 
			 
			/*  
			//url 수정
			if(refresh_url != null){
				history.pushState({}, null, 'gameSearchSpecial.do' + refresh_url);						
			}
			 */
		});							
		
		//검색할 체크박스
		$('.tab_filter_control').on('click', function(){
			var dataParam = $(this).attr('data-param');
			
			if($(this).hasClass('checked')){
				var tagValue = $(this).attr('data-value');
				//선택된 검색 태그 버튼 제거
				$('.termcontainer > div[data-tag_value="' + tagValue + '"]' ).remove();
				$(this).removeClass('checked');
				
				if(dataParam === 'tags'){
					var preExist = $('#tagsval').val();
					var nowExist = preExist.split(',');
					var resultExist = '';
					
					for(var i=0; i < nowExist.length; i++){
						if(tagValue === nowExist[i]){
							//값 추가 x
						}
						else {
							if(resultExist === ''){
								resultExist = nowExist[i];
							}else {
								resultExist += ',' + nowExist[i];								
							}
						}
					}
					$('#tagsval').val(resultExist);
				}
				else if(dataParam === 'category1'){
					var preExist = $('#category1val').val();
					var nowExist = preExist.split(',');
					var resultExist = '';
					
					for(var i=0; i < nowExist.length; i++){
						if(tagValue === nowExist[i]){
							//값 추가 x
						}
						else {
							if(resultExist === ''){
								resultExist = nowExist[i];
							}else {
								resultExist += ',' + nowExist[i];								
							}
						}
					}
					$('#category1val').val(resultExist);
				}
				else if(dataParam === 'category3'){
					var preExist = $('#category3val').val();
					var nowExist = preExist.split(',');
					var resultExist = '';
					
					for(var i=0; i < nowExist.length; i++){
						if(tagValue === nowExist[i]){
							//값 추가 x
						}
						else {
							if(resultExist === ''){
								resultExist = nowExist[i];
							}else {
								resultExist += ',' + nowExist[i];								
							}
						}
					}
					$('#category3val').val(resultExist);
				}
				else if(dataParam === 'vrsupport'){
					var preExist = $('#vrsupportval').val();
					var nowExist = preExist.split(',');
					var resultExist = '';
					
					for(var i=0; i < nowExist.length; i++){
						if(tagValue === nowExist[i]){
							//값 추가 x
						}
						else {
							if(resultExist === ''){
								resultExist = nowExist[i];
							}else {
								resultExist += ',' + nowExist[i];								
							}
						}
					}
					$('#vrsupportval').val(resultExist);
				}
				else if(dataParam === 'os'){
					var preExist = $('#osval').val();
					var nowExist = preExist.split(',');
					var resultExist = '';
					
					for(var i=0; i < nowExist.length; i++){
						if(tagValue === nowExist[i]){
							//값 추가 x
						}
						else {
							if(resultExist === ''){
								resultExist = nowExist[i];
							}else {
								resultExist += ',' + nowExist[i];								
							}
						}
					}
					$('#osval').val(resultExist);
				}
		
				if($('.termcontainer > .tag_dynamic').length == 0){
					$('#termsnone').css('display', 'block');
				}
				searchGo();
				
			}else {
				$(this).addClass('checked');
				createSearchBtn($(this).attr('data-param'), $(this).attr('data-value'),$(this).attr('data-loc'));
				
				if($('.termcontainer > .tag_dynamic').length == 1){
					/* $('.pageheader').text('탐색 중:'); */
					$('#termsnone').css('display', 'none');
				}
				
				if(dataParam === 'tags'){
					var preExist = $('#tagsval').val();
					var nowExist = '';
					
					if(preExist === ''){
						nowExist = $(this).attr('data-value');
					}else {						
						var nowExist = preExist + ',' +$(this).attr('data-value');
					}
					$('#tagsval').val(nowExist);
				}
				else if(dataParam === 'category1'){
					var preExist = $('#category1val').val();
					var nowExist = '';
					
					if(preExist === ''){
						nowExist = $(this).attr('data-value');
					}else {						
						var nowExist = preExist + ',' +$(this).attr('data-value');
					}
					$('#category1val').val(nowExist);
				}
				else if(dataParam === 'category3'){
					var preExist = $('#category3val').val();
					var nowExist = '';
					
					if(preExist === ''){
						nowExist = $(this).attr('data-value');
					}else {						
						var nowExist = preExist + ',' +$(this).attr('data-value');
					}
					$('#category3val').val(nowExist);
				}
				else if(dataParam === 'vrsupport'){
					var preExist = $('#vrsupportval').val();
					var nowExist = '';
					
					if(preExist === ''){
						nowExist = $(this).attr('data-value');
					}else {						
						var nowExist = preExist + ',' +$(this).attr('data-value');
					}
					$('#vrsupportval').val(nowExist);
				}
				else if(dataParam === 'os'){
					var preExist = $('#osval').val();
					var nowExist = '';
					
					if(preExist === ''){
						nowExist = $(this).attr('data-value');
					}else {						
						var nowExist = preExist + ',' +$(this).attr('data-value');
					}
					$('#osval').val(nowExist);
				}
				searchGo();
			}
			
		});
		
		
		//정렬 기준
		$('#sort_by_trigger').on('click', function(){
			if($(this).hasClass('trigger')){
				$(this).removeClass('trigger');
				$(this).addClass('activetrigger');
				$('#sort_by_droplist').removeClass('dropdownhidden');
				$('#sort_by_droplist').addClass('dropdownvisible');
			}else {
				$(this).removeClass('activetrigger');
				$(this).addClass('trigger');
				$('#sort_by_droplist').removeClass('dropdownvisible');
				$('#sort_by_droplist').addClass('dropdownhidden');
			}
		});
		
		$('#sort_by_droplist > li > a').hover(function(){
			$(this).removeClass('inactive_selection');
			$(this).addClass('highlighted_selection');
		}, function(){
			$(this).removeClass('highlighted_selection');
			$(this).addClass('inactive_selection');
		});
		
		$(document).on('click', '.btn', function(){
			var dataValue = $(this).parent().attr('data-tag_value');
			var dataParam = $(this).parent().attr('data-tag_param');
			if(dataParam === 'term'){
				$('#term').val('검색어나 태그 입력');
				$('#termval').val('');
			}
			else if(dataParam === 'tags'){
				var preExist = $('#tagsval').val();
				var nowExist = preExist.split(',');
				var resultExist = '';
				
				for(var i=0; i < nowExist.length; i++){
					if(dataValue === nowExist[i]){
						//값 추가 x
					}
					else {
						if(resultExist === ''){
							resultExist = nowExist[i];
						}else {
							resultExist += ',' + nowExist[i];								
						}
					}
				}
				$('#tagsval').val(resultExist);
			}
			else if(dataParam === 'category1'){
				var preExist = $('#category1val').val();
				var nowExist = preExist.split(',');
				var resultExist = '';
				
				for(var i=0; i < nowExist.length; i++){
					if(dataValue === nowExist[i]){
						//값 추가 x
					}
					else {
						if(resultExist === ''){
							resultExist = nowExist[i];
						}else {
							resultExist += ',' + nowExist[i];								
						}
					}
				}
				$('#category1val').val(resultExist);
			}
			else if(dataParam === 'category3'){
				var preExist = $('#category3val').val();
				var nowExist = preExist.split(',');
				var resultExist = '';
				
				for(var i=0; i < nowExist.length; i++){
					if(dataValue === nowExist[i]){
						//값 추가 x
					}
					else {
						if(resultExist === ''){
							resultExist = nowExist[i];
						}else {
							resultExist += ',' + nowExist[i];								
						}
					}
				}
				$('#category3val').val(resultExist);
			}
			else if(dataParam === 'vrsupport'){
				var preExist = $('#vrsupportval').val();
				var nowExist = preExist.split(',');
				var resultExist = '';
				
				for(var i=0; i < nowExist.length; i++){
					if(dataValue === nowExist[i]){
						//값 추가 x
					}
					else {
						if(resultExist === ''){
							resultExist = nowExist[i];
						}else {
							resultExist += ',' + nowExist[i];								
						}
					}
				}
				$('#vrsupportval').val(resultExist);
			}
			else if(dataParam === 'os'){
				var preExist = $('#osval').val();
				var nowExist = preExist.split(',');
				var resultExist = '';
				
				for(var i=0; i < nowExist.length; i++){
					if(dataValue === nowExist[i]){
						//값 추가 x
					}
					else {
						if(resultExist === ''){
							resultExist = nowExist[i];
						}else {
							resultExist += ',' + nowExist[i];								
						}
					}
				}
				$('#osval').val(resultExist);
			}
			
			$('.tab_filter_control[data-value="' + dataValue + '"]').removeClass('checked');

			$(this).parent().remove();
			if($('.termcontainer > .tag_dynamic').length == 0){
				$('#termsnone').css('display', 'block');
			}
			searchGo();
		});
		
		
		var checkSearch='';
		
		$('#term').focus(function(){
			if(checkSearch === 'exist'){
				$('#term_options').css('display', 'block');				
			}
		});
		
		$('#term').focusout(function(){
			setTimeout(function() {
				$('#term_options').css('display', 'none');
			}, 150);
		});
		
		
		$('#term').keyup(function(){
			if($('#term').val() === ''){
				$('#term_options ul').empty();
				$('#term_options').css('display', 'none');
				checkSearch = '';
			} else {
				//존재하는 게임 이름만 보여줌
				gameName = '';
				$('#term_options ul').empty();
				$.ajax({
					url: '/StreamAjax/searchGameName',
					type: 'post',
					dataType: 'json',
					data: 'searchGameName=' + $('#term').val(),
					success: function(data){
						if(JSON.stringify(data) === '[]'){ //검색된 데이터가 없을 경우
							$('#term_options').css('display', 'none');
							checkSearch = '';
						} else {
							$('#term_options').css('display', 'block');
							
							checkSearch = 'exist';
							
							$.each(data, function(index, data) {
								if(index < 10){
									//console.log(this['g_name']);
									gameName += '<li>';
									gameName += this['g_name'];
									gameName += '</li>'; 
									
								}
							});
							$('#term_options ul').append(gameName);//html은 기본으로 초기화 됨/append는 기존 데이터에 추가로...
						}
						
					},
					error: function(){
						//검색된 데이터 없을 경우 error 발생
						//alert('Error');
					}
				});
			}
		});
		
		//정렬 방법
		$(document).on('click', '#sort_by_droplist > li > a', function(){
			$('#sort_by_trigger').removeClass('activetrigger');
			$('#sort_by_trigger').addClass('trigger');
			$('#sort_by_droplist').removeClass('dropdownvisible');
			$('#sort_by_droplist').addClass('dropdownhidden');
			$('#sort_by_trigger').text($(this).text());
			$('#sort_by').val($(this).attr('id'));
			searchGo();
		});
		
		
		$(document).on('click', '#term_options > ul > li', function(){
			//기존값 먼저 제거
			$('.termcontainer > .tag_dynamic[data-tag_param="term"]').remove();
			
			var selectedGameName = $(this).text();
			$('#termval').val(selectedGameName);
			
			$('#term').val(selectedGameName);
			checkSearch = '';
			createSearchBtn('term', selectedGameName, '\"' + selectedGameName + '\"');
			$('#termsnone').css('display', 'none');
			searchGo();
		});
		
		
		$(document).on('mouseout', '#term_options > ul > li', function(){
			$(this).removeClass('selected');
		});
		
		$(document).on('mouseover', '#term_options > ul > li', function(){
			$(this).addClass('selected');
		});
		
		$('#searchword').on('click', function(){
			if($('#term').val() !== '검색어나 태그 입력'){
				$('.termcontainer > .tag_dynamic[data-tag_param="term"]').remove();
				var word = $('#term').val();
				$('#termval').val(word);
				
				checkSearch = '';
				createSearchBtn('term', word, '\"' + word + '\"');
				
				$('#termsnone').css('display', 'none');
				/* $('.pageheader').text('탐색 중:'); */
				
				searchGo();
			}
		});
		
		
		$('#TagSuggest').keyup(function(){
			var searchTag = $('#TagSuggest').val();
			if(searchTag === ''){
				$('#TagFilter_Container > .tab_filter_control').css('display', 'block');
			}else {				
				$('#TagFilter_Container > .tab_filter_control').css('display', 'none');
				
				$('#TagFilter_Container > .tab_filter_control:containsIN("' + searchTag + '")').css('display', 'block');
			}
			
		});
		
		//검색 작업
		function searchGo(){
			
			$.ajax({
				url: '/StreamAjax/searchOptions',
				type: 'post',
				dataType: 'json',
				data: $('#advsearchform').serialize(),
				success: function(data){
					var searchedGame='';
					$('#searchedList').empty();
					if(JSON.stringify(data) === '[]'){ //검색된 데이터가 없을 경우
						$('#noSearched').css('display', 'block');
						$('.search_pagination').css('display', 'none');
						$('#searchedList').css('display', 'none');
					}
					else {
						$('#noSearched').css('display', 'none');
						$('.search_pagination').css('display', 'block');
						$('#searchedList').css('display', 'block');
						
						$.each(data, function(index, data) {
							if(index < ${pvo.numPerPage}){
								searchedGame += '<a href=\"gameDetail.do?g_idx=' + this['g_idx'] + '" data-ds-appid=\"' + this['g_idx'];
								searchedGame += '\" class=\"search_result_row ds_collapse_flag\"> <div class=\"col search_capsule\">';
								searchedGame += '<img src=\"${pageContext.request.contextPath}/resources/public/game/game_image/' + this['cover'] + '\" style=\"height: 100%; width: 100%;\"></div>';
								searchedGame += '<div class=\"responsive_search_name_combined\"> <div class=\"col search_name ellipsis\" style="margin-left: 8px;"><span class=\"title\">';
								searchedGame += this['g_name'] + '</span><p><span class=\"platform_img win\"></span> ';
								searchedGame += '<span class=\"platform_img mac\"></span><span class=\"platform_img linux\"></span></p></div>';
								searchedGame += '<div class=\"col search_released responsive_secondrow\" style=\"margin-left: 8px;\">' + this['release_date'] + '</div>';
								searchedGame += '<div class=\"col search_reviewscore responsive_secondrow\">';
								
								/* searchedGame += '<span class=\"search_review_summary mixed\" data-store-tooltip=\"  \"></span>'; */
								
								if(this['review_count'] != 0){
									if((this['review_score'] / this['review_count']) >= 70){
										searchedGame += '<span class=\"search_review_summary positive\" data-store-tooltip=\"  \"></span>';
									}
									if(((this['review_score'] / this['review_count']) < 70) && ((this['review_score'] / this['review_count']) >= 40)){
										searchedGame += '<span class=\"search_review_summary mixed\" data-store-tooltip=\"  \"></span>';										
									}
									if((this['review_score'] / this['review_count']) < 40){
										searchedGame += '<span class=\"search_review_summary negative\" data-store-tooltip=\"  \"></span>';
									}
								}
								
								
								searchedGame += '</div><div class=\"col search_price_discount_combined responsive_secondrow\">';
								
								if(this['d_idx'] == null){
									searchedGame += '<div class=\"col search_discount responsive_secondrow\"></div>';
									searchedGame += '<div class=\"col search_price  responsive_secondrow\" style=\"margin-left: 9px;\">₩ ' + this['price'] + '</div>';
								}
								else{
									searchedGame += '<div class=\"col search_discount responsive_secondrow\" style=\"margin-left: 5px;\">';
									searchedGame += '<span>-' + this['percent'] + '%</span></div>';
									searchedGame += '<div class=\"col search_price discounted responsive_secondrow\" style=\"margin-left: 3px;\">';
									searchedGame += '<span style=\"color: #888888; \">';
									searchedGame += '<strike>₩ ' + this['price'] + '</strike></span>';
									var discountPrice = this['price']*(0.01*(100-this['percent']));
									searchedGame += '<br>₩ ' + discountPrice + '</div>';
								}
								
								
								searchedGame += '</div></div><div style=\"clear: left;\"></div></a>';
							}
						});
						$('#searchedList').append(searchedGame);
					}
					
					//현재 주소
					//alert(window.location.href);
					
					//reload 없이 홈페이지 주소 변경
					//url 변경을 위한 변수
					var refresh_url = null;
					
					if($('#termval').val() != ''){
						refresh_url = '?term=' + $('#termval').val();
					}
					
					//tags
					if($('#tagsval').val() != ''){
						if(refresh_url == null){
							refresh_url = '?tags=' + $('#tagsval').val();
						}
						else {
							refresh_url += '&tags=' + $('#tagsval').val();
						}
					}
					//category1
					//category3
					//vrsupport
					//os
					
					//filter
					if($('#filter').val() != ''){
						//filter 정렬 기준
						var filter_type = '';
						if($('#filter').val() == 'count'){
							filter_type = 'topsellers';
						}
						else if($('#filter').val() == 'release_date'){
							filter_type = 'new';							
						}
						
						
						if(refresh_url == null){
							refresh_url = '?filter=' + filter_type;
						}
						else {
							refresh_url += '&filter=' + filter_type;
						}
					}
					
					//페이지
					if($('#page').val() != ''){
						if(refresh_url == null){
							refresh_url = '?page=' + $('#page').val();
						}
						else {
							refresh_url += '&page=' + $('#page').val();
						}
					}
					
					//url 수정
					if(refresh_url != null){
						history.pushState({}, null, 'gameSearchSpecial.do' + refresh_url);						
					}
					else {
						history.pushState({}, null, 'gameSearchSpecial.do');
					}
					
				},
				error : function(){
					alert('error');
				}	
			});
		}
		
	});
	
	function ExpandOptions(agent, target){
		$(agent).css('display', 'none');
		$('#'+target).css('height', 'auto');
	}
	
	
</script>
</head>
<html>
<body class="v6 search_page responsive_page">

	<div class="responsive_page_frame with_header">
		<div class="responsive_page_content">
			<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp" />

			<div id="responsive_store_nav_ctn"></div>
			<div class="responsive_page_template_content">
				<div class="page_header_ctn search">

					<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/contentTopMenu.jsp" />


					<div class="page_content">
						<div class="breadcrumbs"></div>
						<h2 class="pageheader full">
							<c:choose>
								<c:when test="${orderType eq 'count'}">최고 인기 제품</c:when>
								<c:when test="${orderType eq 'release_date'}">신규 출시</c:when>
								<c:otherwise>탐색 중:</c:otherwise>											
							</c:choose>
						</h2>


						<div class="termcontainer">
							<c:choose>
								<c:when test="${(term == null || term == '') && (tags == null || tags == '')}">
								<%-- <c:when test="${tags == null || tags == ''}"> --%>
									<div id="termsnone">
										<div class="pagesubheader" style="display: block;">모든 제품</div>
									</div>
									<%-- 
									<div class="searchtag" id="searchtag_tmpl" style="display: none">
										<span class="label"></span> <a class="btn"></a>
									</div>
									 --%>
								</c:when>
								
								<c:otherwise>
									<div id="termsnone" style="display: none;">
										<div class="pagesubheader" style="display: block;">모든 제품</div>
									</div>
									
									<!-- 검색된 옵션 표시 -->
									<c:if test="${term != null}">
										<div class="searchtag tag_dynamic" id="searchtag_tmpl"
											style="display: inline-block;" data-tag_param="term"
											data-tag_value="${term}">
											<span class="label">"${term}"</span> <a class="btn"></a>
										</div>
									</c:if>
									<!-- end 검색된 옵션 표시 -->
									
									<c:if test="${tags != null}">
										<c:forEach var="k" items="${selectedTag}">
											<div class="searchtag tag_dynamic" id="searchtag_tmpl"
												style="display: inline-block;" data-tag_param="tags"
												data-tag_value="${k.tag_idx}">
												<span class="label">${k.tag_name}</span> <a class="btn"></a>
											</div>
											
										</c:forEach>
									</c:if>
									
									
								</c:otherwise>
								
							</c:choose>
						</div>
					</div>

				</div>
				<form action="gameSearchSpecial.do" id="advsearchform" name="advsearchform"
					onSubmit="return false;">
					
					<c:choose>
	     				<c:when test="term == null || term == ''">
	     					<input type="text" name="term" id="termval">
	     				</c:when>
	     				<c:otherwise>
	     					<input type="text" name="term" id="termval" value="${term}">
	     				</c:otherwise>
	     			</c:choose>
	     			
	     			<c:choose>
	     				<c:when test="tags == null || tags == ''">
	     					<input type="text" name="tags" id="tagsval">
	     				</c:when>
	     				<c:otherwise>
		     				<input type="text" name="tags" id="tagsval" value="${tags}">
	     				</c:otherwise>
	     			</c:choose>
					
					
					<input type="text" name="category1" id="category1val">
					<input type="text" name="category3" id="category3val">
					<input type="text" name="vrsupport" id="vrsupportval">
					<input type="text" name="os" id="osval">
					<input id="sort_by" type="text" name="sortBy" value="byName">
					<input id="filter" type="text" name="filter" value="${orderType}">
					<input type="text" name="page" id="page" value="${pvo.nowPage}">
												
							
					<!-- Main Background -->
					<div class="page_content_ctn">
						<div class="page_content">

							<div class="leftcol large">

								<div class="searchbar">
									<div class="sortbox">
										<div class="label">정렬 기준</div>
										<div class="dselect_container" id="sort_by_dselect_container">
											<c:choose>
												<c:when test="${orderType eq 'count'}">
													<a class="trigger" id="sort_by_trigger" style="cursor: pointer;">구매순</a>												
												</c:when>
												<c:when test="${orderType eq 'release_date'}">
													<a class="trigger" id="sort_by_trigger" style="cursor: pointer;">출시 날짜</a>
												</c:when>
												<c:otherwise>
													<a class="trigger" id="sort_by_trigger" style="cursor: pointer;">이름</a>												
												</c:otherwise>											
											</c:choose>
											
											
											<div class="dropcontainer">
												<ul class="dropdownhidden" id="sort_by_droplist">
													<li><a class="inactive_selection" tabindex="99999" id="byName" style="cursor: pointer;">이름</a></li>
														
													<li><a class="inactive_selection" tabindex="99999" id="byReleasedate" style="cursor: pointer;">출시 날짜</a></li>
														
													<li><a class="inactive_selection" tabindex="99999" id="byLowprice" style="cursor: pointer;">낮은 가격</a></li>
													
													<li><a class="inactive_selection" tabindex="99999" id="byHighprice" style="cursor: pointer;">높은 가격</a></li>
													
													<li><a class="inactive_selection" tabindex="99999" id="byCount" style="cursor: pointer;">구매순</a></li>
												</ul>
											</div>
										</div>

									</div>
									<div class="searchbar_left">
										<input type="text" class="text" id="term" name="displayterm"
											onfocus="if(this.value=='검색어나 태그 입력'){this.value=''}"
											onchange="$('realterm').value= (this.value=='검색어나 태그 입력') ? '' : this.value"
											onblur="if(this.value==''){this.value='검색어나 태그 입력';}"
											value="검색어나 태그 입력" maxlength="64" autocomplete="off">
											
										<button id="searchword" type="button" class="btnv6_blue_hoverfade btn_small">
											<span>검색</span>
										</button>
										<div id="term_options" class="autocomplete"
											style="position: absolute; left: 6px; top: 34px; width: 312px; display: none;">
											<ul>
												<!-- li 추가될 부분  -->
												
											</ul>
										</div>
									</div>
									<div style="clear: both;"></div>
								</div>



								<div id="search_results">
									<div id="search_result_container">

										<div class="search_rule"></div>


										<!-- 검색 결과 없을 경우 -->
										<c:choose>
											<c:when test="${!empty gvo}">
												<div id="noSearched" style="display:none;">
													<p>
														<br>
													</p>
													<p>해당 검색어에 대한 검색 결과가 없습니다.</p>
												</div>
											</c:when>
											<c:otherwise>
												<div id="noSearched" style="display:block;">
													<p>
														<br>
													</p>
													<p>해당 검색어에 대한 검색 결과가 없습니다.</p>
												</div>
											</c:otherwise>
										</c:choose>
										<!-- end 검색 결과 없을 경우 -->



										<!-- List Items -->
										<div id="searchedList">
											<!-- Extra empty div to hack around lame IE7 layout bug -->
											<div></div>
											<!-- End Extra empty div -->

											<c:forEach items="${gvo}" var="k">
												<a href="gameDetail.do?g_idx=${k.g_idx}" data-ds-appid="${k.g_idx}" class="search_result_row ds_collapse_flag">
													<div class="col search_capsule">
														<img src="<c:url value="${pageContext.request.contextPath}/resources/public/game/game_image/${k.cover}"/>" style="height: 100%; width: 100%;">
													</div>
													<div class="responsive_search_name_combined">
														<div class="col search_name ellipsis">
															<span class="title">${k.g_name}</span>
															<p>
																<span class="platform_img win"></span> 
																<span class="platform_img mac"></span> 
																<span class="platform_img linux"></span>
															</p>
														</div>
														
														
														<div class="col search_released responsive_secondrow">${k.release_date}</div>
	
														<!-- 게임 평가 -->
														<div class="col search_reviewscore responsive_secondrow">
															<c:choose>
																<c:when test="${k.review_count ne 0}">
																	<c:if test="${(k.review_score/k.review_count) >= 70}">
																		<span class="search_review_summary positive"
																			data-store-tooltip="긍정적&lt;br&gt;이 게임에 대한 사용자 평가 ${k.review_count}개 중 ...개 가 긍정적입니다.">
																		</span>
																	</c:if>
																	
																	<c:if test="${(k.review_score/k.review_count) < 70 && (k.review_score/k.review_count) >= 40}">
																		<span class="search_review_summary mixed"
																			data-store-tooltip="복합적&lt;br&gt;이 게임에 대한 사용자 평가 ${k.review_count}개 중 ...개 가 복합적입니다.">
																		</span>
																	</c:if>
																	
																	<c:if test="${(k.review_score/k.review_count) < 40}">
																		<span class="search_review_summary negative"
																			data-store-tooltip="부정적&lt;br&gt;이 게임에 대한 사용자 평가 ${k.review_count}개 중 ...개 가 부정적입니다.">
																		</span>
																	</c:if>
																</c:when>
																<c:otherwise> </c:otherwise>
															</c:choose>
															
														</div>
	
														<!-- 할인 여부 판단 -->
														<div class="col search_price_discount_combined responsive_secondrow">
															<c:choose>
																<c:when test="${k.d_idx eq null}">
																	<div class="col search_discount responsive_secondrow">
																	</div>
																	<div class="col search_price  responsive_secondrow">₩ ${k.price}</div>
																</c:when>
																<c:otherwise>
																	<div class="col search_discount responsive_secondrow">
																		<span>-${k.percent}%</span>
																	</div>
																	<div class="col search_price discounted responsive_secondrow">
																		<span style="color: #888888; padding-left: 50px;">
																		<strike>₩ ${k.price}</strike></span>
																		<fmt:parseNumber var="discountPrice" integerOnly="true" value="${k.price*(0.01*(100-k.percent))}"/>
																		<br>₩ ${discountPrice}
																	</div>	
																</c:otherwise>
															</c:choose>
														</div>
													</div>
													<div style="clear: left;"></div>
												</a>
											
											</c:forEach>

										</div>
										<!-- End List Items -->


										<!-- 페이징  -->
										<c:choose>
											<c:when test="${empty gvo}">
												<div class="search_pagination" style="display: none;">
													<div class="search_pagination_left">표시 1 - 25 / ${fn:length(gvo)}</div>
													<div class="search_pagination_right">
													</div>
												</div>
											</c:when>
											<c:otherwise>
												<div class="search_pagination">
													<div class="search_pagination_left">
														<c:choose>
															<c:when test="${fn:length(gvo) < 5}">
																표시 1 - ${fn:length(gvo)} / ${fn:length(gvo)}</div>															
															</c:when>
															<c:otherwise>															
																표시 ${(1 + (pvo.numPerPage * (pvo.nowPage - 1)))} - ${pvo.nowPage * pvo.numPerPage} / ${fn:length(gvo)}</div>
															</c:otherwise>
														</c:choose>
													
													<div class="search_pagination_right">
														<%-- 이전 < --%>
														<c:choose>
													    	<c:when test="${pvo.beginPage < pvo.pagePerBlock }">
													    	
													    	</c:when>
													    	<c:otherwise>
													    		<a
																href=""
																onclick="SearchLinkClick( this ); return false;"
																class="pagebtn">&lt;</a>&nbsp;
													    	</c:otherwise>
													    </c:choose>
														
														<!-- 블록안에 들어간 페이지번호들 -->
														<c:forEach var="k" begin="${pvo.beginPage}" end="${pvo.endPage}" step="1">
															<c:choose>
																<c:when test="${k==pvo.nowPage}">
																	${k}&nbsp;&nbsp;
																</c:when>
																<c:otherwise>
																	<%-- 
																	<a href=""
																	onclick="SearchLinkClick( this ); return false;">${k}</a>
																	 --%>

																	<a href="javascript:void(0);">${k}</a>
																	
																	&nbsp;&nbsp;
																</c:otherwise>
															</c:choose>
														</c:forEach>
														
														<%-- 다음 --%>
														<c:choose>
													    	<c:when test="${pvo.endPage >= pvo.totalPage }">
													    		
													    	</c:when>
													    	<c:otherwise>
													    		<a
																href=""
																onclick="SearchLinkClick( this ); return false;"
																class="pagebtn">&gt;</a>
													    	</c:otherwise>
													    </c:choose>
														
													</div>
													<div style="clear: both;"></div>
												</div>
											</c:otherwise>
										</c:choose>
										
										<!-- end 페이징  -->
									</div>
								</div>
							</div>

								
							<div class="rightcol small responsive_local_menu"
								id="additional_search_options">

								<div class="block">
									<div class="block_header">
										<div>태그로 좁히기</div>
									</div>
									<script>
										$('#TagFilter_Container > .tab_filter_control').on('click', function(){
											$(this).addClass('checked');
										});
									</script>

									<div class="block_content block_content_inner">
										<div id="TagFilter_Container" style="max-height: 150px; overflow: hidden;">
											<!-- 체크할 경우  class="checked" 추가  -->
											<!-- 넘어온 태그의 값과 동일한지 체크  -->
											<c:choose>
												<c:when test="${selectedTag ne null}">
													<c:forEach var="k" items="${tvo}">
														<c:set var="tagCheck" value="0"/>
														<c:forEach var="j" items="${selectedTag}" varStatus="vs">
															<c:if test="${j.tag_idx eq k.tag_idx}">
																<c:set var="tagCheck" value="${tagCheck + 1}"/>
															</c:if>
														</c:forEach>
														<c:choose>
															<c:when test="${tagCheck ne 0}">
																<div class="tab_filter_control checked" data-param="tags" data-value="${k.tag_idx}" data-loc="${k.tag_name}">
																	<div class="tab_filter_control_checkbox"></div>
																	<span class="tab_filter_control_label">${k.tag_name}</span>
																</div>
															</c:when>
															<c:otherwise>
																<div class="tab_filter_control" data-param="tags" data-value="${k.tag_idx}" data-loc="${k.tag_name}">
																	<div class="tab_filter_control_checkbox"></div>
																	<span class="tab_filter_control_label">${k.tag_name}</span>
																</div>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<c:forEach var="k" items="${tvo}">
														<div class="tab_filter_control" data-param="tags" data-value="${k.tag_idx}" data-loc="${k.tag_name}">
															<div class="tab_filter_control_checkbox"></div>
															<span class="tab_filter_control_label">${k.tag_name}</span>
														</div>
													</c:forEach>
												</c:otherwise>
											</c:choose>
											
											
											
											
											
											
										</div>
										<input type="text" id="TagSuggest" class="blur">

									</div>
									<a class="see_all_expander" href="#"
										onclick="ExpandOptions(this, 'TagFilter_Container'); return false;">모두 보기</a>
								</div>
								<div class="block">
									<div class="block_header">
										<div>선택한 형식 보기</div>
									</div>
									<div class="block_content block_content_inner"
										style="height: 57px;">
										<div class="tab_filter_control " data-param="category1"
											data-value="down" data-loc="다운로드 가능한 콘텐츠">
											<div class="tab_filter_control_checkbox"></div>
											<span class="tab_filter_control_label">다운로드 가능한 콘텐츠</span>
										</div>
										<div class="tab_filter_control " data-param="category1"
											data-value="experience" data-loc="체험판">
											<div class="tab_filter_control_checkbox"></div>
											<span class="tab_filter_control_label">체험판</span>
										</div>
									</div>
								</div>
								<div class="block">
									<div class="block_header">
										<div>플레이어 수로 좁히기</div>
									</div>
									<div class="block_content block_content_inner" id="narrow_category3" style="height: 150px;">
										<div class="tab_filter_control " data-param="category3"
											data-value="369" data-loc="싱글 플레이어">
											<div class="tab_filter_control_checkbox"></div>
											<span class="tab_filter_control_label">싱글 플레이어</span>
										</div>
										<div class="tab_filter_control " data-param="category3"
											data-value="375" data-loc="멀티플레이어">
											<div class="tab_filter_control_checkbox"></div>
											<span class="tab_filter_control_label">멀티플레이어</span>
										</div>
										<div class="tab_filter_control " data-param="category3"
											data-value="425" data-loc="로컬 멀티플레이어">
											<div class="tab_filter_control_checkbox"></div>
											<span class="tab_filter_control_label">로컬 멀티플레이어</span>
										</div>
										<div class="tab_filter_control " data-param="category3"
											data-value="390" data-loc="협동">
											<div class="tab_filter_control_checkbox"></div>
											<span class="tab_filter_control_label">협동</span>
										</div>
										<div class="tab_filter_control " data-param="category3"
											data-value="411" data-loc="온라인 협동">
											<div class="tab_filter_control_checkbox"></div>
											<span class="tab_filter_control_label">온라인 협동</span>
										</div>
										<div class="tab_filter_control " data-param="category3"
											data-value="428" data-loc="로컬 협동">
											<div class="tab_filter_control_checkbox"></div>
											<span class="tab_filter_control_label">로컬 협동</span>
										</div>
									</div>
									<a class="see_all_expander" href="#" onclick="ExpandOptions(this, 'narrow_category3'); return false;">모두 보기</a>
								</div>

								<div class="block">
									<div class="block_header">
										<div>VR 지원으로 좁히기</div>
									</div>
									<div class="block_content block_content_inner" id="narrow_byVR"
										style="height: 27px;"> <!-- style="height: 57px; -->
										<!-- 
										<div class="tab_filter_control " data-param="vrsupport"
											data-value="384" data-loc="VR 전용">
											<div class="tab_filter_control_checkbox"></div>
											<span class="tab_filter_control_label">VR 전용</span>
										</div>
										 -->
										<div class="tab_filter_control " data-param="vrsupport"
											data-value="384" data-loc="VR 지원">
											<div class="tab_filter_control_checkbox"></div>
											<span class="tab_filter_control_label">VR 지원</span>
										</div>
										
										
										<!-- <div class="block_header">
											<div>헤드셋</div>
										</div>
										<div class="tab_filter_control " data-param="vrsupport"
											data-value="101" data-loc="HTC Vive">
											<div class="tab_filter_control_checkbox"></div>
											<span class="tab_filter_control_label">HTC Vive</span>
										</div>
										<div class="tab_filter_control " data-param="vrsupport"
											data-value="102" data-loc="Oculus Rift">
											<div class="tab_filter_control_checkbox"></div>
											<span class="tab_filter_control_label">Oculus Rift</span>
										</div>
										<div class="tab_filter_control " data-param="vrsupport"
											data-value="104" data-loc="Windows 혼합 현실">
											<div class="tab_filter_control_checkbox"></div>
											<span class="tab_filter_control_label">Windows 혼합 현실</span>
										</div>
										 -->
										
									</div>
								</div>
								<div class="block">
									<div class="block_header">
										<div>OS으로 좁히기</div>
									</div>
									<div class="block_content block_content_inner">
										<div class="tab_filter_control " data-param="os"
											data-value="win" data-loc="Windows">
											<div class="tab_filter_control_checkbox"></div>
											<span class="tab_filter_control_label">Windows</span>
										</div>
										<div class="tab_filter_control " data-param="os"
											data-value="mac" data-loc="Mac OS X">
											<div class="tab_filter_control_checkbox"></div>
											<span class="tab_filter_control_label">Mac OS X</span>
										</div>
										<div class="tab_filter_control " data-param="os"
											data-value="linux" data-loc="SteamOS + Linux">
											<div class="tab_filter_control_checkbox"></div>
											<span class="tab_filter_control_label">SteamOS + Linux</span>
										</div>
									</div>

								</div>

							</div>
							<div style="clear: both;"></div>
						</div>
					</div>
					<!-- End Main Background -->

					<div id="hidden_searchform_elements">
						<!-- in responsive mode, the hidden right column inputs are reparented here so they are part of the form -->
						<input type="hidden" id="search_snr_value" name="snr" value="1_7_7_topsellers_7"> 
						<input type="hidden" name="list_of_subs" value=""> 
						<input type="hidden" name="specials" value=""> 
						<input type="hidden" name="filter" value="topsellers"> 
						<input type="hidden" name="genre" value=""> 
						<input type="hidden" name="salepage" value=""> 
						<input type="hidden" name="publisher" id="publisher" value=""> 
						<input type="hidden" name="developer" id="developer" value=""> 
						<input type="hidden" name="manufacturer" id="manufacturer" value="">
						<input type="hidden" id="search_current_page" name="page" value="1">
					</div>

				</form>

			</div>
			<!-- responsive_page_legacy_content -->
			<jsp:include
				page="${pageContext.request.contextPath}/WEB-INF/views/common/footer.jsp" />
		</div>
	</div>



	<!-- 팝업 -->
	<div class="hover game_hover" id="global_hover"
		style="left: 887.877px; top: 313.78px; display: none; opacity: 1;">
		<div class="game_hover_box hover_box">
			<div class="content" id="global_hover_content">

				<!-- 게임 정보 - 보일 경우 style="display: block;" -->
				<div id="hover_app_게임 번호" style="display: none;">
					<div class="hover_top_area"></div>
					<h4>게임 제목</h4>
					<div class="hover_release">출시: 2015년 4월 13일</div>
					<div class="hover_screenshots">
						<div class="screenshot" style="background-image: url('이미지')"></div>
					</div>
					<div class="hover_body">
						<div class="hover_review_summary">
							<div class="title">전반적 사용자 평가:</div>
							<span class="game_review_summary mixed">복합적</span> (평가 317,761 개)
						</div>
						<div style="clear: left;"></div>
					</div>
					<div class="hover_body">
						사용자 태그:
						<div class="hover_tag_row">
							<div class="app_tag">태그</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
</body>
</html>