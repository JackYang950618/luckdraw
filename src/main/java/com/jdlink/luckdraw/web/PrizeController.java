package com.jdlink.luckdraw.web;

import com.jdlink.luckdraw.dao.PrizeDAO;
import com.jdlink.luckdraw.pojo.Seat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

/**
 * 奖品控制器
 */
@Controller
public class PrizeController {

    @Autowired
    PrizeDAO prizeDAO;

    @GetMapping("/drawSetting")
    public String listEmployee(Model m) throws Exception {
//        List<Seat> seatList= luckDrawDAO.findAll();
//        m.addAttribute("seatList" ,seatList);
        return "drawSetting";  // 地址栏不会变
    }


}