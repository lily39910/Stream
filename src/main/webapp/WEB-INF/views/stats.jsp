<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Stream: Game and Player Statistics</title>
<link class="include" rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/jqplot/jquery.jqplot.min.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js" />
<script type="text/javascript"> /* $J =  */jQuery.noConflict(); </script>
<link class="include" rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/jqplot/jquery-ui/css/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/jqplot/jqplot.css" />
<link href="${pageContext.request.contextPath}/resources/css/motiva_sans.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/shared_global.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/buttons.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/store.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/styles_stats.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/shared_responsive.css" rel="stylesheet" type="text/css">


<script class="code" type="text/javascript">
	//날짜형 변환
	function getDateStr(myDate){
		var dd = myDate.getDate();
		var mm = myDate.getMonth()+1; //January is 0!
		var yyyy = myDate.getFullYear();
		if(dd<10) {
		    dd='0'+dd;
		} 
		if(mm<10) {
		    mm='0'+mm;
		}
		return yyyy + '-' + mm + '-' + dd;
	}
	
	//오늘
	function today(){
		var d = new Date();
		return getDateStr(d);
	}
	
	//1주일 전
	function lastWeek() {
		var d = new Date();
		var dayOfMonth = d.getDate();
		d.setDate(dayOfMonth - 6);
		return getDateStr(d);
	}

	
	
	$(document).ready(function() {
		$.jqplot._noToImageButton = true;
		
		var userConn = [["2018-03-02", 1]]; //가짜 값
		
		$.ajax({
			url: '/StreamAjax/weekVistCount',
			type: 'get',
			dataType: 'json',
			success: function(data){
				if(JSON.stringify(data) === null){ //검색된 데이터가 없을 경우
					alert('기록이 없습니다.');
				}
				else {
					$.each(data, function(index, data) {
						if(index == 0){
							userConn.splice(index, 1, ['"20'+(this['days']).substr(0,8)+'"', this['count']]);
						}
						else {
							if(index == 6) {
								$('#todayCount').html(this['count']);
							}
							userConn.splice(index, 0, ['"20'+this['days'].substr(0,8)+'"', this['count']]);
						}
					});
					//그래프 그리기
					var plot1 = $.jqplot("chart1", [ userConn ], {
						seriesColors : [ "#589fc9" ],
						// 마우스 접근시 나타나는 정보 옵션
						highlighter : {
							show : true,
							sizeAdjust : 1,
							tooltipOffset : 9
						},
						//배경 정보
						grid : {
							background : '#232628', //그래프 배경 /*'rgba(57,57,57,0.0)'*/
							drawBorder : false,
							shadow : false,
							gridLineColor : '#292b2c', //그래프 뒤 수치 경계선 /*'#666666'*/
							gridLineWidth : 2
						},
						//선 정보
						legend : {
							show : true,
							placement : 'insideGrid',
							location : 'sw' //남쪽, 서쪽
						},
						//그리기 이벤트(동적)
						seriesDefaults : {
							rendererOptions : {
								smooth : true,
								animation : {
									show : true
								}
							},
							showMarker : false
						},
						series : [ {
							//fill: true,
							label : 'Stream users logged in'
						}, ],
						//(기본)x축 y축(안 보이게)
						axesDefaults : {
							rendererOptions : {
								baselineWidth : 1.5,
								baselineColor : '#444444',
								drawBaseline : false
							}
						},
						axes : {
							//가로축
							xaxis : {
								renderer : $.jqplot.DateAxisRenderer,
								tickRenderer : $.jqplot.CanvasAxisTickRenderer,
								tickOptions : {
									// X축의 글자 형식 설정 (년/월/일 시:분 으로 표기 - %y/%m/%d )
						            formatString:'  %y년 %m월 %d일',
									//formatString : "%b %e", //월, 일
									angle : -90,
									textColor : '#dddddd'
								},
								min : lastWeek(),
								max : today(),
								tickInterval : "1 day",
								drawMajorGridlines : false
							},
							//세로축
							yaxis : {
								//renderer: $.jqplot.LogAxisRenderer,
								min : 0,
								pad : 0,
								/* 
								rendererOptions : {
									minorTicks : 3
								},
								 */
								tickOptions : {
									formatString : "%d명", //인원
									showMark : false
								}
							}
						}
					});

					$('.jqplot-highlighter-tooltip').addClass('ui-corner-all');
				}
			},
			error: function(){
				//alert('error');
			}
		});
		
		//게임 순위 전부 보기(펼치기)
		$('#detailLink').on('click', function(){
			$('tr.player_count_row').css('display','');
			$('#more_player_count_link').hide();
		});
	});
	
	function consider(){
		 alert('준비 중인 컨텐츠입니다.');
	}
	
	
	
