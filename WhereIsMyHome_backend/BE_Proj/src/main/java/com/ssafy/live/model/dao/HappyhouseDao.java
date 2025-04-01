package com.ssafy.live.model.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.ssafy.live.model.dto.UserDTO;

public interface HappyhouseDao {
	List<UserDTO> selectAll(Connection con, String sidoName, String gugunName, String dongName) throws SQLException;
}
