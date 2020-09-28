package com.koreait.matzip.rest;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.koreait.matzip.CommonUtils;
import com.koreait.matzip.Const;
import com.koreait.matzip.FileUtils;
import com.koreait.matzip.SecurityUtils;
import com.koreait.matzip.model.CodeVO;
import com.koreait.matzip.model.CommonMapper;
import com.koreait.matzip.rest.model.RestDMI;
import com.koreait.matzip.rest.model.RestFile;
import com.koreait.matzip.rest.model.RestPARAM;
import com.koreait.matzip.rest.model.RestRecMenuVO;
import com.koreait.matzip.rest.model.RestVO;

@Service
public class RestService {

	@Autowired
	private RestMapper mapper;

	@Autowired
	private CommonMapper cMapper;

	public List<RestDMI> selRestList(RestPARAM param) {
		return mapper.selRestList(param);

	}

	public List<CodeVO> selcategoryList() {
		CodeVO p = new CodeVO();
		p.setI_m(1);
		return cMapper.selCodeList(p);
	}

	public int restReg(RestVO param) {
		String nm = param.getNm();
		String addr = param.getAddr();
		double lat = param.getLat();
		double lng = param.getLng();
		int cd_category = param.getCd_category();

		return mapper.insRest(param);

	}
	
	public void addHits(RestPARAM param, HttpServletRequest req) {
	  String myIp= SecurityUtils.ipAddr(req);
	  int i_user=SecurityUtils.getLoginUserPk(req);
	  ServletContext ctx = req.getServletContext(); //어플리케이션 !
	  String currentRestReadIp= (String)ctx.getAttribute(Const.CURRENT_REST_READ_IP+param.getI_rest());
		                                                   // 읽은 글을 뒤에 표시 해서 구분! 
		if(currentRestReadIp==null || currentRestReadIp.equals(myIp)) {
			//조회수 올림
			
			param.setI_user(i_user); //내가 쓴글 조회수 올라가는거 막기 (쿼리문으로!)
			mapper.updAddHits(param);
			ctx.setAttribute(Const.CURRENT_REST_READ_IP+param.getI_rest(), myIp);
		}
	}
	

	public RestDMI selRest(RestPARAM param) {

		return mapper.selRest(param);
	}

	public List<RestRecMenuVO> selRestMenus(RestPARAM param) {
		return mapper.selRestMenus(param);
	}
	
	public List<RestRecMenuVO> selRestRecMenus(RestPARAM param) {
		return mapper.selRestRecMenus(param);
	}

	@Transactional
	public void delRestTran(RestPARAM param) {
		mapper.delRestRecMenu(param);
		mapper.delRestMenu(param);
		mapper.delRest(param);
	}

	public int insMenus(RestFile param, String path, int i_user) {
		int i_rest = param.getI_rest();

		List<RestRecMenuVO> list = new ArrayList();

		for (MultipartFile file : param.getMenu_pic()) {
			RestRecMenuVO vo = new RestRecMenuVO();
			list.add(vo);

			String saveFileNm = FileUtils.saveFile(path, file);
			vo.setMenu_pic(saveFileNm);
			vo.setI_rest(param.getI_rest());
		}

		for (RestRecMenuVO vo : list) {
			mapper.insRestMenu(vo);
		}

		return Const.SUCCESS;

	}

	public int insRecMenus(MultipartHttpServletRequest mReq) {
		int i_user = SecurityUtils.getLoginUserPk(mReq.getSession());
		int i_rest = Integer.parseInt(mReq.getParameter("i_rest"));
		System.out.println("i_rest: " +i_rest);


		List<MultipartFile> fileList = mReq.getFiles("menu_pic");
		String[] menuNmArr = mReq.getParameterValues("menu_nm");
		String[] menuPriceArr = mReq.getParameterValues("menu_price");

		String path = Const.realPath + "resources/img/rest/" + i_rest + "/rec_menu/";

		List<RestRecMenuVO> list = new ArrayList();

		for (int i = 0; i < menuNmArr.length; i++) {
			RestRecMenuVO vo = new RestRecMenuVO();
			list.add(vo);

			String menu_nm = menuNmArr[i];
			int menu_price = CommonUtils.parseStringToInt(menuPriceArr[i]);
			vo.setI_rest(i_rest);
			vo.setMenu_nm(menu_nm);
			vo.setMenu_price(menu_price);

			MultipartFile mf = fileList.get(i);
			String saveFileNm = FileUtils.saveFile(path, mf);
			vo.setMenu_pic(saveFileNm);
		}

		for (RestRecMenuVO vo : list) {
			mapper.insRestRecMenu(vo);
		}

		return i_rest;
	}

	public int delRestRecMenu(RestPARAM param, String realPath) {
		List<RestRecMenuVO> list = mapper.selRestRecMenus(param);

		System.out.println("list0: " + list.size());
		if (list.size() == 1) { // 내가쓰고 삭제할것도 왔음.
			RestRecMenuVO item = list.get(0);

			if (item.getMenu_pic() != null && !item.getMenu_pic().equals("")) {
				File file = new File(realPath + item.getMenu_pic());
				if (file.exists()) { // 존재여부쳌
					if (file.delete()) {
						return mapper.delRestRecMenu(param);
					} else {
						return 0;
					}

				}
			}
		}

		return mapper.delRestRecMenu(param);

	}
	
	public int delRestMenu(RestPARAM param) {
		if(param.getMenu_pic()!=null && "".equals(param.getMenu_pic())) {
			String path=Const.realPath+"/resources/img/rest/" + param.getI_rest() + "/menu/";
			
			if(FileUtils.delFile(path+param.getMenu_pic())) {
				return mapper.delRestMenu(param);
			}else {
				return Const.FAIL;
			}
		}
		
		return mapper.delRestMenu(param);
	}


}
