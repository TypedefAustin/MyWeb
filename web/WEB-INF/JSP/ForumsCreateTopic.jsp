<%@ page import="WebPest.Databases.infomationBaseDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="WebPest.Databases.searchAccountDAO" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019-12-19
  Time: 18:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("IsLogin") == null) {
        request.getRequestDispatcher("/WebContent/do#svolet").forward(request, response);
    }
    infomationBaseDAO inf1 = new infomationBaseDAO();
    ArrayList web_inf = inf1.WebInf((String) session.getAttribute("IsLogin"));
    ArrayList stu_inf = inf1.StuInf((String) web_inf.get(0));
    searchAccountDAO User = new searchAccountDAO();
    User.searchUID((String) web_inf.get(2));
    session.setAttribute("Account",web_inf.get(2));
%>

<!DOCTYPE html>
<html lang="en">
<head>

    <title>Forums - Create Topic</title>

    <!-- Required meta tags always come first -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="Bootstrap/dist/css/bootstrap-reboot.css">
    <link rel="stylesheet" type="text/css" href="Bootstrap/dist/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="Bootstrap/dist/css/bootstrap-grid.css">

    <!-- Main Styles CSS -->
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="css/fonts.min.css">

    <!-- Main Font -->
    <script src="js/libs/webfontloader.min.js"></script>
    <script>
        WebFont.load({
            google: {
                families: ['Roboto:300,400,500,700:latin']
            }
        });
    </script>

</head>

<body class="page-has-left-panels page-has-right-panels">


<!-- Preloader -->

