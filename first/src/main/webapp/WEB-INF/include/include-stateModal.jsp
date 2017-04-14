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
				<h4 class="modal-title" id="myModalLabel">관제 현황판</h4>
			</div>
			<div class="modal-body">
			
				<div class="state-table-head">콜 현황</div>
			
				<table class="state-table-body">
					<colgroup>
						<col style="width: 25%;" />
						<col style="width: 25%;" />
						<col style="width: 25%;" />
						<col style="width: 25%;" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col"></th>
							<th scope="col">미처리</th>
							<th scope="col">처리완료</th>
							<th scope="col">전체콜</th>
						</tr>
					</thead>					
					<tbody>
						<tr>
							<td>금일</td>
							<td>2</td>
							<td>21</td>
							<td>23</td>
						</tr>
					</tbody>
				</table>
				
				<div class="state-table-head">상담원 현황</div>
				
				<table class="state-table-body">
					<colgroup>
						<col style="width: 25%;" />
						<col style="width: 25%;" />
						<col style="width: 25%;" />
						<col style="width: 25%;" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col"></th>
							<th scope="col">대기중</th>
							<th scope="col">상담중</th>
							<th scope="col">휴식중</th>
						</tr>
					</thead>					
					<tbody>
						<tr>
							<td>현재</td>
							<td>14</td>
							<td>4</td>
							<td>2</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
