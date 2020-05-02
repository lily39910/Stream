<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<body>
	<!-- 왼쪽 메뉴바 -->
	<div class="home_page_gutter" style="width: 210px;">
		<!-- 기프트 카드 ~ 카테고리 검색 -->
		<div class="home_page_gutter_block">
			<!-- 이미지 + 기프트카드-->
			<div class="gutter_header">
				<a> 
					<img class="home_page_gutter_giftcard" src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/header/streamcards_promo_02.png"/>">
				</a>
				<br>기프트 카드
			</div>
			<div class="gutter_items">
				<a class="gutter_giftcard gutter_item" style="cursor: pointer;">이제 Stream에서 이용 가능</a>
			</div>

			<!-- 추천 제품 -->
			<div class="gutter_header">추천 제품</div>
			<div class="gutter_items">
				<a class="gutter_item" href="tag.do"> <span class="icon tags"></span>&nbsp;태그</a>
			</div>

			<!-- 맞춤 대기열 -->
			<div class="gutter_header">맞춤 대기열</div>
			<div class="gutter_items">
				<a class="gutter_item" href="main.do"> <span class="icon queue"></span>&nbsp;추천 목록</a> 
				<a class="gutter_item" href="main.do"> <span class="icon queue_new"></span>&nbsp;신규 출시 제품</a>
			</div>

			<!-- 카테고리 검색 -->
			<div class="gutter_header">카테고리 검색</div>
			<div class="gutter_items">
				<a class="gutter_item" href="gameSearchSpecial.do?filter=topsellers"> <span class="icon top_sellers"></span>&nbsp;인기 상품</a> 
				<a class="gutter_item" href="#"> <span class="icon updated"></span>&nbsp;최근에 업데이트됨</a> 
				<a class="gutter_item" href="gameSearchSpecial.do?filter=new"> <span class="icon recent"></span>&nbsp;신규 출시</a> 
				<a class="gutter_item" href="gameSearchSpecial.do"> <span class="icon upcoming"></span>&nbsp;발매 예정</a> 
				<a class="gutter_item" href="gameSearchSpecial.do"> <span class="icon discounts"></span>&nbsp;특별 할인</a> 
				<a class="gutter_item" href="#"> <span class="icon vr"></span>&nbsp;가상 현실</a> 
				<a class="gutter_item" href="#"> <span class="icon controller"></span>&nbsp;Stream 컨트롤러 호환</a>
			</div>
		</div>


		<!-- 장르로 검색 -->
		<div class="home_page_gutter_block">
			<div class="gutter_header pad">장르로 검색</div>
			<a class="gutter_item" href="#">무료</a>
			<a class="gutter_item" href="#">앞서 해보기</a>
			<a class="gutter_item" href="#">대규모 멀티플레이어</a> 
			<a class="gutter_item" href="#">레이싱</a> 
			<a class="gutter_item" href="#">롤 플레잉</a> 
			<a class="gutter_item" href="#">스포츠</a> 
			<a class="gutter_item" href="#">시뮬레이션</a> 
			<a class="gutter_item" href="#">액션</a> 
			<a class="gutter_item" href="#">어드벤처</a> 
			<a class="gutter_item" href="#">인디</a> 
			<a class="gutter_item" href="#">전략</a> 
			<a class="gutter_item" href="#">캐주얼</a>
		</div>



		<!-- 내 태그 -->
		<div class="home_page_gutter_block" id="home_gutter_recommendedtags"
			style="display: none;">
			<div class="gutter_header">내 태그</div>
			<div class="gutter_items"></div>
		</div>


		<!-- 최근에 본 제품 -->
		<div class="home_page_gutter_block" id="home_gutter_recentlyviewed">
			<div class="gutter_header pad">최근에 본 제품</div>
			<div class="gutter_items">
				<a class="gutter_item" data-ds-appid="게임번호" href="#">게임 이름</a>
			</div>
		</div>
	</div>
	<!-- End 왼쪽 메뉴바 -->
</body>
</html>