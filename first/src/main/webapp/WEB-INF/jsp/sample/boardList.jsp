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
						<a class="navbar-brand" href="#">e-Call 관제 시스템</a>
					</div>
					<div id="navbar" class="navbar-collapse collapse">
						<ul class="nav navbar-nav navbar-right">
							<li><a href="#" id="list_not">미처리 관제</a></li>
							<li><a href="#" id="list_ing">처리중 관제</a></li>
							<li><a href="#" id="list_ed">완료된 관제</a></li>
							<li><a href="#" id="statistics">관제 통계</a></li>
						</ul>
					</div>
				</form>
			</div>
		</nav>

		<div class="ecall-controller">
		<div id="myMap" style="border: 1px solid #BBB; width: 750px; height: 675px; float: left; z-index: 0;"></div>

		<div class="ecall-control-list">
			<h3>관제현황</h3>
			<table class="board_list">
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
					<c:choose>
						<c:when test="${fn:length(list) > 0}">
							<c:forEach var="row" items="${list}" varStatus="status">
								<tr>
									<td>${row.eventID}</td>
									<td class="title"><a href="#this" id="title">
										
										<!-- Geocode API -->
										<script type="text/javascript">
											var lat = ${row.positionLatitude};
											var lon = ${row.positionLongitude};
											var coords = new daum.maps.LatLng(lat, lon);
											var geocoder = new daum.maps.services.Geocoder();
											var name;
											
											geocoder.coord2detailaddr(coords, function(status, result) {
												name = result[0].jibunAddress.name;
											});
											if (name != null)
												document.write(name);											
										</script>
										
									</a> <input type="hidden" id="IDX" value="${row.eventID}"></td>
									<td>${row.operatorName}</td>
									<td><c:if test="${row.progress == 0}">
									미처리
									</c:if> <c:if test="${row.progress == 1}">
									처리중
									</c:if> <c:if test="${row.progress == 2}">
									처리완료
									</c:if></td>
									<td>${row.timestamp}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4">조회된 결과가 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>

			<c:if test="${not empty paginationInfo}">
				<ui:pagination paginationInfo="${paginationInfo}" type="text"
					jsFunction="fn_search" />
			</c:if>
			<input type="hidden" id="currentPageNo" name="currentPageNo" /> <br />
			<a href="#this" class="btn" id="write">메시지전송</a>

			<%@ include file="/WEB-INF/include/include-body.jspf"%>
		</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	$(document).ready(function() {
		$("#write").on("click", function(e) { //글쓰기 버튼(메시지전송버튼)
			e.preventDefault();
			fn_openBoardWrite();
		});

		$("a[id='title']").on("click", function(e) { //제목 
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