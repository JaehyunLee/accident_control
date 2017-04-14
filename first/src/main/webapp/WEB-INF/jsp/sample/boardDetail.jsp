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
							<li><a href="#" id="list_not">미처리 관제</a></li>
							<li><a href="#" id="list_ing">처리중 관제</a></li>
							<li><a href="#" id="list_ed">완료된 관제</a></li>
							<li><a data-toggle="modal" href="#stateModal">관제 현황판</a></li>
							<li><a href="#" id="statistics">관제 통계</a></li>
						</ul>
					</div>
				</form>
			</div>
		</nav>
		
		<div class="ecall-controller">
			<div id="myMap" style="border: 1px solid #BBB; width: 800px; height: 675px; float: left; z-index: 0;"></div>
			<div class="ecall-control-list">
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
			
			<form id="commonForm" name="commonForm"></form>
		</div>
		</div>
	</div>
	<!-- stateModal -->
	<%@ include file="/WEB-INF/include/include-stateModal.jsp"%>
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
	
	// daum map setting
	var container = document.getElementById('myMap');
	var lat = ${map.positionLatitude};
	var lon = ${map.positionLongitude};
	var options = {
		center: new daum.maps.LatLng(lat, lon),
		level: 4
	};
	var map = new daum.maps.Map(container, options);	
	var geocoder = new daum.maps.services.Geocoder();


	function setMarker(latLng) {
		searchDetailAddrFromCoords(latLng, function(status, result) {
			if (status === daum.maps.services.Status.OK) {		
				var detailAddr = !!result[0].roadAddress.name ? '<div>'
						+ result[0].roadAddress.name + '</div>' : '';
				detailAddr += '<div>' + result[0].jibunAddress.name
						+ '</div>';

				var content = '<div class="wrap">' + 
				'    <div class="info">' + 
				'        <div class="title">' + 
				'            사고 위치' + 
				'        </div>' + 
				'        <div class="body">' + 
				'            <div class="ellipsis">' +
								detailAddr +
				'			</div>' +  
				'        </div>' + 
				'    </div>' +    
				'</div>';

				var marker = new daum.maps.Marker({
				    map: map, 
				    position: latLng
				});
				var overlay = new daum.maps.CustomOverlay({
				    content: content,
				    map: map,
				    position: latLng      
				});
				var clicked = true;
				
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
			}
		});
	}
	
	setMarker(new daum.maps.LatLng(lat, lon));

	
	function searchDetailAddrFromCoords(coords, callback) {
		// 좌표로 법정동 상세 주소 정보를 요청합니다
		geocoder.coord2detailaddr(coords, callback);
	}
	
</script>
</html>