$(document).on('turbolinks:load',function(){
    var jscrollOption = {
        autoTrigger: true, // 自動で読み込むか否か、trueで自動、falseでボタンクリックとなる。
        padding: 20, // 指定したコンテンツの下かた何pxで読み込むかを指定(autoTrigger: trueの場合のみ)
        nextSelector: 'span.next a',
        contentSelector: '.jscroll' // 読み込む範囲の指定
    };
    $('.jscroll').jscroll(jscrollOption);
});