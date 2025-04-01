package com.ssafy.live.controller;

import com.ssafy.live.model.dto.UserDTO;
import com.ssafy.live.model.service.HappyhouseServiceImpl;
import com.ssafy.live.model.service.HappyhouseService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/home")
public class MainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private HappyhouseService houseService = HappyhouseServiceImpl.getinstance();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        // action 파라미터가 null이면 "list"로 기본값 설정
        if (action == null) {
            action = "list";
        }

        try {
            // action이 "list"인 경우만 처리
            if ("list".equals(action)) {
                list(request, response);
            } else {
                list(request, response); // 기본적으로 "list"로 처리
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void list(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        // sido_name, gugun_name, dong_name 파라미터 가져오기
        String sidoName = request.getParameter("sido_name");
        String gugunName = request.getParameter("gugun_name");
        String dongName = request.getParameter("dong_name");

        // houseService에서 거래 목록 조회
        List<UserDTO> houseList = houseService.selectAll(sidoName, gugunName, dongName);
        System.out.println(houseList.get(0).getApt_nm());

        // 조회된 거래 목록을 request에 담아 JSP로 포워딩
        request.setAttribute("list", houseList);
        request.getRequestDispatcher("/main?action=map").forward(request, response);
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);  // POST 요청도 doGet 메서드로 처리
    }

}
