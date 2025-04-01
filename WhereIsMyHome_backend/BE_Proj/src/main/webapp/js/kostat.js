let accessToken;
const map = sop.map("map");
// marker 목록
const markers = [];
// 경계 목록
const bounds = [];

// access token 가져오기
const getAccessToken = async () => {
  try {
    const json = await getFetch("https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json", {
      consumer_key: "46d0d3813d9c4bc8af25", // 서비스 id
      consumer_secret: "bd0c408816314cdaa46f", // 보안 key
    });
    accessToken = json.result.accessToken;
  } catch (e) {
    console.log(e);
  }
};

// 주소를 UTM-K좌표로 변환해서 반환: - json의 errCd ==-401에서 access token 확보!!
const getCoords = async (address) => {
  try {
    const json = await getFetch("https://sgisapi.kostat.go.kr/OpenAPI3/addr/geocode.json", {
      accessToken: accessToken,
      address: address,
      resultcount: 1,
    });
    if (json.errCd === -401) {
      await getAccessToken();
      return await getCoords(address);
    }
    return json.result.resultdata[0];
  } catch (e) {
    console.log(e);
  }
};

const updateMap = (infos) => {
  resetMarker();
  try {
    for (let i = 0; i < infos.length; i++) {
      const info = infos[i];
      const marker = sop.marker([info.utmk.x, info.utmk.y]);
      marker.addTo(map).bindInfoWindow(info.label);
      markers.push(marker);
      bounds.push([info.utmk.x, info.utmk.y]);
    }
    // 경계를 기준으로 map을 중앙에 위치하도록 함
    if (bounds.length > 1) {
      map.setView(map._getBoundsCenterZoom(bounds).center, map._getBoundsCenterZoom(bounds).zoom);
    } else {
      map.setView(map._getBoundsCenterZoom(bounds).center, 9);
    }

    displayAptInfo(infos);
  } catch (e) {
    console.log(e);
  }
};
const displayAptInfo = (infos) => {
  const aptList = document.getElementById("apt-list"); // <ul> 요소 찾기
  aptList.innerHTML = ""; // 기존 리스트 내용 초기화

  infos.forEach((info) => {
    if (!info.label || !info.dealAmount || !info.excluUseAr || !info.dealYear || !info.dealMonth || !info.dealDay) {
      return; // 값이 하나라도 undefined이면 추가하지 않음
    }
    
    const container = document.createElement("div"); // 개별 거래 정보 컨테이너
    container.classList.add("apt-container");
    
    const mapDiv = document.createElement("div"); // 지도 표시 영역
    mapDiv.classList.add("apt-map");
    
    const infoDiv = document.createElement("div"); // 정보 표시 영역
    infoDiv.classList.add("apt-info");
    
    infoDiv.innerHTML = `
      <h3>${info.label}</h3>
      <p><strong>거래 금액:</strong> ${info.dealAmount}</p>
      <p><strong>면적:</strong> ${info.excluUseAr}</p>
      <p><strong>거래 날짜:</strong> ${info.dealYear} - ${info.dealMonth} - ${info.dealDay}</p>
    `;
    
    container.appendChild(mapDiv);
    container.appendChild(infoDiv);
    aptList.appendChild(container); // 컨테이너를 리스트에 추가
  });
};
// 마커와 경계 초기화
const resetMarker = () => {
  markers.forEach((item) => item.remove());
  bounds.length = 0;
};

