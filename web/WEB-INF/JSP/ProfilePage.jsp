<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="WebPest.Databases.*" %>
<%@ page import="WebPest.getTodayWeather" %>
<%
    if (session.getAttribute("IsLogin") == null) {
        request.getRequestDispatcher("/WebContent/do#svolet").forward(request, response);
    }
%>
<%
    infomationBaseDAO inf1 = new infomationBaseDAO();
    ArrayList web_inf = inf1.WebInf((String) session.getAttribute("IsLogin"));
    ArrayList stu_inf = inf1.StuInf((String) web_inf.get(0));
    searchAccountDAO User = new searchAccountDAO();
    User.searchUID((String) web_inf.get(2));
    getTodayWeather wea = new getTodayWeather();
    wea.Init();
    String week = wea.week;
    session.setAttribute("Account",web_inf.get(2));
%>
<!DOCTYPE html>
<html lang="en">
<head>

    <title>Profile Page</title>

    <!-- Required meta tags always come first -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <!-- Main Font -->
    <script src="js/libs/webfontloader.min.js"></script>
    <script src="js/profile.js"></script>
    <script>
        WebFont.load({
            google: {
                families: ['Roboto:300,400,500,700:latin']
            }
        });


        function Ajax01(opr, docs) {
            var hmlHttp = new XMLHttpRequest();
            hmlHttp.onreadystatechange = function () {
                if (hmlHttp.readyState == 4 && hmlHttp.status == 200) {
                    if (opr == "00")//更新帖子
                    {
                        let res = hmlHttp.responseText;
                        $(res).prependTo("#newsfeed-items-grid");
                    }
                    if (opr == "05")//更新课表
                    {
                        let res = hmlHttp.responseText;
                        $(res).appendTo("#cTable");
                    }
                    if (opr == '01')//评论
                    {
                        let postf = docs.parentNode.parentNode;
                        let res = hmlHttp.responseText;
                        let comnote = postf.getElementsByClassName("comments-list")[0];
                        if (comnote != null) {
                            comnote.appendChild(createNode(res));
                        } else {
                            let sig = postf.getElementsByClassName("control-block-button post-control-button")[0];
                            $(sig).after('<ul class="comments-list"></ul>');
                            comnote = postf.getElementsByClassName("comments-list")[0];
                            comnote.appendChild(createNode(res));
                        }
                        removeTags();
                    }
                    if (opr == '04')//more
                    {
                        let postf = docs.parentNode;
                        let res = hmlHttp.responseText;
                        let comnote = postf.getElementsByClassName("comments-list")[0];
                        $(comnote).append(res);
                        comnote = postf.getElementsByClassName("more-comments")[0];
                        postf.removeChild(comnote);
                    }
                    if (opr == '06')
                    {
                        let fat = docs.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
                        let node = docs.parentNode.parentNode.parentNode.parentNode.parentNode;
                        fat.removeChild(node);
                    }
                    if (opr == '07')
                    {
                        let res = hmlHttp.responseText;
                        $("#userstate").val(res);
                        $("#topstate").val(res);
                        document.getElementById("topstate1").innerHTML=res;
                        alert("修改成功");
                    }
                }
            };
            hmlHttp.open("post", "/Web/WebContent/Ajax01.do", true);
            hmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
            if (opr == "00")//更新帖子
            {
                hmlHttp.send("opr=" + opr);

            }
            ;
            if (opr == "05")//天气
            {
                hmlHttp.send("opr=" + opr);
            };
            if (opr == "01") {
                let comment = $("#commentajax").val();
                let postf = docs.parentNode.parentNode;
                let node = postf.getElementsByClassName("Tid")[0];
                let PostTid = (node.innerHTML);
                let rUid = "<%=(String) web_inf.get(5)%>";
                let email = "<%=(String) web_inf.get(2)%>";
                hmlHttp.send("opr=" + opr + "&text=" + comment + "&Tid=" + PostTid + "&Uid=" + rUid + "&email=" + email);
            }
            if (opr == "03") {
                let comment = $("#Postajax").val();//发表
                let formData = new FormData();
                let files = $('#filess')[0].files[0];
                let email = "<%=User.RUEmail()%>";
                formData.append("email", email);
                formData.append("text", comment);
                formData.append("File", files);
                $.ajax({
                    url: "/Web/WebContent/Ajax01.do",
                    type: 'POST',
                    data: formData,
                    dataType: 'json',
                    processData: false,
                    contentType: false,
                    async:false,
                });
                window.location.href="/Web/WebContent/Skip?key=00";
            }
            if (opr == "04") {
                let postf = docs.parentNode.parentNode;
                let node = postf.getElementsByClassName("Tid")[0];
                let PostTid = (node.innerHTML);
                hmlHttp.send("opr=" + opr + "&Tid=" + PostTid);
            }
            if (opr == '06')
            {
                if(window.confirm('你确定要提交吗？提交后将无法更改！')){
                    let postf = docs.parentNode.parentNode.parentNode.parentNode.parentNode;
                    let node = postf.getElementsByClassName("Tid")[0];
                    let node1 =postf.getElementsByClassName("post__author author vcard inline-items")[0];
                    node1=node1.getElementsByClassName("author-date")[0];
                    node1=node1.getElementsByClassName("h6 post__author-name fn")[0];
                    if(node1.innerHTML !="<%=(String) web_inf.get(1)%>")
                    {
                        alert("不是本人,删除失败");
                        return
                    }
                    let PostTid = (node.innerHTML);
                    hmlHttp.send("opr=" + opr + "&Tid=" + PostTid);
                }else{
                    return;
                }
            }
            if (opr == "07") {
                let state = $("#userstate").val();
                let email = "<%=User.RUEmail()%>";
                hmlHttp.send("opr=" + opr + "&state=" + state+"&email=" + email);
            }
        }

        window.onload = Ajax01('00', null);
        window.onload = Ajax01('05', null);


    </script>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="Bootstrap/dist/css/bootstrap-reboot.css">
    <link rel="stylesheet" type="text/css" href="Bootstrap/dist/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="Bootstrap/dist/css/bootstrap-grid.css">

    <!-- Main Styles CSS -->
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="css/fonts.min.css">


</head>
<body class="page-has-left-panels page-has-right-panels">

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="margin-top: 150px;height: 380px;">
            <div class="col col-lg-12 col-md-12 col-sm-12 col-12">
                <h2 class="presentation-margin" style="margin-top: 0px; margin-bottom: 0px;"> 发表感想吧 </h2>
                <div style="height: 332px" ; class="ui-block">


                    <!-- Comment Form  -->

                    <form class="comment-form inline-items1">

                        <div class="post__author author vcard inline-items">
                            <img src="img/author-page.jpg" alt="author">

                            <div class="form-group with-icon-right ">
							<textarea class="form-control" placeholder="" id="Postajax"
                                      style="height:232px;padding-right: 0px;padding-left: 0px;padding-top: 0px;padding-bottom: 0px;">
                            </textarea>
                                <div class="add-options-message">
                                    <a href="#" class="options-message" data-toggle="modal"
                                       data-target="#update-header-photo">
                                        <svg class="olymp-camera-icon">
                                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-camera-icon"></use>
                                        </svg>
                                    </a>
                                </div>
                            </div>
                        </div>

                        <button type="button" class="btn btn-md-2 btn-primary" onclick="Ajax01('03',this)">Post</button>
                        <button class="btn btn-md-2 btn-border-think c-grey btn-transparent custom-color"
                                class="btn btn-default" data-dismiss="modal">Cancel
                        </button>

                    </form>

                    <!-- ... end Comment Form  -->
                </div>
            </div>


        </div>
    </div><!-- /.modal-content -->
</div><!-- /.modal -->
</div>
<!-- 模态框 -->

<!-- Preloader -->

<div id="hellopreloader">
    <div class="preloader">
        <svg width="45" height="45" stroke="#fff">
            <g fill="none" fill-rule="evenodd" stroke-width="2" transform="translate(1 1)">
                <circle cx="22" cy="22" r="6" stroke="none">
                    <animate attributeName="r" begin="1.5s" calcMode="linear" dur="3s" repeatCount="indefinite"
                             values="6;22"/>
                    <animate attributeName="stroke-opacity" begin="1.5s" calcMode="linear" dur="3s"
                             repeatCount="indefinite" values="1;0"/>
                    <animate attributeName="stroke-width" begin="1.5s" calcMode="linear" dur="3s"
                             repeatCount="indefinite" values="2;0"/>
                </circle>
                <circle cx="22" cy="22" r="6" stroke="none">
                    <animate attributeName="r" begin="3s" calcMode="linear" dur="3s" repeatCount="indefinite"
                             values="6;22"/>
                    <animate attributeName="stroke-opacity" begin="3s" calcMode="linear" dur="3s"
                             repeatCount="indefinite" values="1;0"/>
                    <animate attributeName="stroke-width" begin="3s" calcMode="linear" dur="3s" repeatCount="indefinite"
                             values="2;0"/>
                </circle>
                <circle cx="22" cy="22" r="8">
                    <animate attributeName="r" begin="0s" calcMode="linear" dur="1.5s" repeatCount="indefinite"
                             values="6;1;2;3;4;5;6"/>
                </circle>
            </g>
        </svg>

        <div class="text">Loading ...</div>
    </div>
</div>

<!-- ... end Preloader -->


<!-- Fixed Sidebar Left -->

<div class="fixed-sidebar">
    <div class="fixed-sidebar-left sidebar--small" id="sidebar-left">

        <a href="/Web/WebContent/Skip?key=00" class="logo">
            <div class="img-wrap">
                <img src="img/logo.png" alt="Olympus">
            </div>
        </a>

        <div class="mCustomScrollbar" data-mcs-theme="dark">
            <ul class="left-menu">
                <li>
                    <a href="#" class="js-sidebar-open">
                        <svg class="olymp-menu-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="OPEN MENU">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-menu-icon"></use>
                        </svg>
                    </a>
                </li>
                <li>
                    <a href="03-Newsfeed.html">
                        <svg class="olymp-newsfeed-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="NEWSFEED">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-newsfeed-icon"></use>
                        </svg>
                    </a>
                </li>
                <li>
                    <a href="16-FavPagesFeed.html">
                        <svg class="olymp-star-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="FAV PAGE">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-star-icon"></use>
                        </svg>
                    </a>
                </li>
                <li>
                    <a href="17-FriendGroups.html">
                        <svg class="olymp-happy-faces-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="FRIEND GROUPS">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-happy-faces-icon"></use>
                        </svg>
                    </a>
                </li>
                <li>
                    <a href="18-MusicAndPlaylists.html">
                        <svg class="olymp-headphones-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="MUSIC&PLAYLISTS">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-headphones-icon"></use>
                        </svg>
                    </a>
                </li>
                <li>
                    <a href="19-WeatherWidget.html">
                        <svg class="olymp-weather-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="WEATHER APP">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-weather-icon"></use>
                        </svg>
                    </a>
                </li>
                <li>
                    <a href="20-CalendarAndEvents-MonthlyCalendar.html">
                        <svg class="olymp-calendar-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="CALENDAR AND EVENTS">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-calendar-icon"></use>
                        </svg>
                    </a>
                </li>
                <li>
                    <a href="24-CommunityBadges.html">
                        <svg class="olymp-badge-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="Community Badges">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-badge-icon"></use>
                        </svg>
                    </a>
                </li>
                <li>
                    <a href="25-FriendsBirthday.html">
                        <svg class="olymp-cupcake-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="Friends Birthdays">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-cupcake-icon"></use>
                        </svg>
                    </a>
                </li>
                <li>
                    <a href="26-Statistics.html">
                        <svg class="olymp-stats-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="Account Stats">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-stats-icon"></use>
                        </svg>
                    </a>
                </li>
                <li>
                    <a href="27-ManageWidgets.html">
                        <svg class="olymp-manage-widgets-icon left-menu-icon" data-toggle="tooltip"
                             data-placement="right" data-original-title="Manage Widgets">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-manage-widgets-icon"></use>
                        </svg>
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <div class="fixed-sidebar-left sidebar--large" id="sidebar-left-1">
        <a href="02-ProfilePage.html" class="logo">
            <div class="img-wrap">
                <img src="img/logo.png" alt="Olympus">
            </div>
            <div class="title-block">
                <h6 class="logo-title">olympus</h6>
            </div>
        </a>

        <div class="mCustomScrollbar" data-mcs-theme="dark">
            <ul class="left-menu">
                <li>
                    <a href="#" class="js-sidebar-open">
                        <svg class="olymp-close-icon left-menu-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use>
                        </svg>
                        <span class="left-menu-title">Collapse Menu</span>
                    </a>
                </li>
                <li>
                    <a href="03-Newsfeed.html">
                        <svg class="olymp-newsfeed-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="NEWSFEED">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-newsfeed-icon"></use>
                        </svg>
                        <span class="left-menu-title">Newsfeed</span>
                    </a>
                </li>
                <li>
                    <a href="16-FavPagesFeed.html">
                        <svg class="olymp-star-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="FAV PAGE">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-star-icon"></use>
                        </svg>
                        <span class="left-menu-title">Fav Pages Feed</span>
                    </a>
                </li>
                <li>
                    <a href="17-FriendGroups.html">
                        <svg class="olymp-happy-faces-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="FRIEND GROUPS">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-happy-faces-icon"></use>
                        </svg>
                        <span class="left-menu-title">Friend Groups</span>
                    </a>
                </li>
                <li>
                    <a href="18-MusicAndPlaylists.html">
                        <svg class="olymp-headphones-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="MUSIC&PLAYLISTS">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-headphones-icon"></use>
                        </svg>
                        <span class="left-menu-title">Music & Playlists</span>
                    </a>
                </li>
                <li>
                    <a href="19-WeatherWidget.html">
                        <svg class="olymp-weather-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="WEATHER APP">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-weather-icon"></use>
                        </svg>
                        <span class="left-menu-title">Weather App</span>
                    </a>
                </li>
                <li>
                    <a href="20-CalendarAndEvents-MonthlyCalendar.html">
                        <svg class="olymp-calendar-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="CALENDAR AND EVENTS">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-calendar-icon"></use>
                        </svg>
                        <span class="left-menu-title">Calendar and Events</span>
                    </a>
                </li>
                <li>
                    <a href="24-CommunityBadges.html">
                        <svg class="olymp-badge-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="Community Badges">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-badge-icon"></use>
                        </svg>
                        <span class="left-menu-title">Community Badges</span>
                    </a>
                </li>
                <li>
                    <a href="25-FriendsBirthday.html">
                        <svg class="olymp-cupcake-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="Friends Birthdays">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-cupcake-icon"></use>
                        </svg>
                        <span class="left-menu-title">Friends Birthdays</span>
                    </a>
                </li>
                <li>
                    <a href="26-Statistics.html">
                        <svg class="olymp-stats-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="Account Stats">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-stats-icon"></use>
                        </svg>
                        <span class="left-menu-title">Account Stats</span>
                    </a>
                </li>
                <li>
                    <a href="27-ManageWidgets.html">
                        <svg class="olymp-manage-widgets-icon left-menu-icon" data-toggle="tooltip"
                             data-placement="right" data-original-title="Manage Widgets">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-manage-widgets-icon"></use>
                        </svg>
                        <span class="left-menu-title">Manage Widgets</span>
                    </a>
                </li>
            </ul>

            <div class="profile-completion">

                <div class="skills-item">
                    <div class="skills-item-info">
                        <span class="skills-item-title">Profile Completion</span>
                        <span class="skills-item-count"><span class="count-animate" data-speed="1000"
                                                              data-refresh-interval="50" data-to="76"
                                                              data-from="0"></span><span class="units">76%</span></span>
                    </div>
                    <div class="skills-item-meter">
                        <span class="skills-item-meter-active bg-primary" style="width: 76%"></span>
                    </div>
                </div>

                <span>Complete <a href="#">your profile</a> so people can know more about you!</span>

            </div>
        </div>
    </div>
