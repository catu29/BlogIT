const SITEURL = $('meta[name="asset-path"]').attr('content');
let helper = {
    showProgress: function () {
        $('body').loadingModal({
            position: 'auto',
            text: 'loading',
            color: '#fff',
            opacity: '0.5',
            backgroundColor: 'rgb(0,0,0)',
            animation: 'circle'
        });
    },
    hideProgress: function () {
        $('body').loadingModal('destroy');
    },
    showPopupNotify: function (type, msg) {
        Lobibox.notify(type, {
            title: true,                
            size: 'mini',
            showClass: 'flipInX',
            hideClass: 'zoomOutDown',
            icon: true,
            msg: msg,
            img: null,
            closable: true,
            delay: 5000,
            delayIndicator: true,
            closeOnClick: true,
            width: 400,
            sound: true,
            position: "top right",
            soundPath: SITEURL + 'vendors/lobibox/sounds/',
            iconSource: 'fontAwesome',
        });
    }
}