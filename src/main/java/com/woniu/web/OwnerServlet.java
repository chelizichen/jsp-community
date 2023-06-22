package com.woniu.web;


import com.alibaba.fastjson.JSON;
import com.woniu.entity.Bill;
import com.woniu.entity.Owner;
import com.woniu.entity.User;
import com.woniu.utils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "owner",value = "/owner")
public class OwnerServlet extends HttpServlet {

    private QueryRunner queryRunner = new QueryRunner(DbUtils.getDataSource());


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //根据具体的传参，来决定做什么业务
        String opr = request.getParameter("opr");
        //登录
        if(opr.equals("del")){
            String uid = request.getParameter("uid");
            if(uid != null){
                String sql = " delete from owner where id = " + uid;
                try {
                    int update = queryRunner.update(sql);
                    request.getRequestDispatcher("/WEB-INF/jsp/ownerlist.jsp").forward(request,response);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }

        }
        if(opr.equals("list")){
            System.out.println("走到这");
            String sql = "select * from owner where 1 = 1 ";
            if(request.getParameter("id") != null){
                String id = request.getParameter("id");
                sql += "and id = " +id;
                try {
                    System.out.println(sql);
                    Owner query = queryRunner.query(sql, new BeanHandler<Owner>(Owner.class));
                    response.setContentType("application/json;charset=utf-8");
                    Object jsonStr = JSON.toJSON(query);
                    PrintWriter writer = response.getWriter();
                    writer.write(jsonStr.toString());
                    writer.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
                return;
            }

            try {
                if(request.getParameter("username") != null){
                    sql += "and name like '%" + request.getParameter("username") + "%'";
                }
                List<Owner> execute = queryRunner.query(sql, new BeanListHandler<Owner>(Owner.class));
                request.setAttribute("ownerList",execute);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
            request.getRequestDispatcher("/WEB-INF/jsp/ownerlist.jsp").forward(request,response);
        }
        if(opr.equals("update")){
            request.getRequestDispatcher("/WEB-INF/jsp/owneradd.jsp").forward(request,response);
        }

        if(opr.equals("modify")){
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            if(request.getParameter("id")!=null){
                String sql = "update owner set name = ?,phone = ?,email = ?,address = ? where id = ?";

                try {
                    queryRunner.update(sql,name,phone,email,address,id);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }else{
                String sql = "insert into owner(name,phone,email,address) values(?,?,?,?)";
                try {
                    queryRunner.update(sql,name,phone,email,address);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
            request.getRequestDispatcher("/WEB-INF/jsp/ownerlist.jsp").forward(request,response);

        }
    }


    //用户查询
    private void findUserByCondition(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {


        request.getRequestDispatcher("/WEB-INF/jsp/billlist1.jsp").forward(request,response);
    }


}