</div>

<!-- ... end Fixed Sidebar Left -->


<!-- Fixed Sidebar Left -->

<div class="fixed-sidebar fixed-sidebar-responsive">

    <div class="fixed-sidebar-left sidebar--small" id="sidebar-left-responsive">
        <a href="#" class="logo js-sidebar-open">
            <img src="img/logo.png" alt="Olympus">
        </a>

    </div>

    <div class="fixed-sidebar-left sidebar--large" id="sidebar-left-1-responsive">
        <a href="#" class="logo">
            <div class="img-wrap">
                <img src="img/logo.png" alt="Olympus">
            </div>
            <div class="title-block">
                <h6 class="logo-title">olympus</h6>
            </div>
        </a>

        <div class="mCustomScrollbar" data-mcs-theme="dark">

            <div class="control-block">
                <div class="author-page author vcard inline-items">
                    <div class="author-thumb">
                        <img alt="author" src="img/author-page.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>
                    <a href="02-ProfilePage.html" class="author-name fn">
                        <div class="author-title">
                            <%=(String) web_inf.get(1)%>
                            <svg class="olymp-dropdown-arrow-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-dropdown-arrow-icon"></use>
                            </svg>
                        </div>
                        <span class="author-subtitle"><%=(String) web_inf.get(7)%></span>
                    </a>
                </div>
            </div>

            <div class="ui-block-title ui-block-title-small">
                <h6 class="title">MAIN SECTIONS</h6>
            </div>

            <ul class="left-menu">
                <li>
                    <a href="#" class="js-sidebar-open">
                        <svg class="olymp-close-icon left-menu-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use>
                        </svg>
                        <span class="left-menu-title">Collapse Menu</span>
                    </a>
                </li>
                <li>
                    <a href="mobile-index.html">
                        <svg class="olymp-newsfeed-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="NEWSFEED">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-newsfeed-icon"></use>
                        </svg>
                        <span class="left-menu-title">Newsfeed</span>
                    </a>
                </li>
                <li>
                    <a href="Mobile-28-YourAccount-PersonalInformation.html">
                        <svg class="olymp-star-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="FAV PAGE">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-star-icon"></use>
                        </svg>
                        <span class="left-menu-title">Fav Pages Feed</span>
                    </a>
                </li>
                <li>
                    <a href="mobile-29-YourAccount-AccountSettings.html">
                        <svg class="olymp-happy-faces-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="FRIEND GROUPS">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-happy-faces-icon"></use>
                        </svg>
                        <span class="left-menu-title">Friend Groups</span>
                    </a>
                </li>
                <li>
                    <a href="Mobile-30-YourAccount-ChangePassword.html">
                        <svg class="olymp-headphones-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="MUSIC&PLAYLISTS">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-headphones-icon"></use>
                        </svg>
                        <span class="left-menu-title">Music & Playlists</span>
                    </a>
                </li>
                <li>
                    <a href="Mobile-31-YourAccount-HobbiesAndInterests.html">
                        <svg class="olymp-weather-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="WEATHER APP">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-weather-icon"></use>
                        </svg>
                        <span class="left-menu-title">Weather App</span>
                    </a>
                </li>
                <li>
                    <a href="Mobile-32-YourAccount-EducationAndEmployement.html">
                        <svg class="olymp-calendar-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="CALENDAR AND EVENTS">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-calendar-icon"></use>
                        </svg>
                        <span class="left-menu-title">Calendar and Events</span>
                    </a>
                </li>
                <li>
                    <a href="Mobile-33-YourAccount-Notifications.html">
                        <svg class="olymp-badge-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="Community Badges">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-badge-icon"></use>
                        </svg>
                        <span class="left-menu-title">Community Badges</span>
                    </a>
                </li>
                <li>
                    <a href="Mobile-34-YourAccount-ChatMessages.html">
                        <svg class="olymp-cupcake-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="Friends Birthdays">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-cupcake-icon"></use>
                        </svg>
                        <span class="left-menu-title">Friends Birthdays</span>
                    </a>
                </li>
                <li>
                    <a href="Mobile-35-YourAccount-FriendsRequests.html">
                        <svg class="olymp-stats-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="Account Stats">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-stats-icon"></use>
                        </svg>
                        <span class="left-menu-title">Account Stats</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <svg class="olymp-manage-widgets-icon left-menu-icon" data-toggle="tooltip"
                             data-placement="right" data-original-title="Manage Widgets">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-manage-widgets-icon"></use>
                        </svg>
                        <span class="left-menu-title">Manage Widgets</span>
                    </a>
                </li>
            </ul>

            <div class="ui-block-title ui-block-title-small">
                <h6 class="title">你的信息</h6>
            </div>

            <ul class="account-settings">
                <li>
                    <a href="/Web/WebContent/Skip?key=02">

                        <svg class="olymp-menu-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-menu-icon"></use>
                        </svg>

                        <span>个人设置</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <svg class="olymp-star-icon left-menu-icon" data-toggle="tooltip" data-placement="right"
                             data-original-title="FAV PAGE">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-star-icon"></use>
                        </svg>

                        <span>创建你喜欢的页面</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <svg class="olymp-logout-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-logout-icon"></use>
                        </svg>

                        <span>退出登录</span>
                    </a>
                </li>
            </ul>

            <div class="ui-block-title ui-block-title-small">
                <h6 class="title">关于校内网</h6>
            </div>

            <ul class="about-olympus">
                <li>
                    <a href="#">
                        <span>条款和条件</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span>常见问题</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span>你的生涯</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span>联系我们</span>
                    </a>
                </li>
            </ul>

        </div>
    </div>
</div>

<!-- ... end Fixed Sidebar Left -->


<!-- Fixed Sidebar Right -->

<div class="fixed-sidebar right">
    <div class="fixed-sidebar-right sidebar--small" id="sidebar-right">

        <div class="mCustomScrollbar" data-mcs-theme="dark">
            <ul class="chat-users">
                <li class="inline-items js-chat-open">
                    <div class="author-thumb">
                        <img alt="author" src="img/avatar67-sm.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>
                </li>
                <li class="inline-items js-chat-open">
                    <div class="author-thumb">
                        <img alt="author" src="img/avatar62-sm.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>
                </li>

                <li class="inline-items js-chat-open">
                    <div class="author-thumb">
                        <img alt="author" src="img/avatar68-sm.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>
                </li>

                <li class="inline-items js-chat-open">
                    <div class="author-thumb">
                        <img alt="author" src="img/avatar69-sm.jpg" class="avatar">
                        <span class="icon-status away"></span>
                    </div>
                </li>

                <li class="inline-items js-chat-open">
                    <div class="author-thumb">
                        <img alt="author" src="img/avatar70-sm.jpg" class="avatar">
                        <span class="icon-status disconected"></span>
                    </div>
                </li>
                <li class="inline-items js-chat-open">
                    <div class="author-thumb">
                        <img alt="author" src="img/avatar64-sm.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>
                </li>
                <li class="inline-items js-chat-open">
                    <div class="author-thumb">
                        <img alt="author" src="img/avatar71-sm.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>
                </li>
                <li class="inline-items js-chat-open">
                    <div class="author-thumb">
                        <img alt="author" src="img/avatar72-sm.jpg" class="avatar">
                        <span class="icon-status away"></span>
                    </div>
                </li>
                <li class="inline-items js-chat-open">
                    <div class="author-thumb">
                        <img alt="author" src="img/avatar63-sm.jpg" class="avatar">
                        <span class="icon-status status-invisible"></span>
                    </div>
                </li>
                <li class="inline-items js-chat-open">
                    <div class="author-thumb">
                        <img alt="author" src="img/avatar72-sm.jpg" class="avatar">
                        <span class="icon-status away"></span>
                    </div>
                </li>
                <li class="inline-items js-chat-open">

                    <div class="author-thumb">
                        <img alt="author" src="img/avatar71-sm.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>
                </li>
            </ul>
        </div>

        <div class="search-friend inline-items">
            <a href="#" class="js-sidebar-open">
                <svg class="olymp-menu-icon">
                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-menu-icon"></use>
                </svg>
            </a>
        </div>

        <a href="#" class="olympus-chat inline-items js-chat-open">
            <svg class="olymp-chat---messages-icon">
                <use xlink:href="svg-icons/sprites/icons.svg#olymp-chat---messages-icon"></use>
            </svg>
        </a>

    </div>

    <div class="fixed-sidebar-right sidebar--large" id="sidebar-right-1">

        <div class="mCustomScrollbar" data-mcs-theme="dark">

            <div class="ui-block-title ui-block-title-small">
                <a href="#" class="title">Close Friends</a>
                <a href="#">Settings</a>
            </div>

            <ul class="chat-users">
                <li class="inline-items js-chat-open">

                    <div class="author-thumb">
                        <img alt="author" src="img/avatar67-sm.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Carol Summers</a>
                        <span class="status">ONLINE</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>

                </li>
                <li class="inline-items js-chat-open">

                    <div class="author-thumb">
                        <img alt="author" src="img/avatar62-sm.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Mathilda Brinker</a>
                        <span class="status">AT WORK!</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>

                </li>

                <li class="inline-items js-chat-open">


                    <div class="author-thumb">
                        <img alt="author" src="img/avatar68-sm.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Carol Summers</a>
                        <span class="status">ONLINE</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>


                </li>

                <li class="inline-items js-chat-open">


                    <div class="author-thumb">
                        <img alt="author" src="img/avatar69-sm.jpg" class="avatar">
                        <span class="icon-status away"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Michael Maximoff</a>
                        <span class="status">AWAY</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>


                </li>

                <li class="inline-items js-chat-open">


                    <div class="author-thumb">
                        <img alt="author" src="img/avatar70-sm.jpg" class="avatar">
                        <span class="icon-status disconected"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Rachel Howlett</a>
                        <span class="status">OFFLINE</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>


                </li>
            </ul>


            <div class="ui-block-title ui-block-title-small">
                <a href="#" class="title">MY FAMILY</a>
                <a href="#">Settings</a>
            </div>

            <ul class="chat-users">
                <li class="inline-items js-chat-open">

                    <div class="author-thumb">
                        <img alt="author" src="img/avatar64-sm.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Sarah Hetfield</a>
                        <span class="status">ONLINE</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>
                </li>
            </ul>


            <div class="ui-block-title ui-block-title-small">
                <a href="#" class="title">UNCATEGORIZED</a>
                <a href="#">Settings</a>
            </div>

            <ul class="chat-users">
                <li class="inline-items js-chat-open">

                    <div class="author-thumb">
                        <img alt="author" src="img/avatar71-sm.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Bruce Peterson</a>
                        <span class="status">ONLINE</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>


                </li>
                <li class="inline-items js-chat-open">

                    <div class="author-thumb">
                        <img alt="author" src="img/avatar72-sm.jpg" class="avatar">
                        <span class="icon-status away"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Chris Greyson</a>
                        <span class="status">AWAY</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>

                </li>
                <li class="inline-items js-chat-open">

                    <div class="author-thumb">
                        <img alt="author" src="img/avatar63-sm.jpg" class="avatar">
                        <span class="icon-status status-invisible"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Nicholas Grisom</a>
                        <span class="status">INVISIBLE</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>
                </li>
                <li class="inline-items js-chat-open">

                    <div class="author-thumb">
                        <img alt="author" src="img/avatar72-sm.jpg" class="avatar">
                        <span class="icon-status away"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Chris Greyson</a>
                        <span class="status">AWAY</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>
                </li>
                <li class="inline-items js-chat-open">

                    <div class="author-thumb">
                        <img alt="author" src="img/avatar71-sm.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Bruce Peterson</a>
                        <span class="status">ONLINE</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>
                </li>
            </ul>

        </div>

        <div class="search-friend inline-items">
            <form class="form-group">
                <input class="form-control" placeholder="Search Friends..." value="" type="text">
            </form>

            <a href="29-YourAccount-AccountSettings.html" class="settings">
                <svg class="olymp-settings-icon">
                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-settings-icon"></use>
                </svg>
            </a>

            <a href="#" class="js-sidebar-open">
                <svg class="olymp-close-icon">
                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use>
                </svg>
            </a>
        </div>

        <a href="#" class="olympus-chat inline-items js-chat-open">

            <h6 class="olympus-chat-title">OLYMPUS CHAT</h6>
            <svg class="olymp-chat---messages-icon">
                <use xlink:href="svg-icons/sprites/icons.svg#olymp-chat---messages-icon"></use>
            </svg>
        </a>

    </div>
