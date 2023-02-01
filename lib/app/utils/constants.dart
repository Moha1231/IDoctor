const profilePicture = 'profilePicture';
const checkDoctorDetail = 'checkDoctorDetail';

//maximum price that doctor can add, we put in client for simplicity
//if you want you can do checking using cloud function
const maximumTimeSlotPrice = 100;

//0 mean, the timeslot will be able to get purchase for free
//keep it in mind, client could just buy every free timeslot, right now there's no
//limitation for how much user can buy free timeslot, maybe in the future we wil add that barier
const minimumTimeSlotPrice = 0;

//this doesn't represent the currency, if you wanto change the currency
//please follow the tutorial, this is only for the sign
const currencySign = '\$';
const locale = 'en';
