<%@page language="java" contentType="text/html; charset=UTF-8;" 
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<body>
	<!-- footer -->
	<div id="footer_spacer"></div> <!-- class="small_footer" 생략 -->
	
	<!-- 홈페이지 정보 -->
	<div id="footer"> <!-- class="small_footer" 생략 -->
		<div class="footer_content">
			<div class="rule"></div>
			<div id="footer_logo_stream">
				<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/footer/logo_stream_footer.png"/>"
					alt="Valve Software" border="0">
			</div>
			<div id="footer_logo">
				<a rel="noreferrer">
					<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/footer/logo_valve_footer.png"/>"
					alt="Valve Software" border="0">
				</a>
			</div>
			<div id="footer_text">
				<div>&copy; 2018 Valve Corporation. All rights reserved. 모든 상표는 미국 및
					기타 국가에서 해당하는 소유자의 재산입니다.</div>
				<div>
					부가가치세 포함&nbsp;&nbsp; <a href="#" target="_blank" rel="noreferrer">개인정보
						보호정책</a> &nbsp; | &nbsp; <a href="#" target="_blank" rel="noreferrer">사용권</a>
					&nbsp; | &nbsp; <a href="#" target="_blank" rel="noreferrer">Stream
						이용 약관</a> &nbsp; | &nbsp; <a href="#" target="_blank" rel="noreferrer">환불</a>
				</div>
			</div>
			<div style="clear: left;"></div>
			<div class="rule"></div>
			<div class="valve_links">
				<a href="#" target="_blank" rel="noreferrer">Valve 정보</a> &nbsp; |
				&nbsp; <a href="#" target="_blank" rel="noreferrer">Streamworks</a>
				&nbsp; | &nbsp; <a href="#" target="_blank" rel="noreferrer">채용
					정보</a> &nbsp; | &nbsp; <a href="#" target="_blank" rel="noreferrer">Stream
					배포</a> &nbsp; | &nbsp; <a href="#" target="_blank" rel="noreferrer">기프트
					카드</a> &nbsp; | &nbsp; <a href="#" target="_blank" rel="noreferrer">
					<img
					src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/footer/ico_facebook.gif"/>">&nbsp;Stream
				</a> &nbsp; | &nbsp; <a href="#" target="_blank" rel="noreferrer"> <img
					src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/footer/ico_twitter.gif"/>">&nbsp;@stream_games
				</a>
			</div>
		</div>
	</div>
	<!-- footer end -->
</body>
</html>