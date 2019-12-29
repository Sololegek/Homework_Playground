/**
 * Created by solol on 23.12.2019.
 */

public with sharing class BatchScheduler implements Schedulable{

    public void execute(SchedulableContext context) {
        ContactBatchableProcessor contactBatchableProcessor = new ContactBatchableProcessor();
        TaskBatchableProcessor taskBatchableProcessor = new TaskBatchableProcessor();
        Database.executeBatch(contactBatchableProcessor);
        Database.executeBatch(taskBatchableProcessor);
    }

}