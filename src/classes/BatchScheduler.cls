/**
 * Created by solol on 23.12.2019.
 */

public with sharing class BatchScheduler implements Schedulable{

    private static ContactBatchableProcessor contactBatchableProcessor = new ContactBatchableProcessor();
    private static TaskBatchableProcessor taskBatchableProcessor = new TaskBatchableProcessor();

    public void execute(SchedulableContext context) {
        Database.executeBatch(contactBatchableProcessor);
        Database.executeBatch(taskBatchableProcessor);
    }

}