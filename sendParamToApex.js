import { LightningElement, track, wire } from 'lwc';
import getParam from '@salesforce/apex/traineeController.getParam';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class SendParamToApex extends LightningElement {
    @track UserName;
    @track password;
    @track errors;
    @track uName;
    @track pwd;
    @track score;
    @track UserFound;
    @track callComponent = false;
    @track setNo;
    handleChange(event) {
        if (event.target.name == 'usrName') {
            this.UserName = event.target.value;
        }
        if (event.target.name == 'pswd') {
            this.password = event.target.value;
        }
    }
    handleClick(event) {
        getParam({ userName: this.UserName, passwd: this.password })
            .then(result => {
                if (result != 'false' && result != 'taken') {
                    this.setNo = result;
                    this.callComponent = true;
                }
                else if(result == 'taken'){
                    const evnt = new ShowToastEvent({
                        title: 'Something wrong',
                        message: 'You have taken the exam',
                        variant: 'error',
                        mode: 'dismissable'
                    });
                    this.dispatchEvent(evnt);
                }
                else {
                    const evt = new ShowToastEvent({
                        title: 'Something wrong',
                        message: 'User not found',
                        variant: 'error',
                        mode: 'dismissable'
                    });
                    this.dispatchEvent(evt);
                }
            })
    }

}