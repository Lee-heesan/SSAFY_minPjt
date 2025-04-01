package com.ssafy.live.model.dto;

public class UserDTO {
    String sido_name;
    String gugun_name;
    String dong_name;
    int floor;
    int deal_amount;
    String umd_nm;
    String apt_nm;
    
    // 기본 생성자
    public UserDTO() {}
    
    // 파라미터가 있는 생성자
    public UserDTO(String sido_name, String gugun_name, String dong_name, int floor, int deal_amount, String umd_nm, String apt_nm) {
        this.sido_name = sido_name;
        this.gugun_name = gugun_name;
        this.dong_name = dong_name;
        this.floor = floor;
        this.deal_amount = deal_amount;
        this.umd_nm = umd_nm;
        this.apt_nm = apt_nm;
    }
    
    // Getter and Setter methods
    public String getSido_name() {
        return sido_name;
    }

    public void setSido_name(String sido_name) {
        this.sido_name = sido_name;
    }

    public String getGugun_name() {
        return gugun_name;
    }

    public void setGugun_name(String gugun_name) {
        this.gugun_name = gugun_name;
    }

    public String getDong_name() {
        return dong_name;
    }

    public void setDong_name(String dong_name) {
        this.dong_name = dong_name;
    }

    public int getFloor() {
        return floor;
    }

    public void setFloor(int floor) {
        this.floor = floor;
    }

    public int getDeal_amount() {
        return deal_amount;
    }

    public void setDeal_amount(int deal_amount) {
        this.deal_amount = deal_amount;
    }

    public String getUmd_nm() {
        return umd_nm;
    }

    public void setUmd_nm(String umd_nm) {
        this.umd_nm = umd_nm;
    }

    public String getApt_nm() {
        return apt_nm;
    }

    public void setApt_nm(String apt_nm) {
        this.apt_nm = apt_nm;
    }

	@Override
	public String toString() {
		return "UserDTO [sido_name=" + sido_name + ", gugun_name=" + gugun_name + ", dong_name=" + dong_name
				+ ", floor=" + floor + ", deal_amount=" + deal_amount + ", umd_nm=" + umd_nm + ", apt_nm=" + apt_nm
				+ "]";
	}
    
}
