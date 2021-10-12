@isTest
public class updateScoreTest {
    @isTest
    private static void scoreTest(){
        List<Trainee__c> traineeList=new List<Trainee__c>();
        List<Trainee__c> updatedTraineeList=new List<Trainee__c>();
        for(Integer i=0;i<200;i++){
            Trainee__c newTrainee=new Trainee__c(name='Test'+i, reached_end_date__c=false, User_Name__c='Us'+i,SetNumber__c='Set1',Score__c=20+i,
                                                 Password__c='testt'+i,email__c='test'+i+'@g.com');
            traineeList.add(newTrainee);
            
        }
        insert traineeList;
        list<trainee__c> train= [select id, score__c from trainee__c];
        system.debug(train);
        for(trainee__c i: train){
            i.Score__c=1;
            updatedTraineeList.add(i);
            
            //traineeList.add(newTrainee);
        }
        update updatedTraineeList;
        
        Test.startTest();
        updateScore.updateScore1('Us0', 20);
        Test.stopTest();
    }
}