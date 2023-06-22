<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/head.jsp"%>
<link href="${pageContext.request.contextPath}/statics/css/bootstrap.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/statics/js/jquery-3.4.1.js"></script>
<script src="${pageContext.request.contextPath}/statics/js/bootstrap.js"></script>
<div class="right">
     <div class="location">
         <strong>你现在所在的位置是:</strong>
         <span>维修管理 >> 维修更新页面</span>
     </div>
     <div class="providerAdd">
         <div id="billForm" action="${pageContext.request.contextPath }">
             <!--div的class 为error是验证错误，ok是验证成功-->
             <input type="hidden" name="method" value="add">
             <div>
                 <label for="userid">用户编号：</label>
                 <input type="text" name="userid" id="userid" value="">
				 <font color="red"></font>
             </div>
             <div>
                 <label for="fixedlevel">风险等级：</label>
                 <input type="text" name="fixedlevel" id="fixedlevel" value="">
				 <font color="red"></font>
             </div>
             <div>
                 <label for="fixedtitle">维修标题：</label>
                 <input type="text" name="fixedtitle" id="fixedtitle" value="">
                 <font color="red"></font>
             </div>
             <div>
                 <label for="fixeddesc">维修细节描述：</label>
                 <input type="text" name="fixeddesc" id="fixeddesc" value="">
                 <font color="red"></font>
             </div>
             <div>
                 <label >维修状态：</label>
                 <input type="radio" name="fixedstatus" value="0" >未解决
                 <input type="radio" name="fixedstatus" value="1" checked="checked">待解决
                 <input type="radio" name="fixedstatus" value="2" >正在解决
                 <input type="radio" name="fixedstatus" value="3" >已解决
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
        fetch(path+"/fixed?opr=list&id="+id).then(res=>res.json()).then(res=>{
            $('#userid').val(res.userid)
            $('#fixedlevel').val(res.fixedlevel)
            $('#fixedtitle').val(res.fixedtitle)
            $('#fixeddesc').val(res.fixeddesc)
            $('input[name=\'fixedstatus\']').val(res.fixedstatus)
            $('#paytype').val(res.paytype)
        })
    }
$("#add").click(function () {
    const data = {
        userid:$('#userid').val(),
        fixedlevel:$('#fixedlevel').val(),
        fixedtitle:$('#fixedtitle').val(),
        fixeddesc:$('#fixeddesc').val(),
        fixedstatus:$("input[name='fixedstatus']:checked").val(),
        id,
    }
    $.ajax({
        type:"GET",//请求类型
        url:path+"/fixed?opr=modify",//请求的url
        data,//请求参数
        dataType:"json",//ajax接口（请求url）返回的数据类型
        success:function(data){//data：返回数据（json对象）
            window.alert("修改成功")
        },
    })
})

</script>
<%--<script type="text/javascript" src="${pageContext.request.contextPath }/statics/js/billadd.js"></script>--%>