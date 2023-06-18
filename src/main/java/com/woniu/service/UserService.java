package com.woniu.service;

import com.woniu.dao.UserDao;
import com.woniu.entity.User;

import java.util.List;
import java.util.Map;

public class UserService {

    private UserDao userDao = new UserDao();
    public User getUserByUserCode(String userCode){
        User user = userDao.getUserByUserCode(userCode);
        return user;
    }

    //调用dao的查询总记录条数的方法
    public Long getCountByCondition(Map<String,Object> maps){
        Long count = userDao.getCountByCondition(maps);
        return count;
    }


    public List<User> findUsersByCondition(Map<String,Object> maps){
        return userDao.findUsersByCondition(maps);
    }

    public User getUserById(Integer id){
        return userDao.getUserById(id);
    }
}
