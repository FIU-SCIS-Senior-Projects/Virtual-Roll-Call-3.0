//CONTROLLER for officer app
officerModule.controller('officerCtrl', ['$scope', 'localStorageService', 'dataService', '$controller', '$routeParams',
  function ($scope, localStorageService, dataService, $controller, $routeParams) {

    //TO DO: SAVE AS GLOBALS OR IN SHAREDCTRL
    /***** GLOBALS *****/
    //get name from local storage for user profile customization


    var fname = localStorageService.get('fname');
    var lname = localStorageService.get('lname');
    var id = localStorageService.get('id');
    $scope.login = localStorageService.get('login');
    $scope.name = fname + ' ' + lname;
    $scope.id = id;
    $scope.password_pattern = '^[a-zA-Z0-9]{8,}$';
    $scope.pattern_descr = 'Must contain at least 8 or more characters. Only alphanumeric characters allowed.';
    $scope.background_color = getBackgroundColor(); //getCurrentDisplayMode();
    $scope.text_color = getTextColor();
    $scope.displayMode = "juan";
    getPendingDocuments(id); //$scope.k = getPendingDocuments(id);

    /***** SHARED FUNCTIONS *****/
    var sharedCtrl = $controller('sharedCtrl', { $scope: $scope });
    sharedCtrl.redirect($scope.login);

    $scope.getSiteNames = function () {
      sharedCtrl.getSiteNames();
    };

    $scope.getCategories = function () {
      sharedCtrl.getCategories();
    };

    $scope.logout = function () {
      sharedCtrl.logout();
    }


    /***********************
   * GET ACTIVE DOCUMENTS *
   ***********************/
    $scope.getActiveDocuments = function (user_id) {


          getPendingDocuments(id);



      $scope.selected_cat = $routeParams.selectedCategory;

      dataService.viewDocuments(user_id)
        .then(
        function (data) {
          var cat = $routeParams.selectedCategory;

          //initialize an empty array to store results from the database
          var pinned_documents = [];
          var unpinned_documents = [];

          //add var to count pending documents
          var juan = 0;

          //for each category in the result
          for (var x in data) {
            //create an object and set object properties (i.e. documents data)
            if (cat === data[x].cat_name) {

              var tmp = new Object();
              tmp.name = data[x].name;
              tmp.id = data[x].id;
              tmp.upload_name = data[x].upload_name;
              tmp.doc_description = data[x].doc_description;
              tmp.status = data[x].status;
              tmp.isDone = data[x].status == "Done" ? true : false;
              tmp.doneDisable = data[x].status == "Pending" || data[x].status == "Done" ? true : false;
              if(data[x].status == "Pending"){
                juan = 44;
              }
              if (data[x].pinned == 1) {
                pinned_documents.push(tmp);
              }
              else {
                unpinned_documents.push(tmp);
              }

            }
          }

          //update value in view for use in ng-repeat (to populate)
          $scope.pinned_documents = pinned_documents;
          $scope.unpinned_documents = unpinned_documents;

        //  $scope.pending_count = juan;

        },
        function (error) {
          console.log('Error: ' + error);
        });

    };

    /***********************
   * GET PENDING DOCUMENTS COUNT*
   ***********************/
    function getPendingDocuments (user_id) {

      //$scope.selected_cat = $routeParams.selectedCategory;

      dataService.viewDocuments(user_id)
        .then(
        function (data) {

          //add var to count pending documents
          var archive_files = 0;
          var bolo = 0;
          var internal_memos = 0;

          var dict = {};

          //for each category in the result
          for (var x in data) {
            //create an object and set object properties (i.e. documents data)
            if(data[x].status == "Pending"){
              if(data[x].cat_name in dict){
                dict[data[x].cat_name]++;
              }
              else{
                dict[data[x].cat_name] = 1;
              }

            }

          }

            $scope.pending_count = dict
        },
        function (error) {
          console.log('Error: ' + error);
        });

    };

    /***********************
   * Toggle between day and night mode*
   ***********************/
     $scope.changeDisplayMode = function changeDisplayMode() {
       $scope.displayMode = "lopez";
       //$scope.background_color = "black";
       var nightMode = localStorageService.get('nightMode');
       if(nightMode == true)
       {
         $scope.background_color = "";
         $scope.text_color = "";
         localStorageService.set('nightMode', false);
       }
       //else: daytime set, or not in local storage
       else {
         $scope.background_color = "black";
         $scope.text_color = "white";
         localStorageService.set('nightMode', true);
       }


       $scope.displayMode = localStorageService.get('nightMode');
       $scope.$apply();

     };

     function getBackgroundColor() {
        var nightMode = localStorageService.get('nightMode');
        if(nightMode){
          return "black";
        }
        else {
            return "";
        }
        $scope.$apply();
     };

     function getTextColor(){
       var nightMode = localStorageService.get('nightMode');
       if(nightMode){
         return "white";
       }
       else {
           return "";
       }
       $scope.$apply();
     };


    /***********************
   * GET ARCHIVED DOCUMENTS *
   ***********************/

    $scope.getArchivedDocuments = function (user_id) {

      $scope.selected_cat = $routeParams.selectedCategory;

      dataService.viewArchivedDocuments(user_id)
        .then(
        function (data) {
          var cat = $routeParams.selectedCategory;

          //initialize an empty array to store results from the database
          var unpinned_documents = [];

          //for each category in the result
          for (var x in data) {
            //create an object and set object properties (i.e. documents data)
            if (cat === data[x].cat_name) {

              var tmp = new Object();
              tmp.name = data[x].name;
              tmp.id = data[x].id;
              tmp.upload_name = data[x].upload_name;
              tmp.doc_description = data[x].doc_description;
              tmp.status = data[x].status;
              tmp.isDone = data[x].status == "Done" ? true : false;
              tmp.doneDisable = data[x].status == "Pending" || data[x].status == "Done" ? true : false;

              unpinned_documents.push(tmp); //archive will always be unpinned

            }
          }

          //update value in view for use in ng-repeat (to populate)
          $scope.unpinned_documents = unpinned_documents;

        },
        function (error) {
          console.log('Error: ' + error);
        });

    };

    $scope.document_log = function (user_id, document_id, list_name, status) {
      dataService.documentSaveLog(user_id, document_id);

      if (status == 'Pending'){
        $scope.documentStatusUpdate(user_id, document_id, list_name, status);
        getPendingDocuments(id)
      }




    }

    $scope.documentStatusUpdate = function (user_id, document_id, list_name, status) {
      var updatedDoc;
      dataService.documentStatusUpdate(user_id, document_id, status)
        .then(
        function (data) {
          console.log('Data: Id:' + data.id + ' Status:' + data.status);

          if (list_name == 'pinned')
            $scope.findDocAndUpdate($scope.pinned_documents, data.id, data.status);
          else if (list_name == 'unpinned')
            $scope.findDocAndUpdate($scope.unpinned_documents, data.id, data.status);

        },
        function (error) {
          console.log('Error: ' + error);
        });

    }

    $scope.findDocAndUpdate = function (docs, document_id, status) {
      for (var i in docs) {
        if (docs[i].id == document_id) {
          docs[i].status = status;
          docs[i].doneDisable = status == "Pending" || status == "Done" ? true : false;
          break; //Stop this loop, we found it!
        }
      }
    }

    /***** ALERT FUNCTIONS *****/
    //alert functions (displays accordingly in views)
    $scope.alert = sharedCtrl.alert;

  }]);
