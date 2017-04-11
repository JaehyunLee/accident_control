<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf"%>
</head>
<body>
	<div class="container">
		<div class="header">
			<form>
				<div class="logo">
					<h1>
						<a href="#">e-Call</a>
					</h1>
				</div>
				<div class="menu">
					<ul>
						<li><a href="#" id="list_not">미처리 관제</a></li>
						<li><a href="#" id="list_ing">처리중 관제</a></li>
						<li><a href="#" id="list_ed">완료된 관제</a></li>
						<li><a href="#" id="statistics">관제 통계</a></li>
					</ul>
				</div>
			</form>
		</div>
		<div class="subheader">
			<div class="toptext">
				<h2>e-Call 관제 시스템</h2>
			</div>
		</div>
		<div id="myMap"
			style="border: 1px solid #BBB; width: 750px; height: 750px; float: left; z-index: 0;"></div>
		<div class="list">
			<h3>관제 상세보기</h3>
			<table class="board_view">
				<colgroup>
					<col width="25%" />
					<col width="25%" />
					<col width="25%" />
					<col width="25%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">관제번호</th>
						<td>${map.eventID }</td>
						<th scope="row">진행상황</th>
						<td>
							<c:if test="${map.progress == 0}">미처리</c:if>
							<c:if test="${map.progress == 1}">처리중</c:if>
							<c:if test="${map.progress == 2}">처리완료</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">사고위치</th>
						<td colspan="3">
							<fmt:formatNumber value="${map.positionLatitude}" pattern=".0000000" /> , 
							<fmt:formatNumber value="${map.positionLongitude}" pattern=".0000000" />
						</td>
					</tr>
					<tr>
						<th scope="row">발생시각</th>
						<td colspan="3">${map.timestamp }</td>
					</tr>
					<tr>
						<th scope="row">담당자</th>
						<td>${map.operatorName }</td>
						<th scope="row">담당자연락처</th>
						<td>
							<c:choose>
								<c:when test="${map.operatorPhoneNumber == ''}">미정</c:when>
								<c:otherwise>${map.operatorPhoneNumber}</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th scope="row">사고차종</th>
						<td>
							<c:if test="${map.VehicleType == 0}">알수없음</c:if>
							<c:if test="${map.VehicleType == 1}">승용차</c:if>
							<c:if test="${map.VehicleType == 2}">버스</c:if>
							<c:if test="${map.VehicleType == 3}">택시</c:if>
						</td>
						<th scope="row">단말기종</th>
						<td>
							<c:if test="${map.deviceType == 0}">알수없음</c:if>
							<c:if test="${map.deviceType == 1}">안드로이드폰</c:if>
							<c:if test="${map.deviceType == 2}">아이폰</c:if>
							<c:if test="${map.deviceType == 3}">네비게이션</c:if>
							<c:if test="${map.deviceType == 4}">블랙박스</c:if>
							<c:if test="${map.deviceType == 5}">OBD2</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">사고자연락처</th>
						<td>${map.phoneNumber }</td>
						<th scope="row">차량탑승객수</th>
						<td>
							<c:if test="${map.numberOfPassengers == 0}">알수없음</c:if>
							<c:if test="${map.numberOfPassengers != 0}">${map.numberOfPassengers}</c:if>
						</td>
					</tr>
				</tbody>
			</table>

			<a href="#this" class="btn" id="list">목록으로</a>
			<a href="#this" class="btn" id="update">수정하기</a>
			
			<%@ include file="/WEB-INF/include/include-body.jspf"%>
		</div>
	</div>
</body>

<script type="text/javascript">
	$(document).ready(function() {
		$("#list").on("click", function(e) { //목록으로 버튼
			e.preventDefault();
			fn_openBoardList();
		});

		$("#update").on("click", function(e) { //수정하기 버튼
			e.preventDefault();
			fn_openBoardUpdate();
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
	});

	function fn_openBoardList() {
		var comSubmit = new ComSubmit();
		var progress = ${map.progress};
		
		if(progress == 0)
			comSubmit.setUrl("<c:url value='/sample/openBoardListNot.do' />");
		else if(progress == 1)
			comSubmit.setUrl("<c:url value='/sample/openBoardListIng.do' />");
		else
			comSubmit.setUrl("<c:url value='/sample/openBoardListEd.do' />");	
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
	
	function fn_openBoardUpdate() {
		//var idx = "${map.IDX}";
		//var comSubmit = new ComSubmit();
		//comSubmit.setUrl("<c:url value='/sample/openBoardUpdate.do' />");
		//comSubmit.addParam("IDX", idx);
		//comSubmit.submit();
	}
	
	/*
	// naver map setting
	var oPoint = new nhn.api.map.LatLng(37.394879, 127.11123799999996);
	nhn.api.map.setDefaultPoint('LatLng');
	oMap = new nhn.api.map.Map('myMap', {
		point : oPoint,
		zoom : 12,
		enableWheelZoom : true,
		enalbeDragPan : true,
		enableDblClickZoom : false,
		mapMode : 0,
		activateTrafficMap : false,
		activateBicycleMap : false,
		minMaxLevel : [ 1, 14 ],
		size : new nhn.api.map.Size(750, 750)
	});
	*/
	
	// daum map setting
	var container = document.getElementById('myMap');
	var lat = ${map.positionLatitude};
	var lon = ${map.positionLongitude};
	var geocoder = new daum.maps.services.Geocoder();

	var options = {
			center: new daum.maps.LatLng(lat, lon),
			level: 4
		};
	var map = new daum.maps.Map(container, options);	
	setMarker(new daum.maps.LatLng(lat, lon));

	function setMarker(latLng) {
		searchDetailAddrFromCoords(latLng, function(status, result) {
			if (status === daum.maps.services.Status.OK) {
				
				var marker = new daum.maps.Marker(),
				
				infowindow = new daum.maps.InfoWindow({
					zindex : 1
				});
				
				var detailAddr = !!result[0].roadAddress.name ? '<div>'
						+ result[0].roadAddress.name + '</div>' : '';
				// detailAddr += '<div>지번 주소 : ' + result[0].jibunAddress.name
				//		+ '</div>';

				var content = '<div class="bAddr">'
						+ '<span class="addrTitle">사고위치</span>' + detailAddr
						+ '</div>';

				// 마커를 클릭한 위치에 표시합니다 
				marker.setPosition(latLng);
				marker.setMap(map);

				// 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
				
				// 오류로 인해 주석처리
				// infowindow.setContent(content);
				// infowindow.open(map, marker);
			}
		});
	}
	
	function searchDetailAddrFromCoords(coords, callback) {
		// 좌표로 법정동 상세 주소 정보를 요청합니다
		geocoder.coord2detailaddr(coords, callback);
	}
	
</script>
</html>