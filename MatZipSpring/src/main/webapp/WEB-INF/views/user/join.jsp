<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="sectionContainerCenter">
	<div>
		<form action="/user/join" method="post" class="frm" id="frm">
		
			<div id="idChkResult" class="msg"></div>
			<div><input type="text" name="user_id" placeholder="아이디">
				<button  type="button" onclick="chkId()">중복확인</button></div>
			<div><input type="password" name="user_pw" placeholder="비밀번호" disabled class="disabled"></div>
			<div><input type="password" name="user_pwre" placeholder="비밀번호확인" disabled class="disabled"></div>
			<div><input type="text" name="nm" placeholder="이름" disabled class="disabled"></div>
			<div><input type="submit" value="회원가입"></div>
		</form>
		<div><a href="/user/login">로그인</a></div>
	</div>	
	
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<script>/*  ajax는 리플래쉬 없이 자바스크립트가 값을 가져온다면 변화를주는것  */
		function chkId(){
			const user_id =frm.user_id.value;
			axios.post('/user/ajaxIdChk',{
			// get/post                 , 파라미터
				
					user_id:user_id
				    
			}).then(function(res){
				console.log(res)
				if(res.data =='2'){
				idChkResult.innerText ='사용할 수 있는 아이디 입니다.'
				var dis=document.querySelectorAll(".disabled")
				for(var i=0; i<dis.length; i++){
					dis[i].disabled=false
				}
				frm.user_pw.focus()
				
				dis.disabled=false
				}else if(res.data=='3'){
				idChkResult.innerText='이미사용중입니다.'
				
				}
			})
		}
	
	</script>
	
	
</div>

