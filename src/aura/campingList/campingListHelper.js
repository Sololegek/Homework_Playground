/**
 * Created by Aleh_Salavei on 1/16/2020.
 */
({
    createItem: function(component, event){
        var action = component.get('c.saveItem');
        var newItem = event.getParam('item');
        action.setParams({'item' : newItem});
        action.setCallback(this, function(response){
           if(response.getState() === 'SUCCESS'){
               var items = component.get('v.items');
               items.push(response.getReturnValue());
               component.set('v.items', items);
           }
        });
        $A.enqueueAction(action);
    },

    updateItem: function(component, event){
            var action = component.get('c.saveItem');
            var newItem = event.getParam('item');
            action.setParams({'item' : newItem});
            $A.enqueueAction(action);
        }
})