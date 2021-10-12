public class DesAns {
    @invocablemethod
    public static void test(List<Descriptive_answer__c> DescriptiveList){
        system.debug(DescriptiveList);
        Decimal finalScore=0;
        List<Descriptive_answer__c> answerList=[select score__c,User_Name__c from Descriptive_answer__c where User_Name__c=:DescriptiveList[0].User_Name__c];
        system.debug('Answer list size is :'+ answerList.size());
        for(Integer i=0; i < answerList.size();i++){
            finalScore += answerList[i].score__c;
        }
        System.debug('value='+finalScore);
        List<Trainee__c> traineeList=[select score__c, Descriptive_score__c, Overall_Score__c from Trainee__c where User_Name__c=:DescriptiveList[0].User_Name__c];
        traineeList[0].Descriptive_score__c = finalScore;
        update traineeList;
    }
}