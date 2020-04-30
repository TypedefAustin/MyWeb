<%@ page import="WebPest.Databases.infomationBaseDAO" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019-12-19
  Time: 0:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("IsLogin") != null) {
        request.getRequestDispatcher("/WEB-INF/JSP/ProfilePage.jsp").forward(request, response);
    }
    infomationBaseDAO inf1 = new infomationBaseDAO();
    ArrayList web_inf = inf1.WebInf("1175721708@qq.com");
%>
<!DOCTYPE html>
<html lang="en">
<head>

    <title>Social Search Results</title>

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

<body>


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


<!-- Header-BP-logout -->

<header class="header header--logout" id="site-header">
    <a href="/Web/WebContent/Skip?key=04" class="logo">
        <div class="img-wrap">
            <img src="img/logo.png" alt="Olympus">
        </div>
    </a>

    <div class="page-title">
        <h6>已经登出</h6>
    </div>

    <div class="header-content-wrapper">
        <form class="search-bar w-search notification-list friend-requests">
            <div class="form-group with-button">
                <input class="form-control js-user-search" placeholder="Search here people or pages..." type="text">
                <button>
                    <svg class="olymp-magnifying-glass-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-magnifying-glass-icon"></use></svg>
                </button>
            </div>
        </form>

        <div class="form--login-logout">
            <form class="form-inline" action="/Web/WebContent/login" method="post">
                <div class="form-group">
                    <input class="form-control form-control-sm" name="login_email" type="text" placeholder="Username" value="" required>
                </div>
                <div class="form-group">
                    <input class="form-control form-control-sm" name="login_psw" type="password" placeholder="Password" value="" required>
                </div>
                <button class="btn btn-primary btn-md-2" type="submit">Login</button>
            </form>
            <a href="#" class="btn btn-primary btn-md-2 login-btn-responsive" data-toggle="modal" data-target="#registration-login-form-popup">Login</a>
        </div>
    </div>

</header>

<!-- ... end Header-BP-logout -->
<div class="header-spacer"></div>



<!-- Top Header-Profile Logout -->

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
                                        <a href="#" class="friend-count-item">
                                            <div class="h6">58</div>
                                            <div class="title">Friends</div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#" class="friend-count-item">
                                            <div class="h6">240</div>
                                            <div class="title">Photos</div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#" class="friend-count-item">
                                            <div class="h6">12</div>
                                            <div class="title">Videos</div>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="col col-lg-5 ml-auto col-md-5 col-sm-12 col-12">
                                <ul class="profile-menu">
                                    <li>
                                        <a href="#" class="friend-count-item">
                                            <div class="h6">835</div>
                                            <div class="title">Posts</div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#" class="friend-count-item">
                                            <div class="h6">12.6K</div>
                                            <div class="title">Comments</div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#" class="friend-count-item">
                                            <div class="h6">970</div>
                                            <div class="title">Likes</div>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <div class="control-block-button">
                            <a href="35-YourAccount-FriendsRequests.html" class="btn btn-control bg-blue">
                                <svg class="olymp-happy-face-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-happy-face-icon"></use></svg>
                            </a>

                            <a href="#" class="btn btn-control bg-purple">
                                <svg class="olymp-chat---messages-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-chat---messages-icon"></use></svg>
                            </a>
                        </div>
                    </div>
                    <div class="top-header-author">
                        <a href="02-ProfilePage.html" class="author-thumb">
                            <img src="img/author-main1.jpg" alt="author">
                        </a>
                        <div class="author-content">
                            <a href="02-ProfilePage.html" class="h4 author-name"><%=(String) web_inf.get(1)%></a>
                            <div class="country">江西, 九江</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ... end Top Header-Profile Logout -->
<section class="medium-padding120">
    <div class="container">
        <div class="row">
            <div class="col col-xl-4 col-lg-12 col-md-12 col-12 m-auto">
                <div class="logout-content">
                    <div class="logout-icon">
                        <i class="fas fa-times"></i>
                    </div>
                    <h6>你想看<%=(String) web_inf.get(1)%>的主页吗?</h6>
                    <p><a href="/Web/WebContent/do#svolet">登陆</a> or <a href="/Web/WebContent/do#volet">注册</a> 现在开始去创建你的校园网吧!
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>


