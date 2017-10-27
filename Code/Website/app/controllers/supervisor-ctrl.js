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
    $scope.display_mode_modal = sharedCtrl.getDisplayMode();
    $('#editModal').modal();
  };

  $scope.updateDocument = function(){
    var id = $scope.doc_id;
    var categorie =  $scope.doc_cat_name;
    var name = $scope.doc_name;
    var pinned = $scope.doc_pinned;
    sharedCtrl.updateDocument(id, categorie, name, pinned)

  }
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

  /***** BATCH ADD WATCH ORDERS MODAL *****/
  $scope.addBatchWatchOrders = function(){
    document.getElementById("parsedWatchOrdersPanel").style.display = "none";
    document.getElementById("successMessage").style.display = "none";
    document.getElementById("failMessage").style.display = "none";
    $scope.display_mode_modal = sharedCtrl.getDisplayMode();
    $scope.parsedWatchOrders = [];
    $('#batchWatchOrdersModal').modal('show');
  };

  /***** PARSE CSV FILE*****/
  $scope.parseCSV = function(){

    if (!$('#files')[0].files.length)
    {
      alert("Please choose a CSV file to parse.");
      return;
    }

    var file = $('#files')[0].files[0];

    if(file.type != "text/csv")
    {
      alert("The file must of type CSV.");
      return;
    }
    Papa.parse(file, {
      complete: function(results) {
        $scope.$apply(function () {
          $scope.parsedWatchOrders = results.data;
        });

        if(results.data.length == 0)
        {
          document.getElementById("parsedUsersPanel").style.display = "none";
          document.getElementById("successMessage").style.display = "none";
          document.getElementById("failMessage").style.display = "none";
          alert("No watch orders could be parsed from CSV file");

          return;
        }

        var message = "Parsed (" + results.data.length + ") watch orders from CSV file";
        document.getElementById("parseTitle").innerHTML = message;

        geoCodeAddresses();

      }
    });
    document.getElementById("parsedWatchOrdersPanel").style.display = "block";
    document.getElementById("successMessage").style.display = "none";
    document.getElementById("failMessage").style.display = "none";
  };

  /***** USE GOOGLE API TO CONVERT WATCH ORDER ADDRESSES TO COORDINATES*****/
  function geoCodeAddresses(){

    var orders = $scope.parsedWatchOrders;
    var geocoder = new google.maps.Geocoder();
    //change search boundary for South Florida
    var southWest = new google.maps.LatLng({lat: 5.395327, lng:  -80.583131});
    var northEast = new google.maps.LatLng({lat: 26.316590, lng: -80.075519});
    var searchBoundary = new google.maps.LatLngBounds(northEast, southWest);

    orders.forEach(function(order){

      //convert address into geo coordinates
      geocoder.geocode({address: order[1], bounds: searchBoundary }, function(results, status) {

        if (status == google.maps.GeocoderStatus.OK) {

          $scope.$apply(function () {
            var index = $scope.parsedWatchOrders.indexOf(order);
            $scope.parsedWatchOrders[index][1] = results[0].formatted_address;   //pick first formatted address returned
            $scope.parsedWatchOrders[index].push(results[0].geometry.viewport.f.b, results[0].geometry.viewport.b.b);   // add lat and long coordinates
          });

        }
        else {
          $scope.$apply(function () {
            var index = $scope.parsedWatchOrders.indexOf(order);
            $scope.parsedWatchOrders[index][1] = "Invalid Address";
          });
        }
      });
    });
  }


  /***** ATTEMPT TO ADD ALL PARSED ORDERS FROM CSV FILE TO DATABASE *****/
  $scope.addParsedWatchOrders = function(){

    var orders = $scope.parsedWatchOrders;
    var success = 0;
    var fail = 0;
    var processed = 0;
    var total = orders.length;



    //delete all watch orders from db before adding new orders
    dataService.removeWatchOrders()
    .then(
      function(data){
        if(data['RemovedAll'] === true){
          orders.forEach(function(order){
            addWatchOrder(order).then(
              function(data){
                if(data == true )
                {
                  $scope.$apply(function () {
                    var index = $scope.parsedWatchOrders.indexOf(order);
                    $scope.parsedWatchOrders.splice(index,1);
                  });
                  success++;
                }
                else {
                  fail++;
                }
                processed++;
                if(processed == total)
                {
                  var successLabel = document.getElementById("successMessage");
                  var failLabel = document.getElementById("failMessage");
                  successLabel.style.display = "none";
                  failLabel.style.display = "none";

                  if(fail == 0){
                    var x = document.getElementById("parsedWatchOrdersPanel");
                    x.style.display = "none";
                    successLabel.innerHTML = success + " orders(s) successfully added";
                    successLabel.style.display = "block";
                  }
                  else {
                    if(success > 0)
                    {
                      successLabel.innerHTML = success + " orders(s) successfully added";
                      successLabel.style.display = "block";

                    }
                    failLabel.innerHTML = fail + " orders(s) could not be added";
                    failLabel.style.display = "block";
                  }

                }
              });
            });
        }
        $scope.getWatchOrders;
      },
      function(error){
        console.log('Error: ' + error);
      });



    };

    /***** ATTEMPT TO ADD A PARSED WATCH ORDER TO THE DATABASE *****/
    self.addWatchOrder = function(order){

      return new Promise(function(resolve, reject) {

        //get values from parsed watch order
        var desc = order[0];
        var address = order[1];

        if(!address || address == "Invalid Address" ){
          resolve(false);
          return;
        }
        var lat = order[2];
        var long = order[3];
        if(lat == 0 || long == 0 ){
          resolve(false);
          return;
        }

        dataService.addWatchOrder(desc, address, lat, long)
        .then(
          function(data){
            if(data['Added'] === true){
              resolve(true);
              console.log("true");
            }
            else{
              resolve(false);
              console.log("fail");
            }
          },
          function(error){
            console.log('Error: ' + error);
          });

        });
      };

      /***********************
     * GET WATCH ORDERS
     ***********************/
      $scope.getWatchOrders = function getWatchOrders(){


          dataService.viewWatchOrders()
            .then(
            function (data) {

              //initialize an empty array to store results from the database
              var watch_orders = [];

              //for each category in the result
              for (var x in data) {

                //create an object and set object properties
                  var tmp = new Object();
                  tmp.Id = data[x].Id;
                  tmp.Desc = data[x].Desc;
                  tmp.Address = data[x].Address;
                  tmp.Lat = data[x].Lat;
                  tmp.Lng = data[x].Lng;
                  tmp.Date = data[x].Date;

                  watch_orders.push(tmp);
              }

              //update for use in view
              $scope.watch_orders = watch_orders;

            },
            function (error) {
              console.log('Error: ' + error);
            });



      };

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
          dataService.resetPassword(id, reset_password)
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
            //rowTemplate: '<div ng-style="{\'cursor\': row.cursor, \'z-index\': col.zIndex() }" class="ngCell {{col.cellClass}}" ng-cell></div>',

            exporterPdfOrientation: 'landscape',
            exporterPdfPageSize: 'LETTER',
            exporterPdfMaxGridWidth: 500,
            exporterCsvLinkElement: angular.element(document.querySelectorAll(".custom-csv-link-location")),
            onRegisterApi: function(gridApi){
              $scope.gridApi = gridApi;
            }

          };

        }]);
