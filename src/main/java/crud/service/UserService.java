package crud.service;

import crud.bean.User;
import crud.dao.UserMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    @Autowired
    UserMapper userMapper;
    public User selectUser(String userid,String password){
        return userMapper.selectUser(userid,password);


    }
public boolean CheckUserByid(String userid){
        User user=userMapper.CheckUser(userid);
        if(user==null)
            return true;
        else
            return false;

}
public boolean AddUser(User user){
        int checkNum=userMapper.insertUser(user);
        if(checkNum==0)
            return false;
        else
            return true;
}
}
