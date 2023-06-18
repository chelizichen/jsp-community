<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@include file="/WEB-INF/jsp/common/head.jsp" %>

<div class="right">
    <div class="location">
        <strong>你现在所在的位置是:</strong> <span>用户管理页面</span>
    </div>
    <div class="search">
        <form method="get" action="${pageContext.request.contextPath }/user"
              id="queryform">
            <input type="hidden" name="opr" value="userList"/>
            <span>用户名：</span>
            <input name="queryname" class="input-text"
                                     type="text" value="${requestScope.queryUserName}"> <span>用户角色：</span>
            <select name="queryUserRole">
                <c:if test="${roleList != null }">
                    <option value="0">--请选择--</option>
                    <c:forEach var="role" items="${requestScope.roleList}">
                        <option
                                <c:if test="${role.id == requestScope.queryUserRole }">selected="selected"
                        </c:if> value="${role.id}">${role.roleName}</option>
                    </c:forEach>
                </c:if>
            </select>
            <input type="hidden" name="pageIndex" value="1"/>
            <input value="查 询" type="submit" id="searchbutton">
            <a href="${pageContext.request.contextPath}/user?opr=add">添加用户</a>
        </form>
    </div>
    <!--用户-->
    <table class="providerTable" cellpadding="0" cellspacing="0">
        <tr class="firstTr">
            <th width="10%">用户编码</th>
            <th width="20%">用户名称</th>
            <th width="10%">性别</th>
            <th width="20%">电话</th>
            <th width="10%">用户角色</th>
            <th width="30%">操作</th>
        </tr>
        <c:forEach var="user" items="${requestScope.userList }" varStatus="status">
            <tr>
                <td><span>${user.userCode }</span>
                </td>
                <td><span>${user.userName }</span>
                </td>
                <td><span> <c:if test="${user.gender==1}">男</c:if> <c:if
                        test="${user.gender==2}">女</c:if> </span>
                </td>
                <td><span>${user.phone}</span>
                </td>
                <td><span>${user.roleName}</span>
<%--                <span>${user.role.roleName}</span>--%>
                </td>

                <td><span><a class="viewUser" href="javascript:goViewUser(${user.id});"
                             userid=${user.id } username=${user.userName }>
							<img src="${pageContext.request.contextPath }/statics/images/read.png"
                                 alt="查看" title="查看"/>
					      </a> 
					 </span>

                    <span>
							<a class="modifyUser"
                               href="${pageContext.request.contextPath }/user?opr=userModify&id=${user.id}">
								<img src="${pageContext.request.contextPath}/statics/images/xiugai.png"
                                     alt="修改" title="修改"/>
						    </a> </span> <span>

							<a class="deleteUser" userid=${user.id } username=${user.userName }
                               href="#">
								<img src="${pageContext.request.contextPath }/statics/images/schu.png"
                                     alt="删除" title="删除"/>
							</a> 
					 </span>
                </td>
            </tr>
        </c:forEach>
    </table>
    <input type="hidden" id="totalPageCount" value="${requestScope.pages}"/>
    <center>
        <div style="margin-top:10px">
            <a href="javascript:goPage(1)">首页</a>
            <a href="javascript:goPage(${requestScope.currentPage-1})">上一页</a>
            <c:if test="${not empty requestScope.pages}">
                <c:forEach begin="1" end="${requestScope.pages}" step="1" var="s">
                    <a href="javascript:goPage(${s})">${s}</a>
                </c:forEach>
            </c:if>

            <a href="javascript:goPage(${requestScope.currentPage + 1 })">下一页</a>
            <a href="javascript:goPage(${requestScope.pages})">尾页</a>

        </div>
    </center>

    <div class="providerAdd" style="height:350px;border:1px dashed;">
        <div style="float:left;border:1px solid red">
            <div>
                <label>用户编码：</label> <input type="text" id="v_userCode" value=""
                                            readonly="readonly">
            </div>
            <div>
                <label>用户名称：</label> <input type="text" id="v_userName" value=""
                                            readonly="readonly">
            </div>
            <div>
                <label>用户性别：</label> <input type="text" id="v_gender" value=""
                                            readonly="readonly">
            </div>
            <div>
                <label>出生日期：</label> <input type="text" Class="Wdate" id="v_birthday"
                                            value="" readonly="readonly" onclick="WdatePicker();">
            </div>
            <div>
                <label>用户电话：</label> <input type="text" id="v_phone" value=""
                                            readonly="readonly">
            </div>
            <div>
                <label>用户角色：</label> <input type="text" id="v_userRoleName" value=""
                                            readonly="readonly">
            </div>
            <div>
                <label>用户地址：</label> <input type="text" id="v_address" value=""
                                            readonly="readonly">
            </div>
        </div>
        <div style="border:1px solid red;float:right;width:200px;height:200px;">
            <img style="width:200px;height:200px;"
                 src="" alt="看看"
                 title="看看" id="idpicpath"/>
        </div>
    </div>

</div>
</section>

<!--点击删除按钮后弹出的页面-->
<div class="zhezhao"></div>
<div class="remove" id="removeUse">
    <div class="removerChid">
        <h2>提示</h2>
        <div class="removeMain">
            <p>你确定要删除该用户吗？</p>
            <a href="#" id="yes">确定</a> <a href="#" id="no">取消</a>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/jsp/common/foot.jsp" %>
<script type="text/javascript"
        src="${pageContext.request.contextPath }/statics/js/userlist.js"></script>

<script type="text/javascript">
    function goPage(pageindex) {
        var pageform = document.getElementById("queryform");
        pageform.pageIndex.value = pageindex;
        //pageform.action=pageform.action+"id="+document.getElementById("input").value;
        pageform.submit();
    }
    function goViewUser(id) {
        $.ajax({
            type:"get",
            url:"${pageContext.request.contextPath}/user?opr=userview",
            data:{"id":id},
            datatype:"json",
            success:function (result) {
                console.log(result);
                let user=JSON.parse(result);
                console.log(user);
                $("#v_userCode").val(user.userCode);
                $("#v_userName").val(user.userName);
                $("#v_userRoleName").val(user.roleName);
                $("#v_address").val(user.address);
                $("#v_birthday").val(user.birthday);
                if(user.gender == 1){
                    $("#v_gender").val("男");
                }else{
                    $("#v_gender").val("女");
                }

                $("#v_phone").val(user.phone);
                let path="${pageContext.request.contextPath}/"+user.idpicpath;
                $("#idpicpath").attr("src",path);
            }
        });
    }

</script>
