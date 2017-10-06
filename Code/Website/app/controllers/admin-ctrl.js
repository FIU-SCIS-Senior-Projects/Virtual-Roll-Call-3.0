//CONTROLLER for admin app
adminModule.directive('mydatepicker', function () {
return {
    restrict: 'A',
    require: 'ngModel',

     link: function ($scope, element, attrs, adminCtrl) {
        element.datepicker({
            dateFormat: 'mm/dd/yy',
            onSelect: function (from) {
                $scope.from = from;
                $scope.$apply();
            }
        });
    },


  };
});
adminModule.directive('mydatepickerto', function () {
return {
    restrict: 'A',
    require: 'ngModel',
     link: function ($scope, element, attrs, adminCtrl) {
        element.datepicker({
            dateFormat: 'mm/dd/yy',
            onSelect: function (to) {
                $scope.to = to;
                $scope.$apply();
            }
        });
    }
  };
});


adminModule.controller('adminCtrl', ['$scope', 'dataService', 'localStorageService', '$window', '$controller', '$location', function($scope, dataService, localStorageService, $window, $controller, $location){

/***** GLOBALS *****/
//get name from local storage for user profile customization
var fname = localStorageService.get('fname');
var lname = localStorageService.get('lname');
$scope.login = localStorageService.get('login');

$scope.name = fname + ' ' + lname;


/***** SHARED FUNCTIONS *****/
var sharedCtrl = $controller('sharedCtrl', {$scope: $scope});
sharedCtrl.redirect($scope.login);

/***** GET SITE NAME *****/
$scope.getSiteNames = function(){
  sharedCtrl.getSiteNames();
};

$scope.deleteArchive = function (){
    dataService.deleteArchive($scope.from,$scope.to)
    .then(function(data){
        $scope.files_deleted = data;
    })
}

$scope.logout = function(){
      sharedCtrl.logout();
  }

/***** GET ALL OFFCIERS *****/
$scope.getOfficers = function(){
  sharedCtrl.getOfficers();
};

/***** GET DOCUMENT CATEGORIES ****/
$scope.getCategories = function(){
  sharedCtrl.getCategories();
};

/***********************
* Toggle between day and night mode*
***********************/
 $scope.changeDisplayMode = function changeDisplayMode() {
   sharedCtrl.changeDisplayMode();
 };

 function getDisplayMode(){
   return sharedCtrl.getDisplayMode();
 };

 $scope.display_mode = getDisplayMode();
 $scope.night_mode = localStorageService.get('nightMode');

//alert functions (displays accordingly in views)
$scope.alert = sharedCtrl.alert;

/***** ADMINISTRATOR FUNCTIONS *****/
/***** APPLY ACTIVE BS CLASS *****/
$scope.isActive = function(path) {
  return $location.path() === path; //TO DO: Pull this function into shared ctrl
};

/***** ADD NEW USER *****/
$scope.addUser = function(){

//get values from input fields
var first_name = $scope.fName;
var last_name = $scope.lName;
var username = $scope.username;
var password = $scope.password;
var role = $scope.role;

dataService.addUser(first_name, last_name, username, password, role)
.then(
  function(data){
    if(data['Added'] === true){
      $scope.alert.closeAll();
      $scope.alert.addAlert('success', 'User successfully added!');
      //clear input fields
      $scope.fName = $scope.lName = $scope.username = $scope.password = $scope.role= '';
      //update edit users table to reflect the addition of new user (TO DO: this can be improved; only get new users instead of all)
      sharedCtrl.getOfficers();
    }
    else{
      $scope.alert.closeAll();
      $scope.alert.addAlert('danger', 'Could not add user!');
    }
  },
  function(error){
    console.log('Error: ' + error);
  });};

  /***** REMOVE USER *****/
  $scope.removeUser = function(){
  //when delete button selected, prompt user for confirmation
  var deleteUser = $window.confirm('Are you sure you want to delete this user?');
  if(deleteUser){
    var id = $scope.updateID;
    dataService.removeUser(id)
    .then(
      function(data){
        if(data['Removed'] === true){
          $scope.alert.closeAll();
          $scope.alert.addAlert('success', 'User successfully deleted!');
          sharedCtrl.getOfficers();
          window.location.reload();
          //$('#editModal').modal('hide');
        }else{
          $scope.alert.closeAll();
          $scope.alert.addAlert('danger', 'Could not delete user!');
          window.location.reload();
          //$('#editModal').modal('hide');
        }
      },
      function(error){
        console.log('Error: ' + error);
      });}};

  /***** EDIT USER MODAL *****/
  $scope.editUser = function(update_id, update_first, update_last, update_username, update_role){
    $scope.updateID = update_id;
    $scope.updateFirst = update_first;
    $scope.updateLast = update_last;
    $scope.updateUsername = update_username;
    $scope.updateRole = update_role;
    $scope.display_mode_modal = sharedCtrl.getDisplayMode();
    $('#editModal').modal();
  };

  /***** EDIT USER DATA *****/
  $scope.updateUser = function(){
  var id = $scope.updateID;
  var first_name = $scope.updateFirst;
  var last_name = $scope.updateLast;
  var username =$scope.updateUsername;
  var role = $scope.updateRole;
  dataService.updateUser(id, first_name, last_name, username, role)
  .then(
    function(data){
      if(data['Updated'] === true){
        $scope.alert.closeAll();
        $scope.alert.addAlert('success', 'User successfully updated!');
        sharedCtrl.getOfficers();
        window.location.reload();
        //$('#editModal').modal('hide');
      }
      else{
        $scope.alert.closeAll();
        $scope.alert.addAlert('danger', 'Could not update user!');
        window.location.reload();
        //$('#editModal').modal('hide');
      }
    },
    function(error){
      console.log('Error: ' + error);
    });};

  /***** ADD NEW CATEGORY *****/
  $scope.addCategory = function(new_cat){
  //get values from input fields
  var category = new_cat;
  dataService.addCategory(category)
  .then(
  function(data){
    //check for successful add and notify user accordingly
    if(data['Added'] === true){
      $scope.alert.closeAll();
      $scope.alert.addAlert('success', 'Category successfully added!');
      sharedCtrl.getCategories();
      //clear input fields
      $scope.new_category = '';
    }
    else{
      //the add was unsucessful
      $scope.alert.closeAll();
      $scope.alert.addAlert('danger', 'Could not add category! The category name may already exist.');;
    }
  },
  function(error){
    console.log('Error: ' + error);
  });};

  /***** EDIT CATEGORY MODAL *****/
  $scope.editCategory = function(update_id, update_name){
    $scope.updateID = update_id;
    $scope.updateName = update_name;
    $scope.display_mode_modal = sharedCtrl.getDisplayMode();
    $('#editModal').modal();
  };

  /***** REMOVE CATEGORY *****/
  $scope.removeCategory = function(){
  //when delete button selected, prompt user for confirmation
  var deleteCategory = $window.confirm('Are you sure you want to delete this category?');
  //if confirmed...
  if(deleteCategory){
    var id = $scope.updateID;
    dataService.removeCategory(id)
    .then(
      function(data){
        if(data['Removed'] === true){
          $scope.alert.closeAll();
          $scope.alert.addAlert('success', 'Category successfully removed!');
          sharedCtrl.getCategories();
          window.location.reload();
          //$('#editModal').modal('hide');
        }else{
          $scope.alert.closeAll();
          $scope.alert.addAlert('danger', 'Could not remove category!');
          window.location.reload();
          //$('#editModal').modal('hide');
        }
      },
      function(error){
        console.log('Error: ' + error);
      });}};

  /***** UPDATE CATEGORY *****/
  $scope.updateCategory = function(){

  var id = $scope.updateID;
  var name = $scope.updateName;
  dataService.updateCategory(id, name)
  .then(
    function(data){
      if(data['Updated'] === true){
        $scope.alert.closeAll();
        $scope.alert.addAlert('success', 'Category successfully updated!');
        $scope.getCategories();
        window.location.reload();
        //$('#editModal').modal('hide');
      }
      else{
        $scope.alert.closeAll();
        $scope.alert.addAlert('danger', 'Could not update category! The category name may already exist.');
        window.location.reload();
        //$('#editModal').modal('hide');
      }
    },
    function(error){
      console.log('Error: ' + error);
    });
  };

  /***** UPDATE APP NAME *****/
  $scope.updateAppName = function(name){
  dataService.updateAppName(name)
  .then(
    function(data){
      if(data['Updated'] === true){
        $scope.alert.closeAll();
        $scope.alert.addAlert('success', 'Application name successfully updated!');
        $scope.application_name = '';
      }
      else{
        $scope.alert.closeAll();
        $scope.alert.addAlert('danger', 'Could not update application name!');
      }
    },
    function(error){
      console.log('Error: ' + error);
    });
  };

  /***** UPDATE DEPT NAME *****/
  $scope.updateDeptName = function(name){
  dataService.updateDeptName(name)
  .then(
    function(data){
      if(data['Updated'] === true){
        $scope.alert.closeAll();
        $scope.alert.addAlert('success', 'Department name successfully updated!');
        $scope.department_name = '';
      }
      else{
        $scope.alert.closeAll();
        $scope.alert.addAlert('danger', 'Could not update department name!');
      }
    },
    function(error){
      console.log('Error: ' + error);
    });
  };

}]);
