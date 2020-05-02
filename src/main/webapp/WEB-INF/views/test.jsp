<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Stream 가상 현실 & Stream 컨트롤러</title>
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
<link href="${pageContext.request.contextPath}/resources/css/discoveryqueue.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/tags.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/contenthub.css" rel="stylesheet" type="text/css">	
<link href="${pageContext.request.contextPath}/resources/css/shared_responsive.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.8.3.min.js"/>
<!-- 다른 라이브러리와 충돌 방지를 위해 사용 -->
<script type="text/javascript">/* $J = */ jQuery.noConflict();</script>

</head>
<html>
<body class="v6 tag_page game_bg contenthub_page responsive_page">

	<div class="responsive_page_frame with_header">
		<div class="responsive_page_content">
			<jsp:include
				page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp" />

			<div id="responsive_store_nav_ctn"></div>
			<div class="responsive_page_template_content">


				<div class="contenthub_page_background "
					style="background-image: url('http://cdn.akamai.steamstatic.com/steam/apps/664090/page_bg_generated_v6b.jpg?t=1518708000');">


					<div class="page_content_ctn">

						<jsp:include
							page="${pageContext.request.contextPath}/WEB-INF/views/common/contentTopMenu.jsp" />



					</div>

					<div class="page_contenthub_content">

						<!-- Takeover click area -->

						<div class="page_content content_hub">
							<h2 class="pageheader">Steam 가상 현실</h2>
							<div class="contenthub_subtitle">HTC Vive와 Oculus Rift,
								Windows 혼합 현실 헤드셋으로 이용 가능한 VR 타이틀을 찾아보세요.</div>
						</div>

						<!-- Main Capsule Cover Flow -->
						<div class="page_header_ctn capsules">
							<div class="page_content">

								<div id="genre_large_cluster" class="carousel_container quadscreenshot_carousel">
									<div class="carousel_items store_capsule_container">
										<a href="#" class="focus">
											<div class="main">
												<img class="maincap" src="">
												<!-- 메인 이미지 외 4개 이미지 -->
												<div class="bg">
													<div background-image: url('')></div>
													<div background-image: url('')></div>
													<div background-image: url('')></div>
													<div background-image: url('')></div>
												</div>
												<div class="recommendation_reason default">
													<div><p>최고 인기 제품</p></div>												
												</div>
												<div class="appTitle">
													<h2>게임 이름</h2>
													<div class="discount_block_large">
														
														<!-- 할인 안 할 경우 -->
														<!-- 
														<div class="discount_block  no_discount">
															<div class="discount_prices">
																<div class="discount_final_price">₩ 21,000</div>
															</div>
														</div>
														 -->
														<!-- end 할인 안 할 경우 -->
														
														<!-- 할인 할 경우 -->
														<div class="discount_block ">
															<div class="discount_pct">-30%</div>
															<div class="discount_prices">
																<div class="discount_original_price">₩ 26,000</div>
																<div class="discount_final_price">₩ 20,800</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</a>
									</div>


									<div class="carousel_thumbs">
										<!-- 선택된 경우 focus 주기 -->
										<div class="focus"></div>
										<div class=""></div>
										<div class=""></div>
										<div class=""></div>
										<div class=""></div>
										<div class=""></div>
									</div>

									<div class="arrow left">
										<div></div>
									</div>
									<div class="arrow right">
										<div></div>
									</div>

								</div>

								<script>
	GStoreItemData.AddNavParams( {
		"genre_large_cluster": "1_1453_4__201"	} );

	function populate_genre_large_cluster( rgClusterItems, fnReason )
	{

		function PopulateTemplate( strTemplate, rgArguments )
		{
			var out = strTemplate;

			for( var i=0; i< rgArguments.length; i++)
			{
				var replace = "%"+(i+1)+"\\$s";
				var re = new RegExp(replace,"g");
				out = out.replace(re, rgArguments[i]);
			}

			return out;
		}

		var template = "\r\n\t\t\t<a href=\"%5$s\">\r\n\t\t\t\t\t\r\n\t\t\t\t\t<div class=\"main\">\r\n\t\t\t\t\t\t<img class=\"maincap\" src=\"%6$s\">\r\n\t\t\t\t\t\t<div class=\"bg\">\r\n\t\t\t\t\t\t\t<div style=\"background-image: url( %2$s )\"><\/div>\r\n\t\t\t\t\t\t\t<div style=\"background-image: url( %7$s )\"><\/div>\r\n\t\t\t\t\t\t\t<div style=\"background-image: url( %8$s )\"><\/div>\r\n\t\t\t\t\t\t\t<div style=\"background-image: url( %9$s )\"><\/div>\r\n\t\t\t\t\t<\/div>\r\n\t\t\t\t\t\t<div class=\"recommendation_reason %3$s\">\r\n\t\t\t\t\t\t\t%4$s\r\n\t\t\t\t\t\t<\/div>\r\n\t\t\t\t\t\t<div class=\"appTitle\">\r\n\t\t\t\t\t\t\t<h2>%1$s<\/h2>\r\n\t\t\t\t\t\t\t<div class=\"discount_block_large\">\r\n\t\t\t\t\t\t\t%10$s\r\n\t\t\t\t\t\t\t<\/div>\r\n\t\t\t\t\t\t<\/div>\r\n\r\n\t\t\t\t\t<\/div>\r\n\t\t\t\t\t\r\n\t\t\t\t\r\n\t\t\t<\/a>\r\n\t\t";
		var rec_template_curator = "\r\n\t\t\t<div>\r\n\t\t\t\t<img class=\"curator_avatar\" src=\"%1$s\">\r\n\t\t\t<\/div>\r\n\t\t\t<div>\r\n\t\t\t\t<p>\uce5c\uad6c <span>%2$s<\/span><br>\ub2d8\uc774 <strong>\ucd94\ucc9c<\/strong><\/p>\r\n\t\t\t<\/div>\r\n\t\t";
		var rec_template_default = "\r\n\t\t\t<div>\r\n\t\t\t\t<p>%1$s<\/p>\r\n\t\t\t<\/div>\r\n\t\t";


		$J.each( rgClusterItems, function(i, rgInfo ){

			var rgParams = {};
			var reason = fnReason( rgInfo );
			if ( reason && reason.reason == 'curator' )
			{
				rgParams['curator_clanid'] = reason.curator.curator.clanid;
			}

			var rgItemData = GStoreItemData.GetCapParams( "genre_large_cluster", rgInfo.appid, rgInfo.packageid, rgInfo.bundleid, rgParams );
			if( !rgItemData )
			{
				return;
			}

			if( !rgItemData.screenshots )
				rgItemData.screenshots = [];


			var rec_template;

			if( reason && reason.reason == 'curator'  )
			{
				var curationData = reason.curator;

				rec_class = 'recommended_curator';
				rec_template = rec_template_curator.replace(/%1\$s/, GetAvatarURL( curationData.curator.avatar, '_medium' ) )
					.replace(/%2\$s/, curationData.curator.name )
					.replace(/%5\$s/, rgParams.href );
			} else if( reason && reason.reason == 'tags' )
			{
				rec_class = 'default';
				if( rgItemData.video )
					strReason = "<strong>Recommended<\/strong> because you watch videos tagged with";
				else if (rgItemData.software )
					strReason = "<strong>Recommended<\/strong> because you use software tagged with";
				else
					strReason = "\ub2e4\uc74c \ud0dc\uadf8\uac00 \ubd99\uc740 \uac8c\uc784\uc744 \ud50c\ub808\uc774\ud574\uc11c <strong>\ucd94\ucc9c<\/strong>";

				strReason = strReason + '<br><span class="taglist">' + reason.tags.join('')  + '</span>';
				rec_template = rec_template_default.replace(/%1\$s/, strReason );
			}
			else
			{
				var rec_class = 'default';
				var strReason = rgInfo.status_string || '';

				if( reason && !strReason )
				{
					if( reason.reason == 'concurrent')
						strReason = "\uc778\uae30 \uc788\ub294 \uac8c\uc784\uc774\ub77c\uc11c \ucd94\ucc9c";
					else if ( reason.reason == 'top_seller' )
						strReason = "\ucd5c\uace0 \uc778\uae30 \uc81c\ud488";
					else if ( reason.reason == 'popular_new' || reason.reason == 'featured' )
						strReason = "\uc2e0\uaddc \ucd9c\uc2dc";
					else if ( reason.reason == 'specials' )
						strReason = "Recommended because it's on sale";

				}

				rec_template = rec_template_default.replace(/%1\$s/, strReason || '');

			}

			// Time for the mother of all replace() chains...
			var strHTML = PopulateTemplate(template,[
				rgItemData.name,
				rgItemData.screenshots[0] ? GetScreenshotURL( rgInfo.appid, rgItemData.screenshots[0].filename, '.600x338' ) : '',
				rec_class,
				rec_template,
				rgParams.href,
				rgItemData.main_capsule,
				rgItemData.screenshots[1] ? GetScreenshotURL( rgInfo.appid, rgItemData.screenshots[1].filename, '.600x338' ) : '',
				rgItemData.screenshots[2] ? GetScreenshotURL( rgInfo.appid, rgItemData.screenshots[2].filename, '.600x338' ) : '',
				rgItemData.screenshots[3] ? GetScreenshotURL( rgInfo.appid, rgItemData.screenshots[3].filename, '.600x338' ) : '',
				rgItemData.discount_block]
			);
			var $elCapsule = $J(strHTML);

			$J('#genre_large_cluster .carousel_items').append( $elCapsule );
			$J('#genre_large_cluster .carousel_thumbs').append( $J('<div></div>') );



		});

		CreateFadingCarousel( $J('#genre_large_cluster'), 7, false);
	};

