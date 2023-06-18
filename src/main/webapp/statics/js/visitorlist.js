var userObj;

//用户管理页面上点击删除按钮弹出删除框(userlist.jsp)
function deleteUser(obj){
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
function changeDLGContent(contentStr){
	var p = $(".removeMain").find("p");
	p.html(contentStr);
}

    $(function(){

	/*//通过jquery的class选择器（数组）
	//对每个class为viewUser的元素进行动作绑定（click） 
	$(".viewUser").on("click",function(){ 
		//将被绑定的元素（a）转换成jquery对象，可以使用jquery方法
		var obj = $(this); 
		$.ajax({
			type:"GET",
			url:path+"/user/viewUser.do",
			data:{id:obj.attr("userid")},
			dataType:"json", 
			success:function(result){ 
				//var result = $.parseJSON(result);
				if("failed" == result){
					alert("操作超时！");
				}else if("nodata" == result){
					alert("没有数据！");
				}else{
					$("#v_userCode").val(result.userCode);
					$("#v_userName").val(result.userName); 
					if(result.gender == "1"){
						$("#v_gender").val("男");
					}else if(result.gender == "2"){
						$("#v_gender").val("女");
					} 
					if(result.role.id == "1"){
						$("#v_userRoleName").val("系统管理员");
					}else if(result.role.id == "2"){
						$("#v_userRoleName").val("经理");
					}else{
						$("#v_userRoleName").val("普通员工");
					}
					
					$("#v_birthday").val(result.birthday); 
					$("#v_phone").val(result.phone);
					$("#v_address").val(result.address); 

					$("#idpicpath").attr({"src":path+"/upload/"+
								 result.idpicPath});
				}
			},
			error:function(data){ 
				alert("error!");
			}
		}); 
	});*/
	
	$(".modifyUser").on("click",function(){
		var obj = $(this);
		window.location.href=path+"/jsp/user.do?method=modify&uid="+ obj.attr("userid");
	});

	$('#no').click(function () {
		cancleBtn();
	});
	
	$('#yes').click(function () {
		deleteUser(userObj);
	});

	$(".deleteUser").on("click",function(){
		userObj = $(this); 
		changeDLGContent("你确定要删除用户【"+userObj.attr("username")+"】吗？");
		openYesOrNoDLG();
	});
});