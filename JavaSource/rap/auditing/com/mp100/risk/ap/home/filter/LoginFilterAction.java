package com.mp100.risk.ap.home.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mp100.risk.ap.util.RapParameter;
import com.uap.common.utils.ObjectUtils;

public class LoginFilterAction implements Filter{

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;
		HttpSession session = request.getSession(true);
		
		String path = request.getRequestURI().replace(request.getContextPath(),"");
		// 针对登录页面或者登录页面请求或者退出请求都放行
		if (path.indexOf("/IndexAction-index") >=0 || path.indexOf("/MemberLoginAction-membersLogin") >= 0){
			chain.doFilter(request, response);
		}else if (ObjectUtils.isNull(session.getAttribute(RapParameter.DICTIONARY_LOGIN_INFO))) {// 用户回话失效和用户信息不存在跳转到登录页面
			// 跳转到登录页面
			session.setAttribute("Login", "loginTier();");
			response.sendRedirect(request.getContextPath());
			
		} else {
			chain.doFilter(request, response);
		}
	}

	@Override
	public void destroy() {

	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}
}
