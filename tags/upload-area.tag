<upload-area>
	<div id="uploadArea">
		<!-- <form action={ uploadFile } enctype="multipart/form-data">
			<input type="text" name="filename"> -->
			<input type="text" name="recipeName" id="recipeName" placeholder="Recipe Name">
			<input type="text" name="author" id="author" placeholder="Author">
			<input type="text" name="desc" id="desc" placeholder="Description">
			<button role="button" type="button" onclick={ submitInfo } value="Submit"><br />
			<!-- <button type="submit">Upload File</button>
		</form> -->
	</div>
	<script>
		// Create a storage reference from our storage service
		var storageRef = storage.ref();
		var dataRef = firebase.database().ref();
		var imgDataRef = dataRef.child("imgDatabase");





		this.uploadFile = function(event) {
			var file = event.srcElement.files[0];
			// Create a child reference
			var imagesRef = storageRef.child('images');
			var filename = file.name;
			var title = document.getElementById("title").value;
			var desc = document.getElementById("desc").value;
			console.log(filename);
			console.log(title);
			console.log(desc);
			var newLocationRef = imagesRef.child(filename);
			console.log(imagesRef);

			var metadata = {
				customMetadata: {
					'title':title,
					'desc':desc,
				},
				contentType: 'image/jpeg',
			};

			var uploadTask = newLocationRef.put(file);

			// Register three observers:
			// 1. 'state_changed' observer, called any time the state changes
			// 2. Error observer, called on failure
			// 3. Completion observer, called on successful completion
			uploadTask.on('state_changed', function(snapshot){
			  // Observe state change events such as progress, pause, and resume
			  // Get task progress, including the number of bytes uploaded and the total number of bytes to be uploaded
			  var progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
			  console.log('Upload is ' + progress + '% done');
			  switch (snapshot.state) {
			    case firebase.storage.TaskState.PAUSED: // or 'paused'
			      console.log('Upload is paused');
			      break;
			    case firebase.storage.TaskState.RUNNING: // or 'running'
			      console.log('Upload is running');
			      break;
			  }
			}, function(error) {
			  // Handle unsuccessful uploads
			  console.log(error);
			}, function() {
			  // Handle successful uploads on complete
			  // For instance, get the download URL: https://firebasestorage.googleapis.com/...
			  var downloadURL = uploadTask.snapshot.downloadURL;
			  console.log(downloadURL);
			  var locRef = imgDataRef.child(title);
			  locRef.push(downloadURL).then(function() {
			   		console.log("Push succeeded.");
			  })
			  .catch(function(error) {
			  		console.log("Push failed: " + error.message);
			  });
			});

		}
	</script>
</upload-area>