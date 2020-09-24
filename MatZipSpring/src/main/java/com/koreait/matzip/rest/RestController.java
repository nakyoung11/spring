package com.koreait.matzip.rest;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.koreait.matzip.Const;
import com.koreait.matzip.SecurityUtils;
import com.koreait.matzip.ViewRef;
import com.koreait.matzip.rest.model.RestDMI;
import com.koreait.matzip.rest.model.RestFile;
import com.koreait.matzip.rest.model.RestPARAM;
import com.koreait.matzip.rest.model.RestRecMenuVO;

@Controller
@RequestMapping("/rest")
public class RestController {
	
	@Autowired
	private RestService service;
	

	
	
	@RequestMapping("/map")
	public String restMap(Model model){
		model.addAttribute(Const.TITLE,"지도보기");
		model.addAttribute(Const.VIEW,"rest/restMap");
		return ViewRef.TEMP_MENU_TEMP;
		
	}
	@RequestMapping("/detail")
	public String detail(Model model, RestPARAM param){
		RestDMI data=service.selRest(param);
		List<RestRecMenuVO> list =service.selRestRecMenus(param);
		
		
		model.addAttribute("menuList", service.selRestMenus(param));
		model.addAttribute("css", new String[]{"restaurant"});
		model.addAttribute("recMenuList", list);
		model.addAttribute("data", data);
		model.addAttribute(Const.TITLE,data.getNm());
		model.addAttribute(Const.VIEW,"rest/restDetail");
		return ViewRef.TEMP_MENU_TEMP;
		
	}

	
	@RequestMapping(value ="/restReg", method = RequestMethod.GET)
	public String restReg(Model model){
		
		model.addAttribute("categoryList",service.selcategoryList());
		model.addAttribute(Const.TITLE,"등록");
		model.addAttribute(Const.VIEW,"rest/restReg");
		return ViewRef.TEMP_MENU_TEMP;
		
	}
	
	@RequestMapping(value = "/restReg", method = RequestMethod.POST)
	public String restReg(RestPARAM param, HttpSession hs) {
		param.setI_user(SecurityUtils.getLoginUserPk(hs));
		int result = service.restReg(param);

		if (result == 1) {
			return "redirect:/rest/map";
		}
		
		return "redirect:/rest/map";
	}
	
	@RequestMapping("/del" )
		public String del(RestPARAM param, HttpSession hs) {
			int loginI_user=SecurityUtils.getLoginUserPk(hs);
			System.out.println("user"+loginI_user);
			param.setI_user(loginI_user);
			int result=1;
			
			try {
				service.delRestTran(param);
			}catch(Exception e) {
				result=0;
			}
			
			System.out.println("result:"+result);
			
			return "redirect:/";
			
		}
	
	@RequestMapping(value="/recMenus")
		public String recMenus(MultipartHttpServletRequest mReq, RedirectAttributes ra) {
			int i_rest=service.insRecMenus(mReq);
			
			ra.addAttribute("i_rest", i_rest);
			return "redirect:/rest/detail";
			
	}
	
	
	
	@RequestMapping(value="/ajaxGetList", produces= {"application/json;charset=UTF-8"})
	@ResponseBody public List<RestDMI> ajaxGetList(RestPARAM param) {
		System.out.println("sw_lat: "+ param.getSw_lat());
		System.out.println("sw_lng: "+ param.getSw_lng());
		System.out.println("ne_lat: "+ param.getNe_lat());
		System.out.println("ne_lng: "+ param.getNe_lng());
		return service.selRestList(param);
	}
	
	@RequestMapping(value="/ajaxDelRecMenu")
	@ResponseBody public int ajaxDelRecMenu(RestPARAM param, HttpSession hs) {
		param.setI_user(SecurityUtils.getLoginUserPk(hs));
		String path="/resources/img/rest/" + param.getI_rest() + "/rec_menu/";
		String realPath=hs.getServletContext().getRealPath(path);
		return service.delRecMenu(param, realPath);
	}	
	
	@RequestMapping("/menus")
		public String menus(@ModelAttribute RestFile param, HttpSession hs) {
		int i_user=SecurityUtils.getLoginUserPk(hs);
		int i_rest=param.getI_rest();
		String path= Const.realPath + "resources/img/rest/" + i_rest + "/menu/";
		service.insMenus(param, path, i_user);
		return "redirect:/rest/detail?i_rest="+i_rest;
			
	}
	
	
	
	
}
