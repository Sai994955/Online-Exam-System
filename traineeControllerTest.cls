@isTest
public class traineeControllerTest {
    @isTest
    private static void traineeTest(){
        List<Trainee__c> traineeList=new List<Trainee__c>();
        for(Integer i=0;i<200;i++){
            Trainee__c newTrainee=new Trainee__c(name='Test'+i, reached_end_date__c=false, User_Name__c='Us'+i,SetNumber__c='Set1',Score__c=20+i,
                                                 Password__c='testt'+i,Training_End_Date__c=date.today(),email__c='test'+i+'@g.com');
            traineeList.add(newTrainee);
        }
        insert traineeList;
        System.assertEquals(false, traineeList.size()==0);
        Test.startTest();
        traineeController.getParam('Us0', 'testt0');
        Test.stopTest();
    }
    @isTest
    private static void traineeTest2(){
        List<question1__c> questionList=new List<question1__c>();
        for(Integer i=0;i<200;i++){
            question1__c newQuestion = new question1__c(answer1__c='abc'+i, answer2__c='abc'+i, 
                                    answer3__c='abc'+i, answer4__c='abc'+i, Name='XYZ', 
                                    Correct_answer__c='abc'+i, Type__c='Single');
            questionList.add(newQuestion);
        }
        insert questionList;
        Test.startTest();
        traineeController.getQuestionList('set1');
        Test.stopTest();
    }
}