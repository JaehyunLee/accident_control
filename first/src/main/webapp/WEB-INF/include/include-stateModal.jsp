<%@ page pageEncoding="utf-8"%>
<!-- stateModal -->
<div class="modal fade" id="stateModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">e-Call 종합 관제 현황</h4>
			</div>
			<div class="modal-body">

				<div class="state-clock">
					<div id="state-Date"></div>
					<ul>
						<li id="state-hours"></li>
						<li id="state-point">:</li>
						<li id="state-min"></li>
						<li id="state-point">:</li>
						<li id="state-sec"></li>
					</ul>
				</div>

				<div class="state-table-head">e-Call 처리 현황</div>
			
				<table class="state-table-body">
					<colgroup>
						<col style="width: 20%;" />
						<col style="width: 20%;" />
						<col style="width: 20%;" />
						<col style="width: 20%;" />
						<col style="width: 20%;" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">전체 수신콜</th>
							<th scope="col">처리중</th>
							<th scope="col">처리완료</th>
							<th scope="col">미처리</th>
							<th scope="col">완료율</th>
						</tr>
					</thead>					
					<tbody>
						<tr>
							<td>총 10건</td>
							<td>5</td>
							<td>3</td>
							<td>2</td>
							<td>80%</td>
						</tr>
					</tbody>
				</table>
				
				<div class="state-table-head">운영요원 상담 현황</div>
				
				<table class="state-table-body">
					<colgroup>
						<col style="width: 25%;" />
						<col style="width: 25%;" />
						<col style="width: 25%;" />
						<col style="width: 25%;" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">투입 운영요원</th>
							<th scope="col">상담중</th>
							<th scope="col">대기중</th>
							<th scope="col">휴식중</th>
						</tr>
					</thead>					
					<tbody>
						<tr>
							<td>총 5명</td>
							<td>3</td>
							<td>1</td>
							<td>1</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<!-- 시계화면 스크립트 -->
<script type="text/javascript">
	$(document).ready(
			function() {
				var dayNames = [ "일요일", "월요일", "화요일", "수요일",
						"목요일", "금요일", "토요일" ]
				var newDate = new Date();
				newDate.setDate(newDate.getDate());
				$('#state-Date').html(newDate.getFullYear() + '년 ' + (newDate.getMonth()+1)
				+ '월 ' + newDate.getDate()+ '일 ' +dayNames[newDate.getDay()]);

				setInterval(function() {
					// Create a newDate() object and extract the seconds of the current time on the visitor's
					var seconds = new Date().getSeconds();
					// Add a leading zero to seconds value
					$("#state-sec").html((seconds < 10 ? "0" : "") + seconds);
				}, 1000);

				setInterval(function() {
					// Create a newDate() object and extract the minutes of the current time on the visitor's
					var minutes = new Date().getMinutes();
					// Add a leading zero to the minutes value
					$("#state-min").html((minutes < 10 ? "0" : "") + minutes);
				}, 1000);

				setInterval(function() {
					// Create a newDate() object and extract the hours of the current time on the visitor's
					var hours = new Date().getHours();
					// Add a leading zero to the hours value
					$("#state-hours").html((hours < 10 ? "0" : "") + hours);
				}, 1000);
			});
</script>