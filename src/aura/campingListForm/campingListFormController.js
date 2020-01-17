/**
 * Created by Aleh_Salavei on 1/16/2020.
 */
({
    clickCreateItem: function(component, event, helper){

        var isItemValid = component.find('newItemForm').reduce(function(validSoFar, inputCmp){
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);

        if (isItemValid){
            helper.createItem(component);
        }
    }
})