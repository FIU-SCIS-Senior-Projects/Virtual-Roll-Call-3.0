//CONTROLLER for login
loginModule.controller('loginCtrl', ['$scope', 'localStorageService', 'dataService', '$window', '$controller', function($scope, localStorageService, dataService, $window, $controller) {

  /***** SHARED FUNCTIONS *****/
  var sharedCtrl = $controller('sharedCtrl', {$scope: $scope});

  /***** ALERT FUNCTIONS *****/
  //alert functions (displays accordingly in views)
  $scope.alert = sharedCtrl.alert;
  $scope.login_count = Array();
  $scope.login_count.push(0);

  $scope.getSiteNames = function(){
    sharedCtrl.getSiteNames();
  };

  //when login button is clicked...
  $scope.login = function(){

      //get values from the login input fields
      var username = $scope.username;
      var password = $scope.password;

      var count = $scope.login_count[$scope.login_count.length-1];
      //authenticate user
      dataService.login(username, password)
      .then(
          //http post request succeeded
          function(data){
             //if username/password found in the database
             if(data['Username'] && data['Password']){

               //saved user id and name to local storage
               localStorageService.set('id', data['userID']);
               localStorageService.set('fname', data['First_Name']);
               localStorageService.set('lname', data['Last_Name']);
               localStorageService.set('night-mode', false);

               //route to home page according to role
               if(data['Role'] === 'Administrator'){
                $window.location.href = 'admin-profile.html';
                localStorageService.set('login','administrator');
               }else if (data['Role'] === 'Supervisor'){
                $window.location.href = 'supervisor-profile.html';
                localStorageService.set('login','supervisor');
               }else{
                $window.location.href = 'officer-profile.html';
                localStorageService.set('login','officer');
               }
             }else{
                //invalid credentials...notify user
                count = count +1;
                 $scope.login_count.push(count);
                $scope.alert.closeAll();
                $scope.alert.addAlert('danger', "Invalid credentials. Please try again. " + username + $scope.login_count[$scope.login_count.length-1]);
              }
            },
          //http post request failed
          function(error){
            console.log('Error: ' + error);
          });
  };

  $scope.logout = function (){
      sharedCtrl.logout();
  };

}]);
