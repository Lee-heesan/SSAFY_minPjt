package com.ssafy.live.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ssafy.live.model.dto.Address;
import com.ssafy.live.model.dto.Member;
import com.ssafy.live.model.dto.UserDTO;
import com.ssafy.live.util.DBUtil;


public class HappyHouseDaoImpl implements HappyhouseDao {
private static HappyHouseDaoImpl homeDao;
	
	public static HappyhouseDao getDao() {
		if(homeDao == null) {
			homeDao = new HappyHouseDaoImpl();
		}
		return homeDao;
	}
	
	@Override
	 public List<UserDTO> selectAll(Connection con, String sidoName, String gugunName, String dongName) throws SQLException {
	        List<UserDTO> list = new ArrayList<>();
	        
	        String sql = "SELECT " +
	                     "    dc.sido_name, " +
	                     "    dc.gugun_name, " +
	                     "    dc.dong_name, " +
	                     "    hd.floor, " +
	                     "    hd.deal_amount, " +
	                     "    hi.umd_nm, " +
	                     "    hi.apt_nm " +
	                     "FROM " +
	                     "    ssafyhome.dongcodes dc " +
	                     "JOIN " +
	                     "    ssafyhome.houseinfos hi " +
	                     "    ON dc.dong_name = hi.umd_nm " +  // 동 이름과 umd_nm을 비교
	                     "JOIN " +
	                     "    ssafyhome.housedeals hd " +
	                     "    ON hi.apt_seq = hd.apt_seq " +  // apt_seq 값이 일치하는 경우
	                     "WHERE " +
	                     "    dc.sido_name = ? " +  // sido_name 파라미터 바인딩
	                     "    AND dc.gugun_name = ? " + // gugun_name 파라미터 바인딩
	                     "    AND dc.dong_name = ?;";  // dong_name 파라미터 바인딩
	        
	        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
	            // 파라미터 바인딩
	            pstmt.setString(1, sidoName);
	            pstmt.setString(2, gugunName);
	            pstmt.setString(3, dongName);
	            System.out.println("DaoImpl 확인");
	            // 쿼리 실행
	            try (ResultSet rset = pstmt.executeQuery()) {
	                while (rset.next()) {
	                    // UserDTO 객체 생성
	                    UserDTO user = new UserDTO();
	                    
	                    // 결과에서 값을 UserDTO에 세팅
	                    user.setSido_name(rset.getString("sido_name"));
	                    user.setGugun_name(rset.getString("gugun_name"));
	                    user.setDong_name(rset.getString("dong_name"));
	                    user.setFloor(rset.getInt("floor"));
	                    String dealAmountStr = rset.getString("deal_amount");
	                    if (dealAmountStr != null) {
	                        dealAmountStr = dealAmountStr.replace(",", ""); // 쉼표 제거
	                        user.setDeal_amount(Integer.parseInt(dealAmountStr)); // 정수로 변환
	                    }
	                    user.setUmd_nm(rset.getString("umd_nm"));
	                    user.setApt_nm(rset.getString("apt_nm"));
	                    
	                    list.add(user);
	                }
	            }
	        }
		    return list;
		}
}