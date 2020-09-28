<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div id="sectionContainerCenter">

	<div>

		<div class="recommendMenuContainer">


			<c:forEach items="${recMenuList}" var="item">
				<div class="recMenuItem" id="recMenuItem_${item.seq}">
					<div class="pic">
						<c:if test="${item.menu_pic != null and item.menu_pic != ''}">
							<img src="/res/img/rest/${data.i_rest}/rec_menu/${item.menu_pic}">
						</c:if>

					</div>

					<div class="info">
						<div class="nm">${item.menu_nm}</div>
						<dic class="price"> <fmt:formatNumber type="number"
							value="${item.menu_price}" />
					</div>
					<c:if test="${loginUser.i_user==data.i_user}">
		
						<div class="delIconContainer" onclick="delRecMenu(${item.seq})">
							<span class="material-icons">clear</span>
						</div>
					</c:if>
				</div>
			</c:forEach>

		</div>
		<div class="rstaurant-detail">
			<div class="detail-header">
				<div class="restaurant_title_wrqp">
					<div class="title">
						<h1>${data.nm}</h1>
					<c:if test="${loginUser.i_user!=null}">
				
							<div>
								<span class="material-icons" id="zzim" onclick="toggleFavorite()">
								<c:if test="${data.is_favorite==0}">favorite_border</c:if>	
								<c:if test="${data.is_favorite!=0}">favorite</c:if>
							    </span>
							</div>
							</div>
							
					</c:if>
					
					<c:if test="${loginUser.i_user==data.i_user}">
						<div>
							<!-- el식은 자바스크립에서 사용 불가.. el은 자바가 쓰는 것!!  -->
							<a href="/restaurant/restMod?i_rest$={data.i_rest}"><button>수정</button></a>
							<button onclick="isDel()">가게 삭제</button>
						</div>
					</c:if>
				</div>
				<div class="status">
					<span class="material-icons">visibility</span>
					<span class="cnt_hit">${data.hits}</span>
					<span class="material-icons">favorite</span>
					<span id="cnt_favorite" >${data.cnt_favorite}</span>
				</div>
			</div>
			<h2>추천메뉴 등록</h2>
			<form action="/rest/recMenus" enctype="multipart/form-data"
				method="post" onsubmit="return chk()">
				<input type="hidden" name="i_rest" value="${data.i_rest}">
				<c:if test="${loginUser.i_user==null}">
					<p id="text">회원으로 가입하면 메뉴를 추천할 수 있어요.</p>
				</c:if>

				<c:if test="${loginUser.i_user!=null}">
					<div>
						<button type="button" onclick="addRecMenu()">메뉴추가</button>
					</div>
					<div id="recItem"></div>

					<div>
						<input type="submit" value="등록">
					</div>
				</c:if>
			</form>
			<h2>메뉴판 등록</h2>
			<c:if test="${loginUser.i_user==null}">
				<p id="text">회원으로 가입하면 메뉴판을 추가할 수 있어요.</p>
			</c:if>
			<c:if test="${loginUser.i_user!=null}">
				<form action="/rest/menus" enctype="multipart/form-data"
					method="post" onsubmit="return chk()">
					<input type="hidden" name="i_rest" value="${data.i_rest}">
					<input type="file" name="menu_pic" multiple>
					<!--multiple 여러개 선택가능  -->
					<input type="submit" value="등록">
				</form>
			</c:if>
		</div>



		<div>
			<table>
				<caption>레스토랑 상세정보</caption>
				<tbody>
					<tr>
						<th>주소</th>
						<td>${data.addr}</td>
					</tr>
					<tr>
						<th>카테고리</th>
						<td>${data.cd_category_nm}</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${data.user_nm}</td>
					</tr>
					<tr>
						<th>메뉴</th>
						<td>
							<div class="MenuContainer" id="conMenuList"></div>
						</td>
					</tr>	
				</tbody>
			</table>
		</div>
	</div>
</div>

<div id="carouselContainer">
	<div id="imgContainer">
		<div class="swiper-container">
			<div id="swiperWrapper" class="swiper-wrapper"></div>
			<!-- If we need pagination -->
			<div class="swiper-pagination"></div>

			<!-- If we need navigation buttons -->
			<div class="swiper-button-prev"></div>
			<div class="swiper-button-next"></div>

		</div>
	</div>
	<span class="material-icons" onclick="closeCarousel()">clear</span> 
	<span class="material-icons" class="delimg" onclick="largeDle()">delete</span>
</div>


<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>

function toggleFavorite(){
	
		let parameter = {
			params: {
				i_rest: ${data.i_rest}	
			}
		}
	
	var icon=zzim.innerText.trim()
	switch(icon){
	case 'favorite':
		parameter.params.proc_type='del'
		break;
	case 'favorite_border':
		parameter.params.proc_type='ins'
		break;
	}
	
	axios.get('/user/ajaxToggleFavorite', parameter).then(function(res) {
		if(res.data==1){
			zzim.innerText=(icon=='favorite'? 'favorite_border':'favorite')
		}
	})
	
	
	

}



function closeCarousel(){
	carouselContainer.style.opacity = 0
	carouselContainer.style.zIndex = -10
}

