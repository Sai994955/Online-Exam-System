@isTest
public class CreateEmpHandlerTest {
    @isTest
    static void test1(){
        List<Trainee__c> rec=CreateEmpHandlerTest.test();
        insert rec;
        List<Trainee__c> updatedrec1=new List<Trainee__c>();
        for(Trainee__c i:[SELECT Id, Name,isactive__c,email__c FROM Trainee__c where name LIKE 'Test%']){
            i.isactive__c=true;
            updatedrec1.add(i);
        }
        update updatedrec1;
        System.debug(updatedrec1);
        List<Trainee__c> updatedrec2=new List<Trainee__c>();
        for(Trainee__c i:[SELECT Id, Name,isactive__c,email__c FROM Trainee__c where name LIKE 'Test%']){
            i.isactive__c=false;
            updatedrec2.add(i);
        }
        update updatedrec2;
    }
    @isTest
    static void test2(){
        List<Trainee__c> rec=CreateEmpHandlerTest.test();
        for(Trainee__c i: rec){
            i.isActive__c=true;
        }
        insert rec;
        List<Trainee__c> updatedrec1=new List<Trainee__c>();
        for(Trainee__c i:[SELECT Id, Name,isactive__c,email__c FROM Trainee__c where name LIKE 'Test%']){
            i.isactive__c=false;
            updatedrec1.add(i);
        }
        update updatedrec1;
        System.debug(updatedrec1);
    }
    static List<trainee__c> test(){
        List<Trainee__c> newT=new List<Trainee__c>();
        for(Integer i=0;i<100;i++){
            Trainee__c tests=new Trainee__c(name='test'+i,email__c='test@'+i+'gmail.com',User_Name__c='sai'+i, Password__c='abc'+i,  SetNumber__c='Set1',Training_End_Date__c=Date.newInstance(2021, 10, 9),
                                            isActive__c=false);
            newT.add(tests);
        }
        return newT;
    }
}