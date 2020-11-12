<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resource/img/titlelogo.png">
<title>뺀질코딩-채용공고</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">
<style type="text/css">
.section {
	
	height: 600px;
	width: 80%;
	margin-left:10%;
	border-radius: 20px;
}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/util.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery.min.js"></script>
<script type="text/javascript">
    function sendOk() {
        var f = document.boardForm;

    	var str = f.subject.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.subject.focus();
            return;
        }

    	str = f.content.value;
        if(!str) {
            alert("내용을 입력하세요. ");
            f.content.focus();
            return;
        }
        
        str = f.deadline.value;
    	str = str.trim();
        if(!str || !isValidDateFormat(str)) {
            alert("채용마감일를 입력하세요[YYYY-MM-DD]. ");
            f.deadline.focus();
            return;
        }
        
        var mode = "${mode}";
        if(mode=="created" && ! f.selectFile.value){
        	alert("이미지 파일을 선택하세요.");
        	f.selectFile.focus();
        	return;
        }

    	f.action="${pageContext.request.contextPath}/bbs_recruit/${mode}_ok.do";

        f.submit();
    }
    <c:if test="${mode=='update'}">
    $(function(){ // jquery 대화상자
    	$("#myPhoto").click(function(){
    		var viewer=$("#imageLayout");
    		var s ="<img src='${pageContext.request.contextPath}/uploads/bbs_recruit/${dto.imageFilename}' width='570' height='450'>";
    		viewer.html(s);
    		$("#photoDialog").dialog({
    			title:"이미지",
    			width:600,
    			height:520,
    			modal:true
    		});
    	});
    });
    </c:if>
</script>
</head>
<body>

    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	
<div class="container" >
    <div class="section" >
        <div class="body-title">
            <h3 style="font-family: 'Jua', sans-serif; "> <img src="${pageContext.request.contextPath}/resource/img/recruit_logo.png" style="width: 50px; height: 37.5px;"> 채용공고 등록</h3>
        </div>
        
        <div>
			<form name="boardForm" method="post" enctype="multipart/form-data">
			  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;font-family: 'Jua', sans-serif;">
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td style="padding-left:10px;"> 
			          <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.subject}">
			      </td>
			  </tr>

			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
			      <td style="padding-left:10px;"> 
			          ${sessionScope.member.userName}
			      </td>
			  </tr>
			
			  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
			      <td valign="top" style="padding:5px 0px 5px 10px;"> 
			          <textarea name="content" rows="12" class="boxTA" style="width: 95%;">${dto.content}</textarea>
			      </td>
			  </tr>
			  
			  <tr align="left" style="border-bottom: 1px solid #cccccc;">
			  <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">채용마감일</td>
			  			         <td style="padding-left:10px;"> 
			  			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="deadline" value="${dto.deadline}" maxlength="10" 
			                       class="boxTF" style="width: 95%;" placeholder="채용마감일">
			        </p>
			        <p class="help-block">채용마감일은 2000-01-01 형식으로 입력 합니다.</p>
			  </td>
			   </tr>
			  
			  
			  
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">이미지</td>
			      <td style="padding-left:10px;"> 
			      	<!-- file 객체는 value 속성으로 초기화가 불가능하다. -->
			          <input type="file" name="selectFile" accept="image/*" class="boxTF" size="53" style="height: 25px;">
			       </td>
			  </tr> 
			  <!-- 수정일 때만 나오게 -->
			  <c:if test="${mode=='update'}">
				  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
					      <td width="100" bgcolor="#eeeeee" style="text-align: center;">이미지</td>
					      <td style="padding-left:10px;"> 
					      <img id="myPhoto" src="${pageContext.request.contextPath}/uploads/bbs_recruit/${dto.imageFilename}" width="30" height="30" style="cursor: pointer;">
					       </td>
				  </tr> 
			  </c:if>
			  
			  </table>
			
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			      
			      <c:if test="${mode=='update'}">
			      	<input type="hidden" name="page" value="${page}">
			      	<input type="hidden" name="num" value="${dto.num}">
			      	<input type="hidden" name="imageFilename" value="${dto.imageFilename}">
			      </c:if>
			      
			      
			        <button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/bbs_recruit/list.do';">${mode=='update'?'수정취소':'등록취소'}</button>

				  </td>
			    </tr>
			  </table>
			</form>
        </div>

    </div>
</div>

<div id="photoDialog">
	<div id="imageLayout">
	
	</div>
</div>


<div class="footer">
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
</body>
</html>