function openCarousel() {
	carouselContainer.style.opacity = 1
	carouselContainer.style.zIndex = 40
}
var mySwiper = new Swiper('.swiper-container', {
	  // Optional parameters
	  direction: 'horizontal',
	  loop: true,
	
	  // If we need pagination
	  pagination: {
	    el: '.swiper-pagination',
	  },
	
	  // Navigation arrows
	  navigation: {
	    nextEl: '.swiper-button-next',
	    prevEl: '.swiper-button-prev',
	  }
	})

	var menuList =[]
	function ajaxSelMenuList(){
		axios.get('/rest/ajaxSelMenuList', {
			params:{
				i_rest:${data.i_rest}
			}
		}).then(function(res){
			menuList=res.data
			refreshMenu()
		})
	}

	function refreshMenu(){
		conMenuList.innerHTML=''
		swiperWrapper.innerHTML = ''
		menuList.forEach(function(item, idx){
			makeMenuItem(item, idx)
		})
	}
	
	function makeMenuItem(item, idx){
		const div=document.createElement('div')
		div.setAttribute('class', 'MenuItem')
		
		const img= document.createElement('img')
		img.setAttribute('src', `/res/img/rest/${data.i_rest}/menu/\${item.menu_pic}`)
		img.style.cursor = 'pointer'
		img.addEventListener('click', function() {
				openCarousel(idx + 1)
		})
		
		const swiperDiv = document.createElement('div')
		swiperDiv.setAttribute('class', 'swiper-slide')
		
		const swiperImg = document.createElement('img')
		
		<!----->
		swiperImg.setAttribute('src', `/res/img/rest/${data.i_rest}/menu/\${item.menu_pic}`)
		
		swiperDiv.append(swiperImg)
		
		mySwiper.appendSlide(swiperDiv);
		
		div.append(img)
		
		
		
		<c:if test="${loginUser.i_user==data.i_user}">
		
			const delDiv=document.createElement('div')
			delDiv.setAttribute('class', 'delIconContainer')
			const span = document.createElement('span')
			span.setAttribute('class','material-icons')
			span.innerText='clear'
			delDiv.addEventListener('click', function(){
				if(!confirm('삭제하시겠습니까?')){return	}
				if(idx>-1){
					
				axios.get('/rest/ajaxDelMenu',{
					params:{
						i_rest:${data.i_rest},
						seq:item.seq,
						menu_pic:item.menu_pic
					}
				}).then(function(res){
					console.log(res.data)
					if(res.data==1){
						menuList.splice(idx, 1)
						refreshMenu()	
					}else{
						alert('메뉴를 삭제할 수 없습니다.')
					}
				})
			
				 }
			})	
			
			
			
			delDiv.append(span)
			div.append(delDiv)
			
		</c:if>
			conMenuList.append(div)
	}

	function chk(){
		if(${loginUser.i_user==null}){
			alert('회원가입 후  등록 할 수 있습니다.')
			return false
		}
	}
	
	function delRecMenu(seq) {
		if(!confirm('삭제하시겠습니까?')){
			return
		}	
		axios.get('/rest/ajaxDelRecMenu',{
			params: {
				i_rest: ${data.i_rest}
				, seq: seq		
			}
		}).then(function (res) {
			if(res.data==1)
			var ele=document.querySelector("#recMenuItem_"+seq)
			ele.remove()
		})
	}
	
	
	
	function largeDle(){
		if(${loginUser.i_user==null}){
			alert('로그인 후 삭제할 수 있습니다.')
			return false}
		if(!confirm('삭제하시겠습니까?')){return	}
		const obj = menuList[mySwiper.realIndex]
		if(obj !=undefined){
			
		axios.get('/rest/ajaxDelMenu',{
			params:{
				i_rest:${data.i_rest},
				seq:obj.seq,
				menu_pic:obj.menu_pic
			}
		}).then(function(res){
			console.log(res.data)
			if(res.data==1){
				menuList.splice(mySwiper.realIndex, 1)
				refreshMenu()	
			}else{
				alert('메뉴를 삭제할 수 없습니다.')
			}
		})
		}
	 
}
	

	
	<c:if test="${loginUser.i_user==data.i_user}">
	var idx=0; //함수를 실행할때마다 1씩 증가시킴
	function addRecMenu(){
		
		
		
		var div= document.createElement('div')
		div.setAttribute('id', 'recMenu_' + idx++)
		
		
		var inputNm =document.createElement('input')
		inputNm.setAttribute("type", "text")
		inputNm.setAttribute("name","menu_nm")
		var inputPrice=document.createElement('input')
		inputPrice.setAttribute("type", "number")
		inputPrice.setAttribute("name","menu_price")
		inputPrice.value=0;
		var inputPic =document.createElement('input')
		inputPic.setAttribute("type", "file")
		inputPic.setAttribute("name","menu_pic")
		var delBtn=document.createElement('input')
		delBtn.setAttribute('type', 'button')
		delBtn.setAttribute('value' ,'X')
		delBtn.addEventListener('click', function(){
			div.remove()
		})
	
		div.append('메뉴: ')
		div.append(inputNm)
		div.append('가격: ')
		div.append(inputPrice)
		div.append('사진: ')
		div.append(inputPic)
		div.append(delBtn)
		
		
			recItem.append(div);
	
	}	
	addRecMenu() //기본1개는 세팅 ! 



	function isDel() {
	
		if (confirm('삭제하시겠습니까?')) {
			location.href='/rest/del?i_rest=${data.i_rest}'
		}
	}
	</c:if>

	ajaxSelMenuList()

</script>