</script>
							</div>
						</div>


						<div id="page_section_container"></div>


						<!-- Main Content -->
						<div class="page_content_ctn">
							<div class="page_content">


								<!-- tabs list -->
								<div class="leftcol sub">
									<!-- Tab Section -->
									<div class="tabarea">
										<div class="tabbar_ctn">
											<div class="tabbar store_horizontal_minislider">
												<div id="tab_select_NewReleases"
													class="tab active tab_filler">
													<div class="tab_content">인기 신제품</div>
												</div>
												<div id="tab_select_TopSellers" class="tab ">
													<div class="tab_content">최고 인기 제품</div>
												</div>
												<div id="tab_select_ConcurrentUsers" class="tab ">
													<div class="tab_content">지금 가장 많이 경험 중</div>
												</div>
												<div id="tab_select_ComingSoon" class="tab ">
													<div class="tab_content">출시 예정</div>
												</div>
											</div>
										</div>

										<div class="tab_content_ctn sub">

											<div id="tab_NewReleases_content">
												<div id="NewReleasesTable">
													<div id="NewReleasesRows">
														
														<!--  20번 반복 --> 
														<a href="해당 게임 상세 페이지" class="tab_item  " data-ds-appid="게임 번호"
															onmouseover="GameHover( this, event, 'global_hover', {&quot;type&quot;:&quot;app&quot;,&quot;id&quot;:599070,&quot;params&quot;:{&quot;bDisableHover&quot;:false},&quot;public&quot;:1,&quot;v6&quot;:1} );"
															onmouseout="HideGameHover( this, event, 'global_hover' )">
															<div class="tab_item_cap">
																<img class="tab_item_cap_img"
																	src="http://cdn.akamai.steamstatic.com/steam/apps/599070/capsule_184x69.jpg?t=1519150818">
															</div>
															<!-- 할인할 경우 -->
															<!-- 
															<div class="discount_block tab_item_discount">
																<div class="discount_pct">-33%</div>
																<div class="discount_prices">
																	<div class="discount_original_price">₩ 3,300</div>
																	<div class="discount_final_price">₩ 2,210</div>
																</div>
															</div>
															 -->
															<!-- end 할인할 경우 -->
															<!-- 무료일 경우 && 가격이 있을 경우  -->
															<div class="discount_block tab_item_discount no_discount">
																<div class="discount_prices">
																	<div class="discount_final_price">무료 or ₩ 10,500</div>
																</div>
															</div>
															<!-- end 무료일 경우 && 가격이 있을 경우  -->
															
															<div class="tab_item_content">
																<div class="tab_item_name">게임 제목</div>
																<div class="tab_item_details">
																	<!-- 운영체제 -->
																	<span class="platform_img win"></span>
																	<span class="platform_img mac"></span>
																	<span class="platform_img linux"></span>
																	<!-- 경계 나눔 -->
																	<span class="platform_img hmd_separator"></span>
																	<!-- 지원 기기 -->
																	<span title="HTC Vive" class="platform_img htcvive"></span>
																	<span title="Oculus Rift" class="platform_img oculusrift"></span>
																	<span title="Windows 혼합 현실" class="platform_img windowsmr"></span>
																	
																	<!-- 유저들이 게임에 달은 태그 -->
																	<div class="tab_item_top_tags">
																		<span class="top_tag">시뮬레이션</span><span
																			class="top_tag">, VR</span><span class="top_tag">,
																			인디</span>
																	</div>
																</div>
															</div>
															<div style="clear: both;"></div>
														</a>

													</div>
													<div class="tab_see_more" style="margin-bottom: 5px;">
														<div id="NewReleases_no_results"
															class="paged_items_no_results" style="display: none">
															검색 결과 없음</div>

														<div id="NewReleases_ctn" class="paged_items_paging" style="">
															<div class="paged_items_paging_controls"
																id="NewReleases_controls">
																<span id="NewReleases_btn_prev" class="pagebtn">&lt;</span>
																<span id="NewReleases_links"></span> <span
																	id="NewReleases_btn_next" class="pagebtn">&gt;</span>
															</div>
															<div class="paged_items_paging_summary ellipsis">
																<!-- 총 데이터 갯수 -->
																<span id="NewReleases_total">176</span>개의 결과 중에서 
																<!-- 몇 번째 부터 몇 번째 표시되는지 알려줌 -->
																<span id="NewReleases_start">1</span>-<span id="NewReleases_end">20</span>개 표시 중
															</div>
															<div style="clear: both;"></div>
														</div>
													</div>
													
													<div class="tab_see_more">
														<a class="btnv6_white_transparent btn_small_tall"
															href="#gameSearchSpecial 페이지에서 보기">
															<span>신규 출시 제품 전체 보기</span>
														</a>
													</div>
												</div>
											</div>

											<div id="tab_TopSellers_content" style="display: none;">
												<div id="TopSellersTable">
													<div id="TopSellersRows">
														<a
															href="http://store.steampowered.com/app/476700/Island_359/?snr=1_1453_4__104"
															class="tab_item  " data-ds-appid="476700"
															onmouseover="GameHover( this, event, 'global_hover', {&quot;type&quot;:&quot;app&quot;,&quot;id&quot;:476700,&quot;params&quot;:{&quot;bDisableHover&quot;:false},&quot;public&quot;:1,&quot;v6&quot;:1} );"
															onmouseout="HideGameHover( this, event, 'global_hover' )">
															<div class="tab_item_cap">
																<img class="tab_item_cap_img"
																	src="http://cdn.akamai.steamstatic.com/steam/apps/476700/capsule_184x69.jpg?t=1512524826">
															</div>
															<div class="discount_block tab_item_discount no_discount">
																<div class="discount_prices">
																	<div class="discount_final_price">₩ 20,500</div>
																</div>
															</div>
															<div class="tab_item_content">
																<div class="tab_item_name">Island 359™</div>
																<div class="tab_item_details">
																	<span class="platform_img win"></span><span
																		class="platform_img hmd_separator"></span><span
																		title="HTC Vive" class="platform_img htcvive"></span><span
																		title="Oculus Rift" class="platform_img oculusrift"></span>
																	<div class="tab_item_top_tags">
																		<span class="top_tag">Early Access</span><span
																			class="top_tag">, 액션</span><span class="top_tag">,
																			어드벤처</span><span class="top_tag">, 공룡</span>
																	</div>
																</div>
															</div>
															<div style="clear: both;"></div>
														</a> <a
															href="http://store.steampowered.com/app/382110/Virtual_Desktop/?snr=1_1453_4__104"
															class="tab_item  " data-ds-appid="382110"
															onmouseover="GameHover( this, event, 'global_hover', {&quot;type&quot;:&quot;app&quot;,&quot;id&quot;:382110,&quot;params&quot;:{&quot;bDisableHover&quot;:false},&quot;public&quot;:1,&quot;v6&quot;:1} );"
															onmouseout="HideGameHover( this, event, 'global_hover' )">
															<div class="tab_item_cap">
																<img class="tab_item_cap_img"
																	src="http://cdn.akamai.steamstatic.com/steam/apps/382110/capsule_184x69.jpg?t=1513728802">
															</div>
															<div class="discount_block tab_item_discount no_discount">
																<div class="discount_prices">
																	<div class="discount_final_price">₩ 16,000</div>
																</div>
															</div>
															<div class="tab_item_content">
																<div class="tab_item_name">Virtual Desktop</div>
																<div class="tab_item_details">
																	<span class="platform_img win"></span><span
																		class="platform_img hmd_separator"></span><span
																		title="HTC Vive" class="platform_img htcvive"></span><span
																		title="Oculus Rift" class="platform_img oculusrift"></span><span
																		title="Windows 혼합 현실" class="platform_img windowsmr"></span>
																	<div class="tab_item_top_tags">
																		<span class="top_tag">유틸리티</span><span class="top_tag">,
																			VR</span>
																	</div>
																</div>
															</div>
															<div style="clear: both;"></div>
														</a>
													</div>
													<div class="tab_see_more" style="margin-bottom: 5px;">
														<div id="TopSellers_no_results"
															class="paged_items_no_results" style="display: none">
															검색 결과 없음</div>

														<div id="TopSellers_ctn" class="paged_items_paging"
															style="">
															<div class="paged_items_paging_controls"
																id="TopSellers_controls">
																<span id="TopSellers_btn_prev" class="pagebtn">&lt;</span>
																<span id="TopSellers_links"></span> <span
																	id="TopSellers_btn_next" class="pagebtn">&gt;</span>
															</div>
															<div class="paged_items_paging_summary ellipsis">
																<span id="TopSellers_total">59</span>개의 결과 중에서 <span
																	id="TopSellers_start">1</span>-<span
																	id="TopSellers_end">20</span>개 표시 중
															</div>
															<div style="clear: both;"></div>
														</div>
													</div>
													<div class="tab_see_more">
														<a class="btnv6_white_transparent btn_small_tall"
															href="#gameSearchSpecial 페이지에서 보기">
															<span>최고 인기 제품 모두 보기</span>
														</a>
													</div>
												</div>
											</div>


											<!-- 지금 가장 많이 경험 중 탭 -->
											<div id="tab_ConcurrentUsers_content" style="display: none;">
												<div id="ConcurrentUsersTable">
													<div id="ConcurrentUsersRows">
														<a
															href="http://store.steampowered.com/app/611660/Fallout_4_VR/?snr=1_1453_4__1454"
															class="tab_item  " data-ds-appid="611660"
															onmouseover="GameHover( this, event, 'global_hover', {&quot;type&quot;:&quot;app&quot;,&quot;id&quot;:611660,&quot;params&quot;:{&quot;bDisableHover&quot;:false},&quot;public&quot;:1,&quot;v6&quot;:1} );"
															onmouseout="HideGameHover( this, event, 'global_hover' )">
															<div class="tab_item_cap">
																<img class="tab_item_cap_img"
																	src="http://cdn.akamai.steamstatic.com/steam/apps/611660/capsule_184x69.jpg?t=1515710133">
															</div>
															<div class="discount_block tab_item_discount no_discount">
																<div class="discount_prices">
																	<div class="discount_final_price">₩ 69,000</div>
																</div>
															</div>
															<div class="tab_item_content">
																<div class="tab_item_name">Fallout 4 VR</div>
																<div class="tab_item_details">
																	<span class="platform_img win"></span><span
																		class="platform_img hmd_separator"></span><span
																		title="HTC Vive" class="platform_img htcvive"></span>
																	<div class="tab_item_top_tags">
																		<span class="top_tag">VR</span><span class="top_tag">,
																			롤 플레잉</span><span class="top_tag">, 오픈 월드</span><span
																			class="top_tag">, 포스트아포칼립스</span>
																	</div>
																</div>
															</div>
															<div style="clear: both;"></div>
														</a>  <a
															href="http://store.steampowered.com/app/748370/STAND_OUT__VR_Battle_Royale/?snr=1_1453_4__1454"
															class="tab_item  " data-ds-appid="748370"
															onmouseover="GameHover( this, event, 'global_hover', {&quot;type&quot;:&quot;app&quot;,&quot;id&quot;:748370,&quot;params&quot;:{&quot;bDisableHover&quot;:false},&quot;public&quot;:1,&quot;v6&quot;:1} );"
															onmouseout="HideGameHover( this, event, 'global_hover' )">
															<div class="tab_item_cap">
																<img class="tab_item_cap_img"
																	src="http://cdn.akamai.steamstatic.com/steam/apps/748370/capsule_184x69.jpg?t=1518488328">
															</div>
															<div class="discount_block tab_item_discount no_discount">
																<div class="discount_prices">
																	<div class="discount_final_price">₩ 26,000</div>
																</div>
															</div>
															<div class="tab_item_content">
																<div class="tab_item_name">STAND OUT : VR Battle
																	Royale</div>
																<div class="tab_item_details">
																	<span class="platform_img win"></span><span
																		class="platform_img hmd_separator"></span><span
																		title="HTC Vive" class="platform_img htcvive"></span><span
																		title="Oculus Rift" class="platform_img oculusrift"></span><span
																		title="Windows 혼합 현실" class="platform_img windowsmr"></span>
																	<div class="tab_item_top_tags">
																		<span class="top_tag">Early Access</span><span
																			class="top_tag">, 대규모 멀티플레이어</span><span
																			class="top_tag">, 액션</span><span class="top_tag">,
																			시뮬레이션</span>
																	</div>
																</div>
															</div>
															<div style="clear: both;"></div>
														</a>
													</div>
													<div class="tab_see_more" style="margin-bottom: 5px;">
														<div id="ConcurrentUsers_no_results"
															class="paged_items_no_results" style="display: none">
															검색 결과 없음</div>

														<div id="ConcurrentUsers_ctn" class="paged_items_paging"
															style="">
															<div class="paged_items_paging_controls"
																id="ConcurrentUsers_controls">
																<span id="ConcurrentUsers_btn_prev" class="pagebtn">&lt;</span>
																<span id="ConcurrentUsers_links"></span> <span
																	id="ConcurrentUsers_btn_next" class="pagebtn">&gt;</span>
															</div>
															<div class="paged_items_paging_summary ellipsis">
																<span id="ConcurrentUsers_total">926</span>개의 결과 중에서 <span
																	id="ConcurrentUsers_start">1</span>-<span
																	id="ConcurrentUsers_end">20</span>개 표시 중
															</div>
															<div style="clear: both;"></div>
														</div>
													</div>
													<div class="tab_see_more">
														<a class="btnv6_white_transparent btn_small_tall"
															href="http://store.steampowered.com/search/?vrsupport=402">
															<span>역대 최고 인기 제품 보기</span>
														</a>
													</div>
												</div>
											</div>


											<!-- 출시 예정 탭 -->
											<div id="tab_ComingSoon_content" style="display: none;">
												<div id="ComingSoonTable">
													<div id="ComingSoonRows">
														<a
															href="http://store.steampowered.com/app/775990/Overduty_VR_Battle_Royale/?snr=1_1453_4__105"
															class="tab_item  " data-ds-appid="775990"
															onmouseover="GameHover( this, event, 'global_hover', {&quot;type&quot;:&quot;app&quot;,&quot;id&quot;:775990,&quot;params&quot;:{&quot;bDisableHover&quot;:false},&quot;public&quot;:1,&quot;v6&quot;:1} );"
															onmouseout="HideGameHover( this, event, 'global_hover' )">
															<div class="tab_item_cap">
																<img class="tab_item_cap_img"
																	src="http://cdn.akamai.steamstatic.com/steam/apps/775990/capsule_184x69.jpg?t=1518023322">
															</div>
															<div class="discount_block empty tab_item_discount"></div>
															<div class="tab_item_content">
																<div class="tab_item_name">Overduty VR: Battle
																	Royale</div>
																<div class="tab_item_details">
																	<span class="platform_img win"></span><span
																		class="platform_img hmd_separator"></span><span
																		title="HTC Vive" class="platform_img htcvive"></span><span
																		title="Oculus Rift" class="platform_img oculusrift"></span>
																	<div class="tab_item_top_tags">
																		<span class="top_tag">Early Access</span><span
																			class="top_tag">, 액션</span><span class="top_tag">,
																			대규모 멀티플레이어</span><span class="top_tag">, 고어</span>
																	</div>
																</div>
															</div>
															<div style="clear: both;"></div>
														</a> <a
															href="http://store.steampowered.com/app/619550/Vision/?snr=1_1453_4__105"
															class="tab_item  " data-ds-appid="619550"
															onmouseover="GameHover( this, event, 'global_hover', {&quot;type&quot;:&quot;app&quot;,&quot;id&quot;:619550,&quot;params&quot;:{&quot;bDisableHover&quot;:false},&quot;public&quot;:1,&quot;v6&quot;:1} );"
															onmouseout="HideGameHover( this, event, 'global_hover' )">
															<div class="tab_item_cap">
																<img class="tab_item_cap_img"
																	src="http://cdn.akamai.steamstatic.com/steam/apps/619550/capsule_184x69.jpg?t=1519430285">
															</div>
															<div class="discount_block tab_item_discount no_discount">
																<div class="discount_prices">
																	<div class="discount_final_price">무료</div>
																</div>
															</div>
															<div class="tab_item_content">
																<div class="tab_item_name">Vision</div>
																<div class="tab_item_details">
																	<span class="platform_img win"></span><span
																		class="platform_img hmd_separator"></span><span
																		title="HTC Vive" class="platform_img htcvive"></span><span
																		title="Oculus Rift" class="platform_img oculusrift"></span>
																	<div class="tab_item_top_tags">
																		<span class="top_tag">인디</span><span class="top_tag">,
																			캐주얼</span><span class="top_tag">, 시뮬레이션</span>
																	</div>
																</div>
															</div>
															<div style="clear: both;"></div>
														</a>
													</div>
													<div class="tab_see_more" style="margin-bottom: 5px;">
														<div id="ComingSoon_no_results"
															class="paged_items_no_results" style="display: none">
															검색 결과 없음</div>

														<div id="ComingSoon_ctn" class="paged_items_paging"
															style="">
															<div class="paged_items_paging_controls"
																id="ComingSoon_controls">
																<span id="ComingSoon_btn_prev" class="pagebtn">&lt;</span>
																<span id="ComingSoon_links"></span> <span
																	id="ComingSoon_btn_next" class="pagebtn">&gt;</span>
															</div>
															<div class="paged_items_paging_summary ellipsis">
																<span id="ComingSoon_total">141</span>개의 결과 중에서 <span
																	id="ComingSoon_start">1</span>-<span
																	id="ComingSoon_end">20</span>개 표시 중
															</div>
															<div style="clear: both;"></div>
														</div>
													</div>
													<div class="tab_see_more">
														<a class="btnv6_white_transparent btn_small_tall"
															href="#gameSearchSpecial 페이지에서 보기">
															<span>모든 출시 예정작 보기</span>
														</a>
													</div>
												</div>
											</div>

										</div>
									</div>
									<!-- End Tab Section -->
								</div>

								<!-- right rail -->
								<div class="rightcol small">


									
									<div class="contenthub_spotlight_container">
										<h2>스포트라이트</h2>
								
										<div class="spotlight_block">
											<div class="spotlight_scroll_ctn home_block	" id="spotlight_scroll">
												<div class="home_area_spotlight underlined_links" id="spotlight_0" style="" >
													<a href="http://store.steampowered.com/search/?filter=weeklongdeals">
														<div class="spotlight_weeklong_ctn">
															<div class="spotlight_text_overlay" style="background-image: url('../../resources/public/shared/images/default/weeklong_spotlight_text_overlay.png')"></div>
															<span class="spotlight_count">이번 주 세일 중인 제품</span>
														</div>
														<div class="spotlight_weeklong_subtitle">매주 월요일에 새로운 특가</div>
													</a>
												</div>
											</div>
										</div>
										<div style="clear: both; margin-bottom: 20px;"></div>
									</div>
									

									<!-- 카테고리 검색 검색 시 gameSearchSpecial 페이지로 -->
									<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/categories/vr.jsp"/>
									<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/categories/controller.jsp"/>
									
									
									

									<!-- recommend specials -->
									<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/recommendSpecials.jsp"/>
									
									
									<!-- 묶음 판매는 아마 시간 상 불가 -->
									<!-- 
									<h2>특집 꾸러미</h2>
									<div class="contenthub_featured_item_spotlight">
										<a data-ds-bundleid="4994"
											data-ds-bundle-data="{&quot;m_nDiscountPct&quot;:&quot;30&quot;,&quot;m_bMustPurchaseAsSet&quot;:0,&quot;m_rgItems&quot;:[{&quot;m_nPackageID&quot;:115021,&quot;m_rgIncludedAppIDs&quot;:[501110],&quot;m_bPackageDiscounted&quot;:true,&quot;m_nBasePriceInCents&quot;:1550000,&quot;m_nFinalPriceInCents&quot;:775000,&quot;m_nFinalPriceWithBundleDiscount&quot;:543000},{&quot;m_nPackageID&quot;:195490,&quot;m_rgIncludedAppIDs&quot;:[683790],&quot;m_bPackageDiscounted&quot;:true,&quot;m_nBasePriceInCents&quot;:1050000,&quot;m_nFinalPriceInCents&quot;:525000,&quot;m_nFinalPriceWithBundleDiscount&quot;:368000}],&quot;m_bIsCommercial&quot;:false,&quot;m_bRestrictGifting&quot;:true}"
											onmouseover="GameHover( this, event, 'global_hover', {&quot;type&quot;:&quot;bundle&quot;,&quot;id&quot;:&quot;4994&quot;,&quot;public&quot;:1,&quot;v6&quot;:1} );"
											onmouseout="HideGameHover( this, event, 'global_hover' )"
											class="store_capsule " data-ds-appid="4994"
											href="http://store.steampowered.com/bundle/4994/NWS_Action_Sports_Bundle/?snr=1_1453_4__1463"><div
												class="capsule headerratio">
												<img
													src="http://cdn.akamai.steamstatic.com/steam/bundles/4994/xcxx4rvp2ugwqc9b/header_292x136.jpg?t=1508071895">
											</div>
											<div class="contenthub_featured_item">판매 중</div>
											<div
												class="discount_block discount_block_inline discount_collapse_final_price">
												<div class="bundle_base_discount">-30%</div>
												<div class="discount_pct">-65%</div>
												<div class="discount_prices">
													<div class="discount_original_price">₩ 26,000</div>
													<div class="discount_final_price">₩ 9,110</div>
												</div>
											</div></a>
									</div>
									-->
									

								</div>

								<div class="hover game_hover" id="global_hover"
									style="display: none; left: 0; top: 0;">
									<div class="game_hover_box hover_box">
										<div class="content" id="global_hover_content"></div>
									</div>
									<div class="hover_arrow_left"></div>
									<div class="hover_arrow_right"></div>
								</div>
							</div>
						</div>

						<!-- page_contenthub_content -->
					</div>

					<!-- End Main Background -->
				</div>

				<!-- clear everything for the footer -->
				<div style="clear: both;"></div>

			</div>

			<!-- Footer -->
			<jsp:include
				page="${pageContext.request.contextPath}/WEB-INF/views/common/footer.jsp" />
			<!-- end Footer -->

		</div>

	</div>
</body>
</html>