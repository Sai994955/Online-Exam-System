global class CreateEmpBatch implements Database.Batchable<sObject>,schedulable{
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        
        return Database.getQueryLocator('select id,reached_end_date__c from trainee__C where Training_End_Date__c=Today AND reached_end_date__c=false');
    }
    
    List<trainee__c> temp=new List<trainee__c>();
    global void execute(Database.BatchableContext bc, list<Trainee__c> scope){
        for(Trainee__c t: scope){
            t.reached_end_date__c=true;
            temp.add(t);
            System.debug(temp);
        }
        if(temp.size()>0){
            update temp;}
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Output');
    }
    global void execute(SchedulableContext sc){
        CreateEmpBatch k=new CreateEmpBatch();
        Database.executeBatch(k);
    }
    
    
}