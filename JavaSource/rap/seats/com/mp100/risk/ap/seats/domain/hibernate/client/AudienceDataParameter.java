package com.mp100.risk.ap.seats.domain.hibernate.client;
import java.io.Serializable;

/**
 * Company: 北京众成联信信息技术有限公司 
 * 类描述 : 	受众数据参数类
 * @version 1.0
 * @since: 	2015-05-22
 * @author 	梁家豪
 * @serial:	2015-05-22
 */
public class AudienceDataParameter implements Serializable{
	private static final long serialVersionUID = -7056289018753361429L;
    private String mobile    ;  //号码
    private String province  ;  //省
    private String city      ;  //市
    
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
    
    
    

}
