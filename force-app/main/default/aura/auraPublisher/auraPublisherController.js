({
    doInit : function(component, event, helper){
        const apexAction = component.get('c.getAccounts');
        apexAction.setCallback(this, function(response){
            component.set('v.accounts', response.getReturnValue());
        });
        $A.enqueueAction(apexAction);
    },
    handleClick : function(component, event, helper) {

        const recordId = event.target.dataset.id
        const requestFrom = 'AURA';

        component.set('v.selectedId', recordId);

        const payload = { recordId, requestFrom };

        const message = component.find('mchannel');
        message.publish(payload);
    }
})
