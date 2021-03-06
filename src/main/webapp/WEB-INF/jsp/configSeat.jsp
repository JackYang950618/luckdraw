<%--
  Created by IntelliJ IDEA.
  User: Matt
  Date: 2018/12/6
  Time: 16:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="../../js/jquery.min.js"></script>
    <link href="../../css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
    <script src="../../js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <script src="../../js/webJs/seat.js"></script>
    <script src="../../js/webJs/common.js"></script>
    <title>佳利达抽奖系统</title>
</head>
<style>
    body {
        font-size: 15px;
    }
    .setting > li > a {
        width: 100px;
        height: 40px;
        font-size: 20px;
        margin: 10px;
    }
    ul li{
        list-style: none;
    }
    .new {
        width: 100px;
        height: 40px;
        font-size: 20px;
        margin: 10px;
    }
</style>
<body onload="loadSeatList();">
<div class="container-fluid row">
    <div class="col-md-3 col-sm-3">
        <div class="sidebar">
            <div>
                <ol class="breadcrumb">
                    <li><a href="#">系统配置</a></li>
                    <li><a href="#">座位设置</a></li>
                </ol>
            </div>
            <ul class="setting">
                <li><a class="btn btn-danger" href="/luckDrawSetting">开始抽奖</a></li>
                <li><a class="btn btn-primary" href="/drawSetting">奖项设置</a></li>
                <li><a class="btn btn-warning" href="/seat">座位设置</a></li>
                <li><a class="btn btn-primary" href="/winner">中奖名单</a></li>
                <li><a class="btn btn-primary" href="#" onclick="resetSeat();">中奖重置</a></li>
            </ul>
        </div>
    </div>
    <div class="col-md-9 col-sm-9">
        <div style="margin-left: 6%">
            <a class="btn btn-primary new" onclick="addData();">新增</a>
            <a class="btn btn-primary new" onclick="cleanAll();">清空</a>
        </div>
        <%--新增修改面板--%>
        <div class="panel panel-default" id="newPanel">
            <h3 class="panel-title center-block">
            </h3>
            <div class="panel-heading" >

            </div>
            <div class="panel-body">
                <div id="add">

                    <table class="table table-bordered">

                        <thead>
                            <th class="text-center">桌号</th>
                            <th class="text-center">座号</th>
                            <th class="text-center">部门</th>
                            <th class="text-center">姓名</th>
                        </thead>
                        <tbody>
                        <tr id="clone" class="myclass" >
                            <td><input type="number" class="form-control"></td>
                            <td><input type="number" class="form-control"></td>
                            <td><input type="text" class="form-control"></td>
                            <td><input type="text" class="form-control"></td>
                        </tr>
                        <tr id="plusBtn">
                            <td>
                                <a class="btn btn-default btn-xs" onclick="addNewLine(this);"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></a>
                            </td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        </tbody>
                    </table>

                </div>
            </div>
            <div class="panel-footer">
                <button type="button" class="btn btn-primary" data-toggle="button" aria-pressed="false" autocomplete="off" onclick="save()">
                    保存
                </button>
                <button type="button" class="btn btn-danger" onclick="closed()">
                    关闭
                </button>
            </div>
        </div>
        <%--导入Excel--%>
        <form action="importExcel" method="post" enctype="multipart/form-data">
            请选择模板文件(仅支持xlsx格式文件。注意：导入后会清空中奖名单及人员名单):<a class="btn btn-default" href="/downloadTemplate">下载模板</a>
            <input type="file" name="file" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" />
            <input type="submit" value="导入">
        </form>

        <div style="overflow-y: scroll;margin-left: 6%">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th class="text-center">序号</th>
                    <th class="text-center">桌号</th>
                    <th class="text-center">位置号</th>
                    <th class="text-center">部门</th>
                    <th class="text-center">姓名</th>
                    <th class="text-center">操作</th>
                </tr>
                </thead>
                <tbody>
                <%--循环显示信息--%>
                <c:forEach items="${seatList}" var="seat" varStatus="st">
                    <tr>
                        <td class="text-center">${st.count}</td>
                        <td class="text-center">${seat.tableId}</td>
                        <td class="text-center">${seat.locationId}</td>
                        <td class="text-center">${seat.department}</td>
                        <td class="text-center">${seat.name}</td>
                        <%--隐藏主键--%>
                        <td class="text-center hidden">${seat.id}</td>
                        <td class="text-center">
                            <a href="/editSeat?id=${seat.id}" title="编辑"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>
                            <a onclick="deleteItem(this);" href="#" title="作废"><span class="glyphicon glyphicon-remove" aria-hidden="true" ></span></a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