<div id="hellopreloader">
    <div class="preloader">
        <svg width="45" height="45" stroke="#fff">
            <g fill="none" fill-rule="evenodd" stroke-width="2" transform="translate(1 1)">
                <circle cx="22" cy="22" r="6" stroke="none">
                    <animate attributeName="r" begin="1.5s" calcMode="linear" dur="3s" repeatCount="indefinite" values="6;22"/>
                    <animate attributeName="stroke-opacity" begin="1.5s" calcMode="linear" dur="3s" repeatCount="indefinite" values="1;0"/>
                    <animate attributeName="stroke-width" begin="1.5s" calcMode="linear" dur="3s" repeatCount="indefinite" values="2;0"/>
                </circle>
                <circle cx="22" cy="22" r="6" stroke="none">
                    <animate attributeName="r" begin="3s" calcMode="linear" dur="3s" repeatCount="indefinite" values="6;22"/>
                    <animate attributeName="stroke-opacity" begin="3s" calcMode="linear" dur="3s" repeatCount="indefinite" values="1;0"/>
                    <animate attributeName="stroke-width" begin="3s" calcMode="linear" dur="3s" repeatCount="indefinite" values="2;0"/>
                </circle>
                <circle cx="22" cy="22" r="8">
                    <animate attributeName="r" begin="0s" calcMode="linear" dur="1.5s" repeatCount="indefinite" values="6;1;2;3;4;5;6"/>
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

        <a href="02-ProfilePage.html" class="logo">
            <div class="img-wrap">
                <img src="img/logo.png" alt="Olympus">
            </div>
        </a>

        <div class="mCustomScrollbar" data-mcs-theme="dark">
            <ul class="left-menu">
                <li>
                    <a href="#" class="js-sidebar-open">
                        <svg class="olymp-menu-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="OPEN MENU"><use xlink:href="svg-icons/sprites/icons.svg#olymp-menu-icon"></use></svg>
                    </a>
                </li>
                <li>
                    <a href="03-Newsfeed.html">
                        <svg class="olymp-newsfeed-icon left-menu-icon" data-toggle="tooltip" data-placement="right"   data-original-title="NEWSFEED"><use xlink:href="svg-icons/sprites/icons.svg#olymp-newsfeed-icon"></use></svg>
                    </a>
                </li>
                <li>
                    <a href="16-FavPagesFeed.html">
                        <svg class="olymp-star-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="FAV PAGE"><use xlink:href="svg-icons/sprites/icons.svg#olymp-star-icon"></use></svg>
                    </a>
                </li>
                <li>
                    <a href="17-FriendGroups.html">
                        <svg class="olymp-happy-faces-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="FRIEND GROUPS"><use xlink:href="svg-icons/sprites/icons.svg#olymp-happy-faces-icon"></use></svg>
                    </a>
                </li>
                <li>
                    <a href="18-MusicAndPlaylists.html">
                        <svg class="olymp-headphones-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="MUSIC&PLAYLISTS"><use xlink:href="svg-icons/sprites/icons.svg#olymp-headphones-icon"></use></svg>
                    </a>
                </li>
                <li>
                    <a href="19-WeatherWidget.html">
                        <svg class="olymp-weather-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="WEATHER APP"><use xlink:href="svg-icons/sprites/icons.svg#olymp-weather-icon"></use></svg>
                    </a>
                </li>
                <li>
                    <a href="20-CalendarAndEvents-MonthlyCalendar.html">
                        <svg class="olymp-calendar-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="CALENDAR AND EVENTS"><use xlink:href="svg-icons/sprites/icons.svg#olymp-calendar-icon"></use></svg>
                    </a>
                </li>
                <li>
                    <a href="24-CommunityBadges.html">
                        <svg class="olymp-badge-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="Community Badges"><use xlink:href="svg-icons/sprites/icons.svg#olymp-badge-icon"></use></svg>
                    </a>
                </li>
                <li>
                    <a href="25-FriendsBirthday.html">
                        <svg class="olymp-cupcake-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="Friends Birthdays"><use xlink:href="svg-icons/sprites/icons.svg#olymp-cupcake-icon"></use></svg>
                    </a>
                </li>
                <li>
                    <a href="26-Statistics.html">
                        <svg class="olymp-stats-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="Account Stats"><use xlink:href="svg-icons/sprites/icons.svg#olymp-stats-icon"></use></svg>
                    </a>
                </li>
                <li>
                    <a href="27-ManageWidgets.html">
                        <svg class="olymp-manage-widgets-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="Manage Widgets"><use xlink:href="svg-icons/sprites/icons.svg#olymp-manage-widgets-icon"></use></svg>
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
                        <svg class="olymp-close-icon left-menu-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use></svg>
                        <span class="left-menu-title">Collapse Menu</span>
                    </a>
                </li>
                <li>
                    <a href="03-Newsfeed.html">
                        <svg class="olymp-newsfeed-icon left-menu-icon" data-toggle="tooltip" data-placement="right"   data-original-title="NEWSFEED"><use xlink:href="svg-icons/sprites/icons.svg#olymp-newsfeed-icon"></use></svg>
                        <span class="left-menu-title">Newsfeed</span>
                    </a>
                </li>
                <li>
                    <a href="16-FavPagesFeed.html">
                        <svg class="olymp-star-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="FAV PAGE"><use xlink:href="svg-icons/sprites/icons.svg#olymp-star-icon"></use></svg>
                        <span class="left-menu-title">Fav Pages Feed</span>
                    </a>
                </li>
                <li>
                    <a href="17-FriendGroups.html">
                        <svg class="olymp-happy-faces-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="FRIEND GROUPS"><use xlink:href="svg-icons/sprites/icons.svg#olymp-happy-faces-icon"></use></svg>
                        <span class="left-menu-title">Friend Groups</span>
                    </a>
                </li>
                <li>
                    <a href="18-MusicAndPlaylists.html">
                        <svg class="olymp-headphones-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="MUSIC&PLAYLISTS"><use xlink:href="svg-icons/sprites/icons.svg#olymp-headphones-icon"></use></svg>
                        <span class="left-menu-title">Music & Playlists</span>
                    </a>
                </li>
                <li>
                    <a href="19-WeatherWidget.html">
                        <svg class="olymp-weather-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="WEATHER APP"><use xlink:href="svg-icons/sprites/icons.svg#olymp-weather-icon"></use></svg>
                        <span class="left-menu-title">Weather App</span>
                    </a>
                </li>
                <li>
                    <a href="20-CalendarAndEvents-MonthlyCalendar.html">
                        <svg class="olymp-calendar-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="CALENDAR AND EVENTS"><use xlink:href="svg-icons/sprites/icons.svg#olymp-calendar-icon"></use></svg>
                        <span class="left-menu-title">Calendar and Events</span>
                    </a>
                </li>
                <li>
                    <a href="24-CommunityBadges.html">
                        <svg class="olymp-badge-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="Community Badges"><use xlink:href="svg-icons/sprites/icons.svg#olymp-badge-icon"></use></svg>
                        <span class="left-menu-title">Community Badges</span>
                    </a>
                </li>
                <li>
                    <a href="25-FriendsBirthday.html">
                        <svg class="olymp-cupcake-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="Friends Birthdays"><use xlink:href="svg-icons/sprites/icons.svg#olymp-cupcake-icon"></use></svg>
                        <span class="left-menu-title">Friends Birthdays</span>
                    </a>
                </li>
                <li>
                    <a href="26-Statistics.html">
                        <svg class="olymp-stats-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="Account Stats"><use xlink:href="svg-icons/sprites/icons.svg#olymp-stats-icon"></use></svg>
                        <span class="left-menu-title">Account Stats</span>
                    </a>
                </li>
                <li>
                    <a href="27-ManageWidgets.html">
                        <svg class="olymp-manage-widgets-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="Manage Widgets"><use xlink:href="svg-icons/sprites/icons.svg#olymp-manage-widgets-icon"></use></svg>
                        <span class="left-menu-title">Manage Widgets</span>
                    </a>
                </li>
            </ul>

            <div class="profile-completion">

                <div class="skills-item">
                    <div class="skills-item-info">
                        <span class="skills-item-title">Profile Completion</span>
                        <span class="skills-item-count"><span class="count-animate" data-speed="1000" data-refresh-interval="50" data-to="76" data-from="0"></span><span class="units">76%</span></span>
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
                            James Spiegel <svg class="olymp-dropdown-arrow-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-dropdown-arrow-icon"></use></svg>
                        </div>
                        <span class="author-subtitle">SPACE COWBOY</span>
                    </a>
                </div>
            </div>

            <div class="ui-block-title ui-block-title-small">
                <h6 class="title">MAIN SECTIONS</h6>
            </div>

            <ul class="left-menu">
                <li>
                    <a href="#" class="js-sidebar-open">
                        <svg class="olymp-close-icon left-menu-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use></svg>
                        <span class="left-menu-title">Collapse Menu</span>
                    </a>
                </li>
                <li>
                    <a href="mobile-index.html">
                        <svg class="olymp-newsfeed-icon left-menu-icon" data-toggle="tooltip" data-placement="right"   data-original-title="NEWSFEED"><use xlink:href="svg-icons/sprites/icons.svg#olymp-newsfeed-icon"></use></svg>
                        <span class="left-menu-title">Newsfeed</span>
                    </a>
                </li>
                <li>
                    <a href="Mobile-28-YourAccount-PersonalInformation.html">
                        <svg class="olymp-star-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="FAV PAGE"><use xlink:href="svg-icons/sprites/icons.svg#olymp-star-icon"></use></svg>
                        <span class="left-menu-title">Fav Pages Feed</span>
                    </a>
                </li>
                <li>
                    <a href="mobile-29-YourAccount-AccountSettings.html">
                        <svg class="olymp-happy-faces-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="FRIEND GROUPS"><use xlink:href="svg-icons/sprites/icons.svg#olymp-happy-faces-icon"></use></svg>
                        <span class="left-menu-title">Friend Groups</span>
                    </a>
                </li>
                <li>
                    <a href="Mobile-30-YourAccount-ChangePassword.html">
                        <svg class="olymp-headphones-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="MUSIC&PLAYLISTS"><use xlink:href="svg-icons/sprites/icons.svg#olymp-headphones-icon"></use></svg>
                        <span class="left-menu-title">Music & Playlists</span>
                    </a>
                </li>
                <li>
                    <a href="Mobile-31-YourAccount-HobbiesAndInterests.html">
                        <svg class="olymp-weather-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="WEATHER APP"><use xlink:href="svg-icons/sprites/icons.svg#olymp-weather-icon"></use></svg>
                        <span class="left-menu-title">Weather App</span>
                    </a>
                </li>
                <li>
                    <a href="Mobile-32-YourAccount-EducationAndEmployement.html">
                        <svg class="olymp-calendar-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="CALENDAR AND EVENTS"><use xlink:href="svg-icons/sprites/icons.svg#olymp-calendar-icon"></use></svg>
                        <span class="left-menu-title">Calendar and Events</span>
                    </a>
                </li>
                <li>
                    <a href="Mobile-33-YourAccount-Notifications.html">
                        <svg class="olymp-badge-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="Community Badges"><use xlink:href="svg-icons/sprites/icons.svg#olymp-badge-icon"></use></svg>
                        <span class="left-menu-title">Community Badges</span>
                    </a>
                </li>
                <li>
                    <a href="Mobile-34-YourAccount-ChatMessages.html">
                        <svg class="olymp-cupcake-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="Friends Birthdays"><use xlink:href="svg-icons/sprites/icons.svg#olymp-cupcake-icon"></use></svg>
                        <span class="left-menu-title">Friends Birthdays</span>
                    </a>
                </li>
                <li>
                    <a href="Mobile-35-YourAccount-FriendsRequests.html">
                        <svg class="olymp-stats-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="Account Stats"><use xlink:href="svg-icons/sprites/icons.svg#olymp-stats-icon"></use></svg>
                        <span class="left-menu-title">Account Stats</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <svg class="olymp-manage-widgets-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="Manage Widgets"><use xlink:href="svg-icons/sprites/icons.svg#olymp-manage-widgets-icon"></use></svg>
                        <span class="left-menu-title">Manage Widgets</span>
                    </a>
                </li>
            </ul>

            <div class="ui-block-title ui-block-title-small">
                <h6 class="title">YOUR ACCOUNT</h6>
            </div>

            <ul class="account-settings">
                <li>
                    <a href="#">

                        <svg class="olymp-menu-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-menu-icon"></use></svg>

                        <span>Profile Settings</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <svg class="olymp-star-icon left-menu-icon"  data-toggle="tooltip" data-placement="right"   data-original-title="FAV PAGE"><use xlink:href="svg-icons/sprites/icons.svg#olymp-star-icon"></use></svg>

                        <span>Create Fav Page</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <svg class="olymp-logout-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-logout-icon"></use></svg>

                        <span>Log Out</span>
                    </a>
                </li>
            </ul>

            <div class="ui-block-title ui-block-title-small">
                <h6 class="title">About Olympus</h6>
            </div>

            <ul class="about-olympus">
                <li>
                    <a href="#">
                        <span>Terms and Conditions</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span>FAQs</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span>Careers</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span>Contact</span>
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
                <svg class="olymp-menu-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-menu-icon"></use></svg>
            </a>
        </div>

        <a href="#" class="olympus-chat inline-items js-chat-open">
            <svg class="olymp-chat---messages-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-chat---messages-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
                            </li>
                        </ul>

                    </div>
                </li>
            </ul>

        </div>

        <div class="search-friend inline-items">
            <form class="form-group" >
                <input class="form-control" placeholder="Search Friends..." value="" type="text">
            </form>

            <a href="29-YourAccount-AccountSettings.html" class="settings">
                <svg class="olymp-settings-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-settings-icon"></use></svg>
            </a>

            <a href="#" class="js-sidebar-open">
                <svg class="olymp-close-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use></svg>
            </a>
        </div>

        <a href="#" class="olympus-chat inline-items js-chat-open">

            <h6 class="olympus-chat-title">OLYMPUS CHAT</h6>
            <svg class="olymp-chat---messages-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-chat---messages-icon"></use></svg>
        </a>

    </div>
