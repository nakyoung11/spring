<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${title}</title>

<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/res/css/common.css?dkkjdj=100">

<c:forEach items="${css}" var="item">
		<link rel="stylesheet" type="text/css" href="/res/css/${item}.css">		
</c:forEach>	

</head>	

<body>
	<div id="container">
		
		<header>

			<h1 class="hidden">MatZip</h1>
			<nav id=menu>
				<a href="/rest/map" class="round">
				<span class="material-icons"> location_on </span></a>
				
				<c:if test="${loginUser!=null}">	
				<a href="/rest/restReg" class="round">
				<span class="material-icons">add_business</span></a>
				</c:if>
				<c:if test="${loginUser==null}">
				<a href="#" onclick="alert('로그인이 필요합니다.')" class="round">
				<span class="material-icons">add_business</span></a>
				</c:if>
			
			    <a href="/user/restFavorite" class="round">
			    <span class="material-icons">favorite</span></a>
			<div id="search">
			<input type="search" placeholder="검색어를 입력하세요"></div>
			</nav>
			
			<c:if test="${loginUser!=null}">
			
			<div id="userinfo">
				<div class="containerPImg">
					<c:choose>
						<c:when test="${loiginUser.profile_img !=null}">
							<img class="pImg"
								src="/res/img/user/${loiginUser.i_user}/${loiginUser.profile_img}">
						</c:when>
						<c:otherwise>
							<img class="pImg" src="/res/img/default_profile.jpg">
						</c:otherwise>
					</c:choose>
				</div>
				<div id="userNm">${loginUser.nm}님환영합니다.</div>	
					<div id="logOut">
						<a href="/user/logout">로그아웃</a>
					</div>
				</div>
			</c:if>
			<c:if test="${loginUser==null}">
			<div id="logouts">
						<a href="/user/login">로그인</a>
			</div>
			</c:if>
				</header>
		
			
	
		<section>
			<jsp:include page="/WEB-INF/views/${view}.jsp"></jsp:include>
			
		</section>
			
		<footer> 회사정보 </footer>
	
</div>
</body>
</html>