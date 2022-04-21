<%--
  Created by IntelliJ IDEA.
  User: Farid
  Date: 3/26/2022
  Time: 12:42 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign Up Form by Todo</title>
   <!-- Font Icon -->
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">

    <!-- Main css -->
    <link rel="stylesheet" href="assets/register/css/style.css">

</head>
<body style="overflow: hidden;">
<%--    <jsp:include page="header.jsp"></jsp:include>--%>
<%String successMsg = (String) request.getAttribute("notifications");
    if (successMsg!=null){%>
<div class="alert alert-success" role="alert" style="width: 600px; text-align: center; margin: 0px auto 0px auto"><p><%=successMsg%></p></div>
<%}%>

<div class="main" style="margin-top: -30px">
    <!-- Sign up form -->
    <section class="signup" style="margin-top: -60px;">
        <div class="container">
            <div class="signup-content">
                <div class="signup-form">
                    <h2 class="form-title">Sign up</h2>

                    <form method="POST" action="<%=request.getContextPath()%>/register" class="register-form" id="register-form">
                        <div class="form-group">
                            <label for="name"><i class="zmdi zmdi-account material-icons-name"></i></label>
                            <input type="text" name="firstName" id="name" placeholder="Your Name"/>
                        </div>
                        <div class="form-group">
                            <label for="surname"><i class="zmdi zmdi-email"></i></label>
                            <input type="text" name="lastName" id="surname" placeholder="Your Surname"/>
                        </div>
                        <div class="form-group">
                            <label for="username"><i class="zmdi zmdi-lock"></i></label>
                            <input type="text" name="username" id="username" placeholder="Username"/>
                        </div>
                        <div class="form-group">
                            <label for="password"><i class="zmdi zmdi-lock-outline"></i></label>
                            <input type="password" name="password" id="password" placeholder="password"/>
                        </div>
                        <div class="form-group">
                            <input type="checkbox" name="agree-term" id="agree-term" class="agree-term" />
                            <label for="agree-term" class="label-agree-term"><span><span></span></span>I agree all statements in  <a href="#" class="term-service">Terms of service</a></label>
                        </div>
                        <div class="form-group form-button">
                            <input type="submit" name="signup" id="signup" class="form-submit" value="Register"/>
                        </div>
                    </form>
                </div>
                <div class="signup-image">
                    <figure><img src="assets/register/images/signup-image.jpg" alt="sing up image"></figure>
                    <a href="<%=request.getContextPath()%>/login" class="signup-image-link">I am already member</a>
                </div>
            </div>
        </div>
    </section>
</div>

<!-- JS -->
<script src="assets/register/vendor/jquery/jquery.min.js"></script>
<script src="assets/register/js/main.js"></script>
<%--    <jsp:include page="footer.jsp"></jsp:include>--%>
</body>
</html>