</div>

<!-- ... end Fixed Sidebar Right -->


<!-- Fixed Sidebar Right-Responsive -->

<div class="fixed-sidebar right fixed-sidebar-responsive" id="sidebar-right-responsive">

    <div class="fixed-sidebar-right sidebar--small">
        <a href="#" class="js-sidebar-open">
            <svg class="olymp-menu-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-menu-icon"></use></svg>
            <svg class="olymp-close-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
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

                    <div class="more"><svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>

                        <ul class="more-icons">
                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="START CONVERSATION" class="olymp-comments-post-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-comments-post-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="ADD TO CONVERSATION" class="olymp-add-to-conversation-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-add-to-conversation-icon"></use></svg>
                            </li>

                            <li>
                                <svg data-toggle="tooltip" data-placement="top" data-original-title="BLOCK FROM CHAT" class="olymp-block-from-chat-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-block-from-chat-icon"></use></svg>
                            </li>
                        </ul>

                    </div>
                </li>
            </ul>

        </div>

        <div class="search-friend inline-items">
            <form class="form-group" >
                <input class="form-control" placeholder="Search Friends..." value="" type="text">
            </form>

            <a href="29-YourAccount-AccountSettings.html" class="settings">
                <svg class="olymp-settings-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-settings-icon"></use></svg>
            </a>

            <a href="#" class="js-sidebar-open">
                <svg class="olymp-close-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use></svg>
            </a>
        </div>

        <a href="#" class="olympus-chat inline-items js-chat-open">

            <h6 class="olympus-chat-title">OLYMPUS CHAT</h6>
            <svg class="olymp-chat---messages-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-chat---messages-icon"></use></svg>
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
<div class="header-spacer header-spacer-small"></div>


