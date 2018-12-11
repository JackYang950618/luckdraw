var g_Interval = 50;     // 数字跳转延迟速度(毫秒)
var g_Timer;           // 延迟执行代码块
var running = false; // 是否抽奖
var list = [[1, 2], [2, 1], [1, 3], [1, 4], [1, 1], [2, 2]];  // 参与抽奖的桌号和座位号
var winnerNumber = 1;  // 设置中奖人数
var listWinner = [];  // 中奖的人的桌号和座位号数据
var add = false;   // 新增是否成功
var tableList = [];  // 存放桌号及每桌剩余配额

function beginRndNum(trigger) {
    if (running) {  // 停止抽奖
        running = false;
        clearTimeout(g_Timer); //取消延时
        updateRndNum();  // 设置最终的中奖号码(保证不存在重复)
        $(trigger).text("开始");
        $("span[id^='tableId']").css('color', 'red');
        $("span[id^='locationId']").css('color', 'red');
        if (localStorage.prizeMode !== "true") { // 按桌抽奖
            if (list.length < 1) { //全部抽取完毕后显示中奖名单
                $("#list").show();            // 显示名单按钮
                setTimeout(function () {     // 不点击名单3秒后自动跳转
                    save();
                }, 3000); // 抽奖结束不点击三秒后自动执行
            }
        } else {
            $("#list").show();  // 按钮显示
            setTimeout(function () {     // 不点击名单3秒后自动跳转
                save();
            }, 3000); // 抽奖结束不点击三秒后自动执行
        }
    } else {   // 开始抽奖
        running = true;
        $("span[id^='tableId']").css('color', 'black');
        $("span[id^='locationId']").css('color', 'black');
        $(trigger).text("停止");
        beginTimer();
        $("#list").hide();    // 名单按钮隐藏
        if (localStorage.prizeMode !== "true") { //

        } else {  // 随机抽奖每次清空
            listWinner = [];   // 中奖人清空
        }
    }
}

/**
 * 获取抽奖编号并显示(随机抽奖)
 */
function updateRndNum() {
    if (localStorage.prizeMode === "true") {
        for (var i = 0; i < winnerNumber; i++) {
            var $i = i;
            var num = Math.floor(Math.random() * list.length);  // 序号
            $("#tableId" + $i).html(list[num][0]);
            $("#locationId" + $i).html(list[num][1]);
            if (!running) { // 停止随机后
                listWinner.push(list[num]);
                list.splice(num, 1);   // 将中奖者从数组中删除
            }
        }
    } else {
        var k = 0;
        for (var i = 0; i < localStorage.tableNumber; i++) {// 抽取桌数
            for (var p = 0; p < localStorage.everyTableNumber; p++) { // 每桌抽取人数
                var $i = k;
                var num = Math.floor(Math.random() * list.length);  // 序号
                if (list.length < 1) {
                    $("#tableId" + $i).html("--");
                    $("#locationId" + $i).html("--");
                } else {
                    $("#tableId" + $i).html(list[num][0]);
                    $("#locationId" + $i).html(list[num][1]);
                }
                if (!running) { // 停止随机后
                    if (list.length > 0) {
                        var tableNum = -1;
                        for (var j1 = 0; j1 < tableList.length; j1++) {  // 获取桌号在tableList中的下标位置
                            if (tableList[j1][0] === list[num][0]) { // 如果桌号相同保存其下标
                                tableNum = j1;
                            }
                        }
                        listWinner.push(list[num]); // 将获奖者数据插入到获奖者list中
                        list.splice(num, 1);   // 将中奖者从数组中删除
                        tableList[tableNum][1]--;  // 该桌的配额减一
                        for (var j2 = 0; j2 < list.length; j2++) {
                            if (tableList[tableNum][1] === 0) { // 如果该桌的配额已满，将该桌的剩余数据从list中删除
                                if (list[j2][0] === tableList[tableNum][0]) {
                                    list.splice(j2, 1);
                                    j2--; // 下标回退
                                }
                            }
                        }
                    }
                }
                k++;
            }
        }
    }
}

/**
 * 设置时间延迟
 * */
function beginTimer() {
    g_Timer = setTimeout(beat, g_Interval);
}

/**
 * 时间延迟时间，并执行数字滚动
 * */
function beat() {
    g_Timer = setTimeout(beat, g_Interval);
    updateRndNum();
}

/**
 * 下一轮或者保存数据并跳转中奖名单页面
 */
function save() {
    saveWinner();
    window.location.href = 'showWinnerList';
}

/**
 * 保存中奖数据并跳转到中奖名单
 */
function saveWinner() {
    var seatList = [];     // 初始化
    if (localStorage.prizeMode === "true") { // 随机抽取
        for (var i = 0; i < winnerNumber; i++) {
            var $i = i;
            var seat = {};
            seat.tableId = parseInt($("#tableId" + $i).text());
            seat.locationId = parseInt($("#locationId" + $i).text());
            var winners = {};
            winners.prizeId = localStorage.prizeId; // 保存奖品ID
            var prize = {};
            prize.number = localStorage.winnerNumber; // 奖品数
            winners.prize = prize;
            seat.winners = winners;
            seatList.push(seat);
        }
    } else {        // 按桌抽取
        for(var i = 0; i < listWinner.length; i++){
            var seat = {};
            seat.tableId = listWinner[i][0];
            seat.locationId = listWinner[i][1];
            var winners = {};
            winners.prizeId = localStorage.prizeId; // 保存奖品ID
            var prize = {};
            prize.number = localStorage.winnerNumber; // 奖品数
            winners.prize = prize;
            seat.winners = winners;
            seatList.push(seat);
        }
    }
    $.ajax({   // 将中奖者信息更新到数据库
        type: "POST",
        url: "updateWinner",
        async: false,                      // 同步：意思是当有返回值以后才会进行后面的js程序
        data: {
            "seats": JSON.stringify(seatList)
        },
        dataType: "json",
        success: function () {
            console.log("成功更新");
        }
    });
}

/**
 * 关闭面板
 */
function closed() {
    // 新增编辑面板赢藏
    $('#newPanel').hide(1000);
}