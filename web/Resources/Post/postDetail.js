
$(document).ready(function () {
    $('button.reply').click(function () {
        var username = $(this).parent('.comment').find('.username').data('username');
        var usernameHtml = "<i><b>@" + username + "</b></i>";
        $('form.post-reply').find('textarea[name="message"]').html(usernameHtml);
    });

    $('form.post-reply').submit(function (e) {
        e.preventDefault();

        var today = new Date($.now());
        var date = (today.getDate() < 10 ? '0' : '') + today.getDate() + '/' + (today.getMonth() + 1 < 10 ? '0' : '') + (today.getMonth() + 1) + '/' + today.getFullYear();
        var time = (today.getHours() < 10 ? '0' : '') + today.getHours() + ":" + (today.getMinutes() < 10 ? '0' : '') + today.getMinutes() + ":" + (today.getSeconds() < 10 ? '0' : '') + today.getSeconds();
        var dateTime = time + ' ' + date;

        var form = $(this);
        var url = form.attr('action');
        var params = form.serialize();
        var parentId = form.data('parentid');
        var userUrl = form.data('userurl');
        var userFullName = form.data('userfullname');
        var userAvtUrl = form.data('useravturl');
        var postId = $(this).find('[name="postId"]').val();


        helper.showProgress();

        $.ajax({
            type: 'POST',
            url: url,
            data: params,
            success: function (data) {

                helper.hideProgress();

                $('body').loadingModal('hide');
                $(form)[0].reset();
                if (data == 'succeeded') {
                    var formStr = '';
                    if (parentId == 0) {
                        var returnCmtId = '';
                        formStr = '<div class="collapse" id="formReplyTo_"' + returnCmtId + '><form class="post-reply" action="' + url + '" method="POST" data-parentid="' + returnCmtId + '" data-userurl="' + userUrl + '" data-userfullname="' + userFullName + '" data-useravturl="' + userAvtUrl + '"><div class="row"><div class="col-md-12"><input name="postId" value="' + postId + '" type="hidden"><input name="parentId" value="'+returnCmtId+'" type="hidden"><div class="form-group"><textarea class="input" name="message" placeholder="Nhập bình luận" required="true"></textarea></div></div><div class="col-md-12"><button class="primary-button">Gửi</button></div></div></form></div>';
                    }

                    var commentStr = '<div class="media media-author"><div class="media-left"><a href="' + userUrl + '"><img class="media-object" src="' + userAvtUrl + '" alt=""></a></div><div class="media-body"><div class="comment"><div class="media-heading"><h4><a href="' + userUrl + '" class="username" data-username="' + userFullName + '">' + userFullName + '</a></h4><span class="time">' + dateTime + '</span></div><p>' + $(this).find('[name="message"]').val() + '</p><a data-toggle="collapse" href="#formReplyTo_' + returnCmtId + '" role="button" aria-expanded="false" aria-controls="formReplyTo_' + returnCmtId + '">Trả lời</a></div>' + formStr + '</div></div>';

                    $(commentStr).append(formStr);
                    $('#comments_of_' + parentId).append(commentStr);


                }
            },
            error: function (error) {
                helper.hideProgress();
                $(form)[0].reset();
            }
        });
    });

    $('#likePostBtn').click(function () {
        var url = $(this).data('action');
        var isLiked = $('#likePostBtn').data('isliked');

        $.ajax({
            type: 'GET',
            url: url,
            success: function (data) {

                if (isLiked) {
                    console.log(isLiked);
                    $('#likePostBtn').find('i').removeClass('fas').addClass('far');
                    $('#likePostBtn').data('isliked', false);
                } else {
                    $('#likePostBtn').find('i').removeClass('far').addClass('fas');
                    $('#likePostBtn').data('isliked', true);
                }
            },
            error: function (error) {
                console.log(error);
            }
        });
    });
});

