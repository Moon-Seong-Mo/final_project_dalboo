package com.kh.dalboo.menu.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.kh.dalboo.board.model.exception.BoardException;
import com.kh.dalboo.menu.model.exception.MenuException;
import com.kh.dalboo.menu.model.service.MenuService;
import com.kh.dalboo.menu.model.vo.Menu;



@Controller
public class MenuController {
	
	@Autowired
	private MenuService menuService;
	
	//커피 리스트
	@RequestMapping("coffee_list.cf")
    public ModelAndView  menuList(ModelAndView mv) {
		
	  ArrayList<Menu> list = menuService.selectList();
	  if(list !=null) {
		  mv.addObject("list", list);
		  mv.setViewName("coffee_list");
	  }else {
		  throw new BoardException("커피 조회에 실패했습니다.");
	  }
	  
      return mv;
   }
	
	//디저트 리스트
	@RequestMapping("dessert_list.cf")
	public ModelAndView  menuList2(ModelAndView mv) {
		
		ArrayList<Menu> list = menuService.selectList2();
		if(list !=null) {
			mv.addObject("list", list);
			mv.setViewName("dessert_list");
		}else {
			throw new BoardException("디저트 조회에 실패했습니다.");
		}
		
		return mv;
	}
	
	//음료 리스트
	@RequestMapping("ade_list.cf")
	public ModelAndView  menuList3(ModelAndView mv) {
		
		ArrayList<Menu> list = menuService.selectList3();
		if(list !=null) {
			mv.addObject("list", list);
			mv.setViewName("ade_list");
		}else {
			throw new BoardException("에이드 조회에 실패했습니다.");
		}
		
		return mv;
	}
	
	//신메뉴 리스트
	@RequestMapping("newmenu_list.cf")
	public ModelAndView  menuList4(ModelAndView mv) {
		
		ArrayList<Menu> list = menuService.selectList4();
		
		if(list !=null) {
			mv.addObject("list", list);
			mv.setViewName("newmenu_list");
		}else {
			throw new BoardException("신메뉴 조회에 실패했습니다.");
		}
		
		return mv;
	}
	
	
	// 메뉴 추가view
	@RequestMapping("coffee_insertView.cf")
    public String coffeeInsertView() {
	return "coffee_register";
    }
	

	// 메뉴 추가
	@RequestMapping("coffee_insert.cf")
	public String coffeeInsertFile(@ModelAttribute Menu m, @RequestParam("uploadFile") MultipartFile uploadFile, HttpServletRequest request) {
    	
    	if(uploadFile != null && !uploadFile.isEmpty()) { //첨푸파일이 있다면
    		String renameFileName = saveFile(uploadFile, request);
        	
    		if(renameFileName != null) {
    			m.setRenameFileName(renameFileName);
    			m.setOriginalFileName(uploadFile.getOriginalFilename());
    		}
    	}
    	
    	int result = menuService.insertMenu(m);
    	
    	if(result > 0) {
    		return "redirect:coffee_list.cf";
    	} else {
    		throw new MenuException("커피 등록에 실패하였습니다.");
    	}
	}
    
	
	//메뉴 추가(사진)
	public String saveFile(MultipartFile file, HttpServletRequest request) {
    	String root = request.getSession().getServletContext().getRealPath("resources");
    	
    	String savePath = root + "\\muploadFiles";
    	
    	
    	File folder = new File(savePath);
    	if(!folder.exists()) {
    		folder.mkdirs();
    	}
    		
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
    	String originFileName = file.getOriginalFilename();
    	String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + "." + 
    							originFileName.substring(originFileName.lastIndexOf(".") + 1);
    	
    	String renamePath = folder + "\\" + renameFileName;
    		
    	try {
			file.transferTo(new File(renamePath));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
    	
    	return renameFileName;
    }
	
	
	//메뉴삭제(커피)
    @RequestMapping("coffee_delete.cf")
    public String coffeeDelete(@RequestParam("mNum") int mNum) {
    	
    	int result = menuService.coffeeDelete(mNum);
    	
    	if(result > 0) {
    		return "redirect:coffee_list.cf";
    	} else {
    		throw new MenuException("커피 삭제에 실패하였습니다.");
    	}
    }
    //메뉴삭제(디저트)
    @RequestMapping("dessert_delete.cf")
    public String dessertDelete(@RequestParam("mNum") int mNum) {
    	
    	int result = menuService.dessertDelete(mNum);
    	
    	if(result > 0) {
    		return "redirect:dessert_list.cf";
    	} else {
    		throw new MenuException("디저트 삭제에 실패하였습니다.");
    	}
    }
    
    //메뉴삭제(음료)
    @RequestMapping("ade_delete.cf")
    public String adeDelete(@RequestParam("mNum") int mNum) {
    	
    	int result = menuService.adeDelete(mNum);
    	
    	if(result > 0) {
    		return "redirect:ade_list.cf";
    	} else {
    		throw new MenuException("음료 삭제에 실패하였습니다.");
    	}
    }
    //메뉴삭제(신메뉴)
    @RequestMapping("newmenu_delete.cf")
    public String newmenuDelete(@RequestParam("mNum") int mNum) {
    	
    	int result = menuService.newmenuDelete(mNum);
    	
    	if(result > 0) {
    		return "redirect:newmenu_list.cf";
    	} else {
    		throw new MenuException("신메뉴 삭제에 실패하였습니다.");
    	}
    }
    
    
	

	
}
