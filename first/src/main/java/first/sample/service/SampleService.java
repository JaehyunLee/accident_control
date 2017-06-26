package first.sample.service;

import java.util.Map;

public interface SampleService {

	Map<String, Object> selectBoardListNot(Map<String, Object> map) throws Exception;

	Map<String, Object> selectBoardListIng(Map<String, Object> map) throws Exception;
	
	Map<String, Object> selectBoardListEd(Map<String, Object> map) throws Exception;
	
	Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception;

	/**
	void insertBoard(Map<String, Object> map) throws Exception;


	void updateBoard(Map<String, Object> map) throws Exception;

	void deleteBoard(Map<String, Object> map) throws Exception;
	*/

}
