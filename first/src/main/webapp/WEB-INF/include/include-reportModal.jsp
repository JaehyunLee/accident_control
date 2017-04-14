<%@ page pageEncoding="utf-8"%>

<!-- reportModal -->
<div class="modal fade" id="reportModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">사고 접수</h4>
			</div>
			<div class="modal-body">
				<ul class="list-group">
					<li class="list-group-item list-group-item-warning"><b>공통사항</b></li>
					<li class="list-group-item">
						<input type="checkbox" id="checkbox1">							
						<label for="checkbox1">주변 전선이 늘어짐 여부</label>
					</li>
					<li class="list-group-item">
						<input type="checkbox" id="checkbox2">							
						<label for="checkbox2">주변 교통 통제 여부</label>
					</li>
					<li class="list-group-item">
						<input type="checkbox" id="checkbox3">							
						<label for="checkbox3">주변 화재 및 연기 여부</label>
					</li>
					<li class="list-group-item">
						<input type="checkbox" id="checkbox4">							
						<label for="checkbox4">위험물질 및 냄새 여부</label>
					</li>
					<li class="list-group-item">
						<input type="checkbox" id="checkbox5">							
						<label for="checkbox5">희생자 여부</label>
					</li>
				</ul>	
				
				<ul class="list-group">
					<li class="list-group-item list-group-item-warning"><b>운전자 상태</b></li>
					<li class="list-group-item">
						<input type="checkbox" id="checkbox6">							
						<label for="checkbox6">의식 여부</label>
					</li>
					<li class="list-group-item">
						<input type="checkbox" id="checkbox7">							
						<label for="checkbox7">심정지 여부</label>
					</li>
					<li class="list-group-item">
						<input type="checkbox" id="checkbox8">							
						<label for="checkbox8">화상 여부</label>
					</li>
					<li class="list-group-item">
						<input type="checkbox" id="checkbox9">							
						<label for="checkbox9">호흡곤란 여부</label>
					</li>
					<li class="list-group-item">
						<input type="checkbox" id="checkbox10">							
						<label for="checkbox10">관통상 여부</label>
					</li>
					<li class="list-group-item">
						<input type="checkbox" id="checkbox11">							
						<label for="checkbox11">발작 여부</label>
					</li>
					<li class="list-group-item">
						<input type="checkbox" id="checkbox12">							
						<label for="checkbox12">안전벨트 착용 여부</label>
					</li>
				</ul>
				
				<ul class="list-group">
					<li class="list-group-item list-group-item-warning"><b>차량 상태</b></li>
					<li class="list-group-item">
						<input type="checkbox" id="checkbox13">							
						<label for="checkbox13">유리 파손 여부</label>
					</li>
					<li class="list-group-item">
						<input type="checkbox" id="checkbox14">							
						<label for="checkbox14">에어백 전개 여부</label>
					</li>
					<li class="list-group-item">
						<input type="checkbox" id="checkbox15">							
						<label for="checkbox15">차량 전복 여부</label>
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