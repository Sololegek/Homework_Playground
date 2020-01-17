/**
 * Created by Aleh_Salavei on 1/14/2020.
 */
({
    packItem: function(component, event, helper){
        component.set("v.item.Packed__c", true);
        event.getSource().set("v.disabled", true);
        var event = component.getEvent('updateItem');
        event.setParams({'item' : component.get('v.item')});
        event.fire();
    }
})