</div>

<!-- ... end Fixed Sidebar Right -->


<!-- Fixed Sidebar Right-Responsive -->

<div class="fixed-sidebar right fixed-sidebar-responsive" id="sidebar-right-responsive">

    <div class="fixed-sidebar-right sidebar--small">
        <a href="#" class="js-sidebar-open">
            <svg class="olymp-menu-icon">
                <use xlink:href="svg-icons/sprites/icons.svg#olymp-menu-icon"></use>
            </svg>
            <svg class="olymp-close-icon">
                <use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use>
            </svg>
        </a>
    </div>

    <div class="fixed-sidebar-right sidebar--large">
        <div class="mCustomScrollbar" data-mcs-theme="dark">

            <div class="ui-block-title ui-block-title-small">
                <a href="#" class="title">Close Friends</a>
                <a href="#">Settings</a>
            </div>

            <ul class="chat-users">
                <li class="inline-items js-chat-open">

                    <div class="author-thumb">
                        <img alt="author" src="img/avatar67-sm.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Carol Summers</a>
                        <span class="status">ONLINE</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>

                </li>
                <li class="inline-items js-chat-open">

                    <div class="author-thumb">
                        <img alt="author" src="img/avatar62-sm.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Mathilda Brinker</a>
                        <span class="status">AT WORK!</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>

                </li>

                <li class="inline-items js-chat-open">


                    <div class="author-thumb">
                        <img alt="author" src="img/avatar68-sm.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Carol Summers</a>
                        <span class="status">ONLINE</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>


                </li>

                <li class="inline-items js-chat-open">


                    <div class="author-thumb">
                        <img alt="author" src="img/avatar69-sm.jpg" class="avatar">
                        <span class="icon-status away"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Michael Maximoff</a>
                        <span class="status">AWAY</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>


                </li>

                <li class="inline-items js-chat-open">


                    <div class="author-thumb">
                        <img alt="author" src="img/avatar70-sm.jpg" class="avatar">
                        <span class="icon-status disconected"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Rachel Howlett</a>
                        <span class="status">OFFLINE</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>


                </li>
            </ul>


            <div class="ui-block-title ui-block-title-small">
                <a href="#" class="title">MY FAMILY</a>
                <a href="#">Settings</a>
            </div>

            <ul class="chat-users">
                <li class="inline-items js-chat-open">

                    <div class="author-thumb">
                        <img alt="author" src="img/avatar64-sm.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Sarah Hetfield</a>
                        <span class="status">ONLINE</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>
                </li>
            </ul>


            <div class="ui-block-title ui-block-title-small">
                <a href="#" class="title">UNCATEGORIZED</a>
                <a href="#">Settings</a>
            </div>

            <ul class="chat-users">
                <li class="inline-items js-chat-open">

                    <div class="author-thumb">
                        <img alt="author" src="img/avatar71-sm.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Bruce Peterson</a>
                        <span class="status">ONLINE</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>


                </li>
                <li class="inline-items js-chat-open">

                    <div class="author-thumb">
                        <img alt="author" src="img/avatar72-sm.jpg" class="avatar">
                        <span class="icon-status away"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Chris Greyson</a>
                        <span class="status">AWAY</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>

                </li>
                <li class="inline-items js-chat-open">

                    <div class="author-thumb">
                        <img alt="author" src="img/avatar63-sm.jpg" class="avatar">
                        <span class="icon-status status-invisible"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Nicholas Grisom</a>
                        <span class="status">INVISIBLE</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>
                </li>
                <li class="inline-items js-chat-open">

                    <div class="author-thumb">
                        <img alt="author" src="img/avatar72-sm.jpg" class="avatar">
                        <span class="icon-status away"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Chris Greyson</a>
                        <span class="status">AWAY</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>
                </li>
                <li class="inline-items js-chat-open">

                    <div class="author-thumb">
                        <img alt="author" src="img/avatar71-sm.jpg" class="avatar">
                        <span class="icon-status online"></span>
                    </div>

                    <div class="author-status">
                        <a href="#" class="h6 author-name">Bruce Peterson</a>
                        <span class="status">ONLINE</span>
                    </div>

                    <div class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION"
                                     class="olymp-comments-post-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top"
                                     data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use>
                                </svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT"
                                     class="olymp-block-from-chat-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use>
                                </svg>
                            </li>
                        </ul>

                    </div>
                </li>
            </ul>

        </div>

        <div class="search-friend inline-items">
            <form class="form-group">
                <input class="form-control" placeholder="Search Friends..." value="" type="text">
            </form>

            <a href="29-YourAccount-AccountSettings.html" class="settings">
                <svg class="olymp-settings-icon">
                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-settings-icon"></use>
                </svg>
            </a>

            <a href="#" class="js-sidebar-open">
                <svg class="olymp-close-icon">
                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use>
                </svg>
            </a>
        </div>

        <a href="#" class="olympus-chat inline-items js-chat-open">

            <h6 class="olympus-chat-title">OLYMPUS CHAT</h6>
            <svg class="olymp-chat---messages-icon">
                <use xlink:href="svg-icons/sprites/icons.svg#olymp-chat---messages-icon"></use>
            </svg>
        </a>
    </div>

</div>

<!-- ... end Fixed Sidebar Right-Responsive -->


<!-- Header-BP -->