<!-- Main Header Groups -->

<div class="main-header">
    <div class="content-bg-wrap bg-group"></div>
    <div class="container">
        <div class="row">
            <div class="col col-lg-8 m-auto col-md-8 col-sm-12 col-12">
                <div class="main-header-content">
                    <h1>欢迎来到论坛</h1>
                    <p>在这里的论坛上，您将能够轻松地创建和管理类别和主题，以便与社区共享！我们包括了一些最常用的主题，如音乐，漫画，电影和社区，每一个都有一个很酷和可定制的插图，这样你就可以玩得开心了！ </p>
                </div>
            </div>
        </div>
    </div>

    <img class="img-bottom" src="img/group-bottom.png" alt="friends">
</div>

<!-- ... end Main Header Groups -->

<div class="container">
    <div class="row">
        <div class="col col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
            <div class="ui-block responsive-flex">
                <div class="ui-block-title">
                    <div class="h6 title">论坛</div>
                    <form class="w-search">
                        <div class="form-group with-button">
                            <input class="form-control" type="text" placeholder="Search the forums...">
                            <button>
                                <svg class="olymp-magnifying-glass-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-magnifying-glass-icon"></use></svg>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>



<div class="container">
    <div class="row">
        <div class="col col-xl-9 col-lg-9 col-md-12 col-sm-12 col-12">

            <div class="ui-block">
                <div class="ui-block-title bg-blue">
                    <h6 class="title c-white">创建新的帖子</h6>
                </div>
                <div class="ui-block-content">

                    <form method="post" action="/Web/WebContent/Skip">
                        <div class="row">
                            <div class="col col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <div class="form-group label-floating">
                                    <label class="control-label">标题</label>
                                    <input class="form-control" type="text" placeholder="" name="topic" value="输入一个醒目的标题吧">
                                    <input class="form-control" type="text" placeholder="" style="display: none;" name="email" value="<%=(String) web_inf.get(2)%>">
                                </div>
                            </div>


                            <div class="col col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <div class="form-group label-floating">
                                    <label class="control-label">正文</label>
                                    <textarea class="form-control" name="content" style="height: 240px">输入你想说的话</textarea>
                                </div>

                                <div class="form-group">
                                    <input class="form-control" type="text" placeholder="选择标签类别">
                                </div>
                            </div>

                            <div class="col col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
                                <a href="#" class="btn btn-secondary btn-lg full-width">取消</a>
                            </div>

                            <div class="col col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
                                <input type="submit" class="btn btn-blue btn-lg full-width" value="发表" />
                            </div>
                        </div>
                    </form>
                </div>
            </div>

        </div>

        <div class="col col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12">
            <div class="ui-block">
                <div class="ui-block-title">
                    <h6 class="title">最热帖子</h6>
                </div>
                <div class="ui-block-content">


                    <!-- Widget Featured Topics -->

                    <ul class="widget w-featured-topics">
                        <li>
                            <i class="icon fa fa-star" aria-hidden="true"></i>
                            <div class="content">
                                <a href="#" class="h6 title">新的电影预告片出来了 大家快去看啊</a>
                                <time class="entry-date updated" datetime="2017-06-24T18:18">26分钟前</time>
                            </div>
                        </li>
                        <li>
                            <i class="icon fa fa-star" aria-hidden="true"></i>
                            <div class="content">
                                <a href="#" class="h6 title">希望今年运动会的表现会好一些</a>
                                <time class="entry-date updated" datetime="2017-06-24T18:18">44分钟前</time>
                            </div>
                        </li>
                        <li>
                            <i class="icon fa fa-star" aria-hidden="true"></i>
                            <div class="content">
                                <a href="#" class="h6 title">大家快来看看我拍的校园</a>
                                <time class="entry-date updated" datetime="2017-06-24T18:18">58分钟前</time>
                            </div>
                        </li>
                    </ul>

                    <!-- ... end Widget Featured Topics -->
                </div>
            </div>

            <div class="ui-block">
                <div class="ui-block-title">
                    <h6 class="title">近期专题</h6>
                </div>
                <div class="ui-block-content">


                    <!-- Widget Recent Topics -->

                    <ul class="widget w-featured-topics">
                        <li>
                            <div class="content">
                                <a href="#" class="h6 title">夏天快到了！在东大道公园野餐</a>
                                <time class="entry-date updated" datetime="2017-06-24T18:18">26分钟前</time>
                                <div class="forums">社区</div>
                            </div>
                        </li>
                        <li>
                            <div class="content">
                                <a href="#" class="h6 title">功夫拳击手发布了一段新视频，看看这里！</a>
                                <time class="entry-date updated" datetime="2017-06-24T18:18">44 minutes ago</time>
                                <div class="forums">社区</div>
                            </div>
                        </li>
                        <li>
                            <div class="content">
                                <a href="#" class="h6 title">你最喜欢什么季节？</a>
                                <time class="entry-date updated" datetime="2017-06-24T18:18">59 minutes ago</time>
                                <div class="forums">班级</div>
                            </div>
                        </li>
                        <li>
                            <div class="content">
                                <a href="#" class="h6 title">这个冬天九江也太暖和了吧!</a>
                                <time class="entry-date updated" datetime="2017-06-24T18:18">一小时前</time>
                                <div class="forums">校园</div>
                            </div>
                        </li>
                    </ul>

                    <!-- ... end Widget Recent Topics -->
                </div>
            </div>

        </div>
    </div>
