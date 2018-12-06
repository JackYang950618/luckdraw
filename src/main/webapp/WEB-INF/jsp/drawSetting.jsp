<%--
  Created by IntelliJ IDEA.
  User: 950618
  Date: 2018/12/6
  Time: 15:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>抽奖设置</title>
    <script src="js/jquery/2.0.0/jquery.min.js"></script>
    <script src="js/jquery/2.0.0/jquery.serializejson.js"></script>
    <link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
    <script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link href="css/dashboard.css" rel="stylesheet">
    <link href="css/dropdown-submenu.css" rel="stylesheet">
    <script src="js/time.js"></script>
    <script src="js/util.js"></script>
</head>
<style>
    body {
        font-size: 40px;
    }
    .middle {
        margin-top: 10%;
    }
    .setting > li > a {
        width: 250px;
        height: 80px;
        font-size: 50px;
        margin: 15px;
    }
    ul li{
        list-style: none;
    }
    .new {
        width: 200px;
        height: 80px;
        font-size: 50px;
        margin: 15px;
    }
</style>
<body onload="getCurrentSalesmanId();">
<div class="container-fluid">

    <div class="sidebar">
        <div>
            <ol class="breadcrumb">
                <li><a href="#">系统配置</a></li>
                <li><a href="#">奖项设置</a></li>
            </ol>
        </div>
        <ul class="setting">
            <li><a class="btn btn-primary" href="drawSetting.html">奖项设置</a></li>
            <li><a class="btn btn-primary" href="drawSetting2.html">座位设置</a></li>
            <li><a class="btn btn-primary" href="drawSetting3.html">中奖重置</a></li>
        </ul>
    </div>
    <div class="col-sm-9 col-sm-offset-3 col-md-offset-2 col-md-9 col-md-offset-2 main">
        <div style="margin-left: 25%">
            <a class="btn btn-primary new">新增</a>
        </div>
        <div style="overflow-y: scroll;margin-left: 25%">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th class="text-center">奖项名称</th>
                    <th class="text-center">中奖人数</th>
                    <th class="text-center">奖品图片</th>
                    <th class="text-center">抽奖方式</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td class="text-center" id="awardName"></td>
                    <td class="text-center" id="awardNumber"></td>
                    <td class="text-center" id="awardPicture">
                        <img src="image/price.png" style="width: 60px;height: 60px">
                    </td>
                    <td class="text-center" id="awardWay"></td>
                    <td class="text-center">
                        <a onclick="" href="#" title="编辑"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>
                        <a onclick="" href="#" title="作废"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></a>
                    </td>
                </tr>
                <tr class="CloneTr">
                    <td class="text-center"></td>
                    <td class="text-center"></td>
                    <td class="text-center"></td>
                    <td class="text-center"></td>
                    <td class="text-center"></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div id="embed"></div>
</body>
<script>
    $('#embed').load('embed/loginLogModal.html');
    $("#name").get(0).selectedIndex = -1;
</script>
</html>
