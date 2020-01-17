/**
 * Created by Aleh_Salavei on 1/16/2020.
 */
({
    createItem: function(component){
        var event = component.getEvent('addItem');
        console.log(event);
        console.log(component.get('v.newItem'));
        event.setParams({'item' : component.get('v.newItem')});
        event.fire();
        component.set('v.newItem', {'sobjectType' : 'Camping_Item__c', 'Quantity__c' : 0, 'Price__c' : 0});
    }
})