<div class="modal fade" id="registration-login-form-popup" tabindex="-1" role="dialog" aria-labelledby="registration-login-form-popup" aria-hidden="true">
    <div class="modal-dialog window-popup registration-login-form-popup" role="document">
        <div class="modal-content">
            <a href="#" class="close icon-close" data-dismiss="modal" aria-label="Close">
                <svg class="olymp-close-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use></svg>
            </a>
            <div class="modal-body">
                <div class="registration-login-form">
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#home1" role="tab">
                                <svg class="olymp-login-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-login-icon"></use>
                                </svg>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#profile1" role="tab">
                                <svg class="olymp-register-icon">
                                    <use xlink:href="svg-icons/sprites/icons.svg#olymp-register-icon"></use>
                                </svg>
                            </a>
                        </li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" id="home1" role="tabpanel" data-mh="log-tab">
                            <div class="title h6">Register to Olympus</div>
                            <form class="content">
                                <div class="row">
                                    <div class="col col-12 col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                        <div class="form-group label-floating">
                                            <label class="control-label">First Name</label>
                                            <input class="form-control" placeholder="" type="text">
                                        </div>
                                    </div>
                                    <div class="col col-12 col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                        <div class="form-group label-floating">
                                            <label class="control-label">Last Name</label>
                                            <input class="form-control" placeholder="" type="text">
                                        </div>
                                    </div>
                                    <div class="col col-12 col-xl-12 col-lg-12 col-md-12 col-sm-12">
                                        <div class="form-group label-floating">
                                            <label class="control-label">Your Email</label>
                                            <input class="form-control" placeholder="" type="email">
                                        </div>
                                        <div class="form-group label-floating">
                                            <label class="control-label">Your Password</label>
                                            <input class="form-control" placeholder="" type="password">
                                        </div>

                                        <div class="form-group date-time-picker label-floating">
                                            <label class="control-label">Your Birthday</label>
                                            <input name="datetimepicker" value="10/24/1984" />
                                            <span class="input-group-addon">
											<svg class="olymp-calendar-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-calendar-icon"></use></svg>
										</span>
                                        </div>

                                        <div class="form-group label-floating is-select">
                                            <label class="control-label">Your Gender</label>
                                            <select class="selectpicker form-control">
                                                <option value="MA">Male</option>
                                                <option value="FE">Female</option>
                                            </select>
                                        </div>

                                        <div class="remember">
                                            <div class="checkbox">
                                                <label>
                                                    <input name="optionsCheckboxes" type="checkbox">
                                                    I accept the <a href="#">Terms and Conditions</a> of the website
                                                </label>
                                            </div>
                                        </div>

                                        <a href="#" class="btn btn-purple btn-lg full-width">Complete Registration!</a>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="tab-pane" id="profile1" role="tabpanel" data-mh="log-tab">
                            <div class="title h6">Login to your Account</div>
                            <form class="content">
                                <div class="row">
                                    <div class="col col-12 col-xl-12 col-lg-12 col-md-12 col-sm-12">
                                        <div class="form-group label-floating">
                                            <label class="control-label">Your Email</label>
                                            <input class="form-control" placeholder="" type="email">
                                        </div>
                                        <div class="form-group label-floating">
                                            <label class="control-label">Your Password</label>
                                            <input class="form-control" placeholder="" type="password">
                                        </div>

                                        <div class="remember">

                                            <div class="checkbox">
                                                <label>
                                                    <input name="optionsCheckboxes" type="checkbox">
                                                    Remember Me
                                                </label>
                                            </div>
                                            <a href="#" class="forgot" data-toggle="modal" data-target="#restore-password">Forgot my Password</a>
                                        </div>

                                        <a href="#" class="btn btn-lg btn-primary full-width">Login</a>

                                        <div class="or"></div>

                                        <a href="#" class="btn btn-lg bg-facebook full-width btn-icon-left"><i class="fab fa-facebook-f" aria-hidden="true"></i>Login with Facebook</a>

                                        <a href="#" class="btn btn-lg bg-twitter full-width btn-icon-left"><i class="fab fa-twitter" aria-hidden="true"></i>Login with Twitter</a>


                                        <p>Don’t you have an account?
                                            <a href="#">Register Now!</a> it’s really simple and you can start enjoing all the benefits!
                                        </p>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Window-popup Restore Password -->

<div class="modal fade" id="restore-password" tabindex="-1" role="dialog" aria-labelledby="restore-password" aria-hidden="true">
    <div class="modal-dialog window-popup restore-password-popup" role="document">
        <div class="modal-content">
            <a href="#" class="close icon-close" data-dismiss="modal" aria-label="Close">
                <svg class="olymp-close-icon"><use xlink:href="svg-icons/sprites/icons.svg#olymp-close-icon"></use></svg>
            </a>

            <div class="modal-header">
                <h6 class="title">Restore your Password</h6>
            </div>

            <div class="modal-body">
                <form  method="get">
                    <p>Enter your email and click the send code button. You’ll receive a code in your email. Please use that
                        code below to change the old password for a new one.
                    </p>
                    <div class="form-group label-floating">
                        <label class="control-label">Your Email</label>
                        <input class="form-control" placeholder="" type="email" value="james-spiegel@yourmail.com">
                    </div>
                    <button class="btn btn-purple btn-lg full-width">Send me the Code</button>
                    <div class="form-group label-floating">
                        <label class="control-label">Enter the Code</label>
                        <input class="form-control" placeholder="" type="text" value="">
                    </div>
                    <div class="form-group label-floating">
                        <label class="control-label">Your New Password</label>
                        <input class="form-control" placeholder="" type="password" value="olympus">
                    </div>
                    <button class="btn btn-primary btn-lg full-width">Change your Password!</button>
                </form>

            </div>
        </div>
    </div>
</div>

<!-- ... end Window-popup Restore Password -->




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