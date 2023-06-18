package com.woniu.web;


import com.alibaba.fastjson.JSON;
import com.woniu.entity.Role;
import com.woniu.entity.User;
import com.woniu.service.RoleService;
import com.woniu.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "user",value = "/user")
public class UserServlet extends HttpServlet {
    private UserService userService = new UserService();
    private RoleService roleService = new RoleService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //根据具体的传参，来决定做什么业务
        String opr = request.getParameter("opr");
        //登录
        if(opr.equals("login")){
            this.login(request,response);
        }
        if(opr.equals("userList")){
            //查询  参数：queryUserRole(根据用户角色查) |  queryname（用户名）  |   pageIndex(页码)
            this.findUserByCondition(request,response);
        }
        if(opr.equals("userview")){
            getUserById(request,response);
        }
    }

    //用户登录
    private void login(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        String userCode = request.getParameter("userCode");
        String pass = request.getParameter("userPassword");

        User user = userService.getUserByUserCode(userCode);
        if(user ==null){
            request.setAttribute("error","用户名不正确");
            request.getRequestDispatcher("/login.jsp").forward(request,response);
        }else{
            if(!user.getUserPassword().equals(pass)){
                request.setAttribute("error","密码不正确");
                request.getRequestDispatcher("/login.jsp").forward(request,response);
            }else{
                //用session把这个user对象装起来，在页面上通过这个SessionScope去取用户的姓名
                request.getSession().setAttribute("userSession",user);
                request.getRequestDispatcher("/WEB-INF/jsp/frame.jsp").forward(request,response);
            }


        }
    }

    //用户查询
    private void findUserByCondition(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        //获取参数    用户角色
        String roleId = request.getParameter("queryUserRole");
        String userName = request.getParameter("queryname");
        String pageIndex = request.getParameter("pageIndex");

        Map<String,Object> maps = new HashMap<>();
        maps.put("roleId",roleId);
        maps.put("userName",userName);

        if(pageIndex == null || pageIndex.equals("0")){
            pageIndex = "1";
        }
        //每页大小是5
        int pageSize = 5;
        //定义总页码
        int totalPages = 0;
        //查询符合条件的记录数
        Long count = userService.getCountByCondition(maps);
        int totalCount = Integer.parseInt(count+"");
        if(totalCount % pageSize == 0){
            totalPages = totalCount/pageSize;
        }else{
            totalPages = totalCount/pageSize + 1;
        }
        //控制尾页
        int currentIndex = Integer.parseInt(pageIndex);
        if(currentIndex > totalPages ){
            currentIndex = totalPages;
        }
        maps.put("pageIndex",(currentIndex-1)*pageSize);
        maps.put("pageSize",pageSize);
        List<User> users = userService.findUsersByCondition(maps);
        //查询用户角色列表，在页面上显示
        List<Role> roles = roleService.findAllRoles();
        //页面要显示用户信息
        request.setAttribute("userList",users);
        //装记录数
        request.setAttribute("pages",totalPages);
        //当前页
        request.setAttribute("currentPage",currentIndex);
        request.setAttribute("roleList",roles);
        request.setAttribute("queryUserRole",roleId);

        request.getRequestDispatcher("/WEB-INF/jsp/userlist.jsp").forward(request,response);
    }

    //查询某个用户
    private void getUserById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        User user = userService.getUserById(Integer.parseInt(id));

        //服务器响应客户端的数据是什么类型，编码是什么
        response.setContentType("text/html;charset=utf-8");
        Object jsonStr = JSON.toJSON(user);
        PrintWriter writer = response.getWriter();
        writer.write(jsonStr.toString());
        writer.close();

    }
}
