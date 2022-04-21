<%@ page import="model.User" %><%--
  Created by IntelliJ IDEA.
  User: Farid
  Date: 3/26/2022
  Time: 1:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //HTTP 1.0
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setHeader("Expires", "0"); //Proxies

    if (session.getAttribute("user") == null){
        response.sendRedirect("login");
    }
%>

<%
    HttpSession session1 = request.getSession();
    User user = (User) session1.getAttribute("user");
%>
<html>
<head>
    <title><%=user.getUsername()%></title>

    <!-- Font Awesome -->
    <link
            href=" https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <!-- Google Fonts -->
    <link
            href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"
            rel="stylesheet"
    />
    <!-- MDB -->
    <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
            rel="stylesheet"
    />

    <!-- MDB -->
    <script
            type="text/javascript"
            src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"
    ></script>

    <script
            type="text/javascript"
            src="../assets/main.js">
    </script>

    <style>
        .gradient-custom {
            background: radial-gradient(50% 123.47% at 50% 50%, #00ff94 0%, #720059 100%),
            linear-gradient(121.28deg, #669600 0%, #ff0000 100%),
            linear-gradient(360deg, #0029ff 0%, #8fff00 100%),
            radial-gradient(100% 164.72% at 100% 100%, #6100ff 0%, #00ff57 100%),
            radial-gradient(100% 148.07% at 0% 0%, #fff500 0%, #51d500 100%);
            background-blend-mode: screen, color-dodge, overlay, difference, normal;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #BA68C8
        }

        .profile-button {
            background: #BA68C8;
            box-shadow: none;
            border: none
        }

        .profile-button:hover {
            background: #682773
        }

        .profile-button:focus {
            background: #682773;
            box-shadow: none
        }

        .profile-button:active {
            background: #682773;
            box-shadow: none
        }

        .back:hover {
            color: #682773;
            cursor: pointer
        }

    </style>
</head>
<body class="gradient-custom">




<section class="vh-100 gradient-custom">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col col-xl-10">

                    <c:if test="${todo!=null}">
                        <form action="<%=request.getContextPath()%>/update" method="post">
                    </c:if>

                    <c:if test="${todo==null}">
                        <form action="<%=request.getContextPath()%>/insert" method="post">
                    </c:if>

                <div class="card" style="border-radius: 10px;">
                    <div class="card-header p-3" style="background: #fff; border-radius: 10px;" >
                        <h5 class="mb-0">
                            <c:if test="${todo!=null}">
                                <img src="https://cdn-icons.flaticon.com/png/512/2623/premium/2623081.png?token=exp=1648310744~hmac=355469039557d23ea17f4275fbfcef0d" width="30px" height="30px">
                            </c:if>

                            <c:if test="${todo==null}">
                                <img src="https://cdn-icons-png.flaticon.com/512/2311/2311991.png" width="30px" height="30px">
                            </c:if>
                        </h5>
                    </div>

                    <c:if test="${todo != null}">
                        <input type="hidden" name="id" value="<c:out value='${todo.id}' />" />
                    </c:if>

                    <div class="row">
                        <div class="col-md-4 border-right">
                            <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                                <img class="rounded-circle mt-5" src="https://cdn-icons-png.flaticon.com/512/219/219986.png" width="90">
                                <br>
                                <span class="font-weight-bold"><%=user.getFirstName() + " " + user.getLastName()%></span>
                                <span class="text-black-50">@<%=user.getUsername()%></span>
                                <input type="hidden" name="username" value="<%=user.getUsername()%>">
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="p-3 py-5">
                                <div class="d-flex flex-row align-items-center back" style="margin-top: -20px;"><i class="fa fa-long-arrow-left mr-1 mb-1"></i>
                                    <a style="text-decoration: none; color: #000;" href="<%=request.getContextPath()%>/list">
                                        <h6>Back to home</h6>
                                    </a>
                                </div>
                                </div>

                            <c:if test="${todo!=null}">
                                <input type="hidden" name="id" value="${todo.id}">
                            </c:if>

                                <div class="form-group" style="margin-right: 20px;">
                                    <label for="exampleInputEmail1">Title</label>
                                    <input type="text" class="form-control" id="exampleInputEmail1"
                                           aria-describedby="emailHelp" name="title"
                                           value="<c:out value="${todo.title}"></c:out>"
                                           placeholder="Enter Title">
                                    <small id="emailHelp" class="form-text text-muted">What is Our Current Task</small>
                                </div>
                                <div class="form-group" style="margin-right: 20px;">
                                    <label for="exampleFormControlTextarea1">Description</label>
                                    <textarea class="form-control" placeholder="Enter description.." name="description" id="exampleFormControlTextarea1" rows="3"><c:out value="${todo.description}"></c:out></textarea>
                                </div>
                                <div class="form-group" style="margin-right: 20px;">
                                    <label for="isDone" >Status</label>
                                    <select class="form-control" name="isDone" id="isDone">
                                            <c:if test="${not todo.done}">
                                                <option value="false" selected>In Progress</option>
                                                <option value="true">Done</option>
                                            </c:if>

                                            <c:if test="${todo.done}">
                                                <option value="true" selected>Done</option>
                                                <option value="false">In Progress</option>
                                            </c:if>
                                    </select>
                                </div>
                                <div class="form-group" style="margin-right: 20px;">
                                    <label for="exampleInputEmail1">DeadLine</label>
                                    <input type="date" class="form-control" id="exampleInputEmail2"
                                           aria-describedby="emailHelp1"
                                           name="targetDate";
                                           value="<c:out value="${todo.targetDate}"></c:out>">
                                    <small id="emailHelp1" class="form-text text-muted">Finish your task on time :)</small>
                                </div>
                                <div class="mt-5 text-right" style="margin: auto 20px 20px auto;"><button type="submit" class="btn btn-primary">Save Task</button></div>
                            </div>
                        </div>
                    </div>
                    </form>
                    </form>
            </div>
                </div>
                </div>

            </div>
        </div>
    </div>
</section>

</body>
</html>
