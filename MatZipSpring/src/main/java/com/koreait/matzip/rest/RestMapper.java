package com.koreait.matzip.rest;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.koreait.matzip.rest.model.RestDMI;
import com.koreait.matzip.rest.model.RestPARAM;
import com.koreait.matzip.rest.model.RestRecMenuVO;
import com.koreait.matzip.rest.model.RestVO;

@Mapper
public interface RestMapper {
	 int insRest(RestVO p);
	 int insRestMenu(RestRecMenuVO p);
	 int insRestRecMenu(RestRecMenuVO p);
	 int selRestchkUser(int i_rest);
	 
	 int updAddHits(RestPARAM p);
	 
	 
	 List<RestRecMenuVO> selRestMenus(RestPARAM p);
	 List<RestDMI> selRestList(RestPARAM p);
	 List<RestRecMenuVO>selRestRecMenus(RestPARAM p);
	 RestDMI selRest(RestPARAM p);
	 
	 int delRestRecMenu(RestPARAM p);
	 int delRestMenu(RestPARAM p);
	 int delRest(RestPARAM p);
	 

}