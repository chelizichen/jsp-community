<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/head.jsp"%>
<link href="${pageContext.request.contextPath}/statics/css/bootstrap.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/statics/js/jquery-3.4.1.js"></script>
<script src="${pageContext.request.contextPath}/statics/js/bootstrap.js"></script>
<div class="right">
     <div class="location">
         <strong>你现在所在的位置是:</strong>
         <span>访客管理 >> 访客更新页面</span>
     </div>
     <div class="providerAdd">
         <div id="billForm" action="${pageContext.request.contextPath }">
             <!--div的class 为error是验证错误，ok是验证成功-->
             <input type="hidden" name="method" value="add">
             <div>
                 <label for="username">用户名称：</label>
                 <input type="text" name="username" id="username" value="">
                 <font color="red"></font>
             </div>
             <div>
                 <label for="reason">理由：</label>
                 <input type="text" name="reason" id="reason" value="">
				 <font color="red"></font>
             </div>
             <div>
                 <label >出入：</label>
                 <input type="radio" name="io" value="1" checked="checked">出
				 <input type="radio" name="io" value="2" >入
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
        fetch(path+"/visitor?opr=list&id="+id).then(res=>res.json()).then(res=>{
            $('#username').val(res.username)
            $('#reason').val(res.reason)
            if(String(res.io) == 1){
                $('input[name=\'io\']')[0].check = true
            }else{
                $('input[name=\'io\']')[1].check = true
            }
        })
    }
$("#add").click(function () {
    let io;
    if($("input[name='io']")[0].checked){
        io = 1
    }
    if($("input[name='io']")[1].checked){
        io = 2
    }
    const data = {
        username:$('#username').val(),
        reason:$('#reason').val(),
        io,
        id,
    }
    $.ajax({
        type:"GET",//请求类型
        url:path+"/visitor?opr=modify",//请求的url
        data,//请求参数
        dataType:"json",//ajax接口（请求url）返回的数据类型
    })
    setTimeout(()=>{
        location.href = path+"/visitor?opr=list"
        window.alert("更新成功")
    },1000)
})


</script>
<%--<script type="text/javascript" src="${pageContext.request.contextPath }/statics/js/billadd.js"></script>--%>