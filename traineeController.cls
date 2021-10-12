public without sharing class traineeController {
    @AuraEnabled(cacheable=true)
    public static string getParam(string userName, string passwd){
        system.debug(userName);
        system.debug(passwd);
        string setNumber= 'false';
        List<Trainee__c> traineeList = [SELECT Name, SetNumber__c, Score__c, User_Name__c, Password__c FROM Trainee__c 
                                          WHERE User_Name__c =: userName AND Password__c =: passwd];
        if(traineeList.size() == 0 /*|| traineeList[0].Score__c != null*/) {
            return setNumber;
        }
        else {
              
              return traineeList[0].SetNumber__c;
        }
    }
    @AuraEnabled(cacheable=true)
    public static List<question1__c> getQuestionList(string setValue1) {
        system.debug('setNumber--' +setValue1);
        return [ SELECT answer1__c, answer2__c, answer3__c, answer4__c, Name, Correct_answer__c, Type__c 
                FROM question1__c where RecordType.name = :setValue1];
    }
    @AuraEnabled
    public static void updateScore(string uName, integer Score){
       updateScore.updateScore1(uName,Score);
    }
    @AuraEnabled
    public static void descriptiveAnswers(string userName, string question, string userAnswer){
       descriptiveAnswers.descDetails(userName,question,userAnswer);
    }
}