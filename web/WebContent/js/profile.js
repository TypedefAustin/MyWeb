        // 文档高度
        function getDocumentTop() {
            var scrollTop = 0, bodyScrollTop = 0, documentScrollTop = 0;
            if (document.body) {
                bodyScrollTop = document.body.scrollTop;
            }
            if (document.documentElement) {
                documentScrollTop = document.documentElement.scrollTop;
            }
            scrollTop = (bodyScrollTop - documentScrollTop > 0) ? bodyScrollTop : documentScrollTop;
            return scrollTop;
        }

        //可视窗口高度
        function getWindowHeight() {
            var windowHeight = 0;
            if (document.compatMode == "CSS1Compat") {
                windowHeight = document.documentElement.clientHeight;
            } else {
                windowHeight = document.body.clientHeight;
            }
            return windowHeight;
        }

        //滚动条滚动高度
        function getScrollHeight() {
            var scrollHeight = 0, bodyScrollHeight = 0, documentScrollHeight = 0;
            if (document.body) {
                bodyScrollHeight = document.body.scrollHeight;
            }

            if (document.documentElement) {
                documentScrollHeight = document.documentElement.scrollHeight;
            }
            scrollHeight = (bodyScrollHeight - documentScrollHeight > 0) ? bodyScrollHeight : documentScrollHeight;
            return scrollHeight;
        }


        /*
        当滚动条滑动，触发事件，判断是否到达最底部
        然后调用ajax处理函数异步加载数据
        */
        window.onscroll = function () {
            //监听事件内容
            if (getScrollHeight() == getWindowHeight() + getDocumentTop()) {
                loadDOM();
                loadDOM();
                loadDOM();
            }
        }
		//加载图片
		function loadpic() {
            let filebut = document.getElementById("filess");
            filebut.click();
		//寻找帖子
        }
        function searchpost() {
            let filebut = document.getElementById("spost");
            filebut.click();
        }
		//字符串转换结点
		 function createNode(str) {
            let tempNode = document.createElement('div');
            tempNode.innerHTML = str;
            return tempNode.firstChild;
        }
		//删除评论标签
		function removeTags() {
            var tagElements = document.getElementsByTagName("form");
            for (var m = 0; m < tagElements.length; m++) {
                if (tagElements[m].className == "comment-form inline-items") {
                    tagElements[m].parentNode.removeChild(tagElements[m]);
                }
            }
        }
		//切换首页背景
		function RidoChoose() {
            let radios = document.getElementsByName("optionsRadios");
            for (let i = 3; i < radios.length; i++) {
                if (radios[i].checked) {
                    $('.top-header-thumb img').attr('src', radios[i].value);
                    break;

                }
            }
        };
        function loadDOM() {
            $('<div class="ui-block">\n' +
                '\t\t\t\t\t<!-- Post -->\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t<article class="hentry post has-post-thumbnail shared-photo">\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t<div class="post__author author vcard inline-items">\n' +
                '\t\t\t\t\t\t\t\t<img src="img/author-page.jpg" alt="author">\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t\t<div class="author-date">\n' +
                '\t\t\t\t\t\t\t\t\t<a class="h6 post__author-name fn" href="02-ProfilePage.html">NULL</a> 分享了\n' +
                '\t\t\t\t\t\t\t\t\t<a href="#">NULL</a>’s <a href="#">NULL</a>\n' +
                '\t\t\t\t\t\t\t\t\t<div class="post__date">\n' +
                '\t\t\t\t\t\t\t\t\t\t<time class="published" datetime="2017-03-24T18:18">\n' +
                '\t\t\t\t\t\t\t\t\t\t\t7 hours ago\n' +
                '\t\t\t\t\t\t\t\t\t\t</time>\n' +
                '\t\t\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t\t<div class="more">\n' +
                '\t\t\t\t\t\t\t\t\t<svg class="olymp-three-dots-icon">\n' +
                '\t\t\t\t\t\t\t\t\t\t<use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>\n' +
                '\t\t\t\t\t\t\t\t\t</svg>\n' +
                '\t\t\t\t\t\t\t\t\t<ul class="more-dropdown">\n' +
                '\t\t\t\t\t\t\t\t\t\t<li>\n' +
                '<a href="javascript:void(0)" onclick="Ajax01(\'06\',this)">删除</a>\n'+
                '\t\t\t\t\t\t\t\t\t\t</li>\n' +
                '\t\t\t\t\t\t\t\t\t</ul>\n' +
                '\t\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t<p>这是瀑布流刷新测试~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</p>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t<div class="post-thumb">\n' +
                '\t\t\t\t\t\t\t\t<img src="img/post-photo6.jpg" alt="photo">\n' +
                '\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t<ul class="children single-children">\n' +
                '\t\t\t\t\t\t\t\t<li class="comment-item">\n' +
                '\t\t\t\t\t\t\t\t\t<div class="post__author author vcard inline-items">\n' +
                '\t\t\t\t\t\t\t\t\t\t<img src="img/avatar8-sm.jpg" alt="author">\n' +
                '\t\t\t\t\t\t\t\t\t\t<div class="author-date">\n' +
                '\t\t\t\t\t\t\t\t\t\t\t<a class="h6 post__author-name fn" href="#">NULL</a>\n' +
                '\t\t\t\t\t\t\t\t\t\t\t<div class="post__date">\n' +
                '\t\t\t\t\t\t\t\t\t\t\t\t<time class="published" datetime="2017-03-24T18:18">\n' +
                '\t\t\t\t\t\t\t\t\t\t\t\t\t16 hours ago\n' +
                '\t\t\t\t\t\t\t\t\t\t\t\t</time>\n' +
                '\t\t\t\t\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t\t\t<p>评论测试</p>\n' +
                '\t\t\t\t\t\t\t\t</li>\n' +
                '\t\t\t\t\t\t\t</ul>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t<div class="post-additional-info inline-items">\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t\t<a href="#" class="post-add-icon inline-items">\n' +
                '\t\t\t\t\t\t\t\t\t<svg class="olymp-heart-icon">\n' +
                '\t\t\t\t\t\t\t\t\t\t<use xlink:href="svg-icons/sprites/icons.svg#olymp-heart-icon"></use>\n' +
                '\t\t\t\t\t\t\t\t\t</svg>\n' +
                '\t\t\t\t\t\t\t\t\t<span>15</span>\n' +
                '\t\t\t\t\t\t\t\t</a>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t\t<ul class="friends-harmonic">\n' +
                '\t\t\t\t\t\t\t\t\t<li>\n' +
                '\t\t\t\t\t\t\t\t\t\t<a href="#">\n' +
                '\t\t\t\t\t\t\t\t\t\t\t<img src="img/friend-harmonic5.jpg" alt="friend">\n' +
                '\t\t\t\t\t\t\t\t\t\t</a>\n' +
                '\t\t\t\t\t\t\t\t\t</li>\n' +
                '\t\t\t\t\t\t\t\t\t<li>\n' +
                '\t\t\t\t\t\t\t\t\t\t<a href="#">\n' +
                '\t\t\t\t\t\t\t\t\t\t\t<img src="img/friend-harmonic10.jpg" alt="friend">\n' +
                '\t\t\t\t\t\t\t\t\t\t</a>\n' +
                '\t\t\t\t\t\t\t\t\t</li>\n' +
                '\t\t\t\t\t\t\t\t\t<li>\n' +
                '\t\t\t\t\t\t\t\t\t\t<a href="#">\n' +
                '\t\t\t\t\t\t\t\t\t\t\t<img src="img/friend-harmonic7.jpg" alt="friend">\n' +
                '\t\t\t\t\t\t\t\t\t\t</a>\n' +
                '\t\t\t\t\t\t\t\t\t</li>\n' +
                '\t\t\t\t\t\t\t\t\t<li>\n' +
                '\t\t\t\t\t\t\t\t\t\t<a href="#">\n' +
                '\t\t\t\t\t\t\t\t\t\t\t<img src="img/friend-harmonic8.jpg" alt="friend">\n' +
                '\t\t\t\t\t\t\t\t\t\t</a>\n' +
                '\t\t\t\t\t\t\t\t\t</li>\n' +
                '\t\t\t\t\t\t\t\t\t<li>\n' +
                '\t\t\t\t\t\t\t\t\t\t<a href="#">\n' +
                '\t\t\t\t\t\t\t\t\t\t\t<img src="img/friend-harmonic2.jpg" alt="friend">\n' +
                '\t\t\t\t\t\t\t\t\t\t</a>\n' +
                '\t\t\t\t\t\t\t\t\t</li>\n' +
                '\t\t\t\t\t\t\t\t</ul>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t\t<div class="names-people-likes">\n' +
                '\t\t\t\t\t\t\t\t\t<a href="#">NULL</a>, <a href="#">NULL</a> and\n' +
                '\t\t\t\t\t\t\t\t\t<br>13+点赞了\n' +
                '\t\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t\t<div class="comments-shared">\n' +
                '\t\t\t\t\t\t\t\t\t<a href="javascript:void(0)" onclick="aclick(this)" class="post-add-icon inline-items">\n' +
                '\t\t\t\t\t\t\t\t\t\t<svg class="olymp-speech-balloon-icon">\n' +
                '\t\t\t\t\t\t\t\t\t\t\t<use xlink:href="svg-icons/sprites/icons.svg#olymp-speech-balloon-icon"></use>\n' +
                '\t\t\t\t\t\t\t\t\t\t</svg>\n' +
                '\t\t\t\t\t\t\t\t\t\t<span>0</span>\n' +
                '\t\t\t\t\t\t\t\t\t</a>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t\t\t<a href="#" class="post-add-icon inline-items">\n' +
                '\t\t\t\t\t\t\t\t\t\t<svg class="olymp-share-icon">\n' +
                '\t\t\t\t\t\t\t\t\t\t\t<use xlink:href="svg-icons/sprites/icons.svg#olymp-share-icon"></use>\n' +
                '\t\t\t\t\t\t\t\t\t\t</svg>\n' +
                '\t\t\t\t\t\t\t\t\t\t<span>16</span>\n' +
                '\t\t\t\t\t\t\t\t\t</a>\n' +
                '\t\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t<div class="control-block-button post-control-button">\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t\t<a href="#" class="btn btn-control">\n' +
                '\t\t\t\t\t\t\t\t\t<svg class="olymp-like-post-icon">\n' +
                '\t\t\t\t\t\t\t\t\t\t<use xlink:href="svg-icons/sprites/icons.svg#olymp-like-post-icon"></use>\n' +
                '\t\t\t\t\t\t\t\t\t</svg>\n' +
                '\t\t\t\t\t\t\t\t</a>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t\t<a href="#" class="btn btn-control">\n' +
                '\t\t\t\t\t\t\t\t\t<svg class="olymp-comments-post-icon">\n' +
                '\t\t\t\t\t\t\t\t\t\t<use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>\n' +
                '\t\t\t\t\t\t\t\t\t</svg>\n' +
                '\t\t\t\t\t\t\t\t</a>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t\t<a href="#" class="btn btn-control">\n' +
                '\t\t\t\t\t\t\t\t\t<svg class="olymp-share-icon">\n' +
                '\t\t\t\t\t\t\t\t\t\t<use xlink:href="svg-icons/sprites/icons.svg#olymp-share-icon"></use>\n' +
                '\t\t\t\t\t\t\t\t\t</svg>\n' +
                '\t\t\t\t\t\t\t\t</a>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t</article>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t<!-- .. end Post -->\t\t\t\t</div>').appendTo("#newsfeed-items-grid");

        };
        //添加评论
        function aclick(temp) {
            let html2 = '<form class="comment-form inline-items">\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t<div class="post__author author vcard inline-items">\n' +
                '\t\t\t\t\t\t\t<img src="img/author-page.jpg" alt="author">\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t\t<div class="form-group with-icon-right ">\n' +
                '\t\t\t\t\t\t\t\t<textarea class="form-control" id="commentajax" placeholder=""></textarea>\n' +
                '\t\t\t\t\t\t\t\t<div class="add-options-message">\n' +
                '\t\t\t\t\t\t\t\t\t<a href="#" class="options-message" data-toggle="modal" data-target="#update-header-photo">\n' +
                '\t\t\t\t\t\t\t\t\t\t<svg class="olymp-camera-icon">\n' +
                '\t\t\t\t\t\t\t\t\t\t\t<use xlink:href="svg-icons/sprites/icons.svg#olymp-camera-icon"></use>\n' +
                '\t\t\t\t\t\t\t\t\t\t</svg>\n' +
                '\t\t\t\t\t\t\t\t\t</a>\n' +
                '\t\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\t</div>\n' +
                '\t\t\t\t\t\n' +
                '<button type="button" class="btn btn-md-2 btn-primary" onclick="Ajax01(\'01\',this)">Post Comment</button>' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t\t<button class="btn btn-md-2 btn-border-think c-grey btn-transparent custom-color" onclick="removeTags()" >Cancel</button>\n' +
                '\t\t\t\t\t\n' +
                '\t\t\t\t\t</form>';
            let ft = temp.parentNode.parentNode.parentNode.parentNode;//隐藏div元素

            let empform = ft.getElementsByTagName("form");
            removeTags();
            ft.getElementsByTagName("article")[0].appendChild(createNode(html2));
        };
		
		