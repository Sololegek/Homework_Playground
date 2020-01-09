/**
 * Created by solol on 08.01.2020.
 */

@IsTest
public class Test_TaskHelper {

    public static Task createDummyTask(String subject, String status, Id whatId, Boolean needInsert) {
        Task dummyTask = new Task(Subject = subject, Status = status, WhatId = whatId);
        if (needInsert){
            insert dummyTask;
        }
        return dummyTask;
    }

    public static List<Task> createListOfDummyTasks(Integer count, String subject, String status, Id whatId, Boolean needInsert){
        List<Task> dummyTasks = new List<Task>();
        for (Integer i = 0; i < count; i++) {
            dummyTasks.add(createDummyTask(subject + '#' + i, status, whatId, false));
        }
        if (needInsert) {
            insert dummyTasks;
        }
        return dummyTasks;
    }
}