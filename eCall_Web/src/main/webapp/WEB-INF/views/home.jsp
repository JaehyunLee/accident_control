<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>e-Call 관제센터</title>
<link href="/ecall/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="/ecall/resources/css/justified-nav.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="/ecall/resources/js/bootstrap.min.js"></script>

<!-- Map API -->
<script type="text/javascript" src="http://openapi.map.naver.com/openapi/v2/maps.js?clientId=QRvBZKcm6HKVtLbTGm1Y"></script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=a22e2d3564a4738fc448943a57212135&libraries=services"></script>
<!-- Map Style -->
<style>
.addrTitle {font-weight:bold;display:block;}
.bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="<c:url value='/resources/js/common.js'/>" charset="utf-8"></script>


</head>

<body>
	<div class="container">
		<div class="masthead">
			<h3 class="text-muted">e-Call System</h3>
			<nav>
				<ul class="nav nav-justified">
					<li class="active"><a href="#">미처리 관제</a></li>
					<li><a href="#">처리중 관제</a></li>
					<li><a href="#">완료된 관제</a></li>
					<li><a href="#">관제 통계</a></li>
				</ul>
			</nav>
		</div>
		
		<div id="myMap"
			style="border: 1px solid #BBB; width: 60%; height: 550px; float: left; z-index: 0;"></div>

		<div class="operation-list">
			<h3>관제현황</h3>
			<table class="table">
				<colgroup>
					<col width="15%" />
					<col width="*" />
					<col width="15%" />
					<col width="15%" />
					<col width="23%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">관제번호</th>
						<th scope="col">제목</th>
						<th scope="col">담당자</th>
						<th scope="col">진행상황</th>
						<th scope="col">사고시간</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>아이디</td>
						<td>위치</td>
						<td>이름</td>
						<td>미처리</td>
						<td>시</td>
					</tr>
				</tbody>
			</table>
			<a href="#this" class="btn" id="write">메시지전송</a>
		</div>
	</div>
</body>

<script type="text/javascript">
	// daum map setting
	var container = document.getElementById('myMap');
	var options = {
		center: new daum.maps.LatLng(36.5035230, 127.2538930),
		level: 4
	};
	var map = new daum.maps.Map(container, options);
	
	var geocoder = new daum.maps.services.Geocoder();
	
	
	function setMarker(latLng) {
		searchDetailAddrFromCoords(latLng, function(status, result) {
			if (status === daum.maps.services.Status.OK) {
				
				var marker = new daum.maps.Marker(),
				infowindow = new daum.maps.InfoWindow({
					zindex : 1
				});
				
				var detailAddr = !!result[0].roadAddress.name ? '<div>'
						+ result[0].roadAddress.name + '</div>' : '';
				detailAddr += '<div>' + result[0].jibunAddress.name
						+ '</div>';

				var content = '<div class="bAddr">'
						+ '<span class="addrTitle" style="color:red">사고발생 위치</span>' + detailAddr
						+ '</div>';

				// 마커를 클릭한 위치에 표시합니다 
				marker.setPosition(latLng);
				marker.setMap(map);

				// 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
				infowindow.setContent(content);
				infowindow.open(map, marker);
			}
		});
	}
	
	<c:forEach var="row" items="${list}" varStatus="status">
		var lat = ${row.positionLatitude};
		var lon = ${row.positionLongitude};
		setMarker(new daum.maps.LatLng(lat, lon));
	</c:forEach>

	
	// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
	daum.maps.event.addListener(map, 'idle', function() {
		searchAddrFromCoords(map.getCenter(), function(){});
	});

	function searchAddrFromCoords(coords, callback) {
		// 좌표로 행정동 주소 정보를 요청합니다
		geocoder.coord2addr(coords, callback);
	}

	function searchDetailAddrFromCoords(coords, callback) {
		// 좌표로 법정동 상세 주소 정보를 요청합니다
		geocoder.coord2detailaddr(coords, callback);
	}

</script>

</html>