</div>




<!-- Window-popup-CHAT for responsive min-width: 768px -->

<div class="ui-block popup-chat popup-chat-responsive" tabindex="-1" role="dialog" aria-labelledby="popup-chat-responsive" aria-hidden="true">

    <div class="modal-content">
        <div class="modal-header">
            <span class="icon-status online"></span>
            <h6 class="title" >Chat</h6>
            <div class="more">
                <svg class="olymp-three-dots-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-three-dots-icon"></use></svg>
                <svg class="olymp-little-delete js-chat-open"><use xlink:href="svg-icons/sprites/icons.svg#olymp-little-delete"></use></svg>
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
                            <span class="notification-date"><time class="entry-date updated" datetime="2004-07-24T18:18">Yesterday at 8:10pm</time></span>
                        </div>
                    </li>

                    <li>
                        <div class="author-thumb">
                            <img src="img/author-page.jpg" alt="author" class="mCS_img_loaded">
                        </div>
                        <div class="notification-event">
                            <span class="chat-message-item">Don’t worry Mathilda!</span>
                            <span class="chat-message-item">I already bought everything</span>
                            <span class="notification-date"><time class="entry-date updated" datetime="2004-07-24T18:18">Yesterday at 8:29pm</time></span>
                        </div>
                    </li>

                    <li>
                        <div class="author-thumb">
                            <img src="img/avatar14-sm.jpg" alt="author" class="mCS_img_loaded">
                        </div>
                        <div class="notification-event">
                            <span class="chat-message-item">Hi James! Please remember to buy the food for tomorrow! I’m gonna be handling the gifts and Jake’s gonna get the drinks</span>
                            <span class="notification-date"><time class="entry-date updated" datetime="2004-07-24T18:18">Yesterday at 8:10pm</time></span>
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
                            <svg class="olymp-computer-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-computer-icon"></use></svg>
                        </a>
                        <div class="options-message smile-block">

                            <svg class="olymp-happy-sticker-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-happy-sticker-icon"></use></svg>

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



<a class="back-to-top" href="#">
    <img src="svg-icons/back-to-top.svg" alt="arrow" class="back-icon">
</a>



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
<script src="js/libs/ion.rangeSlider.js"></script>

<script src="js/main.js"></script>
<script src="js/libs-init/libs-init.js"></script>
<script defer src="fonts/fontawesome-all.js"></script>

<script src="Bootstrap/dist/js/bootstrap.bundle.js"></script>

</body>
</html>
