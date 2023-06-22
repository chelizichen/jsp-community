<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/head.jsp"%>
<link href="${pageContext.request.contextPath}/statics/css/bootstrap.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/statics/js/jquery-3.4.1.js"></script>
<script src="${pageContext.request.contextPath}/statics/js/bootstrap.js"></script>
<div class="right">
    <div class="location" >
        <strong>你现在所在的位置是:</strong>
        <span>房屋管理 >> 房屋更新页面</span>
    </div>
    <div class="providerAdd">
        <div id="billForm" action="${pageContext.request.contextPath }">
            <!--div的class 为error是验证错误，ok是验证成功-->
            <input type="hidden" name="method" value="add">
            <div>
                <label for="address">地址：</label>
                <input type="text" name="address" id="address" value="">
                <font color="red"></font>
            </div>
            <div>
                <label for="price">价格：</label>
                <input type="text" name="price" id="price" value="">
                <font color="red"></font>
            </div>
            <div>
                <label for="area">面积：</label>
                <input type="text" name="area" id="area" value="">
                <font color="red"></font>
            </div>
            <div>
                <label >类型：</label>
                <input type="radio" name="io" value="1" checked="checked">商品房
                <input type="radio" name="io" value="2" >公寓类型
            </div>

            <div>
                <label for="ownerid">业主编号：</label>
                <input type="text" name="ownerid" id="ownerid" value="">
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
        fetch(path+"/house?opr=list&id="+id).then(res=>res.json()).then(res=>{
            $('#address').val(res.address)
            $("#input[name='io']").val(res.type)
            $('#area').val(res.area)
            $('#ownerid').val(res.ownerid)
            $('#price').val(res.price)
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
            address:$('#address').val(),
            price:$('#price').val(),
            area:$('#area').val(),
            type:io,
            ownerid:$('#ownerid').val(),
            id,
        }
        $.ajax({
            type:"GET",//请求类型
            url:path+"/house?opr=modify",//请求的url
            data,//请求参数
            dataType:"json",//ajax接口（请求url）返回的数据类型
        })
        setTimeout(()=>{
            location.href = path+"/house?opr=list"
            window.alert("更新成功")
        },1000)
    })


</script>
<%--<script type="text/javascript" src="${pageContext.request.contextPath }/statics/js/billadd.js"></script>--%>