<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@include file="/WEB-INF/jsp/common/head.jsp" %>

<div class="right">
    <div class="location">
        <strong>你现在所在的位置是:</strong> <span>业主管理页面</span>
    </div>
    <div class="search">
        <form method="get" action="${pageContext.request.contextPath }/owner?opr=list"
              id="queryform">
            <input type="hidden" name="opr" value="list"/>
            <span>用户名：</span>
            <input type="hidden" name="pageIndex" value="1"/>
            <input type="text" name="username"/>
            <input value="查 询" type="submit" id="searchbutton">
            <a href="${pageContext.request.contextPath}/owner?opr=update">添加业主</a>
        </form>
    </div>
    <!--用户-->
    <table class="providerTable" cellpadding="0" cellspacing="0">
        <tr class="firstTr">
            <th width="10%">编号</th>
            <th width="10%">业主姓名</th>
            <th width="10%">电话</th>
            <th width="10%">邮箱</th>
            <th width="40%">地址</th>
            <th width="10%">操作</th>
        </tr>
        <c:forEach var="owner" items="${requestScope.ownerList }" varStatus="status">
            <tr>
                <td><span>${owner.id }</span>
                </td>
                <td><span>${owner.name }</span>
                </td>
                <td><span>${owner.phone}</span>
                </td>
                <td><span>${owner.email}</span></td>
                <td><span>${owner.address}</span></td>

                <td><span><a class="viewUser" href="javascript:goOwnerView(${owner.id});"
                             userid=${owner.id } username=${owner.name }>
							<img src="${pageContext.request.contextPath }/statics/images/read.png"
                                 alt="查看" title="查看"/>
					      </a> 
					 </span>

                        <%--                    <span>--%>
                        <%--							<a class="modifyUser"--%>
                        <%--                               href="${pageContext.request.contextPath }/user?opr=userModify&id=${vistor.id}">--%>
                        <%--								<img src="${pageContext.request.contextPath}/statics/images/xiugai.png"--%>
                        <%--                                     alt="修改" title="修改"/>--%>
                        <%--						    </a> </span> <span>--%>

                    <a class="deleteVistor" userid=${owner.id } username=${owner.name }
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

    <%--    <div class="providerAdd" style="height:350px;border:1px dashed;">--%>
    <%--        <div style="float:left;border:1px solid red">--%>
    <%--            <div>--%>
    <%--                <label>用户编码：</label> <input type="text" id="v_userCode" value=""--%>
    <%--                                            readonly="readonly">--%>
    <%--            </div>--%>
    <%--            <div>--%>
    <%--                <label>用户名称：</label> <input type="text" id="v_userName" value=""--%>
    <%--                                            readonly="readonly">--%>
    <%--            </div>--%>
    <%--            <div>--%>
    <%--                <label>用户性别：</label> <input type="text" id="v_gender" value=""--%>
    <%--                                            readonly="readonly">--%>
    <%--            </div>--%>
    <%--            <div>--%>
    <%--                <label>出生日期：</label> <input type="text" Class="Wdate" id="v_birthday"--%>
    <%--                                            value="" readonly="readonly" onclick="WdatePicker();">--%>
    <%--            </div>--%>
    <%--            <div>--%>
    <%--                <label>用户电话：</label> <input type="text" id="v_phone" value=""--%>
    <%--                                            readonly="readonly">--%>
    <%--            </div>--%>
    <%--            <div>--%>
    <%--                <label>用户角色：</label> <input type="text" id="v_userRoleName" value=""--%>
    <%--                                            readonly="readonly">--%>
    <%--            </div>--%>
    <%--            <div>--%>
    <%--                <label>用户地址：</label> <input type="text" id="v_address" value=""--%>
    <%--                                            readonly="readonly">--%>
    <%--            </div>--%>
    <%--        </div>--%>
    <%--        <div style="border:1px solid red;float:right;width:200px;height:200px;">--%>
    <%--            <img style="width:200px;height:200px;"--%>
    <%--                 src="" alt="看看"--%>
    <%--                 title="看看" id="idpicpath"/>--%>
    <%--        </div>--%>
    <%--    </div>--%>

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
<%--<script type="text/javascript"--%>
<%--        src="${pageContext.request.contextPath }/statics/js/visitorlist.js"></script>--%>

<script type="text/javascript">
    function goPage(pageindex) {
        var pageform = document.getElementById("queryform");
        pageform.pageIndex.value = pageindex;
        //pageform.action=pageform.action+"id="+document.getElementById("input").value;
        pageform.submit();
    }
    function goOwnerView(id) {
        window.location.href = "${pageContext.request.contextPath}/owner?opr=update&id="+id
    }
    function changeDLGContent(contentStr){
        var p = $(".removeMain").find("p");
        p.html(contentStr);
    }
    function deleteVisitor(obj){
        $.ajax({
            type:"GET",
            url:path+"/visitor",
            data:{opr:"del",uid:obj.attr("userid")},
            dataType:"json",
            success:function(data){
                console.log(data.delResult)
                if(data.delResult == "true"){//删除成功：移除删除行
                    cancleBtn();
                    obj.parents("tr").remove();
                }else if(data.delResult == "false"){//删除失败
                    //alert("对不起，删除用户【"+obj.attr("username")+"】失败");
                    changeDLGContent("对不起，删除用户【"+obj.attr("username")+"】失败");
                }else if(data.delResult == "notexist"){
                    //alert("对不起，用户【"+obj.attr("username")+"】不存在");
                    changeDLGContent("对不起，用户【"+obj.attr("username")+"】不存在");
                }
            },
            error:function(data){
                cancleBtn();
                obj.parents("tr").remove();
                //alert("对不起，删除失败");
                // changeDLGContent("对不起，删除失败");
            }
        });
    }

    function openYesOrNoDLG(){
        $('.zhezhao').css('display', 'block');
        $('#removeUse').fadeIn();
    }

    function cancleBtn(){
        $('.zhezhao').css('display', 'none');
        $('#removeUse').fadeOut();
    }

    $('#no').click(function () {
        cancleBtn();
    });

    $('#yes').click(function () {
        deleteVisitor(userObj);
    });

    $(".deleteVistor").on("click",function(){
        userObj = $(this);
        console.log('测试111',userObj)
        changeDLGContent("你确定要删除记录【"+userObj.attr("username")+"】吗？");
        openYesOrNoDLG();
    });
</script>
