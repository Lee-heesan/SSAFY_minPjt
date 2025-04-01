<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>부동산 사이트</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            color: #333;
        }
        .header {
            background-color: #fff;
            padding: 20px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #ddd;
        }
        .header .logo {
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }
        .header .nav {
            display: flex;
            gap: 20px;
        }
        .header .nav a {
            text-decoration: none;
            color: #333;
            font-weight: bold;
            padding: 10px;
            transition: color 0.3s ease;
        }
        .header .nav a:hover {
            color: #007BFF;
        }
	    .banner-container {
            position: relative;
            width: 100%;
            height: 400px;
            overflow: hidden;
            margin-bottom: 30px;
        }
        .banner {
            display: flex;
            transition: transform 0.5s ease-in-out;
        }
        .banner img {
            width: 100%;
            height: 400px;
            object-fit: cover;
        }
        .banner-button {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background-color: rgba(0, 0, 0, 0.5);
            color: #fff;
            border: none;
            padding: 10px;
            cursor: pointer;
            font-size: 24px;
        }
        .prev {
            left: 10px;
        }
        .next {
            right: 10px;
        }

        .content {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            padding: 20px 30px;
        }
        .info, .news {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #ddd;
            width: 48%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .info h2, .news h2 {
            font-size: 22px;
            margin-bottom: 15px;
        }
        .info p, .news p {
            font-size: 16px;
            color: #666;
        }
        .recommended {
            padding: 30px;
            background-color: #fff;
            margin: 20px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .recommended h3 {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .property-list {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }
        .property {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
            transition: transform 0.3s ease;
        }
        .property:hover {
            transform: scale(1.05);
        }
        footer {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 20px;
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <%@ include file="/fragments/header.jsp" %>
    
	<div class="banner-container">
        <div class="banner" id="banner">
            <!-- 배너 이미지가 동적으로 로드됨 -->
        </div>
        <button class="banner-button prev" onclick="prevBanner()">&#10094;</button>
        <button class="banner-button next" onclick="nextBanner()">&#10095;</button>
    </div>

    <div class="content">
        <div class="info">
            <a href="${root }/main?action=map">
                <h2>실거래가 조회</h2>
                <p>실거래가 조회 및 지도 제공</p>
            </a>
        </div>
        <div class="news">
            <a href="#">
                <h2>부동산 뉴스</h2>
                <p>서울 아파트, 매매·전세 값 변동 추이...</p>
            </a>
        </div>
    </div>

    <div class="recommended">
        <h3>추천 매물</h3>
        <div class="property-list">
            <img src="https://cdn.gnnews.co.kr/news/photo/202102/467585_257246_1836.jpg" alt="추천 매물 1" class="property">
            <img src="https://cdn.gnnews.co.kr/news/photo/202102/467585_257246_1836.jpg" alt="추천 매물 2" class="property">
            <img src="https://cdn.gnnews.co.kr/news/photo/202102/467585_257246_1836.jpg" alt="추천 매물 3" class="property">
            <img src="https://cdn.gnnews.co.kr/news/photo/202102/467585_257246_1836.jpg" alt="추천 매물 4" class="property">
        </div>
    </div>

    <%@ include file="/fragments/footer.jsp" %>

    <script>
    let index = 0;
    const banner = document.getElementById("banner");
    let banners = [];
    let slideInterval;

    function loadImages() {
        const imageUrls = [
            "https://image.ajunews.com/content/image/2022/04/04/20220404181310254680.jpg",
            "https://thumb.mt.co.kr/06/2022/07/2022071323233486792_1.jpg/dims/optimize/",
            "https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/202303/05/17313d5e-aa0d-4848-9e22-d07d731d5525.jpg"
        ];

        if (imageUrls.length === 0) {
            banner.innerHTML = "<p>이미지가 없습니다.</p>";
            return;
        }

        // 배너 이미지 로드
        imageUrls.forEach((src) => {
            const img = document.createElement("img");
            img.src = src;
            img.alt = "배너 이미지";
            banner.appendChild(img);
        });

        banners = document.querySelectorAll(".banner img");

        // 배너 슬라이드를 자동으로 시작
        startAutoSlide();
    }

    function showBanner() {
        if (banners.length === 0) return;
        // 배너를 현재 index에 맞게 이동
        banner.style.transform = `translateX(-${index * 100}%)`;
    }

    function nextBanner() {
        if (banners.length <= 1) return;
        index = (index + 1) % banners.length; // 슬라이드가 끝나면 처음으로 돌아가도록
        showBanner();
        resetAutoSlide(); // 자동 슬라이드 초기화
    }

    function prevBanner() {
        if (banners.length <= 1) return;
        index = (index - 1 + banners.length) % banners.length; // 이전으로 이동, 끝에서 처음으로 돌아가도록
        showBanner();
        resetAutoSlide(); // 자동 슬라이드 초기화
    }

    function startAutoSlide() {
        if (banners.length > 1) {
            slideInterval = setInterval(nextBanner, 5000); // 5초마다 슬라이드
        }
    }

    function resetAutoSlide() {
        clearInterval(slideInterval); // 기존 타이머 제거
        startAutoSlide(); // 새로운 타이머 시작
    }

    loadImages(); // 페이지 로드 시 이미지 로드 시작
    </script>
</body>
</html>
