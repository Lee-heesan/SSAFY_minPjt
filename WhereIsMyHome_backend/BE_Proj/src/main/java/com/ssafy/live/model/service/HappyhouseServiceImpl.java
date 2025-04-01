package com.ssafy.live.model.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.ssafy.live.model.dao.HappyHouseDaoImpl;
import com.ssafy.live.model.dao.HappyhouseDao;
import com.ssafy.live.model.dto.UserDTO;
import com.ssafy.live.util.DBUtil;

public class HappyhouseServiceImpl implements HappyhouseService {
	private HappyhouseServiceImpl() {}
	private static HappyhouseServiceImpl instance = new HappyhouseServiceImpl();
	public static HappyhouseServiceImpl getinstance() {
		return instance;
	}
	private DBUtil dbUtil = DBUtil.getUtil();
	private HappyhouseDao HouseDao = HappyHouseDaoImpl.getDao();
	
	public List<UserDTO> selectAll(String sidoName, String gugunName, String dongName) throws SQLException{
		try(Connection con = dbUtil.getConnection()) {
			return HouseDao.selectAll(con, sidoName, gugunName, dongName);
		}
	}
}
