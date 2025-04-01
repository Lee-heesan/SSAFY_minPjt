package com.ssafy.live.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.live.model.dto.UserDTO;

public interface HappyhouseService {
	List<UserDTO> selectAll(String sidoName, String gugunName, String dongName) throws SQLException;
}
