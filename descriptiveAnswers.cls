public class descriptiveAnswers {
    @AuraEnabled(cacheable=true)
    public static void descDetails(string userName, string question, string userAnswer ){
        System.debug('User name is '+ userName);
        System.debug('Question is '+ question);
        System.debug('User answer is '+ userAnswer);
        List<question1__c> queValue=[select id from question1__c where name=:question];
        Descriptive_answer__c  newVal=new Descriptive_answer__c(Questionl__c=queValue[0].id, answer__c= userAnswer, User_Name__c=userName);
        insert newVal;
    }
}