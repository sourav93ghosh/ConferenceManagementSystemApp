/*
Class to export sessions report
*/
public with sharing class ExportToExcel {
	
	List<Session__c> sessions;
	
	public void setSessions(List<Session__c> s){
		sessions = s;
	}
	
	public List<Session__c> getSessions(){
		return sessions;
	}
	
	public PageReference allSessions(){
		sessions = [select ID, Name, Date_and_Time__c, Description__c, Duration__c, Level__c, Status__c
						from Session__c];
		setSessions(sessions);				
		return null;
	}
	
	public PageReference endSessions(){
		sessions = [select ID, Name, Date_and_Time__c, Description__c, Duration__c, Level__c, Status__c
						from Session__c where Status__c = 'End'];
		setSessions(sessions);
		return null;
	}
	
	public PageReference upcomingSessions(){
		sessions = [select ID, Name, Date_and_Time__c, Description__c, Duration__c, Level__c, Status__c
						from Session__c where Status__c = 'Upcoming'];
		setSessions(sessions);
		return null;
	}
    
}