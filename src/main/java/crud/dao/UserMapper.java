package crud.dao;

import crud.bean.User;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {
User selectUser(@Param("userid") String userid,@Param("password") String password);
User CheckUser(@Param("userid") String userid);
int insertUser(User user);
}
