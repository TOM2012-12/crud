<%--
  Created by IntelliJ IDEA.
  User: fd
  Date: 2021/8/25
  Time: 17:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Title</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <script src="${APP_PATH}/static/js/jquery-3.1.1.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%
    Cookie[] cookies=request.getCookies();
    for (Cookie cookie : cookies) {
        System.out.println(cookie.getName());
    }
    if(!cookies[1].getName().equals("user")){
        response.sendRedirect(pageContext.getAttribute("APP_PATH").toString()+"/index.jsp");
    }

%>
<!--显示用户信息的查询结果-->
<div class="modal fade" id="empAddModel_show" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel2">员工信息展示</h4>
            </div>
            <div class="modal-body">
                <table class="table table-hover" id="emp_table2">
                    <thead>
                    <tr><th>
                        <input type="checkbox" id="check_all1">
                    </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptId</th>

                    </tr></thead>
                    <tbody id="test1">

                    </tbody>
                </table>
            </div>
            <div class="row">
                <%--            分页文字信息--%>
                <div class="col-md-6" id="page_info_area_r1">
                </div>
                <%--            分页条信息--%>
                <div class="col-md-6" id="page_nav_area_r2">
                </div>
            </div>
        </div>
    </div>
</div>



<!--员工添加模态框-->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_input" placeholder="empName">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_input" placeholder="email@qq.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptname</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<!--员工修改-->
<div class="modal fade" id="empUpdateModel1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel1">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empname_update_static"></p>
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update" placeholder="email@qq.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_update" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_update" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptname</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_update">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>
                ssm-crud
            </h1>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <form class="form-inline" id="like_test_emp">
                <div class="form-group">
                    <label for="testName_emp">Name</label>
                    <input type="text" class="form-control" id="testName_emp" placeholder="Jane Doe" name="empName">
                </div>

                <button type="button" class="btn btn-default" aria-label="Left Align" id="button_submit">
                    <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                </button>
            </form>
        </div>
    </div>

    <div class="row">
        <div class="col-md-4 col-md-offset-8">

            <button class="btn btn-info" id="emp_add_model_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emp_table"><thead>
            <tr><th>
                <input type="checkbox" id="check_all">
            </th>
                <th>#</th>
                <th>empName</th>
                <th>gender</th>
                <th>email</th>
                <th>deptName</th>
                <th>操作</th>
            </tr></thead>
                <tbody id="test">

                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <%--            分页文字信息--%>
        <div class="col-md-6" id="page_info_area">
        </div>
        <%--            分页条信息--%>
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>
</div>
<script type="text/javascript">
    var totalRecord;
    var currentPage;
    $(function () {
        to_page(1);
    });
    function to_page(pn){
        $.ajax({
                url:"${APP_PATH}/emps1",
                data:"pn="+pn,
                type:"get",
                success:function (result) {
                   // console.log(result)
                    //1.解析并显示员工数据
                    build_emps_table(result);
                    //2.解析并显示分页数据
                    build_page_info(result);
                    //3分页条的数据
                    build_page_nav(result);
                }
            }
        );
    }
    function build_emps_table(result) {
        //清空
        $("#emp_table tbody").empty();
        var emps=result.list;
        $.each(emps,function (index,item) {           //alert(item.empName);
            var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>")
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            //append方法执行完了还是返回原来的元素
            var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append("<span></span>")
                .addClass("glyphicon glyphicon-pencil").append("编辑");
            //为编辑按钮添加自定义得属性，来表示当前员工的id
            editBtn.attr("edit_id",item.empId);

            var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append("<span></span>")
                .addClass("glyphicon glyphicon-trash").append("删除");
            delBtn.attr("delete_id",item.empId);
            var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn)
           $("<tr></tr>").append(checkBoxTd).
            append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd).append(btnTd).appendTo("#emp_table tbody")
                ;
        });
        //.appendTo("#emp_table tbody")
    }
    //分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.pageNum+"页,总共"+result.pages+"页"+result.total+"条记录");
        totalRecord=result.total;
        currentPage=result.pageNum;
    }
    //分页条
    function build_page_nav(res) {
        //清空分页条，如果不清空，当页面刷新的时候新的数据不会覆盖旧数据，造成页面混乱
        $("#page_nav_area").empty();
//console.log(res);
        var ul = $("<ul></ul>").addClass("pagination");
        //构建首页和上一页的标签
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        //如果没有上一页，就设置首页和上一页的按钮不可用
        if(res.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            //如果有上一页，才绑定单击事件
            //为首页标签添加单击事件
            firstPageLi.click(function () {
                to_page(1);
            });
            //为上一页标签添加单击事件
            prePageLi.click(function () {
                to_page(res.pageNum - 1);
            });
        }
        //下一页和尾页
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
        //如果没有下一页，就设置下一页和尾页按钮不可用
        if(res.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            //如果有下一页，才绑定单击事件
            //为下一页标签添加单击事件
            nextPageLi.click(function () {
                to_page(res.pageNum + 1);
            });
            //为尾页标签添加单击事件
            lastPageLi.click(function () {
                to_page(res.pages);
            });
        }
        //添加首页和前一页到ul标签中
        ul.append(firstPageLi).append(prePageLi);
        //遍历，给ul中添加页码
        $.each(res.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            //绑定单击事件，点击页码进行跳转
            numLi.click(function () {
                to_page(item);
            })
            //当前页数高亮显示
            if(res.pageNum == item){
                numLi.addClass("active");
            }
            ul.append(numLi);
        })
        //添加下一页和尾页到ul标签中
        ul.append(nextPageLi).append(lastPageLi);
        //把ul添加到nav标签中
        var navEle = $("<nav></nav>").append(ul).appendTo("#page_nav_area");
    }
    //点击按钮弹出模态框
    $("#emp_add_model_btn").click(function () {
        //表单重置
        //发送ajax请求，查出部门信息显示在下拉列表
        getDepts("#dept_add_select");
        //弹出模态框
        $("#empAddModel").modal({
            backdrop:"static"
        })
    })
    function getDepts(ele){
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"get",
            success:function(result){
                //console.log(result);
                $.each(result.extend.depts,function () {
                    var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                })
            }
        });
    }
    //保存员工
    //校验表单
    function validate_add_form1(){
        //得到校验的数据
        var empName=$("#empName_input").val();
        var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            //alert("用户名为2-5为中文或6-16为英文和数字的组合");
            //应该清空样式
            show_validate_msg("#empName_input","error","用户名为2-5为中文或6-16为英文和数字的组合");
            return false;
        }else{
            show_validate_msg("#empName_input","success","");
            //return true;
        }
        var email=$("#email_input").val();
        var regEmail= /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确");
            show_validate_msg("#email_input","error","邮箱格式不正确");
            return false;
        }
        else{
            show_validate_msg("#email_input","success","");
            return true;
        }}
    function show_validate_msg(ele,status,msg){
        //清除状态
        $(ele).parent().removeClass("has-success has_error");
        $(ele).next("span").text("");
        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }
        else if("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    $("#emp_save_btn").click(function () {
        if($(this).attr("ajax-value") == "error"){
            return false;
        }
        //将模态框中填写的表单数据提交服务器保存
        if(!validate_add_form1()){
            return false;
        };
        $.ajax({
                url:"${APP_PATH}/emps1",
                type:"post",
                data:$("#empAddModel form").serialize(),
                success:function (result) {
                    alert(result.msg);
                    //员工保存成功
                    //1关闭模态框
                    $("#empAddModel").modal("hide");
                    //来到最后一页
                    //发送ajax请求显示最后一页
                    to_page(totalRecord);
                }
            }
        );
    })
    $("#empName_input").change(function () {
        //    发送ajax请求校验用户名是否可用
        //  输入框中的值
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName=" + empName,
            type:"POST",
            success:function (res) {

                if(res.code == 100){
                    //成功
                    show_validate_msg("#empName_input", "success", "用户名可用");
                    //    如果用户名可用，将success标志保存到ajax-value属性中
                    $("#emp_save_btn").attr("ajax-value", "success");
                }else{
                    //失败
                    show_validate_msg("#empName_input", "error", res.extend.va_msg);
                    //    如果用户名不可用，将error标志保存到ajax-value属性中
                    $("#emp_save_btn").attr("ajax-value", "error");
                }
            }
        })
    })
    //1.我们是按钮创建之前就绑定了事件所有无法绑定
    //2.创建按钮就绑定事件
    $(document).on("click",".edit_btn",function () {
        //0弹出模态框
        $("#empUpdateModel1").modal({
            backdrop:"static"
        })
        //1弹出部门信息并显示部门列表
        getDepts("#dept_add_update");
        //2查出员工信息显示员工信息
        getEmp($(this).attr("edit_id"))
        //把员工的id传递给模态框的更新
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit_id"));

    })
    $("#emp_update_btn").click(function () {
        //验证邮箱是否合法
        var email=$("#email_update").val();
        var regEmail= /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确");
            show_validate_msg("#email_update","error","邮箱格式不正确");
            return false;
        }
        else{
            //alert("ywuiop")
            show_validate_msg("#email_update","success","");
            //return true;
        }
        //发送ajax请求保存
        $.ajax({
            //加上之前在修改按钮上保存的edit-id的值
            url:"${APP_PATH}/emp1/" + $(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModel1 form").serialize(),// + "&_method=PUT",
            success:function (res) {
                // alert(res.msg);
                //关闭对话框
                $('#empUpdateModel1').modal('hide');

                //回到本页面
                to_page(currentPage);

            }
        })
       
    })
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"get",
            success:function (result) {
                // console.log(result)
                var empData=result.extend.emp;
                $("#empname_update_static").text(empData.empName);
                $("#email_update").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empAddModal select").val([empData.dId]);

            }

        })

    }
    $(document).on("click",".delete_btn",function () {
        //1弹出确认删除对话框
       var empName= $(this).parents("tr").find("td:eq(2)").text();
       var empId=$(this).attr("delete_id");
       if(confirm("确认删除"+empName+"吗？")){
           //发送ajax
           $.ajax({
               url:"${APP_PATH}/emp1/"+empId,
                type:"delete",
               success:function (result) {
                   alert(result.msg);
                   to_page(currentPage);
               }
           })
       }



    })

    //完成全选全不选
    $("#check_all").click(function () {
        //atrr获取checked为undefined
        //我们致谢原生的属性，attr获取自定义的属性
//porp修改和读取dom原生属性
        //7
        $(".check_item").prop("checked",$(this).prop("checked"));


    })
    //check_item
    $(document).on("click",".check_item",function () {
        //判断当前选择的元素是不是五个
       var flag= $(".check_item:checked").length==$(".check_item").length;
       $("#check_all").prop("checked",flag);



    })
    //点击全部删除就批量删除
    $("#emp_delete_all_btn").click(function () {
        var empNames="";
        var del_idstr="";
        $.each($(".check_item:checked"),function () {
            //$(this).parents("tr").find("td:eq(2)").text();
empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-"
        });
        empNames=empNames.substring(0,empNames.length-1);
        del_idstr=del_idstr.substring(0,del_idstr.length-1);

if(confirm("确认删除【"+empNames+"】吗")){
$.ajax({
    url:"${APP_PATH}/emp1/"+del_idstr,
    type:"delete",
    success:function (result) {
        alert(result.msg);
        to_page(currentPage);

    }
})
}
    })
    $("#button_submit").click(function () {
to_page_r3(1);
    })
    function to_page_r3(pn) {
        $.ajax({
            url:"${APP_PATH}/selectEmployee",
            data:"empName="+$("#testName_emp").val()+"&pn="+pn,
            type:"get",
            success:function (result) {
                $("#empAddModel_show").modal({
                    backdrop:"static"
                })
                //显示表单
                build_table_test(result);
//显示页面信息
                show_page_r1(result);
                //显示跳转页面的效果
                show_page_r2(result);


            }
        })
    }
    function build_table_test(result) {
        $("#emp_table2 tbody").empty();
        var emps=result.list;
        $.each(emps,function (index,item) {
            var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>")
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.dId);
            //alert(deptNameTd);
            //append方法执行完了还是返回原来的元素
            //为编辑按钮添加自定义得属性，来表示当前员工的id
            $("<tr></tr>").append(checkBoxTd).
            append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd).appendTo("#emp_table2 tbody");
            ;

        })
    }
    function show_page_r1(result) {
        $("#page_info_area_r1").empty();
        $("#page_info_area_r1").append("当前"+result.pageNum+"页,一共"+result.pages+"页,一共"+result.total+"记录");

    }
    function show_page_r2(res) {
$("#page_nav_area_r2").empty();
var ul=$("<ul></ul>").addClass("pagination");
var first_page=$("<li></li>").append($("<a></a>").attr("href","#").append("首页"));
var pre_page=$("<li></li>").append($("<a></a>").append("&laquo;"));
if(res.hasPreviousPage==false){
    first_page.addClass("disabled");
    pre_page.addClass("disabled");
}else {
    first_page.click(function () {
        to_page_r3(1)
    });
    pre_page.click(function () {
       to_page_r3(res.pageNum-1);
    });
}
var last_page=$("<li></li>").append($("<a></a>").attr("href","#").append("尾页"));
var next_page=$("<li></li>").append($("<a></a>").append("&raquo;"));
if(res.hasNextPage==false){
    last_page.addClass("disabled");
    next_page.addClass("disabled");


}else{
    last_page.click(function () {
        to_page_r3(res.pages);
    })
    next_page.click(function () {
        to_page_r3(res.pageNum+1);
    })
}
ul.append(first_page).append(pre_page);
$.each(res.navigatepageNums,function (index,item) {
    var num_li=$("<li></li>").append($("<a></a>").append(item));
    num_li.click(function () {
        to_page_r3(item);
    })
    if(res.pageNum==item){
        num_li.addClass("active");
    }
ul.append(num_li);

})
ul.append(next_page).append(last_page);
$("<nav></nav>").append(ul).appendTo("#page_nav_area_r2");
    }
</script>

</body>
</html>