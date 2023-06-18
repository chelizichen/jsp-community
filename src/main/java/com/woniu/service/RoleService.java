package com.woniu.service;

import com.woniu.dao.RoleDao;
import com.woniu.entity.Role;

import java.util.List;

public class RoleService {

    private RoleDao roleDao = new RoleDao();

    public List<Role> findAllRoles(){
        return roleDao.findAllUsers();
    }
}
