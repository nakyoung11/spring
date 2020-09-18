<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="sectionContainerCenter">
	<div>
		<form action="/user/joinProc" method="post" class="frm" id="frm">
		
			<div id="idChkResult" class="msg"></div>
			<div><input type="text" name="user_id" placeholder="아이디">
				<button  type="button" onclick="chkId()">중복확인</button></div>
			<div><input type="password" name="user_pw" placeholder="비밀번호"></div>
			<div><input type="password" name="user_pwre" placeholder="비밀번호확인"></div>
			<div><input type="text" name="nm" placeholder="이름"></div>
			<div><input type="submit" value="회원가입"></div>
		</form>
		<div><a href="/user/login">로그인</a></div>
	</div>	
	
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<script>/*  ajax는 리플래쉬 없이 자바스크립트가 값을 가져온다면 변화를주는것  */
		function chkId(){
			const user_id =frm.user_id.value;
			axios.get('/user/ajaxIdChk',{
			// get/post                 , 파라미터
				params:{
					user_id:user_id
				     //  키 :value   post일때는 params를 빼고 키와 value를 빼기
				} //쿼리스트링으로 날리는 것과 같아. 
			}).then(function(res){
				console.log(res)
				if(res.data.result ==2){
				idChkResult.innerText ='사용할 수 있는 아이디 입니다.'
				}else if(res.data.result==3){
				idChkResult.innerText='이미사용중입니다.'
				}
			})
		}
	
	</script>
	
	
</div>

