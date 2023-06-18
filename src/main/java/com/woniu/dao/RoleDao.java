package com.woniu.dao;

import com.woniu.entity.Role;
import com.woniu.utils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.List;

public class RoleDao {

    private QueryRunner queryRunner = new QueryRunner(DbUtils.getDataSource());

    //查询角色列表
    public List<Role> findAllUsers(){
        String sql = "select * from smbms_role";
        try {
           return  queryRunner.query(sql,new BeanListHandler<Role>(Role.class));
        }catch (SQLException exception){
            exception.printStackTrace();
        }
        return null;
    }
}
