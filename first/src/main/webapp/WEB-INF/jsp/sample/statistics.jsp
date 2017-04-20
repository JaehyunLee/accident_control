<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf"%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>
	<div class="ecall-container">
		<nav class="navbar navbar-default navbar-fixed-top">
			<div class="container">
				<form>
					<div class="navbar-header">
						<a class="navbar-brand" href="#">e-Call 관제센터</a>
					</div>
					<div id="navbar" class="navbar-collapse collapse">
						<ul class="nav navbar-nav navbar-right">
							<li><a href="#" id="list_not">사고 처리 현황</a></li>
							<li><a data-toggle="modal" href="#stateModal">관제 현황판</a></li>
							<li><a href="#" id="statistics">관제 통계</a></li>
							<li><a href="#" id="logout">로그아웃</a></li>
						</ul>
					</div>
				</form>
			</div>
		</nav>
		
		<div class="container_frame">
			<iFrame src="http://localhost:8081/#/notebook/2CBYAD81F/" width="100%" height="800px"></iFrame>
		</div>
<!-- 
		<div class="container_chart">
			<div class="div_chart1">
				<h4>지역별 사고 현황</h4>
				<div id="chart-frame1" style="width: 598px; height: 285px;">
					<iFrame src="http://localhost:8081/#/notebook/2CBYAD81F/paragraph/20170328-111535_2061037205?asIframe" 
					width="90%" height="100%"></iFrame>
				</div>
			</div>
			<div class="div_chart2">
				<h4>차종별 사고 현황</h4>
				<div id="chart-frame2" style="width: 598px; height: 285px;">
					<iFrame src="http://localhost:8081/#/notebook/2CBYAD81F/paragraph/20170328-111356_749395341?asIframe" 
					width="90%" height="100%"></iFrame>
				</div>
			</div>
			<div class="div_chart3">
				<h4>월별 사고 현황</h4>
				<div id="chart-frame3" style="width: 598px; height: 285px;">
					<iFrame src="http://localhost:8081/#/notebook/2CBYAD81F/paragraph/20170328-111647_1200821727?asIframe" 
					width="90%" height="100%"></iFrame>
				</div>
			</div>
			
			<div class="div_chart4">
				<h4>연도별 사고 현황</h4>
				<div id="chart-frame4" style="width: 598px; height: 285px;">
				<iFrame src="http://localhost:8081/#/notebook/2CBYAD81F/paragraph/20170328-111520_424722085?asIframe" 
					width="90%" height="100%"></iFrame>
				</div> 
			</div>
		</div>
		 -->
	</div>
	<form id="commonForm" name="commonForm"></form>
	
	<!-- stateModal -->
	<%@ include file="/WEB-INF/include/include-stateModal.jsp"%>
</body>

<script type="text/javascript">
	$(document).ready(function() {
		$("#list_not").on("click", function(e) { // 미처리 관제 버튼
			e.preventDefault();
			fn_openBoardListNot();
		});
		
		$("#list_ing").on("click", function(e) { // 처리중 관제 버튼
			e.preventDefault();
			fn_openBoardListIng();
		});
		
		$("#list_ed").on("click", function(e) { // 완료된 관제 버튼
			e.preventDefault();
			fn_openBoardListEd();
		});
		
		$("#statistics").on("click", function(e) { // 관제 통계 버튼
			e.preventDefault();
			fn_openStatistics();
		});
		$("#logout").on("click", function(e) { // 로그아웃 버튼
			e.preventDefault();
			fn_openLogout();
		});
	});
	
	function fn_openBoardListNot() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/sample/openBoardListNot.do' />");
		comSubmit.submit();
	}
	
	function fn_openBoardListIng() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/sample/openBoardListIng.do' />");
		comSubmit.submit();
	}

	function fn_openBoardListEd() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/sample/openBoardListEd.do' />");
		comSubmit.submit();
	}
	
	function fn_openStatistics() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/sample/openStatistics.do' />");
		comSubmit.submit();
	}
	
	function fn_openLogout() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='../index.jsp' />");
		comSubmit.submit();
	}
</script>

<script type="text/javascript">
	google.charts.load("current", {"packages" : [ "corechart","bar" ]});
	google.charts.setOnLoadCallback(drawChart1);
	function drawChart1() {
		var data = google.visualization.arrayToDataTable([
				[ '타입', '사고횟수' ], 
				[ '안드로이드폰', 7 ],
				[ '아이폰', 6 ], 
				[ '네비게이션', 4 ], 
				[ '블랙박스', 2 ],
				[ 'OBD2', 2 ], 
				[ '알수없음', 3 ] ]);

		var options = {pieHole : 0.4};
		var chart = new google.visualization.PieChart(document.getElementById('chart1'));
		chart.draw(data, options);
	}

	google.charts.setOnLoadCallback(drawChart2);
	function drawChart2() {
		var data = google.visualization.arrayToDataTable([
				[ '연도', '자동신고', '수동신고' ], 
				[ '2013', 1000, 400 ],
				[ '2014', 1170, 460 ], 
				[ '2015', 660, 1120 ],
				[ '2016', 1030, 540 ] ]);

		var options = {
			curveType : 'function',
			legend : {
				position : 'bottom'
			}
		};

		var chart = new google.visualization.LineChart(document
				.getElementById('chart2'));

		chart.draw(data, options);
	}

	google.charts.setOnLoadCallback(drawChart3);
	function drawChart3() {
	      var data = google.visualization.arrayToDataTable([
	        ['담당자', '사고담당 횟수'],
	        ['김핸디', 8],
	        ['이핸디', 7],
	        ['박핸디', 5],
	        ['서핸디', 2]
	      ]);

	      var options = {};
	      
	      var chart = new google.charts.Bar(document.getElementById('chart3'));
	      chart.draw(data, options);
	}
	
	google.charts.setOnLoadCallback(drawChart4);
	function drawChart4() {

		var data = google.visualization.arrayToDataTable([
				[ '타입', '사고횟수' ], 
				[ '승용차', 11 ], 
				[ '택시', 2 ],
				[ '버스', 2 ], 
				[ '오토바이', 2 ], 
				[ '알수없음', 7 ] ]);

		var options = {};

		var chart = new google.visualization.PieChart(document
				.getElementById('chart4'));

		chart.draw(data, options);
	}
</script>
</html>