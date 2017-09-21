//CONTROLLER for supervisor app
supervisorModule.controller('supervisorCtrl', ['$scope', 'localStorageService', 'dataService', '$controller', '$location', function($scope, localStorageService, dataService, $controller, $location){
  
  //TO DO: SAVE AS GLOBALS OR IN SHAREDCTRL
  /***** GLOBALS *****/
  //get name from local storage for user profile customization
  var fname = localStorageService.get('fname');
  var lname = localStorageService.get('lname');
  $scope.login = localStorageService.get('login');
  $scope.name = fname + ' ' + lname;
  $scope.password_pattern = '^[a-zA-Z0-9]{8,}$';
  $scope.pattern_descr = 'Must contain at least 8 or more characters. Only alphanumeric characters allowed.';

  /***** SHARED FUNCTIONS *****/
  var sharedCtrl = $controller('sharedCtrl', {$scope: $scope});
  sharedCtrl.redirect($scope.login);
  $scope.getSiteNames = function(){
    sharedCtrl.getSiteNames();
  };

  $scope.getOfficers = function(){
    sharedCtrl.getOfficers();
  };
  
  $scope.logout = function(){
      sharedCtrl.logout();
  }

  $scope.getCategories = function(){
    sharedCtrl.getCategories();
  }

  $scope.getDocuments = function(){
    sharedCtrl.getDocuments();
  }
  $scope.getlogs = function(){
  	sharedCtrl.getlogs();
  }
  
   $scope.refresh = function(){
       setTimeout(function(){ window.location.reload(); }, 3000);
  }
  
  $scope.editDocument = function(id,name,pinned,category){
 
  $scope.categories.forEach(function(element){
    if(element.name == category)
	category = element;
  });
 
  if(pinned == 1 )
      pinned = true;
  else
      pinned = false;
  
    $scope.doc_id = id; 
    $scope.doc_name = name;
    $scope.doc_cat_name = category;
    $scope.doc_pinned = pinned; 
    $('#editModal').modal();
  };
  
  $scope.updateDocument = function(){
  	var id = $scope.doc_id;
     	var categorie =  $scope.doc_cat_name;
     	var name = $scope.doc_name;
	var pinned = $scope.doc_pinned;
     sharedCtrl.updateDocument(id, categorie, name, pinned)
 
} 
  /***** ALERT FUNCTIONS *****/
  //alert functions (displays accordingly in views)
  $scope.alert = sharedCtrl.alert;

  /***** SUPERVISOR FUNCTIONS *****/

  /***** APPLY ACTIVE BS CLASS *****/
  $scope.isActive = function(path) {
    return $location.path() === path; //TO DO: Pull this function into shared ctrl
  };

  /***** GET SELECTED USER DATA *****/
  //TO DO: ENCAPSULATE THIS FUNCTIONALITY & UPDATE VIEW
  $scope.selected = {};

  $scope.select= function(index){
    $scope.pick = index;
  };

  //TO DO: Clear input fields if another row is selected
  
  //helper for ng-class
  $scope.is_selected = function(index){
    if($scope.pick === index){
      return true;
    }else{
      return false;
    }
  }
  
  //resets selection when value in search bar is entered 
  $scope.$watch('search', function() {
     $scope.selected = {};
     $scope.pick = null;
  });

  /***** RESET USER PASSWORD *****/
  $scope.resetPassword = function(reset_password, reset_password_conf){

  //get the id of the selected user 
  var id = $scope.selected.id;

  //new password and confirmation must match
  if(reset_password !== reset_password_conf){
    $scope.alert.closeAll();
    $scope.alert.addAlert('danger', "The new passwords don\'t match!");
    this.reset_pass = this.reset_pass_conf = '';
  }else{
    this.reset_pass = this.reset_pass_conf = '';
  //call reset password function in data service
  dataService.resetPassword(id, reset_password, reset_password_conf)
    .then(
      function(data){
      if(data['Updated'] === true){
        $scope.alert.closeAll();
        $scope.alert.addAlert('success', 'Officer password was successfully updated!');
      }
    },
      function(error){
        console.log('Error: ' + error);
      });
  }};

  /***** SORT TABLE HEADERS *****/
  $scope.sortTable = function(order){
    $scope.orderBy = order; 
  };

  // Listen event to set grid data after it is ready, event is triggered on sharedCtrl.getlogs()
  $scope.$on('logs-data-ready', function(event, data) {
    $scope.gridOptions.data = data;
  });

  $scope.gridOptions = {
    enableFiltering: true,
    columnDefs: [
      { field: 'Full_Name', displayName: 'Officer Name'},
      { field: 'Document_Name'},
      { field: 'DOC', displayName: 'Log Date'},
      { field: 'Uploaded', displayName: 'Uploaded Date'},
      { field: 'Started', displayName: 'Started'},
      { field: 'Completed', displayName: 'Completed'},
      { field: 'Duration', displayName: 'Duration'},
      { field: 'Status', displayName: 'Status'}
    ],
    enableGridMenu: true,
    enableSelectAll: true,
    exporterCsvFilename: 'Logs.csv',
    exporterPdfDefaultStyle: {fontSize: 9},
    exporterPdfTableStyle: {margin: [30, 30, 30, 30]},
    exporterPdfTableHeaderStyle: {fontSize: 10, bold: true, italics: true, color: 'red'},
    exporterPdfHeader: { text: "Logs Report", style: 'headerStyle' },
    exporterPdfFooter: function ( currentPage, pageCount ) {
      return { text: currentPage.toString() + ' of ' + pageCount.toString(), style: 'footerStyle' };
    },
    exporterPdfCustomFormatter: function ( docDefinition ) {
      docDefinition.styles.headerStyle = { fontSize: 22, bold: true };
      docDefinition.styles.footerStyle = { fontSize: 10, bold: true };
      return docDefinition;
    },
    exporterPdfOrientation: 'landscape',
    exporterPdfPageSize: 'LETTER',
    exporterPdfMaxGridWidth: 500,
    exporterCsvLinkElement: angular.element(document.querySelectorAll(".custom-csv-link-location")),
    onRegisterApi: function(gridApi){
      $scope.gridApi = gridApi;
    }
  };

}]);
