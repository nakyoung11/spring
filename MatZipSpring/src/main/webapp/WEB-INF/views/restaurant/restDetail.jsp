<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div id="sectionContainerCenter">
	<div>
		<c:if test="${loginUser.i_user==data.i_user}">
			<div>
				<!-- el식은 자바스크립에서 사용 불가.. el은 자바가 쓰는 것!!  -->
				<a href="/restaurant/restMod?i_rest$={data.i_rest}"><button>수정</button></a>
				<button onclick="isDel()">가게 삭제</button>
			</div>

		</c:if>
		<div class="recommendMenuContainer">
			<c:forEach items="${recommendMenuList}" var="item">
				<div class="recMenuItem" id="recMeunItem_${item.seq}">
					<div class="pic">
						<c:if test="${item.menu_pic != null and item.menu_pic != ''}">
							<img src="/res/img/restaurant/${data.i_rest}/${item.menu_pic}">
						</c:if>

					</div>

					<div class="info">
						<div class="nm">${item.menu_nm}</div>
						<dic class="price"> <fmt:formatNumber type="number"
							value="${item.menu_price}" />
					</div>
					<div class="delIconContainer"
						onclick="delRecMenu(${data.i_rest}, ${item.seq})">

						<span class="material-icons">clear</span>
					</div>
				</div>
			</c:forEach>

		</div>
		<div class="rstaurant-detail">
			<div class="detail-header">
				<div class="restaurant_title_wrqp">
					<span class="title">
						<h1>${data.nm}</h1>
					</span>
				</div>
				<div class="status">
					<span class="cnt hit">${data.cntHits}</span> <span
						class="cnt favorite">${data.cntFavorite}</span>
				</div>
			</div>
			<h2>추천메뉴 등록</h2>
			<form action="/restaurant/addRecMenusProc"
				enctype="multipart/form-data" method="post">
				<input type="hidden" name="i_rest" value="${data.i_rest}">
				<div>
					<button type="button" onclick="addRecMenu()">메뉴추가</button>
				</div>
				<div id="recItem"></div>
				<div>
					<input type="submit" value="등록">
				</div>
			</form>
			<h2>메뉴판 등록</h2>
			<form action="/restaurant/addMenusProc" enctype="multipart/form-data"
				method="post">
				<input type="hidden" name="i_rest" value="${data.i_rest}"> <input
					type="file" name="menu_pic" multiple>
				<!--multiple 여러개 선택가능  -->
				<input type="submit" value="등록">
			</form>
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
						<th>메뉴</th>
						<td>
							<div class="MenuContainer">
								<c:if test="${fn:length(menuList)>0}">
									<c:forEach var="i" begin="0"
										end="${fn:length(menuList)>3? 2: fn:length(menuList)-1}">

										<div class="MenuItem" id="MeunItem_${item.seq}">
											<div class="pic">
												<img
													src="/res/img/restaurant/${data.i_rest}/menu/${menuList[i].menu_pic}">
											</div>

											<div class="delIconContainer"
												onclick="delMenu(${data.i_rest}, ${item.seq})">

												<span class="material-icons">clear</span>
											</div>
										</div>
									</c:forEach>
									<c:if test="${fn:length(menuList) > 3}">
											<div class="menuItem bg_black">
												<span class="moreCnt">
													+${fn:length(menuList) - 3}
												</span>
											</div>
									</c:if>
									</c:if>
							</div>
						</td>
				</tbody>
			</table>
		</div>
	</div>
</div>



<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
	
	function delRecMenu(i_rest, seq) {
		console.log(i_rest)
		console.log(seq)
		
		axios.get('/restaurant/ajaxDelRecMenu',{
			params: {
				i_rest, seq	
			}
		}).then(function (res) {
			if(res.data==1)
			var ele=document.querySelector("#recMeunItem_"+seq)
			ele.remove()
		})
	}
	
	function delcMenu(i_rest, seq) {
		axios.get('/restaurant/ajaxDelMenu',{
			params: {
				i_rest, seq	
			}
		}).then(function (res) {
			if(res.data==1)
			var ele=document.querySelector("#MeunItem_"+seq)
			ele.remove()
		})
	}
	
	var idx=0; //함수를 실행할때마다 1씩 증가시킴
	function addRecMenu(){
		var div= document.createElement('div')
		var inputNm =document.createElement('input')
		inputNm.setAttribute("type", "text")
		inputNm.setAttribute("name","menu_nm")
		var inputPrice=document.createElement('input')
		inputPrice.setAttribute("type", "number")
		inputPrice.setAttribute("name","menu_price")
		var inputPic =document.createElement('input')
		inputPic.setAttribute("type", "file")
		inputPic.setAttribute("name","menuPic_"+ idx++)
	
		div.append('메뉴: ')
		div.append(inputNm)
		div.append('가격: ')
		div.append(inputPrice)
		div.append('사진: ')
		div.append(inputPic)
		
		
		recItem.append(div);
	
	}
	addRecMenu() //기본1개는 세팅 ! 


	function isDel() {
		if (confirm('삭제하시겠습니까?')) {
			location.herf = "/restaurant/restDel?i_rest=${data.i_rest}"
		}
	}
</script>