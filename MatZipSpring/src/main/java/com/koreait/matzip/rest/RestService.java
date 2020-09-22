package com.koreait.matzip.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.koreait.matzip.model.CodeVO;
import com.koreait.matzip.model.CommonMapper;
import com.koreait.matzip.rest.model.RestDMI;
import com.koreait.matzip.rest.model.RestPARAM;
import com.koreait.matzip.rest.model.RestVO;

@Service
public class RestService {
	
	@Autowired
	private RestMapper mapper;
	
	@Autowired
	private CommonMapper cMapper;
	
	public List<RestDMI> selRestList(RestPARAM param){	
		return mapper.selRestList(param);	
	
	
	}
	
	public List<CodeVO> selcategoryList(){
		CodeVO p= new CodeVO();
		p.setI_m(1);
		return cMapper.selCodeList(p);
	}
	
	public int restReg(RestVO param) {
		String nm=param.getNm();
		String addr=param.getAddr();
		double lat=param.getLat();
		double lng=param.getLng();
		int cd_category=param.getCd_category();
		
		return mapper.insRest(param);
		
		
	}

}
