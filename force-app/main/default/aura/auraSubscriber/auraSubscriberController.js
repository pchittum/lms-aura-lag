({
    handleMessage : function(component, message, helper) {
        if (message && message.getParam('recordId')){
            const accountId = message.getParam('recordId');
            
            component.set('v.publishedId', accountId);
            component.set('v.publishedFrom', message.getParam('requestFrom'));

            const apexAction = component.get('c.getContacts');

            // apexAction.setParams({accountId});
            apexAction.setParam('accountId', accountId);

            apexAction.setCallback(this, function(response){
                if(response.getState() === 'SUCCESS'){
                    component.set('v.contacts', response.getReturnValue());
                }
            });

            $A.enqueueAction(apexAction);
        } else {
            console.error('we got no message or message params');
            component.set('v.contacts', []);
        }
    }
})
