<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/common/head.jsp"%>
<link href="${pageContext.request.contextPath}/statics/css/bootstrap.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/statics/js/jquery-3.4.1.js"></script>
<script src="${pageContext.request.contextPath}/statics/js/bootstrap.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/statics/js/providerlist.js"></script>
<div class="right">
	<div class="location">
		<strong>你现在所在的位置是:</strong>
		<span>供应商管理页面</span>
	</div>
	<div class="search">
		<form id="providerSearch" method="post" action="${pageContext.request.contextPath }/provider/providerlist.do">
			<span>供应商编码：</span>
			<input name="queryProCode" type="text" value="${queryProCode }">

			<span>供应商名称：</span>
			<input name="queryProName" type="text" value="${queryProName }">
			<input type="hidden" name="pageIndex" value="1"/>
			<input value="查 询" type="submit" id="searchbutton">
			<a href="${pageContext.request.contextPath }/provider/provideradd.do">添加供应商</a>
		</form>
	</div>
	<!--供应商操作表格-->
	<table class="providerTable" cellpadding="0" cellspacing="0">
		<tr class="firstTr">
			<th width="10%">供应商编码</th>
			<th width="20%">供应商名称</th>
			<th width="10%">联系人</th>
			<th width="10%">联系电话</th>
			<th width="10%">传真</th>
			<th width="10%">创建时间</th>
			<th width="30%">操作</th>
		</tr>
		<c:forEach var="provider" items="${pageInfo.list}" varStatus="status">
			<tr>
				<td>
					<span>${provider.proCode}</span>
				</td>
				<td>
					<span>${provider.proName }</span>
				</td>
				<td>
					<span>${provider.proContact}</span>
				</td>
				<td>
					<span>${provider.proPhone}</span>
				</td>
				<td>
					<span>${provider.proFax}</span>
				</td>
				<td>
					<span>
					<fmt:formatDate value="${provider.creationDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</span>
				</td>
				<td>
					<span><a class="viewProvider" href="${pageContext.request.contextPath }/provider/view.do?pid=${provider.id }"><img src="${pageContext.request.contextPath }/statics/images/read.png" alt="查看" title="查看"/></a></span>
					<span><a class="modifyProvider" href="${pageContext.request.contextPath }/provider/modify.do?pid=${provider.id}"><img src="${pageContext.request.contextPath }/statics/images/xiugai.png" alt="修改" title="修改"/></a></span>
					<span><a class="deleteProvider1" href="#" proid="${provider.id}" proname="${provider.proName}" ><img src="${pageContext.request.contextPath }/statics/images/schu.png" alt="删除" title="删除"/></a></span>
				</td>
			</tr>
		</c:forEach>
	</table>
	<input type="hidden" id="totalPageCount" value="${pageInfo.pages}"/>
	<!--分页组件-->
	<center>
		<div style="margin-top:10px">
			<a href="javascript:goPage(1)">首页</a>
			<a href="javascript:goPage(${pageInfo.pageNum-1})">上一页</a>
			<c:if test="${not empty pageInfo.pages}">
				<c:forEach begin="1" end="${pageInfo.pages}" step="1" var="s">
					<a href="javascript:goPage(${s})">${s}</a>
				</c:forEach>
			</c:if>

			<a href="javascript:goPage(${pageInfo.pageNum + 1 })">下一页</a>
			<a href="javascript:goPage(${pageInfo.pages})">尾页</a>
			第<input type="text" style="width:20px" id="index" name="index"/>页
			<input type="button" value="确定"
			       onclick="goPage(document.getElementById('index').value)"></button>
		</div>
	</center>
</section>

<script>
    function goPage(p) {
        let pageSize = 5;
        //serialize发送表单中的所有数据并自动拼接
        window.location.href=
            "${pageContext.request.contextPath}/provider/providerlist.do?pageIndex="+p+"&"+$("#providerSearch").serialize();
    };
</script>

<!--点击删除按钮后弹出的页面-->
<div class="zhezhao"></div>
<div class="remove" id="removeProv">
	<div class="removerChid">
		<h2>提示</h2>
		<div class="removeMain" >
			<p>你确定要删除该供应商吗？</p>
			<a href="#" id="yes">确定</a>
			<a href="#" id="no">取消</a>
		</div>
	</div>
</div>

<%@include file="/WEB-INF/jsp/common/foot.jsp" %>