<header class="header" id="site-header">

    <div class="page-title">
        <h6>校内网</h6>
    </div>

    <div class="header-content-wrapper">
        <form class="search-bar w-search notification-list friend-requests" method="post" action="/Web/WebContent/Search.do">
            <div class="form-group with-button">
                <input  placeholder="Search here people or pages..." name="spost1" type="text">
                <button>
                    <svg class="olymp-magnifying-glass-icon">
                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-magnifying-glass-icon"></use>
                    </svg>
                </button>
            </div>
            <input type="submit" style="display: none;" id="spost">
        </form>

        <a href="javascript:void(0)" onclick="searchpost()" class="link-find-friend">Search</a>

        <div class="control-block">

            <div class="control-icon more has-items">
                <svg class="olymp-happy-face-icon">
                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use>
                </svg>
                <div class="label-avatar bg-blue">6</div>

                <div class="more-dropdown more-with-triangle triangle-top-center">
                    <div class="ui-block-title ui-block-title-small">
                        <h6 class="title">好友请求</h6>
                        <a href="#">查找朋友</a>
                        <a href="#">设置</a>
                    </div>

                    <div class="mCustomScrollbar" data-mcs-theme="dark">
                        <ul class="notification-list friend-requests">
                            <li>
                                <div class="author-thumb">
                                    <img src="img/avatar55-sm.jpg" alt="author">
                                </div>
                                <div class="notification-event">
                                    <a href="#" class="h6 notification-friend">米娅的眼泪</a>
                                    <span class="chat-message-item">共同好友:橘子大大</span>
                                </div>
                                <span class="notification-icon">
									<a href="#" class="accept-request">
										<span class="icon-add without-text">
											<svg class="olymp-happy-face-icon"><use
                                                    xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
										</span>
									</a>

									<a href="#" class="accept-request request-del">
										<span class="icon-minus">
											<svg class="olymp-happy-face-icon"><use
                                                    xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
										</span>
									</a>

								</span>

                                <div class="more">
                                    <svg class="olymp-three-dots-icon">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                    </svg>
                                </div>
                            </li>

                            <li>
                                <div class="author-thumb">
                                    <img src="img/avatar56-sm.jpg" alt="author">
                                </div>
                                <div class="notification-event">
                                    <a href="#" class="h6 notification-friend">Tony老师</a>
                                    <span class="chat-message-item">9个共同好友</span>
                                </div>
                                <span class="notification-icon">
									<a href="#" class="accept-request">
										<span class="icon-add without-text">
											<svg class="olymp-happy-face-icon"><use
                                                    xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
										</span>
									</a>

									<a href="#" class="accept-request request-del">
										<span class="icon-minus">
											<svg class="olymp-happy-face-icon"><use
                                                    xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
										</span>
									</a>

								</span>

                                <div class="more">
                                    <svg class="olymp-three-dots-icon">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                    </svg>
                                </div>
                            </li>

                            <li class="accepted">
                                <div class="author-thumb">
                                    <img src="img/avatar57-sm.jpg" alt="author">
                                </div>
                                <div class="notification-event">
                                    你和 <a href="#" class="h6 notification-friend">简单爱</a> 希望我们能成为朋友
                                    <a href="#" class="notification-link">她的名片</a>.
                                </div>
                                <span class="notification-icon">
									<svg class="olymp-happy-face-icon"><use
                                            xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
								</span>

                                <div class="more">
                                    <svg class="olymp-three-dots-icon">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                    </svg>
                                    <svg class="olymp-little-delete">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-little-delete"></use>
                                    </svg>
                                </div>
                            </li>

                            <li>
                                <div class="author-thumb">
                                    <img src="img/avatar58-sm.jpg" alt="author">
                                </div>
                                <div class="notification-event">
                                    <a href="#" class="h6 notification-friend">CCCClost</a>
                                    <span class="chat-message-item">9个共同好友</span>
                                </div>
                                <span class="notification-icon">
									<a href="#" class="accept-request">
										<span class="icon-add without-text">
											<svg class="olymp-happy-face-icon"><use
                                                    xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
										</span>
									</a>

									<a href="#" class="accept-request request-del">
										<span class="icon-minus">
											<svg class="olymp-happy-face-icon"><use
                                                    xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
										</span>
									</a>

								</span>

                                <div class="more">
                                    <svg class="olymp-three-dots-icon">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                    </svg>
                                </div>
                            </li>

                        </ul>
                    </div>

                    <a href="#" class="view-all bg-blue">查看所有</a>
                </div>
            </div>

            <div class="control-icon more has-items">
                <svg class="olymp-chat---messages-icon">
                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-chat---messages-icon"></use>
                </svg>
                <div class="label-avatar bg-purple">2</div>

                <div class="more-dropdown more-with-triangle triangle-top-center">
                    <div class="ui-block-title ui-block-title-small">
                        <h6 class="title">聊天/信息</h6>
                        <a href="#">标为已读</a>
                        <a href="#">设置</a>
                    </div>

                    <div class="mCustomScrollbar" data-mcs-theme="dark">
                        <ul class="notification-list chat-message">
                            <li class="message-unread">
                                <div class="author-thumb">
                                    <img src="img/avatar59-sm.jpg" alt="author">
                                </div>
                                <div class="notification-event">
                                    <a href="#" class="h6 notification-friend">Diana Jameson</a>
                                    <span class="chat-message-item">Hi James! It’s Diana, I just wanted to let you know that we have to reschedule...</span>
                                    <span class="notification-date"><time class="entry-date updated"
                                                                          datetime="2004-07-24T18:18">4 hours ago</time></span>
                                </div>
                                <span class="notification-icon">
									<svg class="olymp-chat---messages-icon"><use
                                            xlink:href="svg-icons/sprites/icons.svg#olymp-chat---messages-icon"></use></svg>
								</span>
                                <div class="more">
                                    <svg class="olymp-three-dots-icon">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                    </svg>
                                </div>
                            </li>

                            <li>
                                <div class="author-thumb">
                                    <img src="img/avatar60-sm.jpg" alt="author">
                                </div>
                                <div class="notification-event">
                                    <a href="#" class="h6 notification-friend">Jake Parker</a>
                                    <span class="chat-message-item">Great, I’ll see you tomorrow!.</span>
                                    <span class="notification-date"><time class="entry-date updated"
                                                                          datetime="2004-07-24T18:18">4 hours ago</time></span>
                                </div>
                                <span class="notification-icon">
									<svg class="olymp-chat---messages-icon"><use
                                            xlink:href="svg-icons/sprites/icons.svg#olymp-chat---messages-icon"></use></svg>
								</span>

                                <div class="more">
                                    <svg class="olymp-three-dots-icon">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                    </svg>
                                </div>
                            </li>
                            <li>
                                <div class="author-thumb">
                                    <img src="img/avatar61-sm.jpg" alt="author">
                                </div>
                                <div class="notification-event">
                                    <a href="#" class="h6 notification-friend">Elaine Dreyfuss</a>
                                    <span class="chat-message-item">We’ll have to check that at the office and see if the client is on board with...</span>
                                    <span class="notification-date"><time class="entry-date updated"
                                                                          datetime="2004-07-24T18:18">Yesterday at 9:56pm</time></span>
                                </div>
                                <span class="notification-icon">
										<svg class="olymp-chat---messages-icon"><use
                                                xlink:href="svg-icons/sprites/icons.svg#olymp-chat---messages-icon"></use></svg>
									</span>
                                <div class="more">
                                    <svg class="olymp-three-dots-icon">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                    </svg>
                                </div>
                            </li>

                            <li class="chat-group">
                                <div class="author-thumb">
                                    <img src="img/avatar11-sm.jpg" alt="author">
                                    <img src="img/avatar12-sm.jpg" alt="author">
                                    <img src="img/avatar13-sm.jpg" alt="author">
                                    <img src="img/avatar10-sm.jpg" alt="author">
                                </div>
                                <div class="notification-event">
                                    <a href="#" class="h6 notification-friend">You, Faye, Ed &amp; Jet +3</a>
                                    <span class="last-message-author">Ed:</span>
                                    <span class="chat-message-item">Yeah! Seems fine by me!</span>
                                    <span class="notification-date"><time class="entry-date updated"
                                                                          datetime="2004-07-24T18:18">March 16th at 10:23am</time></span>
                                </div>
                                <span class="notification-icon">
										<svg class="olymp-chat---messages-icon"><use
                                                xlink:href="svg-icons/sprites/icons.svg#olymp-chat---messages-icon"></use></svg>
									</span>
                                <div class="more">
                                    <svg class="olymp-three-dots-icon">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                    </svg>
                                </div>
                            </li>
                        </ul>
                    </div>

                    <a href="#" class="view-all bg-purple">View All Messages</a>
                </div>
            </div>

            <div class="control-icon more has-items">
                <svg class="olymp-thunder-icon">
                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-thunder-icon"></use>
                </svg>

                <div class="label-avatar bg-primary">8</div>

                <div class="more-dropdown more-with-triangle triangle-top-center">
                    <div class="ui-block-title ui-block-title-small">
                        <h6 class="title">Notifications</h6>
                        <a href="#">Mark all as read</a>
                        <a href="#">Settings</a>
                    </div>

                    <div class="mCustomScrollbar" data-mcs-theme="dark">
                        <ul class="notification-list">
                            <li>
                                <div class="author-thumb">
                                    <img src="img/avatar62-sm.jpg" alt="author">
                                </div>
                                <div class="notification-event">
                                    <div><a href="#" class="h6 notification-friend">Mathilda Brinker</a> commented on
                                        your new <a href="#" class="notification-link">profile status</a>.
                                    </div>
                                    <span class="notification-date"><time class="entry-date updated"
                                                                          datetime="2004-07-24T18:18">4 hours ago</time></span>
                                </div>
                                <span class="notification-icon">
										<svg class="olymp-comments-post-icon"><use
                                                xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
									</span>

                                <div class="more">
                                    <svg class="olymp-three-dots-icon">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                    </svg>
                                    <svg class="olymp-little-delete">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-little-delete"></use>
                                    </svg>
                                </div>
                            </li>

                            <li class="un-read">
                                <div class="author-thumb">
                                    <img src="img/avatar63-sm.jpg" alt="author">
                                </div>
                                <div class="notification-event">
                                    <div>You and <a href="#" class="h6 notification-friend">Nicholas Grissom</a> just
                                        became friends. Write on <a href="#" class="notification-link">his wall</a>.
                                    </div>
                                    <span class="notification-date"><time class="entry-date updated"
                                                                          datetime="2004-07-24T18:18">9 hours ago</time></span>
                                </div>
                                <span class="notification-icon">
										<svg class="olymp-happy-face-icon"><use
                                                xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
									</span>

                                <div class="more">
                                    <svg class="olymp-three-dots-icon">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                    </svg>
                                    <svg class="olymp-little-delete">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-little-delete"></use>
                                    </svg>
                                </div>
                            </li>

                            <li class="with-comment-photo">
                                <div class="author-thumb">
                                    <img src="img/avatar64-sm.jpg" alt="author">
                                </div>
                                <div class="notification-event">
                                    <div><a href="#" class="h6 notification-friend">Sarah Hetfield</a> commented on your
                                        <a href="#" class="notification-link">photo</a>.
                                    </div>
                                    <span class="notification-date"><time class="entry-date updated"
                                                                          datetime="2004-07-24T18:18">Yesterday at 5:32am</time></span>
                                </div>
                                <span class="notification-icon">
										<svg class="olymp-comments-post-icon"><use
                                                xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
									</span>

                                <div class="comment-photo">
                                    <img src="img/comment-photo1.jpg" alt="photo">
                                    <span>“She looks incredible in that outfit! We should see each...”</span>
                                </div>

                                <div class="more">
                                    <svg class="olymp-three-dots-icon">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                    </svg>
                                    <svg class="olymp-little-delete">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-little-delete"></use>
                                    </svg>
                                </div>
                            </li>

                            <li>
                                <div class="author-thumb">
                                    <img src="img/avatar65-sm.jpg" alt="author">
                                </div>
                                <div class="notification-event">
                                    <div><a href="#" class="h6 notification-friend">Green Goo Rock</a> invited you to
                                        attend to his event Goo in <a href="#" class="notification-link">Gotham Bar</a>.
                                    </div>
                                    <span class="notification-date"><time class="entry-date updated"
                                                                          datetime="2004-07-24T18:18">March 5th at 6:43pm</time></span>
                                </div>
                                <span class="notification-icon">
										<svg class="olymp-happy-face-icon"><use
                                                xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
									</span>

                                <div class="more">
                                    <svg class="olymp-three-dots-icon">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                    </svg>
                                    <svg class="olymp-little-delete">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-little-delete"></use>
                                    </svg>
                                </div>
                            </li>

                            <li>
                                <div class="author-thumb">
                                    <img src="img/avatar66-sm.jpg" alt="author">
                                </div>
                                <div class="notification-event">
                                    <div><a href="#" class="h6 notification-friend">James Summers</a> commented on your
                                        new <a href="#" class="notification-link">profile status</a>.
                                    </div>
                                    <span class="notification-date"><time class="entry-date updated"
                                                                          datetime="2004-07-24T18:18">March 2nd at 8:29pm</time></span>
                                </div>
                                <span class="notification-icon">
										<svg class="olymp-heart-icon"><use
                                                xlink:href="svg-icons/sprites/icons.svg#olymp-heart-icon"></use></svg>
									</span>

                                <div class="more">
                                    <svg class="olymp-three-dots-icon">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                    </svg>
                                    <svg class="olymp-little-delete">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-little-delete"></use>
                                    </svg>
                                </div>
                            </li>
                        </ul>
                    </div>

                    <a href="#" class="view-all bg-primary">View All Notifications</a>
                </div>
            </div>

            <div class="author-page author vcard inline-items more">
                <div class="author-thumb">
                    <img alt="author" src="img/author-page.jpg" class="avatar">
                    <span class="icon-status online"></span>
                    <div class="more-dropdown more-with-triangle">
                        <div class="mCustomScrollbar" data-mcs-theme="dark">
                            <div class="ui-block-title ui-block-title-small">
                                <h6 class="title">你的账号</h6>
                            </div>

                            <ul class="account-settings">
                                <li>
                                    <a href="/Web/WebContent/Skip?key=02">

                                        <svg class="olymp-menu-icon">
                                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-menu-icon"></use>
                                        </svg>

                                        <span>个人设置</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="36-FavPage-SettingsAndCreatePopup.html">
                                        <svg class="olymp-star-icon left-menu-icon" data-toggle="tooltip"
                                             data-placement="right" data-original-title="FAV PAGE">
                                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-star-icon"></use>
                                        </svg>

                                        <span>创建主页</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="/Web/WebContent/Skip?key=04">
                                        <svg class="olymp-logout-icon">
                                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-logout-icon"></use>
                                        </svg>

                                        <span>登出</span>
                                    </a>
                                </li>
                            </ul>

                            <div class="ui-block-title ui-block-title-small">
                                <h6 class="title">聊天设置</h6>
                            </div>

                            <ul class="chat-settings">
                                <li>
                                    <a href="#">
                                        <span class="icon-status online"></span>
                                        <span>在线</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="icon-status away"></span>
                                        <span>离开</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="icon-status disconected"></span>
                                        <span>免打扰</span>
                                    </a>
                                </li>

                                <li>
                                    <a href="#">
                                        <span class="icon-status status-invisible"></span>
                                        <span>隐身</span>
                                    </a>
                                </li>
                            </ul>

                            <div class="ui-block-title ui-block-title-small">
                                <h6 class="title">客户信息</h6>
                            </div>

                            <form class="form-group with-button custom-status">
                                <input class="form-control" placeholder="" type="text" id="userstate" id="topstate" value="<%=(String) web_inf.get(7)%>">

                                <button type="button"  onclick="Ajax01('07',this)" class="bg-purple">
                                    <svg class="olymp-check-icon">
                                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-check-icon"></use>
                                    </svg>
                                </button>
                            </form>

                            <div class="ui-block-title ui-block-title-small">
                                <h6 class="title">关于我们</h6>
                            </div>

                            <ul>
                                <li>
                                    <a href="#">
                                        <span>条款和条件</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span>常见问题</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span>生涯</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span>联系我们</span>
                                    </a>
                                </li>
                            </ul>
                        </div>

                    </div>
                </div>
                <a href="02-ProfilePage.html" class="author-name fn">
                    <div class="author-title">
                        <%=(String) web_inf.get(1)%>
                        <svg class="olymp-dropdown-arrow-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-dropdown-arrow-icon"></use>
                        </svg>
                    </div>
                    <span class="author-subtitle" id="topstate1"><%=(String) web_inf.get(7)%></span>
                </a>
            </div>

        </div>
    </div>

</header>

<!-- ... end Header-BP -->


<!-- Responsive Header-BP -->

