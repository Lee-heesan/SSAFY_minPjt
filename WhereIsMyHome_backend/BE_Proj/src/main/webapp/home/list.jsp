<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Happy House - 거래 목록</title>
</head>
<body>
    <h2>거래 목록</h2>
    
	<!-- 검색 폼을 GET 방식으로 수정 -->
	<form action="${pageContext.request.contextPath}/home" method="get">
	    <h3>지역 검색</h3>
	    <label for="sido_name">시도:</label>
	    <input type="text" id="sido_name" name="sido_name" required="required" />
	    <br />
	    <label for="gugun_name">구군:</label>
	    <input type="text" id="gugun_name" name="gugun_name" required="required" />
	    <br />
	    <label for="dong_name">동:</label>
	    <input type="text" id="dong_name" name="dong_name" required="required" />
	    <br />
	    <button type="submit">검색</button>
	</form>


    <br />
    
    <table border="1">
	    <thead>
	        <tr>
	            <th>지역</th>
	            <th>아파트 이름</th>
	            <th>층수</th>
	            <th>거래 금액</th>
	        </tr>
	    </thead>
	    <tbody>
	        <c:forEach var="house" items="${list}">
	            <tr>
	                <td>${house.sido_name} ${house.gugun_name} ${house.dong_name}</td>
	                <td>${house.apt_nm}</td>
	                <td>${house.floor}</td>
	                <td>${house.deal_amount}</td>
	            </tr>
	        </c:forEach>
	    </tbody>
	</table>

</body>
</html>