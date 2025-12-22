
class APIConstants {

      static String BASE_URL = "http://ec2-13-201-5-93.ap-south-1.compute.amazonaws.com:8080/biddy/";
    //static String BASE_URL = 'http://ec2-13-201-5-172.ap-south-1.compute.amazonaws.com:8080/biddyold/';
    //static String BASE_URL = 'http://ec2-13-234-204-105.ap-south-1.compute.amazonaws.com:8080/Biddy3/';
      static String GOOGLEAPIKEY ='AIzaSyAZVdypRwWG3MBmQXD12X1KPgt9lZDEKX4';
      static String LOGIN = BASE_URL + 'user/Login/mobileNumber';
      static String SENDOTP = BASE_URL +'api/driver-details/sendOtp/';
      static String VERIFYOTP =BASE_URL + 'api/driver-details/verifyOtpOnMobileNumber2?';
      static String SIGNUP = BASE_URL +'api/driver-details/register';
      static String EDIT_PROFILR=BASE_URL+'api/driver-details/updateDriver/ByPhoneNumber';
      static String CABREGISTER = BASE_URL +'api/saveVehicle';
      static String UPDATECAB = BASE_URL +'api/updateVehicle/';
      static String DELETECAB = BASE_URL +'api/deleteVehicle/';
      static String DELETEBANKDETAILS = BASE_URL +'api/delete/';
      static String DELETEROUTE = BASE_URL +'api/PreferedRoot/delete/';
      static String BOOKCABRIDE = BASE_URL +'ride/bookCabRide';
      static String GETCABCATEGORUIES = BASE_URL +'api/CabCategories/getAll';
      static String CALCULATEDISTANCETIMEPRICE = BASE_URL +'api/calculateDistanceTimePrice?pickupLat=';
      static String GETPENDINGRIDES = BASE_URL +'api/rides/getPendingRidesByDriverId2?driverId=';
      static String GETINFOOFDRIVER = BASE_URL +'api/getVehicleByDriverId/';
      static String DRIVER_VEHICLE = BASE_URL +'api/getVehicleByDriverId/';
      static String ACCEPT_RIDE_DRIVER = BASE_URL +'api/rides/acceptRideFromUser';
      static String STATUS_CHANGE(int id,String status)=> BASE_URL+'ride/get2/{id}?id=$id&requestStatus=${status}';
      static String RIDE_STATUS_CHANGE = BASE_URL + "api/rides/changeStatus";
      static String END_RIDE= BASE_URL+'ride/EndRide/ByRideId/';
      static String ACTIVE_RIDE= BASE_URL+'ride/getActiveRide/ByUserId?usersId=';
      static String ACTIVE_RIDE_DRIVERID= BASE_URL+'api/rides/in-progress/';
      static String ACCEPTED_RIDE_DRIVERID = BASE_URL + "api/rides/getActiveRides/ByDriverId2/";
      static String ALL_RIDE_DRIVERID= BASE_URL+'api/rides/getByDriverId/';
      static String GET_RIDE_BY_ID=BASE_URL+"api/rides/getBy/";
      static String BID_SEND_TO_USER = BASE_URL +'api/bids/save';
      static String UPLOAD_LEAD_IMG=BASE_URL+"upload/samveImage";
      static String UPLOAD_DOC = BASE_URL+"api/driver-documents/save";
      static String ADD_BANK = BASE_URL+"api/save";
      static String ISONLINE = BASE_URL+"api/driver-details/ActiveDeactiveDriver";
      static String ADD_ROUTE = BASE_URL+"api/PreferedRoot/save";
      static String VIEW_ROUTE = BASE_URL+"api/PreferedRoot/getByDriverId/";
      static String DELETE_ROUTE = BASE_URL+"api/PreferedRoot/delete/";
      static String UPDATE_ROUTE = BASE_URL+ "api/PreferedRoot/updateDriverPrefredRoot";
}