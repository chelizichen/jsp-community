package com.woniu.web;


import com.alibaba.fastjson.JSON;
import com.woniu.entity.Bill;
import com.woniu.entity.Fixed;
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

@WebServlet(name = "bill",value = "/bill")
public class BillServlet extends HttpServlet {

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
                String sql = " delete from bill where id = " + uid;
                try {
                    int update = queryRunner.update(sql);
                    request.getRequestDispatcher("/WEB-INF/jsp/billlist1.jsp").forward(request,response);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }

        }
        if(opr.equals("list")){

            String sql = "select bill.id," +
                    "bill.userid,bill.price," +
                    "bill.status,smbms_user.username" +
                    " from bill inner join smbms_user on smbms_user.id = bill.userid where 1 = 1 ";
            if(request.getParameter("id") != null){
                String id = request.getParameter("id");
                sql += "and bill.id = " +id;
                try {
                    System.out.println(sql);
                    Bill query = queryRunner.query(sql, new BeanHandler<Bill>(Bill.class));
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
                    sql += "and smbms_user.username like '%" + request.getParameter("username") + "%'";
                }
                System.out.println("sql is" + sql);
                List<Bill> execute = queryRunner.query(sql, new BeanListHandler<Bill>(Bill.class));
                request.setAttribute("billList",execute);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
            request.getRequestDispatcher("/WEB-INF/jsp/billlist1.jsp").forward(request,response);
        }
        if(opr.equals("update")){
            request.getRequestDispatcher("/WEB-INF/jsp/billadd.jsp").forward(request,response);
        }

        if(opr.equals("modify")){
            String id = request.getParameter("id");
            String userid = request.getParameter("userid");
            String price = request.getParameter("price");
            String status = request.getParameter("status");
            if(request.getParameter("id")!=null){
                String sql = "update bill set userid = " + userid +
                        ",price = "+price + ",status = " + status +" where id = " + id;

                try {
                    queryRunner.update(sql);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }else{
                String sql = "insert into bill(userid,price,status) values(?,?,?)";
                try {
                    queryRunner.update(sql,userid,price,status);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
            request.getRequestDispatcher("/WEB-INF/jsp/billlist1.jsp").forward(request,response);
        }
    }


    //用户查询
    private void findUserByCondition(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {


        request.getRequestDispatcher("/WEB-INF/jsp/billlist1.jsp").forward(request,response);
    }


}
