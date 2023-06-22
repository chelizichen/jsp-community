<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/head.jsp"%>
<link href="${pageContext.request.contextPath}/statics/css/bootstrap.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/statics/js/jquery-3.4.1.js"></script>
<script src="${pageContext.request.contextPath}/statics/js/bootstrap.js"></script>
<div class="right">
     <div class="location">
         <strong>你现在所在的位置是:</strong>
         <span>车辆管理 >> 车辆更新页面</span>
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
                 <label for="carid">车牌号：</label>
                 <input type="text" name="carid" id="carid" value="">
                 <font color="red"></font>
             </div>
<%--             <div>--%>
<%--                 <label for="reason">理由：</label>--%>
<%--                 <input type="text" name="reason" id="reason" value="">--%>
<%--				 <font color="red"></font>--%>
<%--             </div>--%>
             <div>
                 <label >出入：</label>
                 <input type="radio" name="io" value="1" checked="checked">出
                 <input type="radio" name="io" value="2" >入
             </div>
             <div>
                 <label >付款方式：</label>
                 <input type="radio" name="paytype" value="Paypal" checked="checked">Paypal
                 <input type="radio" name="paytype" value="ApplePay" >ApplePay
                 <input type="radio" name="paytype" value="AliPay" >AliPay
                 <input type="radio" name="paytype" value="WechatPay" >WechatPay
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
        fetch(path+"/car?opr=list&id="+id).then(res=>res.json()).then(res=>{
            $('#username').val(res.username)
            $('#carid').val(res.carid)
            $('#io').val(res.io)
            $('#paytype').val(res.paytype)
        })
    }
$("#add").click(function () {
    const data = {
        username:$('#username').val(),
        carid:$('#carid').val(),
        io:$("input[name='io']:checked").val(),
        paytype:$("input[name='paytype']:checked").val(),
        id,
    }
    $.ajax({
        type:"GET",//请求类型
        url:path+"/car?opr=modify",//请求的url
        data,//请求参数
        dataType:"json",//ajax接口（请求url）返回的数据类型
        success:function(data){//data：返回数据（json对象）
            window.alert("修改成功")
        },
    })
})

</script>
<%--<script type="text/javascript" src="${pageContext.request.contextPath }/statics/js/billadd.js"></script>--%>