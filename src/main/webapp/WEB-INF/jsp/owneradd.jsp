<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/head.jsp"%>
<link href="${pageContext.request.contextPath}/statics/css/bootstrap.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/statics/js/jquery-3.4.1.js"></script>
<script src="${pageContext.request.contextPath}/statics/js/bootstrap.js"></script>
<div class="right">
     <div class="location">
         <strong>你现在所在的位置是:</strong>
         <span>业主管理 >> 业主更新页面</span>
     </div>
     <div class="providerAdd">
         <div id="billForm" action="${pageContext.request.contextPath }">
             <!--div的class 为error是验证错误，ok是验证成功-->
             <input type="hidden" name="method" value="add">
             <div>
                 <label for="name">业主名称：</label>
                 <input type="text" name="name" id="name" value="">
                 <font color="red"></font>
             </div>
             <div>
                 <label for="phone">电话：</label>
                 <input type="text" name="phone" id="phone" value="">
                 <font color="red"></font>
             </div>

             <div>
                 <label for="email">名称：</label>
                 <input type="text" name="email" id="email" value="">
                 <font color="red"></font>
             </div>
             <div>
                 <label for="address">业主地址：</label>
                 <input type="text" name="address" id="address" value="">
                 <font color="red"></font>
             </div>


             <div class="providerAddBtn">
                  <input type="button" name="add" id="add" value="保存">
				  <input type="button" id="back" name="back" value="返回" >
             </div>
         </div>
     </div>
 </div>
</section>
<%@include file="/WEB-INF/jsp/common/foot.jsp" %>
<script>

    const queryURLParameter = (url) => {
        let regx = /([^&?=]+)=([^&?=]+)/g;
        let obj = {};

        url.replace(regx, (...args) => {
            if (obj[args[1]]) {
                obj[args[1]] = Array.isArray(obj[args[1]])
                    ? obj[args[1]]
                    : [obj[args[1]]];
                obj[args[1]].push(args[2]);
            } else {
                obj[args[1]] = args[2];
            }
        });

        return obj;
    }
    let id = queryURLParameter(window.location.href).id

    if(id){
        fetch(path+"/owner?opr=list&id="+id).then(res=>res.json()).then(res=>{
            $('#name').val(res.name)
            $('#phone').val(res.phone)
            $('#email').val(res.email)
            $('#address').val(res.address)
        })
    }

$("#add").click(function () {
    const data = {
        name:$('#userid').val(),
        phone:$('#phone').val(),
        email:$('#email').val(),
        address:$('#address').val(),
        id,
    }
    $.ajax({
        type:"GET",//请求类型
        url:path+"/owner?opr=modify",//请求的url
        data,//请求参数
        dataType:"json",//ajax接口（请求url）返回的数据类型
        success:function(data){//data：返回数据（json对象）
            window.alert("修改成功")
        },
    })
})


</script>
<%--<script type="text/javascript" src="${pageContext.request.contextPath }/statics/js/billadd.js"></script>--%>