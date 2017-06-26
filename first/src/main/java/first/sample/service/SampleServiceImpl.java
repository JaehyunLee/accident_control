package first.sample.service;

import java.util.Map;
import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import first.sample.dao.SampleDAO;

@Service("sampleService")
public class SampleServiceImpl implements SampleService{
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="sampleDAO")
	private SampleDAO sampleDAO;
	
	@Override
	public Map<String, Object> selectBoardListNot(Map<String, Object> map) throws Exception {
		return sampleDAO.selectBoardListNot(map);
		
	}
	
	@Override
	public Map<String, Object> selectBoardListIng(Map<String, Object> map) throws Exception {
		return sampleDAO.selectBoardListIng(map);
		
	}
	
	@Override
	public Map<String, Object> selectBoardListEd(Map<String, Object> map) throws Exception {
		return sampleDAO.selectBoardListEd(map);
		
	}
	
	@Override
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception {
//		sampleDAO.updateHitCnt(map);
		Map<String, Object> resultMap = sampleDAO.selectBoardDetail(map);
		return resultMap;
	}
	
	/**
	@Override
	public void insertBoard(Map<String, Object> map) throws Exception {
		sampleDAO.insertBoard(map);
	}

	

	@Override
	public void updateBoard(Map<String, Object> map) throws Exception{
		sampleDAO.updateBoard(map);
	}

	@Override
	public void deleteBoard(Map<String, Object> map) throws Exception {
		sampleDAO.deleteBoard(map);
	}
 	*/
}
