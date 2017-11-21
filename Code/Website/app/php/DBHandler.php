<?php
require_once('encryption.php');
//TO DO: Notify admin when a username already exists in the db

class DBHandler{
	//Must be updated to match production environment
	function __construct(){
		global $db_connection;
		global $crypter;

		$un = 'root';
		$pw = 'root';
		$dbName = 'VIRTUAL_ROLL_CALL';
		$address = 'localhost';
		$db_connection = new mysqli($address, $un, $pw, $dbName);
		$crypter = new JCrypter();

		if ($db_connection->connect_errno > 0) {
			die('Unable to connect to database[' . $db_connection->connect_error . ']');
		}
	}

	function GetStatusDescription($statusId){
		global $db_connection;
		$result = [];
		$statusDescription = 'Not Defined';

		$sql = "SELECT Description FROM DOCUMENT_STATUS WHERE Id=?";
		$stmt = $db_connection->prepare($sql);

		if(!$stmt->bind_param('i',$statusId)){
			return result;
		}
		if ($stmt->execute()){
			$stmt->bind_result($statusDescription);
			while($stmt->fetch()){
				$statusDescription = $statusDescription;
			};
			$stmt->close();
		}

		return $statusDescription;
	}

	function GetStatusArray(){
		global $db_connection;
		$result = [];

		$sql = "SELECT Id, Description FROM DOCUMENT_STATUS ORDER BY Id";
		$stmt = $db_connection->prepare($sql);

		if ($stmt->execute()){
			$stmt->bind_result($id,$statusDescription);
			array_push($result, "Not Defined");
			while($stmt->fetch()){
					array_push($result, $statusDescription);
			}
			$stmt->close();
		}

		return $result;
	}

	//ADD NEW WATCH ORDER TO DATABASE
	function addWatchOrder($desc, $address, $lat, $long, $addDate, $expDate) {
		global $db_connection;

		$result = ['Added' => false];
		$sql = "INSERT INTO WATCH_ORDERS (`Desc`,`Address`,`Lat`,`Lng`,`AddDate`,`ExpDate`) VALUES (?,?,?,?,?,?)";
		$stmt = $db_connection->prepare($sql);
		if (!$stmt->bind_param('ssddss', $desc, $address, $lat, $long, $addDate, $expDate))
			echo "Binding parameters failed: (" . $stmt->errno . ") " . $stmt->error;
		if (!$stmt->execute())
		{
			return $result;
		}


			$result['Added'] = true;
		$stmt->close();
		$db_connection->close();
		return $result;
	}

	function removeWatchOrders() {
		global $db_connection;

		$result = ['RemovedAll' => false];
		$sql = "DELETE FROM WATCH_ORDERS";
		$stmt = $db_connection->prepare($sql);
		if (!$stmt->execute())
		{
			return $result;
		}

		$result['RemovedAll'] = true;
		$stmt->close();
		$db_connection->close();
		return $result;
	}

	function removeWatchOrder($id) {
		global $db_connection;
		$result = ["Removed" => false];
		$table = "WATCH_ORDERS";
		$sql = "DELETE FROM $table
		        WHERE `Id`=?";
		$stmt = $db_connection->prepare($sql);
		if( !$stmt->bind_param('d', $id) )
		{
			return $result;
		}
		if (!$stmt->execute())
		{
			return $result;
		}
		$result["Removed"] = true;
		$stmt->close();
		$db_connection->close();
		return $result;
	}

	function getWatchOrders() {
		global $db_connection;

		$orders = [];
		$sql = "SELECT `Id`,`Desc`,`Address`,`Lat`,`Lng`,`AddDate`,`ExpDate` FROM WATCH_ORDERS";
		$stmt = $db_connection->prepare($sql);
		$stmt->execute();
		$stmt->bind_result($Id, $Desc, $Address, $Lat, $Lng, $AddDate, $ExpDate);
		while($stmt->fetch()){
			$tmp = ["Id" => $Id,
			"Desc" => $Desc,
			"Address" => $Address,
			"Lat" => $Lat,
			"Lng" => $Lng,
			"AddDate" => $AddDate,
			"ExpDate" => $ExpDate];

			array_push($orders, $tmp);
		}

		$stmt->close();
		$db_connection->close();
		return $orders;
	}

