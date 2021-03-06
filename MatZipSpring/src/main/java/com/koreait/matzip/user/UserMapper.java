package com.koreait.matzip.user;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.koreait.matzip.user.model.UserDMI;
import com.koreait.matzip.user.model.UserPARAM;
import com.koreait.matzip.user.model.UserVO;

@Mapper
public interface UserMapper {
	public int insUser(UserVO p);
	public int insFavorite(UserPARAM p);
	
	public UserDMI selUser(UserPARAM p);
	List<UserDMI> selFaboriteList(UserPARAM p);
	
	public int delFavorite(UserPARAM p);
}
