
$(document).ready(function () {
    $('button.reply').click(function () {
       var username = $(this).parent('.comment').find('.username').data('username');
       var usernameHtml = "<i><b>@"+username+"</b></i>";
       $('form.post-reply').find('textarea[name="message"]').html(usernameHtml);
    });
    
    $('form.post-reply').submit(function (e) {
        e.preventDefault();
        var form = $(this);
        var url = form.attr('action');
        var params = form.serialize();
        
        helper.showProgress();
        $.ajax({
            type: 'POST',
            url: url,
            data: params,
            success: function (data) {
                helper.hideProgress();
                if(data == 'succeeded') {
                    form.reset();
                }
            }
        });
    }); 
    
    $('#likePostBtn').click(function () {
        var url = $(this).data('action');
        var isLiked = $(this).data('isLiked');

        helper.showProgress();
        $.ajax({
            type: 'POST',
            url: url,
            data: '',
            success: function (data) {
                helper.hideProgress();
                if (isLiked) {
                    $(this).find('i').removeClass('fas').addClass('far');
                }
                else {
                    $(this).find('i').removeClass('far').addClass('fas');
                }
            }
        });
    });
});

