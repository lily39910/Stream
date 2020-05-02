<%@page language="java" contentType="text/html; charset=UTF-8;" 
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<style>
.header_installstream_btn_content {
	cursor: pointer;
}
</style>

<body>
	<script type="text/javascript">
		$(document).ready(function(){
			var supernav_store_view = false;
			
			//상점 메뉴
			$('#supernav_store').mouseenter(function(){
				$('#supernav_store_content').css('pointer-events', 'auto');
				$('#supernav_store_content').css('display', 'block');
				$('#supernav_store_content').css('opacity', '1');
				
				$('.submenu_store').css('display', 'block');
			});
			
			$('#supernav_store_content').mouseenter(function(){
				supernav_store_view = true;
				$('#supernav_store_content').css('pointer-events', 'auto');
				$('#supernav_store_content').css('display', 'block');
				$('#supernav_store_content').css('opacity', '1');
				
				$('.submenu_store').css('display', 'block');
			});
		
			$('#supernav_store_content').mouseleave(function(){
				$('#supernav_store_content').css('pointer-events', 'none');
				$('#supernav_store_content').css("display", "none");
				$('#supernav_store_content').css('opacity', '0');
				
				$('.submenu_store').css('display', 'none');
				supernav_store_view = false;
			});
			
			$('#supernav_store').mouseleave(function(){
				if(supernav_store_view === true){
					$('#supernav_store_content').css('pointer-events', 'auto');
					$('#supernav_store_content').css('display', 'block');
					$('#supernav_store_content').css('opacity', '1');
					
					$('.submenu_store').css('display', 'block');				
				}
				else {
					$('#supernav_store_content').css('pointer-events', 'none');
					$('#supernav_store_content').css("display", "none");
					$('#supernav_store_content').css('opacity', '0');
					
					$('.submenu_store').css('display', 'none');
					supernav_store_view = false;
				}
			});
			
			
			
			
			
			
			
			
			
			
			
			/* 로그인한 유저 메뉴 */
			$('#logined_user').on('click', function(){
				userMenu();
			});
			
			function userMenu(){
				if($('#logined_user').hasClass('focus') === true){
					$('#logined_user').removeClass('focus');
					$('#popup_user_menu_wrapper').css('display', 'none');
				}
				else {
					$('#logined_user').addClass('focus');
					$('#popup_user_menu_wrapper').css('display', 'block');
				}
			}
			
			
			
			
			
			
			
			
			
			supernav_admin_view = false;
			
			//관리자 메뉴
			$('#supernav_admin').mouseenter(function(){
				$('#supernav_admin_content').css('pointer-events', 'auto');
				$('#supernav_admin_content').css('display', 'block');
				$('#supernav_admin_content').css('opacity', '1');
				
				$('.submenu_admin').css('display', 'block');
			});
			
			$('#supernav_admin_content').mouseenter(function(){
				supernav_admin_view = true;
				$('#supernav_admin_content').css('pointer-events', 'auto');
				$('#supernav_admin_content').css('display', 'block');
				$('#supernav_admin_content').css('opacity', '1');
				
				$('.submenu_admin').css('display', 'block');
			});
		
			$('#supernav_admin_content').mouseleave(function(){
				$('#supernav_admin_content').css('pointer-events', 'none');
				$('#supernav_admin_content').css("display", "none");
				$('#supernav_admin_content').css('opacity', '0');
				
				$('.submenu_admin').css('display', 'none');
				supernav_admin_view = false;
			});
			
			$('#supernav_admin').mouseleave(function(){
				if(supernav_admin_view === true){
					$('#supernav_admin_content').css('pointer-events', 'auto');
					$('#supernav_admin_content').css('display', 'block');
					$('#supernav_admin_content').css('opacity', '1');
					
					$('.submenu_admin').css('display', 'block');				
				}
				else {
					$('#supernav_admin_content').css('pointer-events', 'none');
					$('#supernav_admin_content').css("display", "none");
					$('#supernav_admin_content').css('opacity', '0');
					
					$('.submenu_admin').css('display', 'none');
					supernav_admin_view = false;
				}
			});
			
			
			//즐겨찾기 등록 부분
			$('#favoriteBtn').on('click', function(e) { 
				var bookmarkURL = window.location.href; 
				var bookmarkTitle = document.title; 
				var triggerDefault = false; 
				if (window.sidebar && window.sidebar.addPanel) { 
					// Firefox version < 23 
					window.sidebar.addPanel(bookmarkTitle, bookmarkURL, ''); 
				} else if ((window.sidebar && (navigator.userAgent.toLowerCase().indexOf('firefox') > -1)) || (window.opera && window.print)) { 
					// Firefox version >= 23 and Opera Hotlist 
					var $this = $(this); 
					$this.attr('href', bookmarkURL); 
					$this.attr('title', bookmarkTitle); 
					$this.attr('rel', 'sidebar'); 
					$this.off(e); 
					triggerDefault = true; 
				} else if (window.external && ('AddFavorite' in window.external)) { 
					// IE Favorite 
					window.external.AddFavorite(bookmarkURL, bookmarkTitle); 
				} else { 
					// WebKit - Safari/Chrome 
					alert((navigator.userAgent.toLowerCase().indexOf('mac') != -1 ? 'Cmd' : 'Ctrl') + '+D 키를 눌러 즐겨찾기에 등록하실 수 있습니다.'); 
				} 
				return triggerDefault; 
			});
			
		});
	</script>
			
			

	<!-- header 부분 -->
	<div id="global_header">
		<div class="content">
			<!-- Stream 로고(home) -->
			<div class="logo">
				<span id="logo_holder">
					<a href="main.do">
						<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/header/globalheader_logo.png"/>" width="176" height="44">
					</a>
				</span>
			</div>

					
			<div class="supernav_container">
				<!-- 메뉴 목록 -->
				<a class="menuitem supernav" href="main.do" data-tooltip-type="selector"
				 data-tooltip-content=".submenu_store" id="supernav_store"> 상점 </a>
						
			 	<!-- 하위 메뉴 목록 -->	
			 	<div id="supernav_store_content" class="supernav_content" style="position: absolute; z-index: 1500; opacity: 0; left: 1px; top: 64px; pointer-events: none;">
					<div class="submenu_store" style="display: none;" data-submenuid="store">
						<a class="submenuitem" href="main.do">특집</a>
						<a class="submenuitem" href="#">탐색</a> 
						<c:choose>
							<c:when test="${login_chk}">
								<a class="submenuitem" href="wishlist.do">찜 목록</a>
							</c:when>
							<c:otherwise>
								<a class="submenuitem" href="login.do">찜 목록</a>
							</c:otherwise>
						</c:choose>
						<!-- <a class="submenuitem" href="news.do">뉴스</a> -->
						<a class="submenuitem" href="javascript:void(0);" onclick="alert('준비 중인 컨텐츠입니다.');">뉴스</a>
						<a class="submenuitem" href="stats.do">통계</a>
					</div>	 	
			 	</div>

				<!-- 메뉴 목록 -->
				<!-- <a class="menuitem" href="about.do">정보 </a> --> 
				<a class="menuitem" href="javascript:void(0);" onclick="alert('준비 중인 컨텐츠입니다.');" >정보 </a> 
				<a class="menuitem" href="javascript:void(0);" onclick="alert('준비 중인 컨텐츠입니다.');" >지원 </a>
				<!-- 관리자인 경우 -->
				<c:if test="${'admin' eq user.type}">
					<a class="menuitem supernav" id="supernav_admin" data-tooltip-type="selector" data-tooltip-content=".submenu_admin"> 관리 </a>
				
					<div id="supernav_admin_content" class="supernav_content" style="position: absolute; z-index: 1500; opacity: 0; right: -45px; top: 64px; pointer-events: none;">
						<div class="submenu_admin" style="display: none;" data-submenuid="admin_menu">
							<a class="submenuitem" href="manageGame.do">게임 관리</a>
							<a class="submenuitem" href="manageSale.do">할인 관리</a>
							<a class="submenuitem" href="news.do">뉴스 관리</a>
							<a class="submenuitem" href="#">판매 내역</a>
						</div>	 	
				 	</div>
				</c:if>
			</div>

			<!-- 로그인 메뉴 있는 부분 -->
			<div id="global_actions">
				<div id="global_action_menu">
					<!-- 설치 버튼(바탕화면에 즐겨찾기 추가로 대체) -->
					<div id="favoriteBtn" class="header_installstream_btn header_installstream_btn_green">
						<div class="header_installstream_btn_leftcap"></div>
						<div class="header_installstream_btn_rightcap"></div>
							
						<a class="header_installstream_btn_content"> Stream 바로가기 생성</a>
					</div>

					<!-- 로그인 여부 체크 -->
					<c:choose>
						<c:when test="${login_chk}">
							&nbsp;<a id="logined_user" class="pulldown global_action_link">${user.id}</a>
							
							<%-- href="logout.do" --%>
							<div id="popup_user_menu_wrapper" class="popup_block_new" style="visibility: visible; top: 20.5px; right: 6px; display: none; opacity: 1;">
								<div class="popup_user_menu">
									<a class="popup_user_menu_item" href="logout.do">로그아웃</a>
								</div>
								<div class="popup_user_menu">
									<a class="popup_user_menu_item" href="profilesEdit.do">프로필</a>
								</div>
								<div class="popup_user_menu">
									<a class="popup_user_menu_item" href="purchasedlist.do">구매목록</a>
								</div>
								<div class="popup_user_menu">
									<a class="popup_user_menu_item" href="cart.do">장바구니</a>
								</div>
								<div class="popup_user_menu">
									<a class="popup_user_menu_item" href="wishlist.do">찜목록</a>
								</div>
								<div class="popup_user_menu">
									<a class="popup_user_menu_item" href="reviewList.do">내 평가</a>
								</div>
							</div>
						</c:when>
						
						<c:otherwise>
							<!-- 로그인 버튼 -->
							&nbsp;<a class="global_action_link" href="login.do">로그인</a>
						</c:otherwise>
					</c:choose>
						
				</div>
			</div>
			<!-- end 로그인 메뉴 있는 부분 -->
		</div>
	</div>
	<!-- end header 부분 -->
</body>
</html>