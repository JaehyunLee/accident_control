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
							<li><a href="#" id="statistics">관제 통계</a></li>
						</ul>
					</div>
				</form>
			</div>
		</nav>

		<div class="ecall-controller">
		<div id="myMap" style="border: 1px solid #BBB; width: 800px; height: 675px; float: left; z-index: 0;"></div>

		<div class="ecall-control-list">
			<h4>사고 처리 현황</h4>
			<table class="board_list">
				<colgroup>
					<col style="width: 19%;"/>
					<col style="width: 17%;"/>
					<col style="width: 20%;"/>
					<col style="width: 22%;"/>
					<col style="width: 22%;"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">관제번호</th>
						<th scope="col">담당자</th>
						<th scope="col">진행상황</th>
						<th scope="col">사고시간</th>
						<th scope="col">사고접수</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(list) > 0}">
							<c:forEach var="row" items="${list}" varStatus="status">
								<tr>
									<td class="detail">
										<a href="#this" id="detail">${row.eventID}</a>
										<input type="hidden" id="IDX" value="${row.eventID}"></td>
									<td>${row.operatorName}</td>
									<td><c:if test="${row.progress == 0}">
									미처리
									</c:if> <c:if test="${row.progress == 1}">
									처리중
									</c:if> <c:if test="${row.progress == 2}">
									처리완료
									</c:if></td>
									<td>${row.timestamp}</td>
									<td>
										<button type="button" class="btn" data-toggle="modal" data-target="#myModal">
											접수하기
										</button>
									</td>
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
			<%@ include file="/WEB-INF/include/include-body.jspf"%>
		</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">사고 접수</h4>
				</div>
				<div class="modal-body">

					<ul class="list-group">
						<li class="list-group-item list-group-item-warning"><b>운전자 상태</b></li>
						<li class="list-group-item">
							<input type="checkbox" id="checkbox1">							
							<label for="checkbox1">의식 여부</label>
						</li>
						<li class="list-group-item">
							<input type="checkbox" id="checkbox2">							
							<label for="checkbox2">심정지 여부</label>
						</li>
						<li class="list-group-item">
							<input type="checkbox" id="checkbox3">							
							<label for="checkbox3">화상 여부</label>
						</li>
						<li class="list-group-item">
							<input type="checkbox" id="checkbox4">							
							<label for="checkbox4">호흡곤란 여부</label>
						</li>
						<li class="list-group-item">
							<input type="checkbox" id="checkbox5">							
							<label for="checkbox5">관통상 여부</label>
						</li>
						<li class="list-group-item">
							<input type="checkbox" id="checkbox6">							
							<label for="checkbox6">발작 여부</label>
						</li>
					</ul>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn" data-dismiss="modal">취소</button>
					<button type="button" class="btn">저장하기</button>
				</div>
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

		$("a[id='detail']").on("click", function(e) { // 상세보기
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
		center: new daum.maps.LatLng(36.5065230, 127.2538930),
		level: 4
	};
	var map = new daum.maps.Map(container, options);
	
	var geocoder = new daum.maps.services.Geocoder();
	
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
				' 			 	<br>관제번호&nbsp;' +
								eventID +
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
	
	<c:forEach var="row" items="${list}" varStatus="status">
		var lat = ${row.positionLatitude};
		var lon = ${row.positionLongitude};
		var eventID = ${row.eventID}
		setMarker(new daum.maps.LatLng(lat, lon), eventID);
	</c:forEach>

	/*
	// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
	daum.maps.event.addListener(map, 'idle', function() {
		searchAddrFromCoords(map.getCenter(), function(){});
	});
	*/
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
	})

</script>
</html>