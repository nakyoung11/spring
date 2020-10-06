<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="f-user">
	<p>
		<span style="font-weight: bold">${loginUser.nm}</span>님이 좋아하는 가게입니다.
	</p>
</div>
<div class="container">


	<c:forEach items="${data}" var="item">
		<div class="f-item">
			<div class="pic">
				<img src="http://localhost:8089/res/img/rest/${item.i_rest}/rec_menu/${item.menuList[0].menu_pic}"
				onerror='none'>
			</div>
			<div class="ctnt">
				<div class="f-ti_fa">
					<div class="f-info">
						<div class="f-title"><a href="rest/detail?i_rest=${item.i_rest}">${item.rest_nm}</div>
						<div class="addr">${item.rest_addr}</div>
					</div>
				</div>
				<div class="f-ctnt">
					<div class="bottom">
					<c:forEach items= "${item.menuList}" var="recMenu" varStatus="status">
						<c:if test ="${status.index>0}">
							<div class="info">
								<div class="img">
									<img src="/res/img/rest/${item.i_rest}/rec_menu/${recMenu.menu_pic}">
								</div>
								<div class="price">${recMenu.menu_nm} : <fmt:formatNumber type="number" value="${recMenu.menu_price}"/>원</div>
					
							</div>
						</c:if>
					</c:forEach>

					</div>
				</div>
			</div>

		</div>


	</c:forEach>


	
</div>