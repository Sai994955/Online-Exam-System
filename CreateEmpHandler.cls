public class CreateEmpHandler {
    public static void empCreationOnNewTrainee(List<Trainee__c> trainees){
         List<Employee__c> newEmps=new List<Employee__c>();
            List<trainee__c> traineeRec=[select name,email__c from trainee__c where isActive__c=true AND id IN :trainees];
            for(trainee__c i: traineeRec){
                Employee__c newEmp= new Employee__c(name=i.Name,email__C=i.email__c);
                newEmps.add(newEmp);
            }
            insert newEmps;
    }
   
    public static void empCreationOnTraineeUpdate(List<trainee__c> newValues, Map<id,trainee__c> oldValues){
        List<String> test1=new List<String>();
        List<String> delTest1=new List<String>();       
        List<Employee__C> newEmps=new List<Employee__c>();
        for (trainee__c t : newValues) {
            trainee__c old = oldValues.get(t.Id);
            if (t.isActive__c != old.isActive__c && t.isActive__c==true) {
                Employee__c newEmp=new Employee__c();
                newEmp.Name=t.Name;
                newEmp.Email__c=t.email__c;
                test1.add(t.email__c);
                newEmps.add(newEmp);   
            }
            else if(t.isActive__c != old.isActive__c && t.isActive__c==false ){
                delTest1.add(t.email__c);
            }
           
        }
       
        List<Employee__C> empRec=[select email__c from employee__c where email__c IN :test1];
        if(newEmps.size()>0 && empRec.size()==0){
            insert newEmps;}
       
        List<Employee__C> empDelRec=[select id from employee__c where email__c IN :delTest1];
        if(empDelRec.size()>0){
            delete empDelRec;}
       
    }
   
    public static void delTraineeRec(List<Trainee__C> oldValues){
        List<Trainee__C> allRec=[select id,name from Trainee__c];
        List<String> deletedRecords=new List<String>();
        for(Trainee__c i:[select id,email__c from trainee__c where id in :oldValues ALL ROWS]){
            deletedRecords.add(i.email__c);
        }
       
        List<Employee__c> deleteEmpRec=[select id from employee__c where email__c IN :deletedRecords];
        delete deleteEmpRec;
    }
}