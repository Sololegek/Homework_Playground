/**
 * Created by Aleh_Salavei on 1/15/2020.
 */
({
    doInit: function(component, event, helper){
        var action = component.get('c.getItems');
        action.setCallback(this, function(response){
            if (response.getState() === 'SUCCESS'){
                console.log(response.getReturnValue());
                component.set('v.items', response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },

    handleAddItem: function(component, event, helper){
        helper.createItem(component, event);
    },

    handleUpdateItem: function(component, event, helper){
        helper.updateItem(component, event);
    }
})