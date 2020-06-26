/**
 * Created by Aleh_Salavei on 1/20/2020.
 */
({
    handleRecordUpdate: function(component, event, helper){
        var eventParams = event.getParams();
        if (eventParams.changeType === "ERROR"){
            component.set("v.recordSaveError", "invalid edit value");
        }
        console.log(component.get("v.recordSaveError"));
    }
})