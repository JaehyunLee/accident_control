<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf"%>
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

		<!-- 사이드 메뉴 -->
 		<div id="side-menu-container">
 			<div class="side-menu-title">종합 상황</div>
	    	<div class="list-group">
    	  		<a data-toggle="modal" href="#stateModal" class="list-group-item">종합 관제 현황</a>
 			    <a data-toggle="modal" href="#reportModal" class="list-group-item">사고 처리 내역</a>
    		</div>
	  	</div>

		<div class="ecall-controller">
			<div id="myMap" style="border: 1px solid #BBB; width: 1200px; height: 630px; float: left; z-index: 0;"></div>
		</div>
	</div>

	<!-- reportModal -->
	<%@ include file="/WEB-INF/include/include-reportModal.jsp"%>	
	<!-- stateModal -->
	<%@ include file="/WEB-INF/include/include-stateModal.jsp"%>
</body>

<script type="text/javascript">

	$(document).ready(function() {
		$("#write").on("click", function(e) { //글쓰기 버튼(메시지전송버튼)
			e.preventDefault();
			fn_openBoardWrite();
		});

		$("#detail").on("click", function(e) { // 상세보기
			e.preventDefault();
			fn_openBoardDetail($(this));
		});
		
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

	function fn_openBoardDetail(obj) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/sample/openBoardDetail.do' />");
		comSubmit.addParam("IDX", obj.parent().find("#IDX").val());
		comSubmit.submit();
	}

	function fn_search(pageNo) {
		var comSubmit = new ComSubmit();
		var progress = ${list[0].progress};

		if(progress == 0)
			comSubmit.setUrl("<c:url value='/sample/openBoardListNot.do' />");
		else if(progress == 1)
			comSubmit.setUrl("<c:url value='/sample/openBoardListIng.do' />");
		else
			comSubmit.setUrl("<c:url value='/sample/openBoardListEd.do' />");
		comSubmit.addParam("currentPageNo", pageNo);
		comSubmit.submit();
	}
	
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
	
	
	/**
	function fn_openBoardWrite() {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/sample/openBoardWrite.do' />");
		comSubmit.submit();
	}
	*/
	
	// daum map setting
	var container = document.getElementById('myMap');
	var options = {
		center: new daum.maps.LatLng(36.5065230, 127.2538930),
		level: 4
	};
	var map = new daum.maps.Map(container, options);
	
	// 지도타입 컨트롤러
	var mapTypeControl = new daum.maps.MapTypeControl();
	map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);
	// 줌인 컨트롤러
	var zoomControl = new daum.maps.ZoomControl();
	map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
	// 실시간 교통
	map.addOverlayMapTypeId(daum.maps.MapTypeId.TRAFFIC);
	// 주소정보
	var geocoder = new daum.maps.services.Geocoder();
	// 마커 클러스터링
	var clusterer = new daum.maps.MarkerClusterer({
		map: map,
		averageCenter: true,
		minLevel:6
	});
	
	function setMarker(latLng, eventID) {
		searchDetailAddrFromCoords(latLng, function(status, result) {
			if (status === daum.maps.services.Status.OK) {		

				var detailAddr = !!result[0].roadAddress.name ? 
						result[0].roadAddress.name : '';
				detailAddr += result[0].jibunAddress.name;

				var content = '<div class="wrap">' + 
				'    <div class="info">' + 
				'        <div class="title">' + 
				'            사고 위치' + 
				'        </div>' + 
				'        <div class="body">' + 
				'            <div class="ellipsis">' +
								detailAddr +
				' 			 	<br><b>관제번호&nbsp;' +
								eventID +
				'			</b></div>' +  
				'        </div>' + 
				'    </div>' +    
				'</div>';

				var marker = new daum.maps.Marker({
				    position: latLng
				});							
								
				var overlay = new daum.maps.CustomOverlay({
				    content: content,
				    map: map,
				    position: latLng      
				});
				
				var clicked = false;
				overlay.setMap(null);
				
				(function(marker, overlay, clicked) {
					// 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
					daum.maps.event.addListener(marker, 'click', function() {
						if(clicked) {
							overlay.setMap(null);
							clicked = false;
						}
						else {
							overlay.setMap(map);
							clicked = true;
						}
					});
			    })(marker, overlay, clicked);
				
				clusterer.addMarker(marker);
			}
		});
	}

	<c:forEach var="row" items="${list}" varStatus="status">
		var lat = ${row.positionLatitude};
		var lon = ${row.positionLongitude};
		var eventID = ${row.eventID}
		setMarker(new daum.maps.LatLng(lat, lon), eventID);
		
	</c:forEach>

	function searchAddrFromCoords(coords, callback) {
		// 좌표로 행정동 주소 정보를 요청합니다
		geocoder.coord2addr(coords, callback);
	}

	function searchDetailAddrFromCoords(coords, callback) {
		// 좌표로 법정동 상세 주소 정보를 요청합니다
		geocoder.coord2detailaddr(coords, callback);
	}
	
	$('#myModal').on('shown.bs.modal', function () {
		  $('#myInput').focus()
	});
	
	$('#side-menu-container').BootSideMenu({
		side:"left",
		duration: 500,
		width: "15%"
	});

</script>
</html>