	function editWatchOrder($id, $desc, $address, $lat, $lng, $expDate) {
		global $db_connection;
		$result = ["Updated" => false];
		$table = "WATCH_ORDERS";
		$sql = "UPDATE $table SET `Desc`=?, `Address`=?, `Lat`=?, `Lng`=?, `ExpDate`=? WHERE `Id`=?";
		$stmt = $db_connection->prepare($sql);
		if( !$stmt->bind_param('sssssd', $desc, $address, $lat, $lng, $expDate, $id) )
		{
			return $result;
		}
		if (!$stmt->execute())
		{
			return $result;
		}
		$result["Updated"] = true;
		$stmt->close();
		$db_connection->close();
		return $result;
	}







  //ADD NEW USER TO DATABASE
	function addUser($first_name, $last_name, $username, $password, $role) {
		global $db_connection;
		global $crypter;
		$hash_password = $crypter->hash($password);

		$result = ['Added' => false,'Username' => $username, 'Password' => $hash_password];
		$sql = "INSERT INTO OFFICERS (First_Name, Last_Name, Username, Password, Role) VALUES (?,?,?,?,?)";
		$stmt = $db_connection->prepare($sql);
		if (!$stmt->bind_param('sssss', $first_name, $last_name, $username, $hash_password, $role))
			echo "Binding parameters failed: (" . $stmt->errno . ") " . $stmt->error;
		if (!$stmt->execute())
			return $result;

    	$result['Added'] = true;
		$stmt->close();
		$db_connection->close();
		return $result;
	}

  // RETRIEVE USER
  function getUser($username){
    global $db_connection;
    $result = ['userID' => NULL, 'First_Name' => NULL, 'Last_Name' => NULL, 'Username' => NULL, 'Role' => NULL];
    $sql = 'SELECT userID, First_Name, Last_Name, Username, Role FROM OFFICERS WHERE Username=?';
    $stmt = $db_connection->prepare($sql);
    $stmt->bind_param('s', $username);
    $stmt->execute();
    $stmt->bind_result($result['userID'], $result['First_Name'], $result['Last_Name'], $result['Username'], $result['Role']);
    if (!$stmt->fetch()){
      return $result;
    }
    $stmt->close();
    $db_connection->close();
    return $result;
  }

	function editUser($id, $first_name, $last_name, $username, $role) {
		global $db_connection;
		$result = ["Updated" => false];
		$table = "OFFICERS";
		$sql = "UPDATE $table SET First_Name=?, Last_Name=?, Username=?, Role=?
		        WHERE userID=?";
		$stmt = $db_connection->prepare($sql);
		if( !$stmt->bind_param('ssssd', $first_name, $last_name, $username, $role, $id) )
		{
			return $result;
		}
		if (!$stmt->execute())
		{
			return $result;
		}
		$result["Updated"] = true;
		$stmt->close();
		$db_connection->close();
		return $result;
	}

	function removeUser($id) {
		global $db_connection;
		$result = ["Removed" => false];
		$table = "OFFICERS";
		$sql = "DELETE FROM $table
		        WHERE userID=?";
		$stmt = $db_connection->prepare($sql);
		if( !$stmt->bind_param('d', $id) )
		{
			return $result;
		}
		if (!$stmt->execute())
		{
			return $result;
		}
		$result["Removed"] = true;
		$stmt->close();
		$db_connection->close();
		return $result;
	}

