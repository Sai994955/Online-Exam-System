@isTest
public class traineeControllerTest2 {
    @isTest
    private static void traineetest2(){
        List<Employee__c> empList=new List<Employee__c>();
        List<trainee__c> traineeList = new List<trainee__c>();
        List<Descriptive_answer__c> ansList=new List<Descriptive_answer__c>();
        for(Integer j=0;j<200;j++){
            trainee__c newTrainee=new trainee__c(User_Name__c='sai'+j, Password__c='abc'+j,  SetNumber__c='Set1', Email__c='abc'+j+'@c.com');
            traineeList.add(newTrainee);
        }
        insert traineeList;
        for(Integer i=0;i<200;i++){
            Descriptive_answer__c newAnswer=new Descriptive_answer__c(User_Name__c='sai'+i, Score__c=20+i);
            ansList.add(newAnswer);
        }
        insert ansList;
        Test.startTest();
        traineeController.updateScore('sai0', 20);
        traineeController.descriptiveAnswers('sai0', 'abc', 'xyz');
        Test.stopTest();
    }
}