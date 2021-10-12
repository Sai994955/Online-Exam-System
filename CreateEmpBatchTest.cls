@isTest
public class CreateEmpBatchTest {
    @isTest
    static void traineeData(){
        List<Employee__c> newEmps=new List<Employee__c>();
        
        List<Trainee__c> traineeList=new List<Trainee__c>();
        for(Integer i=0;i<200;i++){
            
            Trainee__c newTrainee=new Trainee__c(name='Test'+i, reached_end_date__c=false,User_Name__c='Us'+i,SetNumber__c='Set1',
                                                 Password__c='testt'+i,Training_End_Date__c=date.today(),email__c='test'+i+'@g.com');
 
            traineeList.add(newTrainee);
        }
        insert traineeList;
        CreateEmpBatch runBatch=new CreateEmpBatch();
        Test.startTest();
        Database.executeBatch(runBatch);
        String sch = '0 0 2 * * ?';
        System.schedule('AU1', sch, runBatch);
        Test.stopTest();
    }
    
}