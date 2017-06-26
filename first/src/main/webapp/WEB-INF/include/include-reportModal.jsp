<%@ page pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- reportModal -->
<div class="modal fade" id="reportModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">e-Call 사고 처리 내역</h4>
			</div>
			<div class="modal-body">
			
			<!-- 
				<table class="board_list">
					<colgroup>
						<col style="width: 16%;" />
						<col style="width: 16%;" />
						<col style="width: 18%;" />
						<col style="width: 30%;" />
						<col style="width: 20%;" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">관제번호</th>
							<th scope="col">담당자</th>
							<th scope="col">진행상황</th>
							<th scope="col">사고시간</th>
							<th scope="col">사고 정보 확인</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${fn:length(list) > 0}">
								<c:forEach var="row" items="${list}" varStatus="status">
									<tr>
										<td >${row.eventID}</td>
										<td>${row.operatorName}</td>
										<td><c:if test="${row.progress == 0}">
									미처리
									</c:if> <c:if test="${row.progress == 1}">
									처리중
									</c:if> <c:if test="${row.progress == 2}">
									처리완료
									</c:if></td>
										<td>${row.timestamp}</td>
										<td class="detail">
											<button type="button" class="btn" id="detail">사고 정보 확인</button>
											<input type="hidden" id="IDX" value="${row.eventID}">
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
				
				-->
				
				<table class="board_list">
					<colgroup>
						<col style="width: 14%;" />
						<col style="width: 14%;" />
						<col style="width: 14%;" />
						<col style="width: 14%;" />
						<col style="width: 14%;" />
						<col style="width: 14%;" />
						<col style="width: 16%;" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">사고 번호</th>
							<th scope="col">사고 심각도</th>
							<th scope="col">사고 위치</th>
							<th scope="col">담당자</th>
							<th scope="col">사고 처리 현황</th>
							<th scope="col">구조 기관</th>
							<th scope="col">사고 정보 확인</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${fn:length(list) > 0}">
								<c:forEach var="row" items="${list}" varStatus="status">
									<tr>
										<td>${row.eventID}</td>
										<td>보통</td>
										<td>${row.positionLatitude}, ${row.positionLongitude}</td>
										<td>${row.operatorName}</td>
										<td><c:if test="${row.progress == 0}">
									미처리
									</c:if> <c:if test="${row.progress == 1}">
									처리중
									</c:if> <c:if test="${row.progress == 2}">
									처리완료
									</c:if></td>
										<td>미정</td>
										<td class="detail">
											<a href="#" id="detail">사고 정보 확인</a>
											<input type="hidden" id="IDX" value="${row.eventID}">
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
				
				<form id="commonForm" name="commonForm"></form>
				
 				<!-- 
				<div class="modal-footer">
					<c:if test="${not empty paginationInfo}">
						<ui:pagination paginationInfo="${paginationInfo}" type="text"
							jsFunction="fn_search" />
					</c:if>
					<input type="hidden" id="currentPageNo" name="currentPageNo" /> <br />
				</div>	
				 -->

				
			</div>
		</div>
	</div>
</div>