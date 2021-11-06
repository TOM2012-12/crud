package crud.interceptors;

import com.alibaba.fastjson.JSONObject;
import crud.utils.JwtUtil;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

public class TokenInterceptor implements HandlerInterceptor
        {

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("执行方法之前执行这步操作！");
        response.setCharacterEncoding("utf-8");
        Cookie cookie=getCookieByName(request,"user");
        //如果已经登录，不拦截
        if (null != cookie) {
            //验证token是否正确
            boolean result = JwtUtil.verify(cookie.getValue());
            if(!result) {
                return false;
            }
            return true;
        }
        //如果没有登录，则跳转到登录界面
        else {
            //重定向 第一种 调用控制器 方法
            response.sendRedirect(request.getContextPath());
            //重定向 第二种 重定向方法
            //            request.getRequestDispatcher("WEB-INF/jsp/login.jsp").forward(request, response);
            //            System.out.println(request.getContextPath());
            return false;
            /**
             * 以下是为了登录成功后返回到刚刚的操作，不跳到主界面
             * 实现：通过将请求URL保存到session的beforePath中，然后在登录时判断beforePath是否为空
             */
        }
    }


    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    }


    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
    }

    /**
     * 根据名字获取cookie
     *
     * @param request
     * @param name    cookie名字
     * @return
     */
    public static Cookie getCookieByName(HttpServletRequest request, String name) {
        Map<String, Cookie> cookieMap = ReadCookieMap(request);
        if (cookieMap.containsKey(name)) {
            Cookie cookie =  cookieMap.get(name);
            return cookie;
        } else {
            return null;
        }
    }
    /**
     * 将cookie封装到Map里面
     *
     * @param request
     * @return
     */
    private static Map<String, Cookie> ReadCookieMap(HttpServletRequest request) {
        Map<String, Cookie> cookieMap = new HashMap<String, Cookie>();
        Cookie[] cookies = request.getCookies();
        if (null != cookies) {
            for (Cookie cookie : cookies) {
                cookieMap.put(cookie.getName(), cookie);
            }
        }
        return cookieMap;
    }

    /**
     * 返回信息给客户端
     *
     * @param response
     * @param out
     * @param apiResponse
     */
    private void responseMessage(HttpServletRequest request, HttpServletResponse response, PrintWriter out) throws IOException {
        response.setContentType("application/json; charset=utf-8");
        //out.print(JSONObject.toJSONString(apiResponse));
        out.flush();
        out.close();
    }
}
