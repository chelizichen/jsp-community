package com.woniu.dao;

import com.woniu.entity.User;
import com.woniu.utils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.SQLException;
import java.util.*;

public class UserDao {
    private QueryRunner queryRunner = new QueryRunner(DbUtils.getDataSource());


    public User getUserByUserCode(String userCode){
        String sql = "select * from smbms_user where usercode = ?";
        try {
            User user = queryRunner.query(sql, new BeanHandler<User>(User.class),userCode);
            return user;
        }catch (SQLException exception){
            exception.printStackTrace();
        }
        return null;

    }
    //符合条件的记录数
    public Long getCountByCondition(Map<String,Object> maps){
        String sql = "select count(*) from smbms_user where 1 = 1" ;
        List<Object> lists = new ArrayList();
        if(maps.get("roleId") != null ){
            if(!maps.get("roleId").equals("0")){
                sql += " and roleid = ?";
                maps.put("roleId", Integer.parseInt(maps.get("roleId").toString()));
                lists.add(Integer.parseInt(maps.get("roleId").toString()));
            }else{
                maps.remove("roleId");
            }
        }else{
            maps.remove("roleId");
        }
        if(maps.get("userName") != null){
            if(!maps.get("userName").equals("")){
                sql += " and username = ?";
                lists.add(maps.get("userName"));
            }else{
                maps.remove("userName");
            }
        }else{
            maps.remove("userName");
        }
        try {
            Long flag = queryRunner.query(sql, new ScalarHandler<Long>(),lists.toArray());
            return flag;

        }catch (SQLException ex){
            ex.printStackTrace();
        }
        return 0L;
    }



    //符合条件的记录
    public List<User> findUsersByCondition(Map<String,Object> maps){
        String sql = "select u.*,r.rolename from smbms_user u inner join smbms_role r " +
                "on u.roleid = r.id where 1 = 1 ";
        List<Object> lists =  new ArrayList<>();

        if(maps.get("roleId") != null ){
            if(!maps.get("roleId").equals("0")){
                sql += " and roleid = ?";
                lists.add( maps.put("roleId", Integer.parseInt(maps.get("roleId").toString())));
            }
        }
        if(maps.get("userName") != null){
            if(!maps.get("userName").equals("")){
                sql += " and username = ?";
                lists.add(maps.get("userName"));
            }
        }
        sql += " limit ?,?";
        lists.add(maps.get("pageIndex"));
        lists.add(maps.get("pageSize"));

        try {
            List<User> users = queryRunner.query(sql,new BeanListHandler<User>(User.class),
                    lists.toArray());
            return users;
        }catch (SQLException exception){
            exception.printStackTrace();
        }
        return null;
    }

    public User getUserById(Integer id){
        String sql = "select u.*,r.rolename from smbms_user u inner join smbms_role r on u.roleid = r.id  where u.id = ?";
        try {
            return queryRunner.query(sql,new BeanHandler<User>(User.class),id);
        }catch (SQLException ex){
            ex.printStackTrace();
        }
        return null;
    }

}
