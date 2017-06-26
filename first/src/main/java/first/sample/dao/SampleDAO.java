package first.sample.dao;

import java.util.Map;
import org.springframework.stereotype.Repository;

import first.common.dao.AbstractDAO;

@Repository("sampleDAO")
public class SampleDAO extends AbstractDAO{

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardListNot(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectPagingList("sample.selectBoardListNot", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardListIng(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectPagingList("sample.selectBoardListIng", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardListEd(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectPagingList("sample.selectBoardListEd", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("sample.selectBoardDetail", map);
	}
	/**
	public void insertBoard(Map<String, Object> map) throws Exception{
		insert("sample.insertBoard", map);
	}

	public void updateHitCnt(Map<String, Object> map) throws Exception{
		update("sample.updateHitCnt", map);
	}
	
	public void updateBoard(Map<String, Object> map) throws Exception{
		update("sample.updateBoard", map);
	}

	public void deleteBoard(Map<String, Object> map) throws Exception{
		update("sample.deleteBoard", map);
	}
	*/
}
