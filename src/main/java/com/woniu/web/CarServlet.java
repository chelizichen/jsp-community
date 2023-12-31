package com.woniu.web;


import com.alibaba.fastjson.JSON;
import com.woniu.entity.Car;
import com.woniu.entity.Owner;
import com.woniu.entity.Visitor;
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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "car",value = "/car")
public class CarServlet extends HttpServlet {

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
                String sql = " delete from car where id = " + uid;
                try {
                    int update = queryRunner.update(sql);
                    request.getRequestDispatcher("/WEB-INF/jsp/carlist.jsp").forward(request,response);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }

        }
        if(opr.equals("list")){
            String sql = "select * from car  where 1 = 1 ";
            if(request.getParameter("id") != null){
                String id = request.getParameter("id");
                sql += "and id = " +id;
                try {
                    System.out.println(sql);
                    Car query = queryRunner.query(sql, new BeanHandler<Car>(Car.class));
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
                System.out.println(request.getParameter("username"));
                if(request.getParameter("username") != null){
                    sql += "and username like '%" + request.getParameter("username") + "%'";
                }
                System.out.println("sql is " + sql);
                List<Car> execute = queryRunner.query(sql, new BeanListHandler<Car>(Car.class));
                request.setAttribute("carList",execute);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
            request.getRequestDispatcher("/WEB-INF/jsp/carlist.jsp").forward(request,response);
        }
        if(opr.equals("update")){
            request.getRequestDispatcher("/WEB-INF/jsp/caradd.jsp").forward(request,response);
        }
        if(opr.equals("modify")){
            SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd.HH:mm:ss");
            String iotime = date.format(new Date());
            String id = request.getParameter("id");
            String username = request.getParameter("username");
            String paytype = request.getParameter("paytype");
            String carid = request.getParameter("carid");
            String io = request.getParameter("io");
            if(request.getParameter("id")!=null){
                String sql = "update car set iotime = ?,username = ?,paytype = ?,io = ?,carid = ? where id = ?";
                try {
                    queryRunner.update(sql,iotime,username,paytype,io,id,carid);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }

            }else{
                String sql = "insert into car(iotime,username,paytype,io,carid) values(?,?,?,?)";
                try {
                    queryRunner.update(sql,iotime,username,paytype,io,id,carid);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
            request.getRequestDispatcher("/WEB-INF/jsp/carlist.jsp").forward(request,response);
        }

    }



}