	function loginUser($username, $password){
		global $db_connection;
		global $crypter;

        //store the result here
		$result = ['userID' => NULL,
				   'First_Name' => NULL, 'Last_Name' => NULL,
				   'Username' => NULL, 'Password' => NULL, 'Role' => NULL,
				   'Lock_Count' => NULL];
		$failed = $result;

		$sql = 'SELECT userID, First_Name, Last_Name, Username, Password, Role, lock_count
				FROM OFFICERS o
				LEFT JOIN LOGIN_LOGS l ON o.userID = l.log_id
				WHERE lower(Username) = lower(?) AND Active = 1';
		$stmt = $db_connection->prepare($sql);
		$stmt->bind_param('s', $username);
		$stmt->execute();
		$stmt->bind_result(	$result['userID'],
							$result['First_Name'], $result['Last_Name'],
						   	$result['Username'], $result['Password'],
						   	$result['Role'], $result['Lock_Count'] );

		if (!$stmt->fetch()) return $failed;
		if ( !$crypter->verify($password, $result['Password'])) return $failed;

		$stmt->close();
		$db_connection->close();
		return $result;
	}

	function changePassword($id, $curr_pw, $new_pw){
		global $db_connection;
		global $crypter;
		$hash_new_pw = $crypter->hash($new_pw);

		$result = ['userID' => NULL, 'Updated' => NULL];

		$stmt = $db_connection->prepare('UPDATE OFFICERS SET Password=? WHERE UserID=?');
		$stmt->bind_param('sd', $hash_new_pw, $id);
		$stmt->execute();
		if ($stmt->affected_rows === 1)
			$result['Updated'] = true;

		$stmt->close();
		$db_connection->close();
		return $result;
	}

	function getTally( $username ) {
		global $db_connection;
		$result = ['userid' => 0, 'count' => 0, 'locked' => 0, 'created' => NULL];

		$query = "SELECT userID, lock_count, lock_status, l.created_at
				  FROM OFFICERS O LEFT JOIN LOGIN_LOGS L ON O.userID = L.log_id
				  WHERE lower(O.username) = lower(?) ";

		$stmt = $db_connection->prepare($query);
	    $stmt->bind_param('s', $username);
	    $stmt->execute();
	    $stmt->bind_result( $result['userid'],
	    					$result['count'],
	    					$result['locked'],
	    					$result['created'] );

	    if (!$stmt->fetch()) return $result;
		$stmt->close();
		$db_connection->close();
		return $result;
	}

