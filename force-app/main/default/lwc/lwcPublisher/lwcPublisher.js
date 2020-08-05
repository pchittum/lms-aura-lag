import { LightningElement, wire } from 'lwc';
import getAccounts from "@salesforce/apex/DataFetcher.getAccounts";

import { publish, MessageContext } from "lightning/messageService";
import TEST_MESSAGE_CHANNEL from "@salesforce/messageChannel/test_channel__c";

export default class LwcPublisher extends LightningElement {

    @wire(MessageContext)
    messageContext;
    
    @wire(getAccounts)
    accounts;

    selectedId;

    handleClick(event){
        console.log(event);
        console.log(event.target.dataset.id);
        this.selectedId = event.target.dataset.id; 

        const payload = { 
                            recordId: this.selectedId,
                            requestFrom: 'LWC' 
                        };

        publish(this.messageContext, TEST_MESSAGE_CHANNEL, payload);

    }

}