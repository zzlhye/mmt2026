package com.mis.persistence;

public interface MentoringRelateDAO {
	
	// 현재 유저가 이 글에 눌러둔 타입(없으면 null)
    public String getType(int mentoringNum, String userId) throws Exception;

    // 반응 추가
    public void create(int mentoringNum, String userId, String relateType) throws Exception;

    // 반응 취소(해당 글에서 유저 반응 전부 삭제)
    public void delete(int mentoringNum, String userId) throws Exception;
    
    public void deleteAll(int mentoringNum) throws Exception;

    // 해당 글 전체 반응 수(타입 상관없이)
    public int countAll(int mentoringNum) throws Exception;
    
    public int countEmo1(int mentoringNum) throws Exception;  
    
    public int countEmo2(int mentoringNum) throws Exception; 
    
    public int countEmo3(int mentoringNum) throws Exception; 
     
    public int countEmo4(int mentoringNum) throws Exception; 
    
    public int countEmo5(int mentoringNum) throws Exception; 
    
    public int countEmo6(int mentoringNum) throws Exception; 
    
    public int countEmo7(int mentoringNum) throws Exception; 
    

}
