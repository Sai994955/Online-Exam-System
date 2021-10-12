import { LightningElement,api,wire,track} from 'lwc';
import centLogo from '@salesforce/resourceUrl/centelonLogo';
export default class Result extends LightningElement {
		LogoUrl = centLogo;
    @api result;
}