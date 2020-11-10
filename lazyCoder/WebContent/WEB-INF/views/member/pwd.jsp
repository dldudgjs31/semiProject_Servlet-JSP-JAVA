<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
*{
	margin: 0; padding: 0;
}

body {
	font-size: 14px;
	font-family: 맑은 고딕, 돋움, sans-serif;
}
a{
	color: #000;
	text-decoration: none;
}
a:active, a:hover{
	color: tomato;
	text-decoration: underline;
}
textarea:focus, input:focus{
	outline: none;
}
.btn{
	color: #333;
	font-weight: 500;
	font-family: 나눔고딕, "맑은고딕", 돋움, sans-serif;
	border: 1px solid #ccc;
	text-align: center;
	cursor: pointer;
	padding: 3px 10px 5px;
	border-radius: 4px;
}
.btn:active, .btn:focus, .btn:hover{
	background-color: #e6e6e6;
	border-color: #adadad;
}

.boxTF{
	border: 1px solid #999;
	padding: 3px 5px 5px;
	border-radius: 4px;
	font-family: "맑은 고딕",돋움, sans-serif;
}
.boxTA{
	border: 1px solid #999;
	height: 150px;
	padding: 3px 5px;
	border-radius: 4px;
	font-family: "맑은 고딕",돋움, sans-serif;
	resize: none;
}
.selectField{
	border: 1px solid #999;
	padding: 3px 5px 5px;
	border-radius: 4px;
	font-family: "맑은 고딕",돋움, sans-serif;
}

.title{
	font-weight: bold;
	font-size: 15px;
	font-family: 나눔고딕, "맑은 고딕", 돋움, sans-serif;
}
.boardLayout{
	width: 300px;
	margin: 30px auto;
}
.boardLayout table{
	width: 100%;
	border-spacing: 1px;
	background-color:#ccc;
	
}
.boardLayout table td{
	background-color: #fff;
	text-align: center;
}
.boardLayout .btnBox{
	height: 50px;
	line-height: 50px;
	text-align: center;
}

.boardLayout .msgBox{
	height: 50px;
	line-height: 50px;
	text-align: center;
	color: blue;
}
</style>
<script type="text/javascript">

function deletemember(){
	var f=document.deleteFrom;
	var str;
	
	str = f.pwd.value;
	str = str.trim();
	if(!str) {
		alert("비밀번호를 입력하세요. ");
		f.pwd.focus();
		return;
	}

	if (confirm("탈퇴하시겠습니까?")) {
		f.action="${pageContext.request.contextPath}/member/pwd_ok.do";
	    f.submit();
	 }
	
}

</script>

</head>
<body>
	<div class="boardLayout">
	<form name="deleteFrom" method="post">
		<table>
			<tr height="40">
				
			</tr>
			<tr height="50">
				<td bgcolor="#fff">
					패스워드: <input type="password" name="pwd" class="boxTF" style="width:120px;">
				</td>
			</tr>
		</table>
		
		<div class="btnBox">
			<input type="hidden" name="mode" value="${mode }">
			<input type="hidden" name="userId" value="${userId }">
			
			<button type="button" class="btn" onclick="deletemember()">확인</button>
			<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/';">취 소</button>
		</div>
		<div>
		${message }
		</div>
		
		</form>
		
		
	</div>

</body>
</html>