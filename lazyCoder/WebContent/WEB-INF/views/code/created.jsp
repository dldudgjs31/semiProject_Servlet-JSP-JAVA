<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resource/img/titlelogo.png">
<title>뺀질코딩-비밀의 소스코드</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">

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
        
        str = f.category.value;
        if(!str) {
            alert("언어를 입력하세요. ");
            f.category.focus();
            return;
        }
        
   		f.action="${pageContext.request.contextPath}/code/${mode}_ok.do"+"?page=${page}&num=${dto.num}";
   		f.submit();
			
		
    }
</script>
</head>
<body>

    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	
<div class="container">
    <div class="body-container" style="width: 1080px;">
        <div class="body-title">
            <h3 style="font-family: 'Jua', sans-serif; "> <img src="${pageContext.request.contextPath}/resource/img/source_logo.png" style="width: 50px; height: 37.5px;">${category }게시판 </h3>
        </div>
        
        <div>
			<form name="boardForm" method="post">
			  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse; font-family: 'Jua', sans-serif;">
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%;" value="${mode=='update'? dto.subject :''}">
			      </td>
			  </tr>
			
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
			      <td style="padding-left:10px;"> 
			          ${sessionScope.member.userId }
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
			      <td style="padding-left:10px;"> 
			          <p style="margin-top: 1px; margin-bottom: 5px;">
			            <select class="selectField" id="category" name="category" style="font-family: 'Jua', sans-serif;">
			                <option value="">::선 택::</option>
			                <option value="c" ${dto.category.equals("c") ? "selected='selected'" : ""}>C언어</option>
			                <option value="c++" ${dto.category.equals("c++") ? "selected='selected'" : ""}>C++</option>
			                <option value="java" ${dto.category.equals("java") ? "selected='selected'" : ""}>JAVA</option>
			                <option value="html/css" ${dto.category.equals("html/css") ? "selected='selected'" : ""}>HTML/CSS</option>
			                <option value="javascript" ${dto.category.equals("javascript") ? "selected='selected'" : ""}>JAVASCRIPT</option>
			            </select>
			        </p>
			      </td>
			  </tr>

			
			<tr align="left" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">color<br>script</td>
			      <td valign="top" style="padding:5px 0px 5px 10px;"> 
			        <object type="text/html" data="http://colorscripter.com/"
								width="1000px" height="500px"
								style="overflow: auto; border: 3px ridge black"> </object>
			      </td>
			  </tr>


			<tr align="left" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">H&nbsp;T&nbsp;M&nbsp;L&nbsp;</td>
			      <td valign="top" style="padding:5px 0px 5px 10px;"> 
			        <textarea name="url" rows="12" class="boxTA" style="width: 95%; font-family: 'Jua', sans-serif;">${mode=='update'? dto.url:'위 코드를 복사를 하여 넣어주세요.' }</textarea>
			      </td>
			  </tr>
			  
			  
			  
			  
			  
			  
			  
			
			  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
			      <td valign="top" style="padding:5px 0px 5px 10px;"> 
			        <textarea name="content" rows="5" class="boxTA" style="width: 95%;">${mode=='update'? dto.content:'' }</textarea>
			      </td>
			  </tr>
			  </table>
			
			  <table style="width: 100%; border-spacing: 0px; font-family: 'Jua', sans-serif;">
			     <tr height="45"> 
			      <td align="center" >

			        <button type="button" class="btn" onclick="sendOk();" style="font-family: 'Jua', sans-serif;">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="btn" style="font-family: 'Jua', sans-serif;">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/code/${category }list.do';" style="font-family: 'Jua', sans-serif;">${mode=='update'?'수정취소':'등록취소'}</button>
			      </td>
			    </tr>
			  </table>
			</form>
        </div>

    </div>
</div>

    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>

<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
</body>
</html>