<%@page language="java" contentType="text/html; charset=UTF-8;" 
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<body>
	<!-- 로그인 하지 않은 경우 footer 위에 뜨는 로그인 추천 -->
	<div class="home_ctn home_content_ctn">
		<div id="homecontent_anchor"></div>
			
		<div id="content_callout" class="page_content_ctn dark" data-usability-scroll="120" style="display: none;">
			<div class="home_page_content">
				<div class="more_content_title">
					<span>계속 스크롤 하셔서 더 많은 추천 제품들을 확인해 보세요.</span>
				</div>
				<div class="more_content_desc">귀하께서 관심가는 다양한 Stream 제품들을 아래서 찾을 수 있을 것입니다.</div>
			</div>
		</div>
	
		<div id="content_login" class="page_content_ctn dark">
			<div class="home_page_content">
				<div class="more_content_title">
					<span>추천 제품들을 찾고 계십니까?</span>
				</div>
			</div>
			<div class="home_page_content">
				<div class="home_page_sign_in_ctn small">
					<p>맞춤 추천 제품을 보려면 로그인하세요.</p>
					<div class="signin_buttons_ctn">
						<a class="btn_green_white_innerfade btn_border_2px btn_medium" href="login.do">
							<span>로그인</span>
						</a>
						 <br> <br> 아직 가입하지 않으셨다면 먼저 
						 <a href="join.do">가입</a>하신 후 무료로 Stream을 이용하세요.
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end 로그인 하지 않은 경우 footer 위에 뜨는 로그인 추천 -->
</body>
</html>