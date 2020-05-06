$(document).ready(function() {
	if ($("#alertSuccess").text().trim() == "") {
		$("#alertSuccess").hide();
	}
	$("#alertError").hide();
});
// SAVE ============================================
$(document).on("click", "#btnSave", function(event) {
	// Clear alerts---------------------
	$("#alertSuccess").text("");
	$("#alertSuccess").hide();
	$("#alertError").text("");
	$("#alertError").hide();

	// Form validation-------------------
	var status = validateHForm();
	if (status != true) {
		$("#alertError").text(status);
		$("#alertError").show();
		return;
	}
	// If valid------------------------
	var type = ($("#hidItemIDSave").val() == "") ? "POST" : "PUT";

	$.ajax({
		url : "HospitalAPI",
		type : type,
		data : $("#formHospital").serialize(),
		dataType : "text",
		complete : function(response, status) {
			onItemSaveComplete(response.responseText, status);
		}
	});
});

//UPDATE==========================================
function onItemSaveComplete(response, status) {
	if (status == "success") {
		var resultSet = JSON.parse(response);
		if (resultSet.status.trim() == "success") {
			$("#alertSuccess").text("Successfully saved.");
			$("#alertSuccess").show();
			$("#divItemsGrid").html(resultSet.data);
		} else if (resultSet.status.trim() == "error") {
			$("#alertError").text(resultSet.data);
			$("#alertError").show();
		}
	} else if (status == "error") {
		$("#alertError").text("Error while saving.");
		$("#alertError").show();
	} else {
		$("#alertError").text("Unknown error while saving..");
		$("#alertError").show();
	}
	$("#hidItemIDSave").val("");
	$("#formHospital")[0].reset();
}

$(document).on("click", ".btnRemove", function(event) {
	$.ajax({
		url : "HospitalAPI",
		type : "DELETE",
		data : "Hospital_ID=" + $(this).data("hosid"),
		dataType : "text",
		complete : function(response, status) {
			onItemDeleteComplete(response.responseText, status);
		}
	});
});

//DELETE==========================================
function onItemDeleteComplete(response, status) {
	if (status == "success") {
		var resultSet = JSON.parse(response);
		if (resultSet.status.trim() == "success") {
			$("#alertSuccess").text("Successfully deleted.");
			$("#alertSuccess").show();
			$("#divItemsGrid").html(resultSet.data);
		} else if (resultSet.status.trim() == "error") {
			$("#alertError").text(resultSet.data);
			$("#alertError").show();
		}
	} else if (status == "error") {
		$("#alertError").text("Error while deleting.");
		$("#alertError").show();
	} else {
		$("#alertError").text("Unknown error while deleting..");
		$("#alertError").show();
	}
}

// UPDATE==========================================
$(document).on(
		"click",
		".btnUpdate",
		function(event) {
			$("#hidItemIDSave").val(
			$(this).closest("tr").find('#hidItemIDUpdate').val());
			
			$("#HospitalName").val($(this).closest("tr").find('td:eq(1)').text());
			$("#Email").val($(this).closest("tr").find('td:eq(2)').text());
			$("#Address").val($(this).closest("tr").find('td:eq(3)').text());
			$("#PhoneNumber").val($(this).closest("tr").find('td:eq(4)').text());
			$("#Reg_Number").val($(this).closest("tr").find('td:eq(5)').text());
		});

// CLIENTMODEL=========================================================================
function validateHForm() {
	// name
	if ($("#HospitalName").val().trim() == "") {
		return "Insert Hospital Name.";
	}
	// email
	if ($("#Email").val().trim() == "") {
		return "Insert Hospital Email.";
	}
	// address-------------------------------
	if ($("#Address").val().trim() == "") {
		return "Insert Hospital Address.";
	}
	// pNO-------------------------------
	if ($("#PhoneNumber").val().trim() == "") {
		return "Insert Hospital Phone number.";
	}
	
	var tmpPhoneNo = $("#PhoneNumber").val().trim();
	if (!$.isNumeric(tmpPhoneNo)) {
		return "Insert a numerical value for phone number.";
	}
	// Reg NO-------------------------------
	if ($("#Reg_Number").val().trim() == "") {
		return "Insert Hospital Register number.";
	}

	return true;
}
