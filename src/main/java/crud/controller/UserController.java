package crud.controller;

import com.auth0.jwt.JWT;
import crud.bean.User;
import crud.service.UserService;
import crud.utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Locale;

@Controller
public class UserController {
    @Autowired
    UserService userService;
    @RequestMapping("/selectUser")
    @ResponseBody
    public String selectUser(@RequestParam("userid")String userid, @RequestParam("password") String password,HttpServletResponse response) {
        User user = userService.selectUser(userid, password);
        System.out.println(user.getPassword());
        if (user != null) {
            String token = JwtUtil.sign(userid, password);
            if (token != null) {
                System.out.println(token);
                Cookie cookie = new Cookie("user", token);
                cookie.setMaxAge(3600);//设置token有效时间
                //model.addAttribute("user", token);
                response.addCookie(cookie);
                return response.toString();
            }
        } else{
            return "error";}
        return null;

    }
@RequestMapping("/checkUser")
@ResponseBody
    public String checkUser(@RequestParam("userid") String userid){
        boolean check=userService.CheckUserByid(userid);
        if(check)
        return "success";
        else
            return "error";

}
@RequestMapping("/adddUser")
@ResponseBody
    public String addUser(User user){
        boolean check=userService.AddUser(user);
    if(check)
        return "success";
    else
        return "error";
}

}
