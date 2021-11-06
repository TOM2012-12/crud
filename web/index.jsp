<%--
  Created by IntelliJ IDEA.
  User: fd
  Date: 2021/9/17
  Time: 17:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Title</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());

    %>
    <script src="${APP_PATH}/static/js/jquery-3.1.1.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>
<!--添加用户-->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Add User</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="add_id">
                    <div class="form-group">
                        <label for="input_id" class="col-sm-2 control-label">UserId</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="input_id" placeholder="UserId" name="userid">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_password" class="col-sm-2 control-label">Password</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="input_password" placeholder="Password" name="password">
                            <span  class="help-block"></span>
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-default" id="add_user">addUser</button>
            </div>
        </div>
    </div>
</div>


<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>
                welcome to my web!please sign your name and password
            </h1>
        </div>
    </div></div>

<form class="form-horizontal" id="testform">
    <div class="form-group">
        <label for="userid_test">Name:</label>
        <input type="text" class="form-control" id="userid_test" placeholder="Name" name="userid">
    </div>
    <div class="form-group">
        <label for="password_test">Password:</label>
        <input type="password" class="form-control" id="password_test" placeholder="Password" name="password">
    </div>

    <button type="button" class="btn btn-default" id="submit_check">Submit</button>
    <button type="button" class="btn btn-default" id="add_check">Add User</button>

</form>
<script type="text/javascript">
    $("#submit_check").click(function () {

        $.ajax({
            url:"${APP_PATH}/selectUser",
            type:"get",
            data:$("#testform").serialize(),
            success:function (res) {
                if(res!="error"&&res!=null){
                    //alert(res);
                     window.location.href="${APP_PATH}/new.jsp";
                }else{
                    //
                    // alert(res);

                    window.location.href="index.jsp";
                }

            }
        })
    })
    $("#add_check").click(function () {
        $('#myModal').modal({
            backdrop:"static"
        })
        $("#add_user").click(function () {

//1检验是否符合格式,
var userid=$("#input_id").val();
var userpassword=$("#input_password").val();
var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
var regPassword=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
if(!regName.test(userid)){
    show_validate_msg("#input_id","error","用户名为2-5为中文或6-16为英文和数字的组合");
    return false;
}else{
    show_validate_msg("#input_id","success","");
}
if(!regPassword.test(userpassword)){
                show_validate_msg("#input_password","error","用户名为2-5为中文或6-16为英文和数字的组合");
                return false
            }else{
                show_validate_msg("#input_password","success","");
            }
//3发送ajax来添加用户
$.ajax({
    url:"${APP_PATH}/adddUser",
    data:$("#add_id").serialize(),
    type:"get",
    success:function (res) {
        if(res=="error"){
            window.location.href="error.jsp";
        }
        else{
            alert("success你的账户已经成功注册");
            window.location.href="index.jsp";
        }
    }
})
        })
        $("#input_id").change(function () {
//alert($("#input_id").val());
            //2检验是否存在重复的用户
            $.ajax({
                url:"${APP_PATH}/checkUser",
                data:"userid="+$("#input_id").val(),
                type:"get",
                success:function (res) {
                    if(res=="success"){
                        show_validate_msg("#input_id","success","可以使用");
                    }
                    else{
                        show_validate_msg("#input_id","error","该用户名已经被使用");
                        return false;
                    }
                }
            })

        })
        function show_validate_msg(ele,status,msg){
            //清除状态
            $(ele).parent().removeClass("has-success has_error");
            $(ele).next("span").text("");
            if("success"==status){
               // alert("success")
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }
            else if("error"==status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }


    })
</script>
</body>
</html>