</script>

<!-- Don't touch this! -->
<script class="include" type="text/javascript" src="${pageContext.request.contextPath}/resources/jqplot/jquery.jqplot.min.js"></script>
<!-- End Don't touch this! -->

<!-- Additional plugins go here -->
<script class="include" type="text/javascript" src="${pageContext.request.contextPath}/resources/jqplot/plugins/jqplot.dateAxisRenderer.min.js"></script>
<script class="include" type="text/javascript" src="${pageContext.request.contextPath}/resources/jqplot/plugins/jqplot.logAxisRenderer.min.js"></script>
<script class="include" type="text/javascript" src="${pageContext.request.contextPath}/resources/jqplot/plugins/jqplot.canvasTextRenderer.min.js"></script>
<script class="include" type="text/javascript" src="${pageContext.request.contextPath}/resources/jqplot/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
<script class="include" type="text/javascript" src="${pageContext.request.contextPath}/resources/jqplot/plugins/jqplot.highlighter.min.js"></script>
<!-- End additional plugins -->

</head>

<body class="v6 responsive_page">
	<div class="responsive_page_frame with_header">
		<div class="responsive_page_content">
			<!-- header -->
			<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp"/>
			<div id="responsive_store_nav_ctn"></div>
			<div class="responsive_page_template_content">
				<div class="page_header_ctn search">
					<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/contentTopMenu.jsp"/>
					<div class="page_content">
						<div class="breadcrumbs">
							<a href="stats.do">Stream 통계</a>
						</div>
						<h2 class="pageheader">
							Stream &amp; 게임 통계 <span class="statsTopSmall secondary_text">업데이트됨</span>
						</h2>

						<div class="">
							<p class="body_text">
								Stream에서 저희의 지속적인 목적은 고객 여러분께 제공하는 서비스를 개선하기 위함입니다. 저희는 이 데이터를
								공유함으로써 사전에 문제를 식별하여 더 효율적으로 Stream 서비스를 개선하고 궁극적으로 더 나은 제품 및 경험을
								만들기 위함입니다. 어떻게 생각하시는지 <a style="cursor: pointer;" onClick="consider();">저희에게 알려주세요.</a>
							</p>
							<br>
							<div class="block">
								<div class="block_header">
									<div>
										Stream 사용자 접속 기록 <span id="community_activity_note" class="header_inline">(최근 7일간)</span>
									</div>
								</div>
								
								<!-- 그래프 -->
								<div class="block_content block_content_inner dark">
									<div class="chart_center">
										<div id="chartlegendUsers" class="chartLegend"></div>
										<div id="chartdivUsers" class="chartdiv">
											<!-- 그래프 출력 부분 --> 
											<div class="ui-widget ui-corner-all">
												<div class="ui-widget-content ui-corner-bottom">
													<div id="chart1"></div>
												</div>
											</div>
											<!-- end 그래프 출력 부분 -->
										</div>
									</div>
									<div class="statsTop">
										<table class="users_count_table" border="0" cellspacing="0" cellpadding="5">
											<tr>
												<td align="left">&nbsp;</td>
												<td align="right">오늘</td>
												<td align="right">총계</td>
												<td>&nbsp;</td>
											</tr>
											<tr>
												<td class="users_label" align="left">접속한 Stream 사용자:</td>
												<td class="users_count" align="right">
													<span id="todayCount" class="statsTopHi">오늘 접속한 인원</span>
												</td>
												<td class="users_count" align="right">
													<span class="statsTopHi">${totalCount}</span>
												</td>
												<td>&nbsp;</td>
											</tr>
										</table>
									</div>
								</div>
								<!-- end 그래프 -->
								
							</div>
						</div>
					</div>
				</div>


				<div class="page_content">

					<div class="rightcol stats_links">
						<div class="block">
							<div class="block_header">
								<div>Stream 하드웨어 및 소프트웨어 설문조사</div>
							</div>
							<div class="block_content block_content_inner">
								<a class="linkbar" onClick="consider();">Stream 하드웨어 및 소프트웨어 설문조사</a>
							</div>
						</div>
						<div class="block">
							<div class="block_header">
								<div>Stream 통계</div>
							</div>
							<div class="block_content block_content_inner">
								<a class="linkbar" onClick="consider();">Stream 다운로드 통계</a>
							</div>
							<div class="block_content block_content_inner">
								<a class="linkbar" onClick="consider();">Stream 고객지원 통계</a>
							</div>
						</div>
					</div>
					<div class="topgames_col">
						<div class="block">
							<div class="block_header">
								<div>현재 가장 플레이어 수가 많은 게임</div>
							</div>
							<div class="block_content block_content_inner">

								<div id="detailStats">
									<table>
										<tr>
											<td align="right"><b>현재 플레이어</b></td>
											<td align="right" style="padding-left: 12px"><b>오늘 최고 기록</b></td>
											<td width="20">&nbsp;</td>
											<td align="left"><b>게임</b></td>
										</tr>
										<tr>
											<td colspan="5">&nbsp;</td>
										</tr>
										<tr class="player_count_row" style="">
											<td align="right"><span class="currentServers">302,090</span></td>
											<td align="right"><span class="currentServers">601,629</span></td>
											<td width="20">&nbsp;</td>
											<td>
												<a class="gameLink"
													onmouseover="GameHover( this, event, 'global_hover', {&quot;type&quot;:&quot;app&quot;,&quot;id&quot;:570,&quot;public&quot;:1,&quot;v6&quot;:1} );"
													onmouseout="HideGameHover( this, event, 'global_hover' )"
													href="#게임 페이지">Dota 2
												</a>
											</td>
										</tr>
										
										
										
										
										<!-- 게임 모두 보기 선택 시 보여지게... -->
										<tr class="player_count_row" style="display: none;">
											<td align="right"><span class="currentServers">9,164</span>
											</td>
											<td align="right"><span class="currentServers">12,141</span>
											</td>
											<td width="20">&nbsp;</td>
											<td>
												<a class="gameLink"
													onmouseover="GameHover( this, event, 'global_hover', {&quot;type&quot;:&quot;app&quot;,&quot;id&quot;:489830,&quot;public&quot;:1,&quot;v6&quot;:1} );"
													onmouseout="HideGameHover( this, event, 'global_hover' )"
													href="#게임 상세 페이지">게임 이름
												</a>
											</td>
										</tr>
										
									</table>
									<br>
									<div id="more_player_count_link">
										<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/ico/ico_arrow_blue_old.gif"/>"/>&nbsp;
										<a id="detailLink" style="cursor: pointer;">
											가장 많이 플레이한 최고 100 개의 게임 모두 보기
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div style="clear: both;"></div>
				</div>
			</div>
			
			<!-- footer 회사 정보 -->
			<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/footer.jsp"/>
			<!-- end footer 회사 정보 -->
			
		</div>
	</div>
</body>
</html>