	function updateFailedLog( $lock_found, $log_id, $lock_count )
	{
		global $db_connection;
		$result = ['status' => ''];
		$lockStatus = 0;

		if ( $lock_found )
		{
			$query =  'UPDATE login_logs SET lock_count = ?, updated_at = now() ';
			if ( $lock_count == 1)
				$query .= ', created_at = now() ';
			$query .= 'WHERE log_id = ? ';
			$stmt = $db_connection->prepare($query);
			if ( !$stmt->bind_param('ii', $lock_count, $log_id ) )
				$result["status"] = "Query failed at biding. ";
		}
		else
		{
			$stmt = $db_connection
					->prepare('INSERT INTO login_logs (log_id, created_at, lock_count, lock_status )
							   VALUES (?,now(),?,?) ');
			if ( !$stmt->bind_param('iii', $log_id, $lock_count, $lockStatus) )
				$result["status"] = "Query failed at biding. ";
			else
				$result["status"] = "Failed Attempt Recorded.";
		}

		if (!$stmt->execute()) return $result;
		$stmt->close();
		$db_connection->close();

		return $result;
	}

	function lockUser( $id )
	{
		global $db_connection;
		$result = ['status' => ''];
		$query = "UPDATE login_logs SET lock_status = 1 WHERE log_id = ?";
		$stmt = $db_connection->prepare($query);
		if( !$stmt->bind_param('i', $id) ) return $result;
		if (!$stmt->execute())  return $result;

		$query = 'UPDATE officers SET Active = 0 WHERE userID = ?';
		$stmt = $db_connection->prepare($query);
		if( !$stmt->bind_param('i', $id) ) return $result;
		if (!$stmt->execute())  return $result;

		$result['status'] = 'Your account has been locked!';
		$stmt->close();
		$db_connection->close();
		return $result;
	}

	function resetLock ( $id )
	{
		global $db_connection;
		$result = ['reset' => false];
		$logCount = 0;
		$stmt = $db_connection->
			prepare('UPDATE LOGIN_LOGS SET lock_count=?, created_at=now() WHERE log_id=?');
		if(!$stmt->bind_param('ii', $logCount, $id)) return $result;
		if(!$stmt->execute()) return $result;
		$result['reset'] = true;
		$stmt->close();
		$db_connection->close();
		return $result;
	}

	function getOfficers(){
		global $db_connection;
		$officers = [];
		$sql = 'SELECT userID, First_Name, Last_Name, Username, Role FROM OFFICERS';
		$stmt = $db_connection->prepare($sql);
		$stmt->execute();
		$stmt->bind_result($userID, $First_Name, $Last_Name, $Username, $Role);
		while($stmt->fetch()){
			$tmp = ["id" => $userID,
			"firstName" => $First_Name,
			"lastName" => $Last_Name,
			"username" => $Username,
			"role" => $Role];
			array_push($officers, $tmp);
		}
		$stmt->close();
		$db_connection->close();
		return $officers;
	}

	function GetDocumentStatusByUser($user_id)
	{
		$status = 0;

		if($user_id == ''){
			$status = 'NULL AS Status';
		}
		else
		{
			$status =
			'(
                SELECT DOCUMENT_STATUS.Description AS Status
                FROM DOCUMENT_STATUS
                WHERE DOCUMENT_STATUS.Id =
                (
                    SELECT StatusId
                    FROM USER_DOC_STATUS
                    WHERE DOCUMENTS.document_ID = USER_DOC_STATUS.DocumentId
                    AND USER_DOC_STATUS.OfficerId = '.$user_id.'
                )

            )
			AS Status';
		}

		return $status;
	}

	//GET ALL MESSAGES FROM THE DATABASE
	function getMessages()
	{
		global $db_connection;
		$messages = [];
		$query = 'SELECT MessageId, OfficerId, Title, Message, Created_at, Updated_by, Updated_at FROM Messages';
		$stmt = $db_connection->prepare($query);
		$stmt->execute();
		$stmt->bind_result($message_id, $officer_id, $title, $message, $created_at, $updated_by, $updated_at);
		while($stmt->fetch()){
			$tmp = ["id" => $message_id,
					"officer_id" => $officer_id,
					"title" => $title,
					"message" => $message,
					"createdAt" => $created_at,
					"updatedBy" => $updated_by,
					"updatedAt" => $updated_at];
			array_push($messages, $tmp);
		}
		$stmt->close();
		$db_connection->close();
		return $messages;
	}