<header class="header header-responsive" id="site-header-responsive">

    <div class="header-content-wrapper">
        <ul class="nav nav-tabs mobile-app-tabs" role="tablist">
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#request" role="tab">
                    <div class="control-icon has-items">
                        <svg class="olymp-happy-face-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use>
                        </svg>
                        <div class="label-avatar bg-blue">6</div>
                    </div>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#chat" role="tab">
                    <div class="control-icon has-items">
                        <svg class="olymp-chat---messages-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-chat---messages-icon"></use>
                        </svg>
                        <div class="label-avatar bg-purple">2</div>
                    </div>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#notification" role="tab">
                    <div class="control-icon has-items">
                        <svg class="olymp-thunder-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-thunder-icon"></use>
                        </svg>
                        <div class="label-avatar bg-primary">8</div>
                    </div>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#search" role="tab">
                    <svg class="olymp-magnifying-glass-icon">
                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-magnifying-glass-icon"></use>
                    </svg>
                    <svg class="olymp-close-icon">
                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use>
                    </svg>
                </a>
            </li>
        </ul>
    </div>

    <!-- Tab panes -->
    <div class="tab-content tab-content-responsive">

        <div class="tab-pane " id="request" role="tabpanel">

            <div class="mCustomScrollbar" data-mcs-theme="dark">
                <div class="ui-block-title ui-block-title-small">
                    <h6 class="title">FRIEND REQUESTS</h6>
                    <a href="#">Find Friends</a>
                    <a href="#">Settings</a>
                </div>
                <ul class="notification-list friend-requests">
                    <li>
                        <div class="author-thumb">
                            <img src="img/avatar55-sm.jpg" alt="author">
                        </div>
                        <div class="notification-event">
                            <a href="#" class="h6 notification-friend">Tamara Romanoff</a>
                            <span class="chat-message-item">Mutual Friend: Sarah Hetfield</span>
                        </div>
                        <span class="notification-icon">
										<a href="#" class="accept-request">
											<span class="icon-add without-text">
												<svg class="olymp-happy-face-icon"><use
                                                        xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
											</span>
										</a>

										<a href="#" class="accept-request request-del">
											<span class="icon-minus">
												<svg class="olymp-happy-face-icon"><use
                                                        xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
											</span>
										</a>

									</span>

                        <div class="more">
                            <svg class="olymp-three-dots-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                            </svg>
                        </div>
                    </li>
                    <li>
                        <div class="author-thumb">
                            <img src="img/avatar56-sm.jpg" alt="author">
                        </div>
                        <div class="notification-event">
                            <a href="#" class="h6 notification-friend">Tony Stevens</a>
                            <span class="chat-message-item">4 Friends in Common</span>
                        </div>
                        <span class="notification-icon">
										<a href="#" class="accept-request">
											<span class="icon-add without-text">
												<svg class="olymp-happy-face-icon"><use
                                                        xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
											</span>
										</a>

										<a href="#" class="accept-request request-del">
											<span class="icon-minus">
												<svg class="olymp-happy-face-icon"><use
                                                        xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
											</span>
										</a>

									</span>

                        <div class="more">
                            <svg class="olymp-three-dots-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                            </svg>
                        </div>
                    </li>
                    <li class="accepted">
                        <div class="author-thumb">
                            <img src="img/avatar57-sm.jpg" alt="author">
                        </div>
                        <div class="notification-event">
                            You and <a href="#" class="h6 notification-friend">Mary Jane Stark</a> just became friends.
                            Write on <a href="#" class="notification-link">her wall</a>.
                        </div>
                        <span class="notification-icon">
										<svg class="olymp-happy-face-icon"><use
                                                xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
									</span>

                        <div class="more">
                            <svg class="olymp-three-dots-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                            </svg>
                            <svg class="olymp-little-delete">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-little-delete"></use>
                            </svg>
                        </div>
                    </li>
                    <li>
                        <div class="author-thumb">
                            <img src="img/avatar58-sm.jpg" alt="author">
                        </div>
                        <div class="notification-event">
                            <a href="#" class="h6 notification-friend">Stagg Clothing</a>
                            <span class="chat-message-item">9 Friends in Common</span>
                        </div>
                        <span class="notification-icon">
										<a href="#" class="accept-request">
											<span class="icon-add without-text">
												<svg class="olymp-happy-face-icon"><use
                                                        xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
											</span>
										</a>

										<a href="#" class="accept-request request-del">
											<span class="icon-minus">
												<svg class="olymp-happy-face-icon"><use
                                                        xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
											</span>
										</a>

									</span>

                        <div class="more">
                            <svg class="olymp-three-dots-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                            </svg>
                        </div>
                    </li>
                </ul>
                <a href="#" class="view-all bg-blue">Check all your Events</a>
            </div>

        </div>

        <div class="tab-pane " id="chat" role="tabpanel">

            <div class="mCustomScrollbar" data-mcs-theme="dark">
                <div class="ui-block-title ui-block-title-small">
                    <h6 class="title">Chat / Messages</h6>
                    <a href="#">Mark all as read</a>
                    <a href="#">Settings</a>
                </div>

                <ul class="notification-list chat-message">
                    <li class="message-unread">
                        <div class="author-thumb">
                            <img src="img/avatar59-sm.jpg" alt="author">
                        </div>
                        <div class="notification-event">
                            <a href="#" class="h6 notification-friend">Diana Jameson</a>
                            <span class="chat-message-item">Hi James! It’s Diana, I just wanted to let you know that we have to reschedule...</span>
                            <span class="notification-date"><time class="entry-date updated"
                                                                  datetime="2004-07-24T18:18">4 hours ago</time></span>
                        </div>
                        <span class="notification-icon">
										<svg class="olymp-chat---messages-icon"><use
                                                xlink:href="svg-icons/sprites/icons.svg#olymp-chat---messages-icon"></use></svg>
									</span>
                        <div class="more">
                            <svg class="olymp-three-dots-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                            </svg>
                        </div>
                    </li>

                    <li>
                        <div class="author-thumb">
                            <img src="img/avatar60-sm.jpg" alt="author">
                        </div>
                        <div class="notification-event">
                            <a href="#" class="h6 notification-friend">Jake Parker</a>
                            <span class="chat-message-item">Great, I’ll see you tomorrow!.</span>
                            <span class="notification-date"><time class="entry-date updated"
                                                                  datetime="2004-07-24T18:18">4 hours ago</time></span>
                        </div>
                        <span class="notification-icon">
										<svg class="olymp-chat---messages-icon"><use
                                                xlink:href="svg-icons/sprites/icons.svg#olymp-chat---messages-icon"></use></svg>
									</span>

                        <div class="more">
                            <svg class="olymp-three-dots-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                            </svg>
                        </div>
                    </li>
                    <li>
                        <div class="author-thumb">
                            <img src="img/avatar61-sm.jpg" alt="author">
                        </div>
                        <div class="notification-event">
                            <a href="#" class="h6 notification-friend">Elaine Dreyfuss</a>
                            <span class="chat-message-item">We’ll have to check that at the office and see if the client is on board with...</span>
                            <span class="notification-date"><time class="entry-date updated"
                                                                  datetime="2004-07-24T18:18">Yesterday at 9:56pm</time></span>
                        </div>
                        <span class="notification-icon">
											<svg class="olymp-chat---messages-icon"><use
                                                    xlink:href="svg-icons/sprites/icons.svg#olymp-chat---messages-icon"></use></svg>
										</span>
                        <div class="more">
                            <svg class="olymp-three-dots-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                            </svg>
                        </div>
                    </li>

                    <li class="chat-group">
                        <div class="author-thumb">
                            <img src="img/avatar11-sm.jpg" alt="author">
                            <img src="img/avatar12-sm.jpg" alt="author">
                            <img src="img/avatar13-sm.jpg" alt="author">
                            <img src="img/avatar10-sm.jpg" alt="author">
                        </div>
                        <div class="notification-event">
                            <a href="#" class="h6 notification-friend">You, Faye, Ed &amp; Jet +3</a>
                            <span class="last-message-author">Ed:</span>
                            <span class="chat-message-item">Yeah! Seems fine by me!</span>
                            <span class="notification-date"><time class="entry-date updated"
                                                                  datetime="2004-07-24T18:18">March 16th at 10:23am</time></span>
                        </div>
                        <span class="notification-icon">
											<svg class="olymp-chat---messages-icon"><use
                                                    xlink:href="svg-icons/sprites/icons.svg#olymp-chat---messages-icon"></use></svg>
										</span>
                        <div class="more">
                            <svg class="olymp-three-dots-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                            </svg>
                        </div>
                    </li>
                </ul>

                <a href="#" class="view-all bg-purple">View All Messages</a>
            </div>

        </div>

        <div class="tab-pane " id="notification" role="tabpanel">

            <div class="mCustomScrollbar" data-mcs-theme="dark">
                <div class="ui-block-title ui-block-title-small">
                    <h6 class="title">Notifications</h6>
                    <a href="#">Mark all as read</a>
                    <a href="#">Settings</a>
                </div>

                <ul class="notification-list">
                    <li>
                        <div class="author-thumb">
                            <img src="img/avatar62-sm.jpg" alt="author">
                        </div>
                        <div class="notification-event">
                            <div><a href="#" class="h6 notification-friend">Mathilda Brinker</a> commented on your new
                                <a href="#" class="notification-link">profile status</a>.
                            </div>
                            <span class="notification-date"><time class="entry-date updated"
                                                                  datetime="2004-07-24T18:18">4 hours ago</time></span>
                        </div>
                        <span class="notification-icon">
											<svg class="olymp-comments-post-icon"><use
                                                    xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
										</span>

                        <div class="more">
                            <svg class="olymp-three-dots-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                            </svg>
                            <svg class="olymp-little-delete">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-little-delete"></use>
                            </svg>
                        </div>
                    </li>

                    <li class="un-read">
                        <div class="author-thumb">
                            <img src="img/avatar63-sm.jpg" alt="author">
                        </div>
                        <div class="notification-event">
                            <div>You and <a href="#" class="h6 notification-friend">Nicholas Grissom</a> just became
                                friends. Write on <a href="#" class="notification-link">his wall</a>.
                            </div>
                            <span class="notification-date"><time class="entry-date updated"
                                                                  datetime="2004-07-24T18:18">9 hours ago</time></span>
                        </div>
                        <span class="notification-icon">
											<svg class="olymp-happy-face-icon"><use
                                                    xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
										</span>

                        <div class="more">
                            <svg class="olymp-three-dots-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                            </svg>
                            <svg class="olymp-little-delete">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-little-delete"></use>
                            </svg>
                        </div>
                    </li>

                    <li class="with-comment-photo">
                        <div class="author-thumb">
                            <img src="img/avatar64-sm.jpg" alt="author">
                        </div>
                        <div class="notification-event">
                            <div><a href="#" class="h6 notification-friend">Sarah Hetfield</a> commented on your <a
                                    href="#" class="notification-link">photo</a>.
                            </div>
                            <span class="notification-date"><time class="entry-date updated"
                                                                  datetime="2004-07-24T18:18">Yesterday at 5:32am</time></span>
                        </div>
                        <span class="notification-icon">
											<svg class="olymp-comments-post-icon"><use
                                                    xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
										</span>

                        <div class="comment-photo">
                            <img src="img/comment-photo1.jpg" alt="photo">
                            <span>“She looks incredible in that outfit! We should see each...”</span>
                        </div>

                        <div class="more">
                            <svg class="olymp-three-dots-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                            </svg>
                            <svg class="olymp-little-delete">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-little-delete"></use>
                            </svg>
                        </div>
                    </li>

                    <li>
                        <div class="author-thumb">
                            <img src="img/avatar65-sm.jpg" alt="author">
                        </div>
                        <div class="notification-event">
                            <div><a href="#" class="h6 notification-friend">Green Goo Rock</a> invited you to attend to
                                his event Goo in <a href="#" class="notification-link">Gotham Bar</a>.
                            </div>
                            <span class="notification-date"><time class="entry-date updated"
                                                                  datetime="2004-07-24T18:18">March 5th at 6:43pm</time></span>
                        </div>
                        <span class="notification-icon">
											<svg class="olymp-happy-face-icon"><use
                                                    xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
										</span>

                        <div class="more">
                            <svg class="olymp-three-dots-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                            </svg>
                            <svg class="olymp-little-delete">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-little-delete"></use>
                            </svg>
                        </div>
                    </li>

                    <li>
                        <div class="author-thumb">
                            <img src="img/avatar66-sm.jpg" alt="author">
                        </div>
                        <div class="notification-event">
                            <div><a href="#" class="h6 notification-friend">James Summers</a> commented on your new <a
                                    href="#" class="notification-link">profile status</a>.
                            </div>
                            <span class="notification-date"><time class="entry-date updated"
                                                                  datetime="2004-07-24T18:18">March 2nd at 8:29pm</time></span>
                        </div>
                        <span class="notification-icon">
											<svg class="olymp-heart-icon"><use
                                                    xlink:href="svg-icons/sprites/icons.svg#olymp-heart-icon"></use></svg>
										</span>

                        <div class="more">
                            <svg class="olymp-three-dots-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                            </svg>
                            <svg class="olymp-little-delete">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-little-delete"></use>
                            </svg>
                        </div>
                    </li>
                </ul>

                <a href="#" class="view-all bg-primary">View All Notifications</a>
            </div>

        </div>

        <div class="tab-pane " id="search" role="tabpanel">


            <form class="search-bar w-search notification-list friend-requests">
                <div class="form-group with-button">
                    <input class="form-control js-user-search" placeholder="Search here people or pages..." type="text">
                </div>
            </form>


        </div>

    </div>
    <!-- ... end  Tab panes -->

</header>

<!-- ... end Responsive Header-BP -->
<div class="header-spacer"></div>


<!-- Top Header-Profile -->

<div class="container">
    <div class="row">
        <div class="col col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
            <div class="ui-block">
                <div class="top-header">
                    <div class="top-header-thumb">
                        <img src="img/top-header1.jpg" alt="nature">
                    </div>
                    <div class="profile-section">
                        <div class="row">
                            <div class="col col-lg-5 col-md-5 col-sm-12 col-12">
                                <ul class="profile-menu">
                                    <li>
                                        <a href="02-ProfilePage.html" class="active">动态</a>
                                    </li>
                                    <li>
                                        <a href="/Web/WebContent/Skip?key=05">帖子</a>
                                    </li>
                                    <li>
                                        <a href="06-ProfilePage.html">朋友</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="col col-lg-5 ml-auto col-md-5 col-sm-12 col-12">
                                <ul class="profile-menu">
                                    <li>
                                        <a href="07-ProfilePage-Photos.html">照片</a>
                                    </li>
                                    <li>
                                        <a href="09-ProfilePage-Videos.html">电影</a>
                                    </li>
                                    <li>
                                        <div class="more">
                                            <svg class="olymp-three-dots-icon">
                                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                            </svg>
                                            <ul class="more-dropdown more-with-triangle">
                                                <li>
                                                    <a href="#">开放主页</a>
                                                </li>
                                                <li>
                                                    <a href="#">关闭主页</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <div class="control-block-button">
                            <a href="35-YourAccount-FriendsRequests.html" class="btn btn-control bg-blue">
                                <svg class="olymp-happy-face-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use>
                                </svg>
                            </a>

                            <a href="#" class="btn btn-control bg-purple" class="btn btn-primary btn-lg"
                               data-toggle="modal" data-target="#myModal">
                                <svg class="olymp-chat---messages-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-chat---messages-icon"></use>
                                </svg>
                            </a>

                            <div class="btn btn-control bg-primary more">
                                <svg class="olymp-settings-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-settings-icon"></use>
                                </svg>

                                <ul class="more-dropdown more-with-triangle triangle-bottom-right">
                                    <li>
                                        <a href="#" data-toggle="modal" data-target="#update-header-photo">更换头像</a>
                                    </li>
                                    <li>
                                        <a href="#" data-toggle="modal" data-target="#update-header-photo">更换背景</a>
                                    </li>
                                    <li>
                                        <a href="/Web/WebContent/Skip?key=02">账户信息</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="top-header-author">
                        <a href="/Web/WebContent/Skip?key=02" class="author-thumb">
                            <img src="img/author-main1.jpg" alt="author">
                        </a>
                        <div class="author-content">
                            <a href="/Web/WebContent/Skip?key=02" class="h4 author-name"><%=(String) web_inf.get(1)%><br/></a>
                            <div class="country"><%=wea.area%>,<%=wea.city%></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ... end Top Header-Profile -->
