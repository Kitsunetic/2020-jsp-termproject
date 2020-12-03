// Logout button
$('#logout-button').on('click', function () {
    window.location.href = './api/logout.jsp'
})

// File choose box
$("#input-file-0").on("change", function () {
    var fileName = $(this).val().split("\\").pop();
    $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
});

// login + signup button
$('#btn-login').on('click', function () {
    window.location.href = './loginForm.jsp'
})
$('#btn-signup').on('click', function () {
    window.location.href = './signUpForm.jsp'
})

// search box
$('#idbox').on('keypress', function (e) {
    if(e.which == 13) {

    }
})