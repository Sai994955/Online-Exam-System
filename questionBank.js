import { LightningElement, wire, track, api } from 'lwc';
import getQuestionList from '@salesforce/apex/traineeController.getQuestionList';
import updateScore from '@salesforce/apex/traineeController.updateScore';
import descriptiveAnswers from '@salesforce/apex/traineeController.descriptiveAnswers';
import singleCorrectAnswers from '@salesforce/apex/traineeController.singleCorrectAnswers';
import multiCorrectAnswers from '@salesforce/apex/traineeController.multiCorrectAnswers';

import centLogo from '@salesforce/resourceUrl/centelonLogo';
export default class questionBank extends LightningElement {
    LogoUrl = centLogo;
    @api setNumber;
    @api userName;
    inputLabel = '';
    inputValue;
    questionList;
    question;
    option1;
    option2;
    option2;
    option4;
    indexValue = 0;
    score = 0;
    totalQuestions = 0;
    input = true;
    disableSubmitButton = true;
    disableNextButton = false;
    multiAns;
    @track checkboxOptions = [];
    checkboxOptionsValue ;
    @track radioGroupOptions = [];
    radioGroupOptionsValue = '';
    @track callResult = false;

    connectedCallback() {
        this.getQuestions();
    }

    getQuestions() {
        getQuestionList({ setValue1: this.setNumber })
            .then(result => {
                this.questionList = result;
                this.totalQuestions = this.questionList.length;
                this.setQuestions();
            })
            .catch(error => {
            })
    }

    setQuestions() {
        this.checkboxOptions = [];
        this.checkboxOptionsValue = [];
        this.radioGroupOptions = [];
        this.radioGroupOptionsValue = '';


        if (this.questionList[this.indexValue].Type__c == "Multiple") {
            this.question = this.questionList[this.indexValue].Name + '(choose all possible answers)' ;
            this.checkboxOptions.push({
                label: this.questionList[this.indexValue].answer1__c,
                value: this.questionList[this.indexValue].answer1__c
            });
            this.checkboxOptions.push({
                label: this.questionList[this.indexValue].answer2__c,
                value: this.questionList[this.indexValue].answer2__c
            });
            this.checkboxOptions.push({
                label: this.questionList[this.indexValue].answer3__c,
                value: this.questionList[this.indexValue].answer3__c
            });
            this.checkboxOptions.push({
                label: this.questionList[this.indexValue].answer4__c,
                value: this.questionList[this.indexValue].answer4__c
            });
            this.input = true;
        }
        else if (this.questionList[this.indexValue].Type__c == "Single") {
            this.question = this.questionList[this.indexValue].Name;
            this.radioGroupOptions.push({
                label: this.questionList[this.indexValue].answer1__c,
                value: this.questionList[this.indexValue].answer1__c
            });
            this.radioGroupOptions.push({
                label: this.questionList[this.indexValue].answer2__c,
                value: this.questionList[this.indexValue].answer2__c
            });
            this.radioGroupOptions.push({
                label: this.questionList[this.indexValue].answer3__c,
                value: this.questionList[this.indexValue].answer3__c
            });
            this.radioGroupOptions.push({
                label: this.questionList[this.indexValue].answer4__c,
                value: this.questionList[this.indexValue].answer4__c
            });
            this.input = true;
        }
        else if (this.questionList[this.indexValue].Type__c == "Descriptive") {
            this.question = this.questionList[this.indexValue].Name;
            this.input = false;
        }
    }
    onChangeRadioButtonGroup(event) {
        this.radioGroupOptionsValue = event.target.value;
    }
    onChangecheckboxGroup(event) {
        this.checkboxOptionsValue = event.target.value;
    }
    onChangeInput(event) {
        this.inputValue = event.target.value;
    }

    onButtonClick(event) {
        if (event.target.label == 'Next') {
            if (this.indexValue < this.totalQuestions) {
                if (this.questionList[this.indexValue].Type__c == "Descriptive") {
                    descriptiveAnswers({ userName: this.userName, question: this.question, userAnswer: this.inputValue })
                    this.inputValue = '';
                }
                if (this.questionList[this.indexValue].Type__c == "Multiple") {
                    if (this.questionList[this.indexValue].Correct_answer__c == this.checkboxOptionsValue) {
                        this.score = this.score + 1;
                    }
                    this.multiAns =this.checkboxOptionsValue.toString();
                    multiCorrectAnswers({ usName: this.userName, ques: this.question, usAnswer: this.multiAns})
                    console.log('score is >> '+ this.score);
                    console.log('answer is >> '+ this.multiAns);
                    //this.multiAns = '';
                    //console.log('converted string>> '+ this.multiAns );
                }
                if (this.questionList[this.indexValue].Type__c == "Single") {
                    if (this.questionList[this.indexValue].Correct_answer__c == this.radioGroupOptionsValue) {
                        this.score = this.score + 1;
                    }
                    singleCorrectAnswers({ uName: this.userName, Question: this.question, uAnswer: this.radioGroupOptionsValue })
                    this.radioGroupOptionsValue = '';
                    console.log('score is >> '+ this.score);
                }
                /*if (this.questionList[this.indexValue].Correct_answer__c == this.radioGroupOptionsValue || this.questionList[this.indexValue].Correct_answer__c == this.checkboxOptionsValue) {
                    this.score = this.score + 1;
                }*/
                this.indexValue = this.indexValue + 1;
                this.setQuestions();
                if (this.totalQuestions - 1 == this.indexValue) {
                    this.disableSubmitButton = false;
                    this.disableNextButton = true;
                } 
            }
        }
        else if (event.target.label == 'Submit') {
            if (this.questionList[this.indexValue].Type__c == "Descriptive") {
                descriptiveAnswers({ userName: this.userName, question: this.question, userAnswer: this.inputValue })
                this.inputValue = '';
                this.callResult = true;
            }
            if (this.questionList[this.indexValue].Type__c == "Multiple") {
                if (this.questionList[this.indexValue].Correct_answer__c == this.checkboxOptionsValue) {
                    this.score = this.score + 1;
                    updateScore({ uName: this.userName, Score: this.score })
                }
                this.multiAns =this.checkboxOptionsValue.toString();
                multiCorrectAnswers({usName: this.userName, ques: this.question, usAnswer: this.multiAns})
                this.callResult = true;
                console.log('score is >> '+ this.score);
                //this.multiAns = '';
                //console.log('converted string>> '+ this.multiAns );
            }
            if (this.questionList[this.indexValue].Type__c == "Single") {
                if (this.questionList[this.indexValue].Correct_answer__c == this.radioGroupOptionsValue) {
                    this.score = this.score + 1;
                    updateScore({ uName: this.userName, Score: this.score })
                }
                singleCorrectAnswers({ uName: this.userName, Question: this.question, uAnswer: this.radioGroupOptionsValue })
                this.radioGroupOptionsValue = '';
                this.callResult = true;
                console.log('score is >> '+ this.score);
            }
            /*if (this.questionList[this.indexValue].Correct_answer__c == this.radioGroupOptionsValue || this.questionList[this.indexValue].Correct_answer__c == this.checkboxOptionsValue) {
                this.score = this.score + 1;
                updateScore({ uName: this.userName, Score: this.score })
                this.callResult = true;
            }*/
            else {
                updateScore({ uName: this.userName, Score: this.score })
                this.callResult = true;
            }
        }
    }
}

