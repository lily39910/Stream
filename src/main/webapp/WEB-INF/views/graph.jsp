<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title></title>

<link class="include" rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/jqplot/jquery.jqplot.min.css" />
<script class="include" type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js" />
<script type="text/javascript"> /* $J =  */jQuery.noConflict(); </script>
<link class="include" rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/jqplot/jquery-ui/css/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/jqplot/jqplot.css" />


<script class="code" type="text/javascript">
	$(document).ready(function() {
		$.jqplot._noToImageButton = true;
		var currYear = [ [ "2011-08-01", 796.01 ],
		[ "2011-08-02", 510.5 ], [ "2011-08-03", 527.8 ],
		[ "2011-08-04", 308.48 ], [ "2011-08-05", 420.36 ],
		[ "2011-08-06", 219.47 ], [ "2011-08-07", 333.82 ],
		[ "2011-08-08", 660.55 ], [ "2011-08-09", 1093.19 ],
		[ "2011-08-10", 521 ], [ "2011-08-11", 660.68 ],
		[ "2011-08-12", 928.65 ], [ "2011-08-13", 864.26 ],
		[ "2011-08-14", 395.55 ], [ "2011-08-15", 623.86 ],
		[ "2011-08-16", 1300.05 ], [ "2011-08-17", 972.25 ],
		[ "2011-08-18", 661.98 ], [ "2011-08-19", 1008.67 ],
		[ "2011-08-20", 1546.23 ], [ "2011-08-21", 593 ],
		[ "2011-08-22", 560.25 ], [ "2011-08-23", 857.8 ],
		[ "2011-08-24", 939.5 ], [ "2011-08-25", 1256.14 ],
		[ "2011-08-26", 1033.01 ], [ "2011-08-27", 811.63 ],
		[ "2011-08-28", 735.01 ], [ "2011-08-29", 985.35 ],
		[ "2011-08-30", 1401.58 ], [ "2011-08-31", 1177 ],
		[ "2011-09-01", 1023.66 ], [ "2011-09-02", 1442.31 ] ];

		var plot1 = $.jqplot("chart1", [ currYear ], {
			seriesColors : [ "#589fc9" ],
			highlighter : {
				show : true,
				sizeAdjust : 1,
				tooltipOffset : 9
			},
			//배경 정보
			grid : {
				background : 'rgba(57,57,57,0.0)',
				drawBorder : false,
				shadow : false,
				gridLineColor : '#666666',
				gridLineWidth : 2
			},
			//선 정보
			legend : {
				show : true,
				placement : 'insideGrid',
				location : 'sw'
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
						formatString : "%b %e", //월, 일
						angle : -90,
						textColor : '#dddddd'
					},
					min : "2011-08-01",
					max : "2011-09-02",
					tickInterval : "1 days",
					drawMajorGridlines : false
				},
				//세로축
				yaxis : {
					//renderer: $.jqplot.LogAxisRenderer,
					pad : 0,
					rendererOptions : {
						minorTicks : 1
					},
					tickOptions : {
						formatString : "%'d", //인원
						showMark : false
					}
				}
			}
		});

		$('.jqplot-highlighter-tooltip').addClass('ui-corner-all')
	});
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
<body>
	<div class="ui-widget ui-corner-all">
		<div class="ui-widget-content ui-corner-bottom">
			<div id="chart1"></div>
		</div>
	</div>
</body>
</html>