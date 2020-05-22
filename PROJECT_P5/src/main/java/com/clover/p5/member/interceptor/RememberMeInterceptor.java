package com.clover.p5.member.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.clover.p5.member.dto.Member;
import com.clover.p5.member.mapper.MemberMapper;
import com.clover.p5.member.service.MemberService;

public class RememberMeInterceptor extends HandlerInterceptorAdapter {
	
    @Autowired
    MemberService memberService;
    @Autowired
    MemberMapper memberMapper;
     
    // preHandle() : 컨트롤러보다 먼저 수행되는 메서드
    @Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler)
            throws Exception {
         
        // session 객체를 가져옴
        HttpSession session = req.getSession();
 //       System.out.println("자동로그인 하러왔나요?");
        // login처리를 담당하는 사용자 정보를 담고 있는 객체를 가져옴
        if (session.getAttribute("user") == null ){// 로그인된 세션이 없는 경우...
            // 우리가 만들어 논 쿠키를 꺼내온다.
            Cookie rememberMe = WebUtils.getCookie(req,"rememberMe");
            
            if (rememberMe != null){// 쿠키가 존재하는 경우(이전에 로그인때 생성된 쿠키가 존재한다는 것)
                String cookieValue = rememberMe.getValue();
                
                if(memberMapper.selectRememberMeCount(cookieValue) == 1) { // 유효한 쿠키이면
                	int memberId = memberMapper.selectRememberMeMemberId(cookieValue);
                	Member member = memberMapper.selectMember(memberId);
                	
                	session.setAttribute("user", member); // 해당 정보를 찾아 세션에 넣어주고
                	rememberMe = memberService.refreshCookie(req, memberId); // DB의 쿠키 정보를 갱신한다.
                	res.addCookie(rememberMe); // 갱신된 쿠키를 보내준다.
                	
                	System.out.println("자동 로그인을 완료했습니다.");
                }
            }
        }
        return true;
    }
 



}