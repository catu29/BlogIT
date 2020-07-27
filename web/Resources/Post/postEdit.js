
$(document).ready(function () {
    CKEDITOR.replace('content');

    $('#addNewSeriesModal').find(form).submit(function (e) {
        e.preventDefault();

        var url = $(this).attr('action');
        var params = $(this).serialize();

        $.ajax({
            type: "POST",
            url: url,
            data: params,
            success: function (data)
            {
                alert(data); // show response from the php script.
            },
            error: function (error) {
                console.log(error);
            }
        });
    });
});