// var userObj;
//
// //用户管理页面上点击删除按钮弹出删除框(userlist.jsp)
// function deleteVisitor(obj){
// 	$.ajax({
// 		type:"GET",
// 		url:path+"/visitor",
// 		data:{opr:"del",uid:obj.attr("userid")},
// 		dataType:"json",
// 		success:function(data){
// 			console.log(data.delResult)
// 			if(data.delResult == "true"){//删除成功：移除删除行
// 				cancleBtn();
// 				obj.parents("tr").remove();
// 			}else if(data.delResult == "false"){//删除失败
// 				//alert("对不起，删除用户【"+obj.attr("username")+"】失败");
// 				changeDLGContent("对不起，删除用户【"+obj.attr("username")+"】失败");
// 			}else if(data.delResult == "notexist"){
// 				//alert("对不起，用户【"+obj.attr("username")+"】不存在");
// 				changeDLGContent("对不起，用户【"+obj.attr("username")+"】不存在");
// 			}
// 		},
// 		error:function(data){
// 			cancleBtn();
// 			obj.parents("tr").remove();
// 			//alert("对不起，删除失败");
// 			// changeDLGContent("对不起，删除失败");
// 		}
// 	});
// }
//
// function openYesOrNoDLG(){
// 	$('.zhezhao').css('display', 'block');
// 	$('#removeUse').fadeIn();
// }
//
// function cancleBtn(){
// 	$('.zhezhao').css('display', 'none');
// 	$('#removeUse').fadeOut();
// }
//
// $('#no').click(function () {
// 	cancleBtn();
// });
//
// $('#yes').click(function () {
// 	deleteVisitor(userObj);
// });
//
// $(".deleteVistor").on("click",function(){
// 	userObj = $(this);
// 	changeDLGContent("你确定要删除用户【"+userObj.attr("username")+"】吗？");
// 	openYesOrNoDLG();
// });