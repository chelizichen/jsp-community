package com.woniu.web;


import com.alibaba.fastjson.JSON;
import com.woniu.entity.Fixed;
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

@WebServlet(name = "fixed",value = "/fixed")
public class FixedServlet extends HttpServlet {

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
                String sql = " delete from fixed where id = " + uid;
                try {
                    int update = queryRunner.update(sql);
                    request.getRequestDispatcher("/WEB-INF/jsp/fixedlist.jsp").forward(request,response);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }

        }
        if(opr.equals("list")){
            String sql = "select *,fixed.id as id from fixed inner join smbms_user on smbms_user.id = fixed.userid where 1 = 1 ";
            if(request.getParameter("id") != null){
                String id = request.getParameter("id");
                sql += "and fixed.id = " +id;
                try {
                    System.out.println(sql);
                    Fixed query = queryRunner.query(sql, new BeanHandler<Fixed>(Fixed.class));
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
                    sql += "and smbms_user.username like '%" + request.getParameter("username") + "%'";
                }
                System.out.println("sql is" + sql);
                List<Fixed> execute = queryRunner.query(sql, new BeanListHandler<Fixed>(Fixed.class));
                request.setAttribute("fixedList",execute);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
            request.getRequestDispatcher("/WEB-INF/jsp/fixedlist.jsp").forward(request,response);
        }
        if(opr.equals("update")){
            request.getRequestDispatcher("/WEB-INF/jsp/fixedadd.jsp").forward(request,response);
        }
        if(opr.equals("modify")){
            String id = request.getParameter("id");
            String userid = request.getParameter("userid");
            String fixedlevel = request.getParameter("fixedlevel");
            String fixedtitle = request.getParameter("fixedtitle");
            String fixeddesc = request.getParameter("fixeddesc");
            String fixedstatus = request.getParameter("fixedstatus");
            if(request.getParameter("id")!=null){
                String sql = "update fixed set userid = ?,fixedlevel = ?,fixedtitle = ?,fixeddesc = ?,fixedstatus = ? where id = ?";
                try {
                    queryRunner.update(sql,userid,fixedlevel,fixedtitle,fixeddesc,fixedstatus,id);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }

            }else{
                String sql = "insert into fixed(userid,fixedlevel,fixedtitle,fixeddesc,fixedstatus) values(?,?,?,?,?)";
                try {
                    queryRunner.update(sql,userid,fixedlevel,fixedtitle,fixeddesc,fixedstatus);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
        }
        request.getRequestDispatcher("/WEB-INF/jsp/fixedlist.jsp").forward(request,response);



    }


    //用户查询
    private void findUserByCondition(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {


        request.getRequestDispatcher("/WEB-INF/jsp/fixedlist.jsp").forward(request,response);
    }


}
