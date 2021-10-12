public without sharing class updateScore {
    public static void updateScore1(string uName, integer Score){
        system.debug(uName);
        system.debug(Score);
        Trainee__c trn= [Select User_Name__c, Score__c from Trainee__c where User_Name__c =: uName limit 1];
        trn.Score__c = Score;
        database.update(trn);
    }
}