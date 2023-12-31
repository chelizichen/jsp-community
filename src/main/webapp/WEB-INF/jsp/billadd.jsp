<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/head.jsp"%>
<link href="${pageContext.request.contextPath}/statics/css/bootstrap.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/statics/js/jquery-3.4.1.js"></script>
<script src="${pageContext.request.contextPath}/statics/js/bootstrap.js"></script>
<div class="right">
     <div class="location">
         <strong>你现在所在的位置是:</strong>
         <span>物业账单管理 >> 物业账单更新页面</span>
     </div>
     <div class="providerAdd">
         <div id="billForm" action="${pageContext.request.contextPath }">
             <!--div的class 为error是验证错误，ok是验证成功-->
             <input type="hidden" name="method" value="add">
             <div>
                 <label for="userid">用户编码：</label>
                 <input type="text" name="userid" id="userid" value="">
				 <font color="red"></font>
             </div>
             <div>
                 <label for="price">物业价格：</label>
                 <input type="text" name="price" id="price" value="">
				 <font color="red"></font>
             </div>
             <div>
                 <label >是否付款：</label>
                 <input type="radio" name="isPayment" value="1" checked="checked">未付款
				 <input type="radio" name="isPayment" value="2" >已付款
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
        fetch(path+"/bill?opr=list&id="+id).then(res=>res.json()).then(res=>{
            $('#userid').val(res.userid)
            $('#price').val(res.price)
            // $('#status').val(res.status)
            if(Number(res.status) == 1){
                $('input[name=\'isPayment\']')[0].check = true
            }else{
                $('input[name=\'isPayment\']')[1].check = true
            }

        })
    }
$("#add").click(function () {
    let status;
    if($("input[name='isPayment']")[0].checked){
        status = 1
    }
    if($("input[name='isPayment']")[1].checked){
        status = 2
    }

    const data = {
        userid:$('#userid').val(),
        price:$('#price').val(),
        status:$("input[name='isPayment']:checked").val(),
        id,
    }
    $.ajax({
        type:"GET",//请求类型
        url:path+"/bill?opr=modify",//请求的url
        data,//请求参数
        dataType:"json",//ajax接口（请求url）返回的数据类型
    })
    setTimeout(()=>{
        location.href = path+"/bill?opr=list"
        window.alert("更新成功")
    },1000)
})

</script>
<%--<script type="text/javascript" src="${pageContext.request.contextPath }/statics/js/billadd.js"></script>--%>