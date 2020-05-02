<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<body>
	<script>
		$(document).ready(function(){
			//게임 선택 부분
			//var selectedGame = $('#tab_newreleases_content').children('a');
			$('#game_tab > .tab_content > a').mouseenter(function(){	
				$('.home_tabs_content > .tab_content > a').removeClass('focus');
				$(this).addClass('focus');
			});
			$('#game_tab > .tab_content > a').mouseleave(function(){
				$(this).addClass('focus');
			});
			
			$('#game_tab > .tab_content > a').mouseenter(function(){
				supernav_view = true;
				$('.supernav_content').css('pointer-events', 'auto');
				$('.supernav_content').css('display', 'block');
				$('.submenu_store').css('display', 'block');
			});
			
			/* 
			$('#tab_newreleases_content > a').mouseenter(function(){	
				$('#tab_newreleases_content > a').removeClass('focus');
				$(this).addClass('focus');
			});
			$('#tab_newreleases_content > a').mouseleave(function(){
				$(this).addClass('focus');
			});
			
			$('#tab_newreleases_content').mouseenter(function(){
				supernav_view = true;
				$('.supernav_content').css('pointer-events', 'auto');
				$('.supernav_content').css('display', 'block');
				$('.submenu_store').css('display', 'block');
			});
			 */
			
			//if($("#tab_newreleases_content").children('a').hasClass("focus") //=== true) {
			
			//}
			
			
			//탭 선택 이벤트
			$('#main_recommend_game > div').on('click', function (){
				$('#main_recommend_game > div').removeClass('active');
				$(this).addClass('active');
				
				var selectedDiv = $(this).children('.main_tab_content').html();
				$('.home_tabs_content > .tab_content').css('display','none');
				$('.home_tabs_content > div > a').removeClass('focus');
				
				if(selectedDiv === '인기 신제품'){	
					$('.home_tabs_content > #tab_newreleases_content').css('display','');
					$('.home_tabs_content > #tab_newreleases_content > a').first().addClass('focus');
					
				}
				else if(selectedDiv === '최고 인기 제품'){
					$('.home_tabs_content > #tab_topsellers_content').css('display','');
					$('.home_tabs_content > #tab_topsellers_content > a').first().addClass('focus');
				} 
				else if(selectedDiv === '출시 예정'){
					$('.home_tabs_content > #tab_topsellers_content').css('display','');
				}
				else if(selectedDiv === '특별 할인'){
					$('.home_tabs_content > #tab_topsellers_content').css('display','');
				}
			});
			
			
			$('#main_recommend_game > .home_tab > .main_tab_content').mouseover(function(){
				$(this).css('color','');
			})
			
			
			/*  
			function HomeTabSelect(tab, selectedDiv){
				$('.home_tabs_content > .tab_content').removeClass('focus');
				$(selectedDiv).addClass('focus');
			}
 			*/
		});
	</script>

	<!-- 탭 부분 -->
	<div class="home_ctn tab_container" style="overflow: visible;">
		<div class="home_page_content" style="padding-left: 234px;">
			<div class="home_leftcol home_tab_col">

				<div class="home_tabs_row_ctn">
					<div class="home_tabs_row store_horizontal_minislider" id="main_recommend_game">
						<!-- 선택된 경우 클래스 추가 active -->
						<div id="tab_newreleases_content_trigger"
							class="home_tab active" data-usability="5">
							<div class="main_tab_content">인기 신제품</div>
						</div>
						<div id="tab_topsellers_content_trigger"
							class="home_tab" data-usability="6">
							<div class="main_tab_content">최고 인기 제품</div>
						</div>
						<div id="tab_upcoming_content_trigger"
							class="home_tab" data-usability="7">
							<div class="main_tab_content">출시 예정</div>
						</div>
						<div id="tab_specials_content_trigger"
							class="home_tab" data-usability="8">
							<div class="main_tab_content">특별 할인</div>
						</div>
					</div>
				</div>
				<input id="last_tab" type="hidden" value="">



				<div class="home_tabs_content" id="game_tab">

					<!-- 게임 리스트 탭 1-->
					<div class="tab_content" id="tab_newreleases_content">
						<c:forEach begin="0" end="4">
							<a href="해당 게임 상세 페이지" class="tab_item app_impression_tracked focus" data-ds-appid="게임 번호">
								<div class="tab_item_cap">
									<img class="tab_item_cap_img" src="이미지">
								</div>
								<div class="discount_block tab_item_discount">
									<div class="discount_pct">-75%</div>
									<div class="discount_prices">
										<div class="discount_original_price">₩ 10,500</div>
										<div class="discount_final_price">₩ 2,620</div>
									</div>
								</div>
	
								<div class="tab_item_content">
									<div class="tab_item_name">게임 이름</div>
									<div class="tab_item_details">
										<span class="platform_img win"></span><span
											class="platform_img mac"></span>
										<div class="tab_item_top_tags">
											<span class="top_tag">게임 태그</span><span class="top_tag">,
												게임 태그</span><span class="top_tag">, 게임 태그 </span><span
												class="top_tag">, 게임 태그</span>
										</div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</a>
	
							<!-- 예시  선택되면 focus 클래스 주기-->
							<a href="http://store.steampowered.com/app/379430/Kingdom_Come_Deliverance/?snr=1_4_4__tab-PopularNewReleases"
								class="tab_item app_impression_tracked" data-ds-appid="379430">
								<div class="tab_item_cap">
									<img class="tab_item_cap_img"
										src="http://cdn.akamai.steamstatic.com/steam/apps/379430/capsule_184x69.jpg?t=1518704264">
								</div>
								<div class="discount_block tab_item_discount no_discount">
									<div class="discount_prices">
										<div class="discount_final_price">₩ 65,000</div>
									</div>
								</div>
								<div class="tab_item_content">
									<div class="tab_item_name">Kingdom Come: Deliverance</div>
									<div class="tab_item_details">
										<span class="platform_img win"></span>
										<div class="tab_item_top_tags">
											<span class="top_tag">중세</span><span class="top_tag">,
												롤 플레잉</span><span class="top_tag">, 오픈 월드</span><span
												class="top_tag">, 현실적</span>
										</div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</a>
						</c:forEach>
						
						
						<div class="tab_see_more">
							더 보기: <a
								href="http://store.steampowered.com/search/?specials=1&os=win&snr=1_4_4__tabsmore"
								class="btnv6_white_transparent btn_small_tall"> <span>신규 출시</span>
							</a>
						</div>
					</div>
					<!-- end 게임 리스트 탭 1-->
					
					
					
					
					<!-- 게임 리스트 탭 -->
					<div class="tab_content" id="tab_topsellers_content" style="display: none;">
						<c:forEach begin="0" end="4">
							<a href="해당 게임 상세 페이지" class="tab_item app_impression_tracked" data-ds-appid="게임 번호">
								<div class="tab_item_cap">
									<img class="tab_item_cap_img" src="이미지">
								</div>
								<div class="discount_block tab_item_discount">
									<div class="discount_pct">-75%</div>
									<div class="discount_prices">
										<div class="discount_original_price">₩ 10,500</div>
										<div class="discount_final_price">₩ 2,620</div>
									</div>
								</div>
	
								<div class="tab_item_content">
									<div class="tab_item_name">게임 이름</div>
									<div class="tab_item_details">
										<span class="platform_img win"></span><span
											class="platform_img mac"></span>
										<div class="tab_item_top_tags">
											<span class="top_tag">게임 태그</span><span class="top_tag">,
												게임 태그</span><span class="top_tag">, 게임 태그 </span><span
												class="top_tag">, 게임 태그</span>
										</div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</a>
	
							<!-- 예시  선택되면 focus 클래스 주기-->
							<a href="http://store.steampowered.com/app/379430/Kingdom_Come_Deliverance/?snr=1_4_4__tab-PopularNewReleases"
								class="tab_item app_impression_tracked" data-ds-appid="379430">
								<div class="tab_item_cap">
									<img class="tab_item_cap_img"
										src="http://cdn.akamai.steamstatic.com/steam/apps/379430/capsule_184x69.jpg?t=1518704264">
								</div>
								<div class="discount_block tab_item_discount no_discount">
									<div class="discount_prices">
										<div class="discount_final_price">₩ 65,000</div>
									</div>
								</div>
								<div class="tab_item_content">
									<div class="tab_item_name">Kingdom Come: Deliverance</div>
									<div class="tab_item_details">
										<span class="platform_img win"></span>
										<div class="tab_item_top_tags">
											<span class="top_tag">중세</span><span class="top_tag">,
												롤 플레잉</span><span class="top_tag">, 오픈 월드</span><span
												class="top_tag">, 현실적</span>
										</div>
									</div>
								</div>
								<div style="clear: both;"></div>
							</a>
						</c:forEach>
						
						
						<div class="tab_see_more">
							더 보기: <a
								href="http://store.steampowered.com/search/?specials=1&os=win&snr=1_4_4__tabsmore"
								class="btnv6_white_transparent btn_small_tall"> <span>최고 인기 제품</span>
							</a>
						</div>
					</div>



				</div>
				<div data-usability-scroll="80"></div>
			</div>


			<!-- 게임 상세 설명 보여지는 곳-->
			<div class="home_rightcol">
				<div id="tab_preview_container">
					<!-- 게임 갯수 만큼 div 생성 (여기도 보여지는 곳은 class="focus")-->
					<div class="tab_preview focus">
						<h2>게임 제목</h2>
						
						<div class="tab_review_summary" data-tooltip-content="게임 평가">
							<div class="title">전반적 사용자 평가:</div>
							<span class="game_review_summary mixed">평가 전체적인 분위기</span>
							<span>&nbsp;(구매 평가 갯수)</span>
						</div>
						
						<div class="tags">
							<a href="태그 관련 게임 검색">태그</a>
						</div>
						
						<!-- data-background-image-url="이미지(600x338.jpg)" 없어도 되는듯... -->
						<c:forEach begin="1" end="3">
						<div class="screenshot" style="background-image: url('${pageContext.request.contextPath}/resources/game/civili_test.jpg');" data-background-image-url="이미지(600x338.jpg)"></div>
						</c:forEach>
						<div class="screenshot" style="background-image: url('이미지(600x338.jpg)');" data-background-image-url="이미지(600x338.jpg)"></div>
						
					</div>
				</div>
			</div>
			
			<!-- 화면 clear -->
			<div style="clear: both;"></div>
			<!-- end 게임 상세 설명 보여지는 곳-->
		</div>
	</div>
	<!-- end 탭 부분 -->
</body>
</html>