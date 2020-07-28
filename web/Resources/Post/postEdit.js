
$(document).ready(function () {
    var contextPath = $('meta[name="asset-path"]').attr('content');

    var contentCKEditor = CKEDITOR.replace('content');


    $('#addNewSeriesModal').find('form').submit(function (e) {
        e.preventDefault();

        var url = $(this).attr('action');
        var params = $(this).serialize();
        helper.showProgress();

        $.ajax({
            type: "POST",
            url: url,
            data: params,
            success: function (data)
            {
                helper.hideProgress();
                $('#addNewSeriesModal').modal('hide');
                $('#addNewSeriesModal').find('form').find('[name="seriesName"]').val('');
                
                if (data) {
                    helper.showPopupNotify('success', 'Thêm series thành công');
                    
                    $('[name="series"]').empty();
                    var newOption = new Option('Select an option...', '', false, false);
                    $('[name="series"]').append(newOption).trigger('change');
                    
                    data.forEach(function (series) {
                        newOption = new Option(series.seriesName, series.seriesId, false, false);
                        $('[name="series"]').append(newOption).trigger('change');
                    });
                }
                else {
                    helper.showPopupNotify('error', 'Đã có lỗi xảy ra vui lòng thử lại sau');
                }
            },
            error: function (error) {
                helper.hideProgress();
                $('#addNewSeriesModal').find('form').find('[name="seriesName"]').val('');
                $('#addNewSeriesModal').modal('hide');
            }
        });
    });

    var upload = new FileUploadWithPreview('myUniqueUploadId', {
        showDeleteButtonOnImages: true,
        text: {
            chooseFile: 'Choose file ...',
            browse: 'Browse',
        },
        images: {
            baseImage: contextPath + 'placeholder-image.png',
        },
    })
});