	//GET ALL DOCUMENTS FROM THE DATABASE
	function getDocuments($type, $user_id){

		$statusArray = $this->GetStatusArray();
		$status = $this->GetDocumentStatusByUser($user_id);

		global $db_connection;
		$documents = [];
		$sql = 'SELECT
				DOCUMENTS.document_ID,
				DOCUMENTS.Document_Name,
				DOCUMENTS.Category_ID,
				DOCUMENTS.Upload_Date,
				DOCUMENTS.Pinned,
				DOCUMENTS.Uploaded_By,
				CATEGORIES.category_name,
				DOCUMENTS.Upload_Name,
				DOCUMENTS.Description,
					IF(
					((DOCUMENTS.Upload_Date < (DATE(NOW()) - INTERVAL 7 DAY) AND DOCUMENTS.Pinned = false) OR DOCUMENTS.Manual_Archived = true),
					\'Yes\',
					\'No\'
				) AS Archived,
				'.$status.'
				FROM DOCUMENTS
				INNER JOIN CATEGORIES ON DOCUMENTS.Category_ID = CATEGORIES.Category_ID
				';

		if ($type == 'archived')
		{
		 	$sql .= ' WHERE ((DOCUMENTS.Upload_Date < (DATE(NOW()) - INTERVAL 7 DAY) AND DOCUMENTS.Pinned = false) OR DOCUMENTS.Manual_Archived = true)';
		}
		else if ($type == 'active')
		{
			$sql .= ' WHERE ((DOCUMENTS.Upload_Date >= (DATE(NOW()) - INTERVAL 7 DAY) OR DOCUMENTS.Pinned = true) AND DOCUMENTS.Manual_Archived = false)';
		}

		$stmt = $db_connection->prepare($sql);
		$stmt->execute();
		$stmt->bind_result($id, $name, $catID, $date, $pinned, $uploadedBy, $cat_name, $upload_name, $doc_description, $archived, $status);
		while($stmt->fetch()){
			$tmp = ["id" => $id,
			"name" => $name,
			"cat_name" => $cat_name,
			"date" => $date,
			"pinned" => $pinned,
			"uploadedBy" => $uploadedBy,
			"upload_name" => $upload_name,
			"doc_description" => $doc_description,
			"archived" => $archived,
			"status" => $status == NULL ? $statusArray[1] : $status]
			;
			array_push($documents, $tmp);
		}
		$stmt->close();
		$db_connection->close();
		return $documents;
	}

