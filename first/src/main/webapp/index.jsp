<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf"%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/login-ui.css?ver=1'/>" />
</head>
<body>

	<div class="form-signin">
		<h2 class="form-signin-heading">e-Call 관제시스템</h2>
		<label for="inputEmail" class="sr-only">Email address</label>
		<input type="email" id="inputEmail" class="form-control"
			placeholder="ID" required autofocus>
		<label for="inputPassword" class="sr-only">Password</label>
		<input type="Password" id="inputPassword" class="form-control"
			placeholder="Password" required>
		<button type="button" class="btn btn-lg btn-primary btn-block" id="log-in">로그인</button>
		<div class="checkbox">
			<input type="checkbox" id="remember-me">							
			<label for="remember-me">아이디 저장하기</label>
		</div>
		
		<div class="form-password">
			<button type="button" class="btn-password" id="log-in">비밀번호 찾기</button>
		</div>
		<form id="commonForm" name="commonForm"></form>
		
	</div>

</body>

<script type="text/javascript">
	$(document).ready(function() {
		$("#log-in").on("click", function(e) { // 로그인 버튼
			e.preventDefault();
			fn_login();
		});
	});

	function fn_login() {		
		if(!$.trim($('#inputPassword').val()))
			 alert('아이디 또는 비밀번호를 확인하세요.');
		else {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardListNot.do' />");
			comSubmit.submit();
		}
	}
</script>