<div class="container">
    <div class="row">

        <!-- Main Content -->

        <div class="col col-xl-6 order-xl-2 col-lg-12 order-lg-1 col-md-12 col-sm-12 col-12">
            <div id="newsfeed-items-grid">


            </div>

            <a id="load-more-button" href="#" class="btn btn-control btn-more" data-load-link="items-to-load.html"
               data-container="newsfeed-items-grid">
                <svg class="olymp-three-dots-icon">
                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                </svg>
            </a>
        </div>

        <!-- ... end Main Content -->


        <!-- Left Sidebar -->

        <div class="col col-xl-3 order-xl-1 col-lg-6 order-lg-2 col-md-6 col-sm-6 col-12">

            <div class="ui-block">
                <div class="ui-block-title">
                    <h6 class="title">我的信息</h6>
                </div>
                <div class="ui-block-content">

                    <!-- W-Personal-Info -->

                    <ul class="widget w-personal-info item-block">
                        <li>
                            <span class="title">About Me:</span>
                            <span class="text">
								昵称:<%=(String) web_inf.get(1)%><br/>
								我的邮箱:<%=(String) web_inf.get(2)%><br/>
								所在院校:九江学院<br/>
								姓名:<%=(String) stu_inf.get(1)%>
							</span>
                        </li>
                        <li>
                            <span class="title">最爱的电视节目</span>
                            <span class="text">少年的你, 冰雪奇缘, 生活大爆炸.</span>
                        </li>
                        <li>
                            <span class="title">喜欢的音乐和运动</span>
                            <span class="text">音乐:My Heart Will Go On.  运动:网球 、冲浪</span>
                        </li>
                    </ul>

                    <!-- .. end W-Personal-Info -->
                    <!-- W-Socials -->

                    <div class="widget w-socials">
                        <h6 class="title">分享到这里:</h6>
                        <a href="#" class="social-item bg-facebook">
                            <i class="fab fa-facebook-f" aria-hidden="true"></i>
                            微博
                        </a>
                        <a href="#" class="social-item bg-twitter">
                            <i class="fab fa-twitter" aria-hidden="true"></i>
                            腾讯
                        </a>
                        <a href="#" class="social-item bg-dribbble">
                            <i class="fab fa-dribbble" aria-hidden="true"></i>
                            微信
                        </a>
                    </div>


                    <!-- ... end W-Socials -->
                </div>
            </div>

            <div class="ui-block">

                <div class="ui-block-title">
                    <h6 class="title">今日课表</h6>
                    <a href="#" class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>
                    </a>
                </div>


                <!-- W-Activity-Feed -->

                <ul class="widget w-activity-feed notification-list" id="cTable">
                </ul>

                <!-- .. end W-Activity-Feed -->
            </div>

            <div class="ui-block">
                <div class="ui-block-title">
                    <h6 class="title">我的播放列表</h6>
                </div>

                <!-- W-Playlist -->

                <ol class="widget w-playlist">
                    <li class="js-open-popup" data-popup-target=".playlist-popup">
                        <div class="playlist-thumb">
                            <img src="img/playlist6.jpg" alt="thumb-composition">
                            <div class="overlay"></div>
                            <a href="#" class="play-icon">
                                <svg class="olymp-music-play-icon-big">
                                    <use xlink:href="svg-icons/sprites/icons-music.svg#olymp-music-play-icon-big"></use>
                                </svg>
                            </a>
                        </div>

                        <div class="composition">
                            <a href="#" class="composition-name">The Past Starts Slow...</a>
                            <a href="#" class="composition-author">System of a Revenge</a>
                        </div>

                        <div class="composition-time">
                            <time class="published" datetime="2017-03-24T18:18">3:22</time>
                            <div class="more">
                                <svg class="olymp-three-dots-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                </svg>
                                <ul class="more-dropdown">
                                    <li>
                                        <a href="#">Add Song to Player</a>
                                    </li>
                                    <li>
                                        <a href="#">Add Playlist to Player</a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                    </li>

                    <li class="js-open-popup" data-popup-target=".playlist-popup">
                        <div class="playlist-thumb">
                            <img src="img/playlist7.jpg" alt="thumb-composition">
                            <div class="overlay"></div>
                            <a href="#" class="play-icon">
                                <svg class="olymp-music-play-icon-big">
                                    <use xlink:href="svg-icons/sprites/icons-music.svg#olymp-music-play-icon-big"></use>
                                </svg>
                            </a>
                        </div>

                        <div class="composition">
                            <a href="#" class="composition-name">The Pretender</a>
                            <a href="#" class="composition-author">Kung Fighters</a>
                        </div>

                        <div class="composition-time">
                            <time class="published" datetime="2017-03-24T18:18">5:48</time>
                            <div class="more">
                                <svg class="olymp-three-dots-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                </svg>
                                <ul class="more-dropdown">
                                    <li>
                                        <a href="#">Add Song to Player</a>
                                    </li>
                                    <li>
                                        <a href="#">Add Playlist to Player</a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                    </li>
                    <li class="js-open-popup" data-popup-target=".playlist-popup">
                        <div class="playlist-thumb">
                            <img src="img/playlist8.jpg" alt="thumb-composition">
                            <div class="overlay"></div>
                            <a href="#" class="play-icon">
                                <svg class="olymp-music-play-icon-big">
                                    <use xlink:href="svg-icons/sprites/icons-music.svg#olymp-music-play-icon-big"></use>
                                </svg>
                            </a>
                        </div>

                        <div class="composition">
                            <a href="#" class="composition-name">Blood Brothers</a>
                            <a href="#" class="composition-author">Iron Maid</a>
                        </div>

                        <div class="composition-time">
                            <time class="published" datetime="2017-03-24T18:18">3:06</time>
                            <div class="more">
                                <svg class="olymp-three-dots-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                </svg>
                                <ul class="more-dropdown">
                                    <li>
                                        <a href="#">Add Song to Player</a>
                                    </li>
                                    <li>
                                        <a href="#">Add Playlist to Player</a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                    </li>
                    <li class="js-open-popup" data-popup-target=".playlist-popup">
                        <div class="playlist-thumb">
                            <img src="img/playlist9.jpg" alt="thumb-composition">
                            <div class="overlay"></div>
                            <a href="#" class="play-icon">
                                <svg class="olymp-music-play-icon-big">
                                    <use xlink:href="svg-icons/sprites/icons-music.svg#olymp-music-play-icon-big"></use>
                                </svg>
                            </a>
                        </div>

                        <div class="composition">
                            <a href="#" class="composition-name">Seven Nation Army</a>
                            <a href="#" class="composition-author">The Black Stripes</a>
                        </div>

                        <div class="composition-time">
                            <time class="published" datetime="2017-03-24T18:18">6:17</time>
                            <div class="more">
                                <svg class="olymp-three-dots-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                </svg>
                                <ul class="more-dropdown">
                                    <li>
                                        <a href="#">Add Song to Player</a>
                                    </li>
                                    <li>
                                        <a href="#">Add Playlist to Player</a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                    </li>
                    <li class="js-open-popup" data-popup-target=".playlist-popup">
                        <div class="playlist-thumb">
                            <img src="img/playlist10.jpg" alt="thumb-composition">
                            <div class="overlay"></div>
                            <a href="#" class="play-icon">
                                <svg class="olymp-music-play-icon-big">
                                    <use xlink:href="svg-icons/sprites/icons-music.svg#olymp-music-play-icon-big"></use>
                                </svg>
                            </a>
                        </div>

                        <div class="composition">
                            <a href="#" class="composition-name">Killer Queen</a>
                            <a href="#" class="composition-author">Archiduke</a>
                        </div>

                        <div class="composition-time">
                            <time class="published" datetime="2017-03-24T18:18">5:40</time>
                            <div class="more">
                                <svg class="olymp-three-dots-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                                </svg>
                                <ul class="more-dropdown">
                                    <li>
                                        <a href="#">Add Song to Player</a>
                                    </li>
                                    <li>
                                        <a href="#">Add Playlist to Player</a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                    </li>
                </ol>

                <!-- .. end W-Playlist -->
            </div>

            <div class="ui-block">
                <div class="ui-block-title">
                    <h6 class="title">最新视频</h6>
                </div>
                <div class="ui-block-content">

                    <!-- W-Latest-Video -->

                    <ul class="widget w-last-video">
                        <li>
                            <a href="https://vimeo.com/ondemand/viewfromabluemoon4k/147865858"
                               class="play-video play-video--small">
                                <svg class="olymp-play-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-play-icon"></use>
                                </svg>
                            </a>
                            <img src="img/video8.jpg" alt="video">
                            <div class="video-content">
                                <div class="title">System of a Revenge - Hypnotize...</div>
                                <time class="published" datetime="2017-03-24T18:18">3:25</time>
                            </div>
                            <div class="overlay"></div>
                        </li>
                        <li>
                            <a href="https://youtube.com/watch?v=excVFQ2TWig" class="play-video play-video--small">
                                <svg class="olymp-play-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-play-icon"></use>
                                </svg>
                            </a>
                            <img src="img/video7.jpg" alt="video">
                            <div class="video-content">
                                <div class="title">Green Goo - Live at Dan’s Arena</div>
                                <time class="published" datetime="2017-03-24T18:18">5:48</time>
                            </div>
                            <div class="overlay"></div>
                        </li>
                    </ul>

                    <!-- .. end W-Latest-Video -->
                </div>
            </div>

        </div>

        <!-- ... end Left Sidebar -->


        <!-- Right Sidebar -->

        <div class="col col-xl-3 order-xl-3 col-lg-6 order-lg-3 col-md-6 col-sm-6 col-12">
            <div class="ui-block">
                <div class="ui-block-title">
                    <h6 class="title">天气</h6>
                </div>


                <!-- W-Weather -->

                <div class="widget w-wethear">
                    <a href="#" class="more">
                        <svg class="olymp-three-dots-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                        </svg>
                    </a>

                    <div class="wethear-now inline-items">
                        <div class="temperature-sensor"><%=wea.feel_tem%>
                        </div>
                        <div class="max-min-temperature">
                            <span><%=wea.tmp1%></span>
                            <span><%=wea.tmp2%></span>
                        </div>

                        <svg class="olymp-weather-partly-sunny-icon">
                            <use xlink:href="svg-icons/sprites/icons-weather.svg#olymp-weather-partly-sunny-icon"></use>
                        </svg>
                    </div>

                    <div class="wethear-now-description">
                        <div class="climate"><%=wea.cond%>
                        </div>
                        <span>体感温度: <span><%=wea.feel_tem%></span></span>
                        <span>降雨概率: <span>30%</span></span>
                    </div>

                    <ul class="weekly-forecast">

                        <li>
                            <div class="day">sun</div>
                            <svg class="olymp-weather-sunny-icon">
                                <use xlink:href="svg-icons/sprites/icons-weather.svg#olymp-weather-sunny-icon"></use>
                            </svg>

                            <div class="temperature-sensor-day">13°C</div>
                        </li>

                        <li>
                            <div class="day">mon</div>
                            <svg class="olymp-weather-partly-sunny-icon">
                                <use xlink:href="svg-icons/sprites/icons-weather.svg#olymp-weather-partly-sunny-icon"></use>
                            </svg>
                            <div class="temperature-sensor-day">15°</div>
                        </li>

                        <li>
                            <div class="day">tue</div>
                            <svg class="olymp-weather-cloudy-icon">
                                <use xlink:href="svg-icons/sprites/icons-weather.svg#olymp-weather-cloudy-icon"></use>
                            </svg>

                            <div class="temperature-sensor-day">14°</div>
                        </li>

                        <li>
                            <div class="day">wed</div>
                            <svg class="olymp-weather-rain-icon">
                                <use xlink:href="svg-icons/sprites/icons-weather.svg#olymp-weather-rain-icon"></use>
                            </svg>

                            <div class="temperature-sensor-day">12°</div>
                        </li>

                        <li>
                            <div class="day">thu</div>
                            <svg class="olymp-weather-storm-icon">
                                <use xlink:href="svg-icons/sprites/icons-weather.svg#olymp-weather-storm-icon"></use>
                            </svg>

                            <div class="temperature-sensor-day">10°</div>
                        </li>

                        <li>
                            <div class="day">fri</div>
                            <svg class="olymp-weather-snow-icon">
                                <use xlink:href="svg-icons/sprites/icons-weather.svg#olymp-weather-snow-icon"></use>
                            </svg>

                            <div class="temperature-sensor-day">8°</div>
                        </li>

                        <li>
                            <div class="day">sat</div>

                            <svg class="olymp-weather-wind-icon-header">
                                <use xlink:href="svg-icons/sprites/icons-weather.svg#olymp-weather-wind-icon-header"></use>
                            </svg>

                            <div class="temperature-sensor-day">11°</div>
                        </li>

                    </ul>

                    <div class="date-and-place">
                        <h5 class="date"><%=wea.week%>, <%=wea.time%>
                        </h5>
                        <div class="place"><%=wea.area%>,<%=wea.city%>
                        </div>
                    </div>

                </div>

                <!-- W-Weather -->


                <div class="ui-block">
                    <div class="ui-block-title">
                        <h6 class="title">最近照片</h6>
                    </div>
                    <div class="ui-block-content">

                        <!-- W-Latest-Photo -->

                        <ul class="widget w-last-photo js-zoom-gallery">
                            <li>
                                <a href="img/last-photo10-large.jpg">
                                    <img src="img/last-photo10-large.jpg" alt="photo">
                                </a>
                            </li>
                            <li>
                                <a href="img/last-phot11-large.jpg">
                                    <img src="img/last-phot11-large.jpg" alt="photo">
                                </a>
                            </li>
                            <li>
                                <a href="img/last-phot12-large.jpg">
                                    <img src="img/last-phot12-large.jpg" alt="photo">
                                </a>
                            </li>
                            <li>
                                <a href="img/last-phot13-large.jpg">
                                    <img src="img/last-phot13-large.jpg" alt="photo">
                                </a>
                            </li>
                            <li>
                                <a href="img/last-phot14-large.jpg">
                                    <img src="img/last-phot14-large.jpg" alt="photo">
                                </a>
                            </li>
                            <li>
                                <a href="img/last-phot15-large.jpg">
                                    <img src="img/last-phot15-large.jpg" alt="photo">
                                </a>
                            </li>
                            <li>
                                <a href="img/last-phot16-large.jpg">
                                    <img src="img/last-phot16-large.jpg" alt="photo">
                                </a>
                            </li>
                            <li>
                                <a href="img/last-phot17-large.jpg">
                                    <img src="img/last-phot17-large.jpg" alt="photo">
                                </a>
                            </li>
                            <li>
                                <a href="img/last-phot18-large.jpg">
                                    <img src="img/last-phot18-large.jpg" alt="photo">
                                </a>
                            </li>
                        </ul>


                        <!-- .. end W-Latest-Photo -->
                    </div>
                </div>

                <div class="ui-block">
                    <div class="ui-block-title">
                        <h6 class="title">帖子</h6>
                    </div>
                    <!-- W-Blog-Posts -->

                    <ul class="widget w-blog-posts">
                        <li>
                            <article class="hentry post">

                                <a href="#" class="h4">大家都买了几号的票回家呢</a>

                                <p> 买不到票了，3号考完准备4号回家</p>

                                <div class="post__date">
                                    <time class="published" datetime="2017-03-24T18:18">
                                        7 小时前
                                    </time>
                                </div>

                            </article>
                        </li>
                        <li>
                            <article class="hentry post">

                                <a href="#" class="h4">忘记了教务系统的登录密码怎么办啊啊啊啊</a>

                                <p>我可以把我的密码告诉你.</p>

                                <div class="post__date">
                                    <time class="published" datetime="2017-03-24T18:18">
                                        11月18日, 傍晚 6:52pm
                                    </time>
                                </div>

                            </article>
                        </li>
                    </ul>

                    <!-- .. end W-Blog-Posts -->
                </div>

                <div class="ui-block">
                    <div class="ui-block-title">
                        <h6 class="title">朋友(+86)</h6>
                    </div>
                    <div class="ui-block-content">

                        <!-- W-Faved-Page -->

                        <ul class="widget w-faved-page js-zoom-gallery">
                            <li>
                                <a href="#">
                                    <img src="img/avatar38-sm.jpg" alt="author">
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <img src="img/avatar24-sm.jpg" alt="user">
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <img src="img/avatar36-sm.jpg" alt="author">
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <img src="img/avatar35-sm.jpg" alt="user">
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <img src="img/avatar34-sm.jpg" alt="author">
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <img src="img/avatar33-sm.jpg" alt="author">
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <img src="img/avatar32-sm.jpg" alt="user">
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <img src="img/avatar31-sm.jpg" alt="author">
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <img src="img/avatar30-sm.jpg" alt="author">
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <img src="img/avatar29-sm.jpg" alt="user">
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <img src="img/avatar28-sm.jpg" alt="user">
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <img src="img/avatar27-sm.jpg" alt="user">
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <img src="img/avatar26-sm.jpg" alt="user">
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <img src="img/avatar25-sm.jpg" alt="user">
                                </a>
                            </li>
                            <li class="all-users">
                                <a href="#">+74</a>
                            </li>
                        </ul>

                        <!-- .. end W-Faved-Page -->
                    </div>
                </div>


                <div class="ui-block">
                    <div class="ui-block-title">
                        <h6 class="title">投票活动</h6>
                    </div>
                    <div class="ui-block-content">

                        <!-- W-Pool -->

                        <ul class="widget w-pool">
                            <li>
                                <p>给你这个周末活动想去的地点投票 </p>
                            </li>
                            <li>
                                <div class="skills-item">
                                    <div class="skills-item-info">
									<span class="skills-item-title">
										<span class="radio">
											<label>
												<input type="radio" name="optionsRadios">
												奶牛场
											</label>
										</span>
									</span>
                                        <span class="skills-item-count">
										<span class="count-animate" data-speed="1000" data-refresh-interval="50"
                                              data-to="62" data-from="0"></span>
										<span class="units">62%</span>
									</span>
                                    </div>
                                    <div class="skills-item-meter">
                                        <span class="skills-item-meter-active bg-primary" style="width: 62%"></span>
                                    </div>

                                    <div class="counter-friends">12个朋友投票了</div>

                                    <ul class="friends-harmonic">
                                        <li>
                                            <a href="#">
                                                <img src="img/friend-harmonic1.jpg" alt="friend">
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <img src="img/friend-harmonic2.jpg" alt="friend">
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <img src="img/friend-harmonic3.jpg" alt="friend">
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <img src="img/friend-harmonic4.jpg" alt="friend">
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <img src="img/friend-harmonic5.jpg" alt="friend">
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <img src="img/friend-harmonic6.jpg" alt="friend">
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <img src="img/friend-harmonic7.jpg" alt="friend">
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <img src="img/friend-harmonic8.jpg" alt="friend">
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <img src="img/friend-harmonic9.jpg" alt="friend">
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#" class="all-users">+3</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>

                            <li>
                                <div class="skills-item">
                                    <div class="skills-item-info">
									<span class="skills-item-title">
										<span class="radio">
											<label>
												<input type="radio" name="optionsRadios">
												敬老院
											</label>
										</span>
									</span>
                                        <span class="skills-item-count">
										<span class="count-animate" data-speed="1000" data-refresh-interval="50"
                                              data-to="27" data-from="0"></span>
										<span class="units">27%</span>
									</span>
                                    </div>
                                    <div class="skills-item-meter">
                                        <span class="skills-item-meter-active bg-primary" style="width: 27%"></span>
                                    </div>
                                    <div class="counter-friends">7个朋友投票了</div>

                                    <ul class="friends-harmonic">
                                        <li>
                                            <a href="#">
                                                <img src="img/friend-harmonic7.jpg" alt="friend">
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <img src="img/friend-harmonic8.jpg" alt="friend">
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <img src="img/friend-harmonic9.jpg" alt="friend">
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <img src="img/friend-harmonic10.jpg" alt="friend">
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <img src="img/friend-harmonic11.jpg" alt="friend">
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <img src="img/friend-harmonic12.jpg" alt="friend">
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <img src="img/friend-harmonic13.jpg" alt="friend">
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>

                            <li>
                                <div class="skills-item">
                                    <div class="skills-item-info">
									<span class="skills-item-title">
										<span class="radio">
											<label>
												<input type="radio" name="optionsRadios">
												市运动馆
											</label>
										</span>
									</span>
                                        <span class="skills-item-count">
										<span class="count-animate" data-speed="1000" data-refresh-interval="50"
                                              data-to="11" data-from="0"></span>
										<span class="units">11%</span>
									</span>
                                    </div>
                                    <div class="skills-item-meter">
                                        <span class="skills-item-meter-active bg-primary" style="width: 11%"></span>
                                    </div>

                                    <div class="counter-friends">2个朋友投票了</div>

                                    <ul class="friends-harmonic">
                                        <li>
                                            <a href="#">
                                                <img src="img/friend-harmonic14.jpg" alt="friend">
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <img src="img/friend-harmonic15.jpg" alt="friend">
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                        </ul>

                        <!-- .. end W-Pool -->
                        <a href="#" class="btn btn-md-2 btn-border-think custom-color c-grey full-width">Vote Now!</a>
                    </div>
                </div>

            </div>

            <!-- ... end Right Sidebar -->

        </div>
    </div>
    <input type="file" name="what" id="filess" style="opacity: 0"/>
    <!-- Window-popup update Header Photo -->

    <div class="modal fade" id="update-header-photo" tabindex="-1" role="dialog" aria-labelledby="update-header-photo"
         aria-hidden="true">
        <div class="modal-dialog window-popup update-header-photo" role="document">
            <div class="modal-content">
                <a href="#" class="close icon-close" data-dismiss="modal" aria-label="Close">
                    <svg class="olymp-close-icon">
                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use>
                    </svg>
                </a>

                <div class="modal-header">
                    <h6 class="title">Update Header Photo</h6>
                </div>

                <div class="modal-body">
                    <a href="javascript:void(0);" onclick="loadpic()" class="upload-photo-item">
                        <svg class="olymp-computer-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-computer-icon"></use>
                        </svg>
                        <h6>Upload Photo</h6>
                        <span>Browse your computer.</span>
                    </a>

                    <a href="#" class="upload-photo-item" data-toggle="modal" data-target="#choose-from-my-photo">

                        <svg class="olymp-photos-icon">
                            <use xlink:href="svg-icons/sprites/icons.svg#olymp-photos-icon"></use>
                        </svg>

                        <h6>Choose from My Photos</h6>
                        <span>Choose from your uploaded photos</span>
                    </a>
                </div>
            </div>
        </div>
    </div>


    <!-- ... end Window-popup update Header Photo -->

    <!-- Window-popup Choose from my Photo -->

    <div class="modal fade" id="choose-from-my-photo" tabindex="-1" role="dialog" aria-labelledby="choose-from-my-photo"
         aria-hidden="true">
        <div class="modal-dialog window-popup choose-from-my-photo" role="document">

            <div class="modal-content">
                <a href="#" class="close icon-close" data-dismiss="modal" aria-label="Close">
                    <svg class="olymp-close-icon">
                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use>
                    </svg>
                </a>
                <div class="modal-header">
                    <h6 class="title">Choose from My Photos</h6>

                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#home" role="tab" aria-expanded="true">
                                <svg class="olymp-photos-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-photos-icon"></use>
                                </svg>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#profile" role="tab" aria-expanded="false">
                                <svg class="olymp-albums-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-albums-icon"></use>
                                </svg>
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="modal-body">
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" id="home" role="tabpanel" aria-expanded="true">

                            <div class="choose-photo-item" data-mh="choose-item">
                                <div class="radio">
                                    <label class="custom-radio">
                                        <img src="img/choose-photo1.jpg" alt="photo">
                                        <input type="radio" name="optionsRadios" value="img/choose-photo1.jpg">
                                    </label>
                                </div>
                            </div>
                            <div class="choose-photo-item" data-mh="choose-item">
                                <div class="radio">
                                    <label class="custom-radio">
                                        <img src="img/choose-photo2.jpg" alt="photo">
                                        <input type="radio" name="optionsRadios" value="img/top-header1.jpg">
                                    </label>
                                </div>
                            </div>
                            <div class="choose-photo-item" data-mh="choose-item">
                                <div class="radio">
                                    <label class="custom-radio">
                                        <img src="img/choose-photo3.jpg" alt="photo">
                                        <input type="radio" name="optionsRadios" value="img/choose-photo3.jpg">
                                    </label>
                                </div>
                            </div>

                            <div class="choose-photo-item" data-mh="choose-item">
                                <div class="radio">
                                    <label class="custom-radio">
                                        <img src="img/top-headermin2.jpg" alt="photo">
                                        <input type="radio" name="optionsRadios" style="display: none;"
                                               value="img/top-header2.jpg">
                                    </label>
                                </div>
                            </div>
                            <div class="choose-photo-item" data-mh="choose-item">
                                <div class="radio">
                                    <label class="custom-radio">
                                        <img src="img/choose-photo5.jpg" alt="photo">
                                        <input type="radio" name="optionsRadios" value="img/choose-photo5.jpg">
                                    </label>
                                </div>
                            </div>
                            <div class="choose-photo-item" data-mh="choose-item">
                                <div class="radio">
                                    <label class="custom-radio">
                                        <img src="img/choose-photo6.jpg" alt="photo">
                                        <input type="radio" name="optionsRadios" value="img/choose-photo6.jpg">
                                    </label>
                                </div>
                            </div>

                            <div class="choose-photo-item" data-mh="choose-item">
                                <div class="radio">
                                    <label class="custom-radio">
                                        <img src="img/choose-photo7.jpg" alt="photo">
                                        <input type="radio" name="optionsRadios" value="img/choose-photo7.jpg">
                                    </label>
                                </div>
                            </div>
                            <div class="choose-photo-item" data-mh="choose-item">
                                <div class="radio">
                                    <label class="custom-radio">
                                        <img src="img/choose-photo8.jpg" alt="photo">
                                        <input type="radio" name="optionsRadios" value="img/choose-photo8.jpg">
                                    </label>
                                </div>
                            </div>
                            <div class="choose-photo-item" data-mh="choose-item">
                                <div class="radio">
                                    <label class="custom-radio">
                                        <img src="img/choose-photo9.jpg" alt="photo">
                                        <input type="radio" name="optionsRadios" value="img/choose-photo9.jpg">
                                    </label>
                                </div>
                            </div>


                            <a href="#" class="btn btn-secondary btn-lg btn--half-width">Cancel</a>
                            <a href="javascript:void(0);" onclick="RidoChoose()"
                               class="btn btn-primary btn-lg btn--half-width">Confirm Photo</a>

                        </div>
                        <div class="tab-pane" id="profile" role="tabpanel" aria-expanded="false">

                            <div class="choose-photo-item" data-mh="choose-item">
                                <figure>
                                    <img src="img/choose-photo10.jpg" alt="photo">
                                    <figcaption>
                                        <a href="#">South America Vacations</a>
                                        <span>Last Added: 2 hours ago</span>
                                    </figcaption>
                                </figure>
                            </div>
                            <div class="choose-photo-item" data-mh="choose-item">
                                <figure>
                                    <img src="img/choose-photo11.jpg" alt="photo">
                                    <figcaption>
                                        <a href="#">Photoshoot Summer 2016</a>
                                        <span>Last Added: 5 weeks ago</span>
                                    </figcaption>
                                </figure>
                            </div>
                            <div class="choose-photo-item" data-mh="choose-item">
                                <figure>
                                    <img src="img/choose-photo12.jpg" alt="photo">
                                    <figcaption>
                                        <a href="#">Amazing Street Food</a>
                                        <span>Last Added: 6 mins ago</span>
                                    </figcaption>
                                </figure>
                            </div>

                            <div class="choose-photo-item" data-mh="choose-item">
                                <figure>
                                    <img src="img/choose-photo13.jpg" alt="photo">
                                    <figcaption>
                                        <a href="#">Graffity & Street Art</a>
                                        <span>Last Added: 16 hours ago</span>
                                    </figcaption>
                                </figure>
                            </div>
                            <div class="choose-photo-item" data-mh="choose-item">
                                <figure>
                                    <img src="img/choose-photo14.jpg" alt="photo">
                                    <figcaption>
                                        <a href="#">Amazing Landscapes</a>
                                        <span>Last Added: 13 mins ago</span>
                                    </figcaption>
                                </figure>
                            </div>
                            <div class="choose-photo-item" data-mh="choose-item">
                                <figure>
                                    <img src="img/choose-photo15.jpg" alt="photo">
                                    <figcaption>
                                        <a href="#">The Majestic Canyon</a>
                                        <span>Last Added: 57 mins ago</span>
                                    </figcaption>
                                </figure>
                            </div>


                            <a href="#" class="btn btn-secondary btn-lg btn--half-width">Cancel</a>
                            <a href="#" class="btn btn-primary btn-lg disabled btn--half-width">Confirm Photo</a>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- ... end Window-popup Choose from my Photo -->

    <!-- Playlist Popup -->

    <div class="window-popup playlist-popup" tabindex="-1" role="dialog" aria-labelledby="playlist-popup"
         aria-hidden="true">

        <a href="" class="icon-close js-close-popup">
            <svg class="olymp-close-icon">
                <use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use>
            </svg>
        </a>

        <div class="mCustomScrollbar">
            <table class="playlist-popup-table">

                <thead>

                <tr>

                    <th class="play">
                        PLAY
                    </th>

                    <th class="cover">
                        COVER
                    </th>

                    <th class="song-artist">
                        SONG AND ARTIST
                    </th>

                    <th class="album">
                        ALBUM
                    </th>

                    <th class="released">
                        RELEASED
                    </th>

                    <th class="duration">
                        DURATION
                    </th>

                    <th class="spotify">
                        GET IT ON SPOTIFY
                    </th>

                    <th class="remove">
                        REMOVE
                    </th>
                </tr>

                </thead>

                <tbody>
                <tr>
                    <td class="play">
                        <a href="#" class="play-icon">
                            <svg class="olymp-music-play-icon-big">
                                <use xlink:href="svg-icons/sprites/icons-music.svg#olymp-music-play-icon-big"></use>
                            </svg>
                        </a>
                    </td>
                    <td class="cover">
                        <div class="playlist-thumb">
                            <img src="img/playlist19.jpg" alt="thumb-composition">
                        </div>
                    </td>
                    <td class="song-artist">
                        <div class="composition">
                            <a href="#" class="composition-name">We Can Be Heroes</a>
                            <a href="#" class="composition-author">Jason Bowie</a>
                        </div>
                    </td>
                    <td class="album">
                        <a href="#" class="album-composition">Ziggy Firedust</a>
                    </td>
                    <td class="released">
                        <div class="release-year">2014</div>
                    </td>
                    <td class="duration">
                        <div class="composition-time">
                            <time class="published" datetime="2017-03-24T18:18">6:17</time>
                        </div>
                    </td>
                    <td class="spotify">
                        <i class="fab fa-spotify composition-icon" aria-hidden="true"></i>
                    </td>
                    <td class="remove">
                        <a href="#" class="remove-icon">
                            <svg class="olymp-close-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use>
                            </svg>
                        </a>
                    </td>
                </tr>

                <tr>
                    <td class="play">
                        <a href="#" class="play-icon">
                            <svg class="olymp-music-play-icon-big">
                                <use xlink:href="svg-icons/sprites/icons-music.svg#olymp-music-play-icon-big"></use>
                            </svg>
                        </a>
                    </td>
                    <td class="cover">
                        <div class="playlist-thumb">
                            <img src="img/playlist6.jpg" alt="thumb-composition">
                        </div>
                    </td>
                    <td class="song-artist">
                        <div class="composition">
                            <a href="#" class="composition-name">The Past Starts Slow and Ends</a>
                            <a href="#" class="composition-author">System of a Revenge</a>
                        </div>
                    </td>
                    <td class="album">
                        <a href="#" class="album-composition">Wonderize</a>
                    </td>
                    <td class="released">
                        <div class="release-year">2014</div>
                    </td>
                    <td class="duration">
                        <div class="composition-time">
                            <time class="published" datetime="2017-03-24T18:18">6:17</time>
                        </div>
                    </td>
                    <td class="spotify">
                        <i class="fab fa-spotify composition-icon" aria-hidden="true"></i>
                    </td>
                    <td class="remove">
                        <a href="#" class="remove-icon">
                            <svg class="olymp-close-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use>
                            </svg>
                        </a>
                    </td>
                </tr>

                <tr>
                    <td class="play">
                        <a href="#" class="play-icon">
                            <svg class="olymp-music-play-icon-big">
                                <use xlink:href="svg-icons/sprites/icons-music.svg#olymp-music-play-icon-big"></use>
                            </svg>
                        </a>
                    </td>
                    <td class="cover">
                        <div class="playlist-thumb">
                            <img src="img/playlist7.jpg" alt="thumb-composition">
                        </div>
                    </td>
                    <td class="song-artist">
                        <div class="composition">
                            <a href="#" class="composition-name">The Pretender</a>
                            <a href="#" class="composition-author">Kung Fighters</a>
                        </div>
                    </td>
                    <td class="album">
                        <a href="#" class="album-composition">Warping Lights</a>
                    </td>
                    <td class="released">
                        <div class="release-year">2014</div>
                    </td>
                    <td class="duration">
                        <div class="composition-time">
                            <time class="published" datetime="2017-03-24T18:18">6:17</time>
                        </div>
                    </td>
                    <td class="spotify">
                        <i class="fab fa-spotify composition-icon" aria-hidden="true"></i>
                    </td>
                    <td class="remove">
                        <a href="#" class="remove-icon">
                            <svg class="olymp-close-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use>
                            </svg>
                        </a>
                    </td>
                </tr>

                <tr>
                    <td class="play">
                        <a href="#" class="play-icon">
                            <svg class="olymp-music-play-icon-big">
                                <use xlink:href="svg-icons/sprites/icons-music.svg#olymp-music-play-icon-big"></use>
                            </svg>
                        </a>
                    </td>
                    <td class="cover">
                        <div class="playlist-thumb">
                            <img src="img/playlist8.jpg" alt="thumb-composition">
                        </div>
                    </td>
                    <td class="song-artist">
                        <div class="composition">
                            <a href="#" class="composition-name">Seven Nation Army</a>
                            <a href="#" class="composition-author">The Black Stripes</a>
                        </div>
                    </td>
                    <td class="album">
                        <a href="#" class="album-composition ">Icky Strung (LIVE at Cube Garden)</a>
                    </td>
                    <td class="released">
                        <div class="release-year">2014</div>
                    </td>
                    <td class="duration">
                        <div class="composition-time">
                            <time class="published" datetime="2017-03-24T18:18">6:17</time>
                        </div>
                    </td>
                    <td class="spotify">
                        <i class="fab fa-spotify composition-icon" aria-hidden="true"></i>
                    </td>
                    <td class="remove">
                        <a href="#" class="remove-icon">
                            <svg class="olymp-close-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use>
                            </svg>
                        </a>
                    </td>
                </tr>

                <tr>
                    <td class="play">
                        <a href="#" class="play-icon">
                            <svg class="olymp-music-play-icon-big">
                                <use xlink:href="svg-icons/sprites/icons-music.svg#olymp-music-play-icon-big"></use>
                            </svg>
                        </a>
                    </td>
                    <td class="cover">
                        <div class="playlist-thumb">
                            <img src="img/playlist9.jpg" alt="thumb-composition">
                        </div>
                    </td>
                    <td class="song-artist">
                        <div class="composition">
                            <a href="#" class="composition-name">Leap of Faith</a>
                            <a href="#" class="composition-author">Eden Artifact</a>
                        </div>
                    </td>
                    <td class="album">
                        <a href="#" class="album-composition">The Assassins’s Soundtrack</a>
                    </td>
                    <td class="released">
                        <div class="release-year">2014</div>
                    </td>
                    <td class="duration">
                        <div class="composition-time">
                            <time class="published" datetime="2017-03-24T18:18">6:17</time>
                        </div>
                    </td>
                    <td class="spotify">
                        <i class="fab fa-spotify composition-icon" aria-hidden="true"></i>
                    </td>
                    <td class="remove">
                        <a href="#" class="remove-icon">
                            <svg class="olymp-close-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use>
                            </svg>
                        </a>
                    </td>
                </tr>

                <tr>
                    <td class="play">
                        <a href="#" class="play-icon">
                            <svg class="olymp-music-play-icon-big">
                                <use xlink:href="svg-icons/sprites/icons-music.svg#olymp-music-play-icon-big"></use>
                            </svg>
                        </a>
                    </td>
                    <td class="cover">
                        <div class="playlist-thumb">
                            <img src="img/playlist10.jpg" alt="thumb-composition">
                        </div>
                    </td>
                    <td class="song-artist">
                        <div class="composition">
                            <a href="#" class="composition-name">Killer Queen</a>
                            <a href="#" class="composition-author">Archiduke</a>
                        </div>
                    </td>
                    <td class="album">
                        <a href="#" class="album-composition ">News of the Universe</a>
                    </td>
                    <td class="released">
                        <div class="release-year">2014</div>
                    </td>
                    <td class="duration">
                        <div class="composition-time">
                            <time class="published" datetime="2017-03-24T18:18">6:17</time>
                        </div>
                    </td>
                    <td class="spotify">
                        <i class="fab fa-spotify composition-icon" aria-hidden="true"></i>
                    </td>
                    <td class="remove">
                        <a href="#" class="remove-icon">
                            <svg class="olymp-close-icon">
                                <use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use>
                            </svg>
                        </a>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <audio id="mediaplayer" data-showplaylist="true">
            <source src="mp3/Twice.mp3" title="Track 1" data-poster="track1.png" type="audio/mpeg">
            <source src="mp3/Twice.mp3" title="Track 2" data-poster="track2.png" type="audio/mpeg">
            <source src="mp3/Twice.mp3" title="Track 3" data-poster="track3.png" type="audio/mpeg">
            <source src="mp3/Twice.mp3" title="Track 4" data-poster="track4.png" type="audio/mpeg">
        </audio>

    </div>

    <!-- ... end Playlist Popup -->


    <a class="back-to-top" href="#">
        <img src="svg-icons/back-to-top.svg" alt="arrow" class="back-icon">
    </a>


    <!-- Window-popup-CHAT for responsive min-width: 768px -->

    <div class="ui-block popup-chat popup-chat-responsive" tabindex="-1" role="dialog"
         aria-labelledby="popup-chat-responsive" aria-hidden="true">

        <div class="modal-content">
            <div class="modal-header">
                <span class="icon-status online"></span>
                <h6 class="title">聊天</h6>
                <div class="more">
                    <svg class="olymp-three-dots-icon">
                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use>
                    </svg>
                    <svg class="olymp-little-delete js-chat-open">
                        <use xlink:href="svg-icons/sprites/icons.svg#olymp-little-delete"></use>
                    </svg>
                </div>
            </div>
            <div class="modal-body">
                <div class="mCustomScrollbar">
                    <ul class="notification-list chat-message chat-message-field">
                        <li>
                            <div class="author-thumb">
                                <img src="img/avatar14-sm.jpg" alt="author" class="mCS_img_loaded">
                            </div>
                            <div class="notification-event">
                                <span class="chat-message-item">Hi James! Please remember to buy the food for tomorrow! I’m gonna be handling the gifts and Jake’s gonna get the drinks</span>
                                <span class="notification-date"><time class="entry-date updated"
                                                                      datetime="2004-07-24T18:18">Yesterday at 8:10pm</time></span>
                            </div>
                        </li>

                        <li>
                            <div class="author-thumb">
                                <img src="img/author-page.jpg" alt="author" class="mCS_img_loaded">
                            </div>
                            <div class="notification-event">
                                <span class="chat-message-item">Don’t worry Mathilda!</span>
                                <span class="chat-message-item">I already bought everything</span>
                                <span class="notification-date"><time class="entry-date updated"
                                                                      datetime="2004-07-24T18:18">Yesterday at 8:29pm</time></span>
                            </div>
                        </li>

                        <li>
                            <div class="author-thumb">
                                <img src="img/avatar14-sm.jpg" alt="author" class="mCS_img_loaded">
                            </div>
                            <div class="notification-event">
                                <span class="chat-message-item">Hi James! Please remember to buy the food for tomorrow! I’m gonna be handling the gifts and Jake’s gonna get the drinks</span>
                                <span class="notification-date"><time class="entry-date updated"
                                                                      datetime="2004-07-24T18:18">Yesterday at 8:10pm</time></span>
                            </div>
                        </li>
                    </ul>
                </div>

                <form class="need-validation">

                    <div class="form-group label-floating is-empty">
                        <label class="control-label">Press enter to post...</label>
                        <textarea class="form-control" placeholder=""></textarea>
                        <div class="add-options-message">
                            <a href="#" class="options-message">
                                <svg class="olymp-computer-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-computer-icon"></use>
                                </svg>
                            </a>
                            <div class="options-message smile-block">

                                <svg class="olymp-happy-sticker-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-happy-sticker-icon"></use>
                                </svg>

                                <ul class="more-dropdown more-with-triangle triangle-bottom-right">
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat1.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat2.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat3.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat4.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat5.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat6.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat7.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat8.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat9.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat10.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat11.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat12.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat13.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat14.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat15.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat16.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat17.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat18.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat19.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat20.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat21.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat22.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat23.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat24.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat25.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat26.png" alt="icon">
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <img src="img/icon-chat27.png" alt="icon">
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                </form>
            </div>
        </div>

    </div>

    <!-- ... end Window-popup-CHAT for responsive min-width: 768px -->


    <!-- JS Scripts -->
    <script src="js/jQuery/jquery-3.4.1.js"></script>
    <script src="js/libs/jquery.appear.js"></script>
    <script src="js/libs/jquery.mousewheel.js"></script>
    <script src="js/libs/perfect-scrollbar.js"></script>
    <script src="js/libs/jquery.matchHeight.js"></script>
    <script src="js/libs/svgxuse.js"></script>
    <script src="js/libs/imagesloaded.pkgd.js"></script>
    <script src="js/libs/Headroom.js"></script>
    <script src="js/libs/velocity.js"></script>
    <script src="js/libs/ScrollMagic.js"></script>
    <script src="js/libs/jquery.waypoints.js"></script>
    <script src="js/libs/jquery.countTo.js"></script>
    <script src="js/libs/popper.min.js"></script>
    <script src="js/libs/material.min.js"></script>
    <script src="js/libs/bootstrap-select.js"></script>
    <script src="js/libs/smooth-scroll.js"></script>
    <script src="js/libs/selectize.js"></script>
    <script src="js/libs/swiper.jquery.js"></script>
    <script src="js/libs/moment.js"></script>
    <script src="js/libs/daterangepicker.js"></script>
    <script src="js/libs/fullcalendar.js"></script>
    <script src="js/libs/isotope.pkgd.js"></script>
    <script src="js/libs/ajax-pagination.js"></script>
    <script src="js/libs/Chart.js"></script>
    <script src="js/libs/chartjs-plugin-deferred.js"></script>
    <script src="js/libs/circle-progress.js"></script>
    <script src="js/libs/loader.js"></script>
    <script src="js/libs/run-chart.js"></script>
    <script src="js/libs/jquery.magnific-popup.js"></script>
    <script src="js/libs/jquery.gifplayer.js"></script>
    <script src="js/libs/mediaelement-and-player.js"></script>
    <script src="js/libs/mediaelement-playlist-plugin.min.js"></script>
    <script src="js/libs/sticky-sidebar.js"></script>
    <script src="js/libs/ion.rangeSlider.js"></script>

    <script src="js/main.js"></script>
    <script src="js/libs-init/libs-init.js"></script>
    <script defer src="fonts/fontawesome-all.js"></script>

    <script src="Bootstrap/dist/js/bootstrap.bundle.js"></script>

</body>
</html>