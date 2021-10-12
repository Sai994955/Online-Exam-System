@isTest
public class descriptiveAnswersTest {
    @isTest
    private static void desAnsTest(){
        List<question1__c> quesList=new List<question1__c>();
        List<trainee__c> traineeList=new List<trainee__c>();
        for(Integer i=0;i<200;i++){
            question1__c newTrainee=new question1__c(name='Test'+i, type__c='Single');
            quesList.add(newTrainee);    
        }
        for(Integer i=0;i<200;i++){
            trainee__c newTrain=new trainee__c(name='Test'+i, reached_end_date__c=false, User_Name__c='Test'+i,SetNumber__c='Set1',Score__c=20+i,
                                                 Password__c='testt'+i,Training_End_Date__c=date.today(),email__c='test'+i+'@g.com');
            traineeList.add(newTrain);    
        }
        insert quesList;
        insert traineeList;
        Test.startTest();
        descriptiveAnswers.descDetails('xyz', 'Test0', 'abc');
        Test.stopTest();
    }
}