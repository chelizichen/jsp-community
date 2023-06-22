package com.woniu.web;


import com.alibaba.fastjson.JSON;
import com.woniu.entity.Bill;
import com.woniu.entity.House;
import com.woniu.entity.Owner;
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

@WebServlet(name = "house",value = "/house")
public class HouseServlet extends HttpServlet {

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
                String sql = " delete from house where id = " + uid;
                try {
                    int update = queryRunner.update(sql);
                    request.getRequestDispatcher("/WEB-INF/jsp/houselist.jsp").forward(request,response);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }

        }
        if(opr.equals("list")){
            String sql = "select *,house.id as id,house.address as address from house inner join owner on owner.id = house.ownerid where 1 = 1 ";
            if(request.getParameter("id") != null){
                String id = request.getParameter("id");
                sql += "and house.id = " +id;
                try {
                    System.out.println(sql);
                    House query = queryRunner.query(sql, new BeanHandler<House>(House.class));
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
                    sql += "and owner.`name` like '%" + request.getParameter("username") + "%'";
                }
                System.out.println("sql is" + sql);
                List<House> execute = queryRunner.query(sql, new BeanListHandler<House>(House.class));
                request.setAttribute("houseList",execute);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
            request.getRequestDispatcher("/WEB-INF/jsp/houselist.jsp").forward(request,response);
        }
        if(opr.equals("update")){
            request.getRequestDispatcher("/WEB-INF/jsp/houseadd.jsp").forward(request,response);
        }

        if(opr.equals("modify")){
            String id = request.getParameter("id");
            String address = request.getParameter("address");
            String type = request.getParameter("type");
            String area = request.getParameter("area");
            String ownerid = request.getParameter("ownerid");
            String price = request.getParameter("price");
            System.out.println(id + address + type + address + ownerid);
            if(request.getParameter("id")!=null){
                String sql = "update house set address = ?,type = ?,area = ?,ownerid = ?,price = ? where id = ?";
                try {
                    queryRunner.update(sql,address,type,area,ownerid,price,id);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }else{
                String sql = "insert into house(address,type,area,ownerid,price) values(?,?,?,?,?)";
                try {
                    queryRunner.update(sql,address,type,area,ownerid,price);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
            request.getRequestDispatcher("/WEB-INF/jsp/houselist.jsp").forward(request,response);

        }
    }


    //用户查询
    private void findUserByCondition(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {


        request.getRequestDispatcher("/WEB-INF/jsp/billlist1.jsp").forward(request,response);
    }


}
