package kr.or.everyware.everyware.mypage.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.everyware.mypage.vo.MyPage;
import kr.or.everyware.login.vo.Employee;



@Mapper
public interface MyPageMapper {

	List<MyPage> selectMyList(MyPage mypage);







}