        function getlogs(){

				$statusArray = $this->GetStatusArray();

                global $db_connection;
                $logs = [];
                $sql = 'SELECT
						OFFICERS.First_Name,
						OFFICERS.Last_Name,
						DOCUMENTS.Document_Name,
						LOGS.DOC,
						DOCUMENTS.Upload_Date AS Uploaded,
						USER_DOC_STATUS.StartDateTime AS Started,
						USER_DOC_STATUS.EndDateTime AS Completed,
						CONCAT(TRUNCATE((TIMESTAMPDIFF(SECOND, USER_DOC_STATUS.startdatetime, USER_DOC_STATUS.enddatetime)), 2), \' Sec\') AS Duration,
						USER_DOC_STATUS.StatusId
						FROM DOCUMENTS
						LEFT JOIN LOGS ON LOGS.documentid = DOCUMENTS.document_ID
						LEFT JOIN OFFICERS ON LOGS.userid = OFFICERS.userID
						LEFT JOIN USER_DOC_STATUS ON DOCUMENTS.document_ID = USER_DOC_STATUS.DocumentId AND OFFICERS.userID = USER_DOC_STATUS.OfficerId
						LEFT JOIN DOCUMENT_STATUS ON USER_DOC_STATUS.StatusId = DOCUMENT_STATUS.Id
						ORDER BY DOCUMENTS.Upload_Date DESC
						';

                $stmt = $db_connection->prepare($sql);
                $stmt->execute();
                $stmt->bind_result(
					$First_Name, $Last_Name, $Document_Name, $DOC,
					$Uploaded, $Started, $Completed, $Duration, $Status
					);
                while($stmt->fetch()){


                        $tmp = [
							"Full_Name" => $First_Name.' '.$Last_Name,
							"Document_Name" => $Document_Name,
							"DOC" => $DOC,
							"Uploaded" => $Uploaded,
							"Started" => $Started,
							"Completed" => $Completed,
							"Duration" => $Duration < 0 ? '0.00 Sec' : $Duration,
							"Status" => $Status == NULL ? $statusArray[1] : $statusArray[(int)$Status]
						];
                        array_push($logs, $tmp);
                }
                $stmt->close();
                $db_connection->close();
                return $logs;
        }

	//TODO: UPLOAD DATE COME WITH 1 DAY MORE THAN THE ACTUAL DATE
	//ADD DOCUMENT METADATA  TO THE DATABASE
	function addDocument($document, $category, $upload_date, $pinned, $uploaded_by, $upload_name, $upload_description){
		global $db_connection;
		$result = ['Added' => false];
		$archived = 0;
		$sql = 'INSERT INTO
						DOCUMENTS (Document_Name, Category_ID, Upload_Date, Pinned, Uploaded_By, Upload_Name, Description, Manual_Archived)
						VALUES 	  (?,?,?,?,?,?,?,?)';
		$stmt = $db_connection->prepare($sql);

		if (!$stmt->bind_param('sdsdsssi', $document, $category, $upload_date, $pinned, $uploaded_by, $upload_name, $upload_description, $archived))
			echo "Binding parameters failed: (" . $stmt->errno . ") " . $stmt->error;
		if (!$stmt->execute())
			return "Execute Statement failed: (" . $stmt->errno . ") " . $stmt->error;//return $result;

		$result['Added'] = true;
		$stmt->close();
		$db_connection->close();
		return $result;
	}

	function uploadMessage($title, $new_msg, $uploaded_by) {
		global $db_connection;
		$result = ['Added' => false];
		$query = 'INSERT INTO Messages (Title, Message, OfficerId) VALUES(?,?,?)';
		$stmt = $db_connection->prepare($query);

		if( !$stmt->bind_param('ssi', $title, $new_msg, $uploaded_by) )
			$result['Added'] = "Unable to add message";
		if (!$stmt->execute())
			return $result;
		$result['Added'] = true;
		$stmt->close();
		return $result;
	}

    //GET ALL CATEGORIES FROM THE DATABASE
	function getCategories(){
		global $db_connection;
		$categories = [];
		$sql = 'SELECT category_ID, Category_Name FROM CATEGORIES';
		$stmt = $db_connection->prepare($sql);
		$stmt->execute();
		$stmt->bind_result($id, $name);
		while($stmt->fetch()){
			$tmp = ["id" => $id,
			"name" => $name];
			array_push($categories, $tmp);
		}
		$stmt->close();
		$db_connection->close();
		return $categories;
	}

	//ADD NEW CATEGORY TO DATABASE
	function addCategory($name) {
		global $db_connection;
		$result = ['Added' => false,'name' => $name];
		$sql = "INSERT INTO CATEGORIES (Category_Name) VALUES (?)";
		$stmt = $db_connection->prepare($sql);
		if (!$stmt->bind_param('s', $name)){
			echo "Binding parameters failed: (" . $stmt->errno . ") " . $stmt->error;
		}
		if (!$stmt->execute()){
			return $result;
		}
        $result['Added'] = true;
		$stmt->close();
		$db_connection->close();
		return $result;
	}

	//REMOVE CATEGORY FROM THE DATABASE
	function removeCategory($cat_id) {
		global $db_connection;
		$result = ["Removed" => false];
		$table = "CATEGORIES";
		$sql = "DELETE FROM $table
		        WHERE category_ID=?";
		$stmt = $db_connection->prepare($sql);
		if( !$stmt->bind_param('d', $cat_id) )
		{
			return $result;
		}
		if (!$stmt->execute())
		{
			return $result;
		}
		$result["Removed"] = true;
		$stmt->close();
		$db_connection->close();
		return $result;
	}

    //UPDATE CATEGORY IN THE DATABASE
	function updateCategory($cat_id, $cat_name) {
		global $db_connection;
		$result = ["Updated" => false];
		$sql = "UPDATE CATEGORIES SET Category_Name=? WHERE category_ID=?";
		$stmt = $db_connection->prepare($sql);
		if( !$stmt->bind_param('sd', $cat_name, $cat_id)){
			return $result;
		}
		if (!$stmt->execute()){
			return $result;
		}
		$result["Updated"] = true;
		$stmt->close();
		$db_connection->close();
		return $result;
	}

    //RESET OFFICER PASSWORD IN THE DATABASE
	function resetPassword($id, $reset_pw){
		global $db_connection;
		global $crypter;

		$hash_reset = $crypter->hash($reset_pw);
		$result = ['userID' => $id, 'Updated' => false];
		$active = 1;

		//Update the Officers Relation
		$stmt = $db_connection->prepare('UPDATE OFFICERS SET Password=?, Active=? WHERE UserID=?');
		if(!$stmt->bind_param('sid', $hash_reset, $active, $id)) return $result;
		if(!$stmt->execute()) return $result;

		//Update the Login_logs Relation
		$logCount = 0; $lockStatus = 0;
		$stmt = $db_connection->prepare('UPDATE LOGIN_LOGS SET lock_count=?, lock_status=? WHERE log_id=?');
		if(!$stmt->bind_param('iii', $logCount, $lockStatus, $id)) return $result;
		if(!$stmt->execute()) return $result;

		$result["Updated"] = true;
		$stmt->close();
		$db_connection->close();
		return $result;
	}

	//GET ALL CATEGORIES FROM THE DATABASE
	function getSiteNames(){
		global $db_connection;
		$result = [];
		$sql = 'SELECT Application_Name, Department_Name FROM SETTINGS';
		$stmt = $db_connection->prepare($sql);
		$stmt->execute();
		$stmt->bind_result($app_name, $dept_name);
		while($stmt->fetch()){
			$result = ["app_name" => $app_name, "dept_name" => $dept_name];
		}
		$stmt->close();
		$db_connection->close();
		return $result;
	}

	//UPDATE CATEGORY IN THE DATABASE
	function updateAppName($app_name) {
		global $db_connection;
		$result = ["Updated" => false];
		$sql = "UPDATE SETTINGS SET Application_Name=?";
		$stmt = $db_connection->prepare($sql);
		if( !$stmt->bind_param('s', $app_name)){
			return $result;
		}
		if (!$stmt->execute()){
			return $result;
		}
		$result["Updated"] = true;
		$stmt->close();
		$db_connection->close();
		return $result;
	}

	//UPDATE CATEGORY IN THE DATABASE
	function updateDeptName($dept_name) {
		global $db_connection;
		$result = ["Updated" => false];
		$sql = "UPDATE SETTINGS SET Department_Name=?";
		$stmt = $db_connection->prepare($sql);
		if( !$stmt->bind_param('s', $dept_name)){
			return $result;
		}
		if (!$stmt->execute()){
			return $result;
		}
		$result["Updated"] = true;
		$stmt->close();
		$db_connection->close();
		return $result;
	}

	function documentSaveLog($user_id,$document_id){
		global $db_connection;
		$sql = "insert into LOGS (DOC,documentid,userid) values(now(),?,?) ";
		$stmt = $db_connection->prepare($sql);
		$stmt->bind_param('ii',$document_id,$user_id);
		$stmt->execute();

	}

	function updateDocument($id,$name,$categories,$pinned){
			global $db_connection;
			$sql = "Update DOCUMENTS set Document_Name=?,Category_ID=?,Pinned=? where document_ID =?";
			$rs = $db_connection->prepare($sql);
			if(!$rs->bind_param('siii',$name,$categories,$pinned,$id))
					return "Bind paramenter error";

			if(!$rs->execute()){
					return "Execute Error";
			}
			$rs->close();
			$db_connection->close();
			return true;
	}

        function deleteArchive($from,$to){
                global $db_connection;
                $officers = [];
                $from = date("Y-m-d",  strtotime($from));
                $to = date("Y-m-d",  strtotime($to));

                $sql = "select Document_name,Uploaded_By,Upload_Name from DOCUMENTS WHERE (Upload_Date BETWEEN ? AND ?) and pinned = 0";
                $rs = $db_connection->prepare($sql);
                if(!$rs->bind_param('ss',$from,$to))
                        return "Bind paramenter error";

                $rs->execute();
                $rs->bind_result($Document_name, $Uploaded_By,$upload_Name);
                while($rs->fetch()){

                    unlink("uploads/".$upload_Name);
                    $tmp = ["name" => $Document_name,
                        "uploaded" => $Uploaded_By,
                        "file" => $upload_Name];
                    array_push($officers, $tmp);
                }
                $sql = "SET SQL_SAFE_UPDATES = 0;";
                $rs = $db_connection->prepare($sql);
                $rs->execute();

                $sql = "delete from DOCUMENTS WHERE (Upload_Date BETWEEN ? AND ?) and pinned = 0";
                $rs = $db_connection->prepare($sql);
                if(!$rs->bind_param('ss',$from,$to))
                        return "Bind paramenter error";

                $rs->execute();

                $rs->close();
                $db_connection->close();
                return $officers;

        }

	//UPDATE DOCUMENT STATUS
	function documentStatusUpdate($user_id,$document_id,$new_status){

		global $db_connection;
		$insert = true;
		$result = [];

		$new_status_id;
		if ( $new_status != 'Done' )
			$new_status_id = $new_status == 'Pending' ?  2 : 3;

		$sqlselect = "SELECT Id FROM USER_DOC_STATUS WHERE DocumentId=? AND OfficerId=?";
		$stmselect = $db_connection->prepare($sqlselect);
		$stmselect->bind_param('ii',$document_id,$user_id);
		$stmselect->execute();

		$stmselect->bind_result($id);
		while($stmselect->fetch()){
			$insert = false;
		}

		//document is read by first time, status will be set to reviewed and start date time will be set as well
		if($insert){
			$sql = "INSERT INTO USER_DOC_STATUS (StartDateTime, EndDateTime, DocumentId,OfficerId,StatusId)
						   values(now(),now(),?,?,?) ";
			$stmt = $db_connection->prepare($sql);
			$stmt->bind_param('iii',$document_id,$user_id,$new_status_id);

			if (!$stmt->execute()){
				return "Error creating entry on USER_DOC_STATUS";
			}
			else{
				$result = [
					"id" => $document_id,
					"status" => $this->GetStatusDescription(2),//status reviewed
					];
				$stmt->close();
				$db_connection->close();
				return $result;
			}
		}
		else{//document has been mark as done, status will be change to done and end date time will be set as well
			//$EndDateTime = getdate();
			$sql = 'UPDATE USER_DOC_STATUS SET StatusId=?,EndDateTime=now() WHERE DocumentId=? AND OfficerId=?';
			$stmt = $db_connection->prepare($sql);
			if(!$stmt->bind_param('iii',$new_status_id,$document_id,$user_id)){
				return result;
			}
			if(!$stmt->execute()){
				return result;
			}
			else{

				//$stmt->close();

				$sql = 'SELECT
				USER_DOC_STATUS.DocumentId,
				DOCUMENT_STATUS.Description
				FROM USER_DOC_STATUS
				LEFT JOIN DOCUMENT_STATUS ON USER_DOC_STATUS.StatusId = DOCUMENT_STATUS.Id
				WHERE DocumentId=? AND OfficerId=?
				';
				$stmtSelect = $db_connection->prepare($sql);
				$stmtSelect->bind_param('ii',$document_id,$user_id);
				if (!$stmtSelect->execute()){
					return "Error updating entry on USER_DOC_STATUS";
				}
				else{
					$stmtSelect->bind_result($document_id, $new_status_id);
					while($stmtSelect->fetch()){
						$result = [
							"id" => $document_id,
							"status" => $new_status_id
							];
					}
					$stmtSelect->close();

					$this->documentSaveLog($user_id,$document_id);

					$db_connection->close();
					return $result;
				}
			}

		}
		return $result;
	}
}
