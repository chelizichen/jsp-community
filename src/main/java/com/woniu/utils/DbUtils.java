package com.woniu.utils;

import com.alibaba.druid.pool.DruidDataSourceFactory;

import javax.sql.DataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Properties;

public class DbUtils {

    //声明一个数据源对象
    private static DataSource dataSource;
    private static ThreadLocal<Connection> threadLocal=new ThreadLocal<Connection>();  //本地线程变量

    /**
     * 静态初始化块
     */
    static {
        // 读取配置文件
        try (InputStream inStream = DbUtils.class.getClassLoader().getResourceAsStream("jdbc.properties")) {
            Properties props = new Properties();
            props.load(inStream);
            //创建连接池对象
            dataSource= DruidDataSourceFactory.createDataSource(props);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("配置文件读取失败");
        }
    }

    //返回连接池对象
    public static DataSource getDataSource(){
        return dataSource;
    }

    /**
     * 从数据源中获得一个连接对象
     */
    public static Connection getConnection() {
        Connection conn = threadLocal.get();
        try {
            if(conn==null) {
                conn = dataSource.getConnection();
                //关闭自动提交事务
                conn.setAutoCommit(true);

                //存到本地线程变量
                threadLocal.set(conn);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    /**
     * 回滚事务
     * @throws SQLException
     */
    public static void rollback() throws SQLException {
        Connection conn = threadLocal.get();
        if (conn != null) {
            conn.rollback();
        }
    }

    /**
     * 关闭连接
     */
    public static void closeConnection() {
        Connection conn=threadLocal.get();
        try {
            if (conn != null) {
                //提交事务
                conn.commit();
                //释放连接对象
                conn.close();
                //从ThreadLocal中删除连接
                threadLocal.remove();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
