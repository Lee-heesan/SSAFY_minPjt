<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>실거래가 조회</title>
    <style>
      body {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
        background-color: #f9f9f9;
        text-align: center;
      }

      .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        background: white;
        border-radius: 10px;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
      }

      .search-box {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        align-items: center;
        padding: 15px;
        background: #ffffff;
        border-radius: 8px;
      }

      select, input {
        padding: 8px;
        font-size: 14px;
        border: 1px solid #ced4da;
        border-radius: 5px;
        width: 180px;
      }

      button {
        background-color: #007bff;
        color: white;
        border: none;
        padding: 10px 15px;
        font-size: 14px;
        border-radius: 5px;
        cursor: pointer;
      }

      button:hover {
        background-color: #0056b3;
      }

      /* 지도 스타일 */
      #map {
        width: 50%;
        height: 500px;
        margin-top: 20px;
        border-radius: 8px;
        border: 1px solid #ddd;
        position: relative;
      }

      /* 거래 정보 리스트 스타일 */
      #apart-list {
        width: 45%;
        margin-top: 20px;
        height: 500px;
        overflow-y: auto; /* 스크롤 추가 */
        padding: 10px;
        border-radius: 8px;
        border: 1px solid #ddd;
        position: relative;
      }

      /* 테이블 스타일 */
      table {
        width: 100%;
        border-collapse: collapse;
      }

      table th, table td {
        padding: 10px;
        text-align: left;
        border-bottom: 1px solid #ddd;
      }

      table th {
        background-color: #f2f2f2;
      }

      /* Flexbox 레이아웃을 사용하여 지도와 리스트 나란히 배치 */
      .map-and-list-container {
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap; /* 모바일에서 잘 보이게 하려고 추가 */
      }
    </style>
  </head>
  <body>
    <%@ include file="/fragments/header.jsp" %>
    <div class="container">
      <h2>실거래가 조회</h2>
      <div class="search-box">
        <label>지역 선택:</label>
        <form action="${pageContext.request.contextPath}/home" method="get">
          <label for="sido_name">시도:</label>
          <input type="text" id="sido_name" name="sido_name" required="required" />
          <label for="gugun_name">구군:</label>
          <input type="text" id="gugun_name" name="gugun_name" required="required" />
          <label for="dong_name">동:</label>
          <input type="text" id="dong_name" name="dong_name" required="required" />
          <input type="month" id="dealYmd" />
          <button type="submit">검색</button>
        </form>
      </div>
      <hr />

      <!-- 지도와 리스트를 나란히 배치 -->
      <div class="map-and-list-container">
        <!-- 지도 -->
        <div id="map"></div>

        <!-- 거래 정보 리스트 -->
        <div id="apart-list">
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
        </div>
      </div>
    </div>

    <%@ include file="/fragments/footer.jsp" %>

    <script type="text/javascript" src="https://sgisapi.kostat.go.kr/OpenAPI3/auth/javascriptAuth?consumer_key=afa1af3e0a5b40a891ef"></script>
    <script src="<c:url value='/js/keys.js'/>"></script>
    <script src="<c:url value='/js/com.js'/>"></script>
    <script src="<c:url value='/js/kostat.js'/>"></script>
    <script src="<c:url value='/js/happyHouse.js'/>"></script>
    <script src="<c:url value='/js/enjoytrip.js'/>"></script>

    <script>
      // DOM이 완전히 로드된 후 실행되도록 설정
      document.addEventListener("DOMContentLoaded", function () {
        const area = document.querySelector("#sido");
        const sigungu = document.querySelector("#gugun");
        const contentType = document.querySelector("#dong");

        if (area) {
          area.addEventListener("change", async function () {
            await areaCode1(area.value);
          });
        }

        if (sigungu) {
          sigungu.addEventListener("change", async function () {
            await sigunguCode1(sigungu.value);
          });
        }

        if (contentType) {
          contentType.addEventListener("change", async function () {
            await contentTypeCode1(contentType.value);
          });
        }
      });

      // 중복 선언 방지: getFetch 함수가 이미 선언되어 있으면 다시 선언하지 않음
      if (typeof getFetch === "undefined") {
        const getFetch = async (url, param, isXml) => {
          try {
            const queryString = new URLSearchParams(param).toString();
            console.log("URL:", url + "?" + queryString);  // URL 확인
            const response = await fetch(url + "?" + queryString);
            if (!response.ok) {
              throw new Error('네트워크 응답에 문제가 발생했습니다.');
            }

            let result = "";
            if (isXml) {
              result = await response.text();
            } else {
              result = await response.json();
            }
            console.log("응답 결과:", result);  // 응답 결과 확인
            return result;
          } catch (e) {
            console.log("에러:", e);
            throw e;
          }
        };
      }

      const init = async () => {
        try {
          updateSido();
          areaCode1();
          const coords = await getCoords("서울특별시 강남구 테헤란로 212");
          updateMap([{
            address: "서울특별시 강남구 테헤란로 212",
            utmk: coords,
            label: "멀티캠퍼스",
          }]);
        } catch (error) {
          console.error("초기화 중 오류 발생:", error);
        }
      };
      init();
    </script>
  </body>
</html>
