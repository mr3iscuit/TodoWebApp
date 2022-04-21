<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Todo" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Farid
  Date: 3/26/2022
  Time: 2:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Title</title>

        <!-- Font Awesome -->
        <link
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                rel="stylesheet"
        />
        <!-- Google Fonts -->
        <link
                href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
                rel="stylesheet"
        />
        <!-- MDB -->
        <link
                href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.11.0/mdb.min.css"
                rel="stylesheet"
        />

        <!-- MDB -->
        <script
                type="text/javascript"
                src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.11.0/mdb.min.js"
        ></script>


        <style>
            .gradient-custom {
                background: radial-gradient(50% 123.47% at 50% 50%, #00ff94 0%, #720059 100%),
                linear-gradient(121.28deg, #669600 0%, #ff0000 100%),
                linear-gradient(360deg, #0029ff 0%, #8fff00 100%),
                radial-gradient(100% 164.72% at 100% 100%, #6100ff 0%, #00ff57 100%),
                radial-gradient(100% 148.07% at 0% 0%, #fff500 0%, #51d500 100%);
                background-blend-mode: screen, color-dodge, overlay, difference, normal;
            }
             input[type=checkbox]:checked + label.line {
                 text-decoration:line-through;
             }
        </style>


    </head>
    <body>
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //HTTP 1.0
        response.setHeader("Pragma", "no-cache"); //HTTP 1.0
        response.setHeader("Expires", "0"); //Proxies

        if (session.getAttribute("user") == null){
            response.sendRedirect("login");
        }
    %>




    <section class="vh-100 gradient-custom">
        <div class="container py-5 h-100">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col col-xl-10">
                    <div class="p-3 py-5">

                    </div>
                    <div class="card">
                        <div class="card-header p-3">
                            <h5 class="mb-0"><i class="fas fa-tasks me-2"></i>Task List</h5>
                            <div class="d-flex flex-row align-items-center back" style="margin-top: -20px; margin-left: 950px;">
                                <i class="fa fa-long-arrow-left mr-1 mb-1">&nbsp;</i>
                                <a style="text-decoration: none; color: #000;" href="<%=request.getContextPath()%>/">
                                    <h6>Log out</h6>
                                </a>
                            </div>
                        </div>

                        <div class="card-body p-5" style="margin-top: -30px; ">
                            <!-- Tabs navs -->
                            <ul class="nav nav-tabs mb-4 pb-2" id="ex1" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <a class="nav-link active" id="ex1-tab-1" data-mdb-toggle="tab" href="#ex1-tabs-1" role="tab"
                                       aria-controls="ex1-tabs-1" aria-selected="true">All</a>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <a class="nav-link" id="ex1-tab-2" data-mdb-toggle="tab" href="#ex1-tabs-2" role="tab"
                                       aria-controls="ex1-tabs-2" aria-selected="false">Active</a>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <a class="nav-link" id="ex1-tab-3" data-mdb-toggle="tab" href="#ex1-tabs-3" role="tab"
                                       aria-controls="ex1-tabs-3" aria-selected="false">Completed</a>
                                </li>
                            </ul>
                            <!-- Tabs navs -->

                            <!-- Tabs content -->

                            <div class="tab-content" id="ex1-content">
                                <div class="tab-pane fade show active" id="ex1-tabs-1" role="tabpanel" aria-labelledby="ex1-tab-1" style="margin-top: -20px;">
                                    <c:if test="${todos!=null}">
                                        <% Integer count=0;%>
                                    <c:forEach var="todo" items="${todos}">

                                        <table aria-colspan="3" style="border-spacing: 10em;">
                                            <tr style="background-color: #f4f6f7; height: 40px;">
                                                <td style="width: 10px;"></td>

                                                <td  style="width: 10px;">
                                                    <form action="<%=request.getContextPath()%>/list" method="get">

                                                        <input type="hidden" name="isDone" id="isDone<%=count++%>"/>
                                                        <input type="hidden" name="id" value="<c:out value="${todo.id}"/>" />

                                                        <c:if test="${todo.done}">
                                                            <input class="form-check-input me-2"
                                                                   type="checkbox"
                                                                   name="checkbox"
                                                                   onclick="isChecked()"
                                                                   id="check"
                                                                   onchange="this.form.submit()"
                                                                   value=""
                                                                   checked />
                                                        </c:if>
<%--                                                        --%>
                                                        <c:if test="${not todo.done}">
                                                            <input class="form-check-input me-2"
                                                                   type="checkbox"
                                                                   name="checkbox"
                                                                   onclick="isChecked()"
                                                                   id="check"
                                                                   onchange="this.form.submit()"
                                                                   value=""
                                                                   />
                                                        </c:if>
                                                    </form>

                                                </td>
                                                <td style="width: 150px; ">
                                                    <label class="line" id="line"><c:out value='${todo.title}'/></label>
                                                </td>

                                                <td style="width: 800px;">
                                                    <div class="text-middle text-muted" style="text-align: center;">
                                                        <a href="#!" class="text-muted" data-mdb-toggle="tooltip" title="Created date">
                                                            <p class="small mb-0"><i class="fas fa-info-circle me-2"></i><c:out value='${todo.targetDate}'/></p></a>
                                                    </div>
                                                </td>

                                                <td style="width: 5px;">
                                                    <div>
                                                        <a href="edit?id=<c:out value='${todo.id}'/>" data-mdb-toggle="tooltip" style="border: none;  text-decoration: none;" title="Edit">
                                                            <img src="https://cdn-icons-png.flaticon.com/512/1827/1827933.png" width="20" height="20"></a>
                                                    </div>
                                                </td>

                                                <td style="margin-right: 7px;">
                                                    <div style="margin-left: 5px;">
                                                        <a href="delete?id=<c:out value='${todo.id}'/>" style="border: none; text-decoration: none;" data-mdb-toggle="tooltip" title="Remove">
                                                            <img src="https://cdn-icons.flaticon.com/png/512/484/premium/484662.png?token=exp=1648301536~hmac=5bf484b3bb69702eb40edb95833049df"
                                                                 width="20" height="20"></a>
                                                    </div>
                                                </td>
                                                <td style="width: 10px;"></td>
                                            </tr>
                                            <tr style="height: 5px; background: #fff"></tr>
                                        </table>

                                    </c:forEach>
                                    </c:if>

                                </div>
                                <div class="tab-pane fade" id="ex1-tabs-2" role="tabpanel" aria-labelledby="ex1-tab-2">
                                    <c:if test="${todos!=null}">
                                        <% Integer count=0;%>
                                        <c:forEach var="todo" items="${todos}">
                                            <c:if test="${not todo.done}">
                                                <table aria-colspan="3" style="border-spacing: 10em;">
                                                    <tr style="background-color: #f4f6f7; height: 40px;">
                                                        <td style="width: 10px;"></td>

                                                        <td  style="width: 10px;">
                                                            <form action="<%=request.getContextPath()%>/list" method="get">

                                                                <input type="hidden" name="isDone" id="isDone<%=count++%>"/>
                                                                <input type="hidden" name="id" value="<c:out value="${todo.id}"/>" />
                                                                    <%--                                                        --%>

                                                                    <input class="form-check-input me-2"
                                                                           type="checkbox"
                                                                           name="checkbox"
                                                                           onclick="isCheckedProgress()"
                                                                           id="checkProgress"
                                                                           onchange="this.form.submit()"
                                                                           value=""
                                                                    />

                                                            </form>

                                                        </td>
                                                        <td style="width: 150px; ">
                                                            <label class="line"><c:out value='${todo.title}'/></label>
                                                        </td>

                                                        <td style="width: 800px;">
                                                            <div class="text-middle text-muted" style="text-align: center;">
                                                                <a href="#!" class="text-muted" data-mdb-toggle="tooltip" title="Created date">
                                                                    <p class="small mb-0"><i class="fas fa-info-circle me-2"></i><c:out value='${todo.targetDate}'/></p></a>
                                                            </div>
                                                        </td>

                                                        <td style="width: 5px;">
                                                            <div>
                                                                <a href="edit?id=<c:out value='${todo.id}'/>" data-mdb-toggle="tooltip" style="border: none;  text-decoration: none;" title="Edit">
                                                                    <img src="https://cdn-icons-png.flaticon.com/512/1827/1827933.png" width="20" height="20"></a>
                                                            </div>
                                                        </td>

                                                        <td style="margin-right: 7px;">
                                                            <div style="margin-left: 5px;">
                                                                <a href="delete?id=<c:out value='${todo.id}'/>" style="border: none; text-decoration: none;" data-mdb-toggle="tooltip" title="Remove">
                                                                    <img src="https://cdn-icons.flaticon.com/png/512/484/premium/484662.png?token=exp=1648301536~hmac=5bf484b3bb69702eb40edb95833049df"
                                                                         width="20" height="20"></a>
                                                            </div>
                                                        </td>

                                                    <td style="width: 10px;"></td>
                                                </tr>
                                                <tr style="height: 5px; background: #fff"></tr>
                                            </table>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>

                                </div>
                                <div class="tab-pane fade" id="ex1-tabs-3" role="tabpanel" aria-labelledby="ex1-tab-3">
                                    <c:if test="${todos!=null}">
                                        <% Integer count=0;%>
                                        <c:forEach var="todo" items="${todos}">
                                            <c:if test="${todo.done}">
                                                <table aria-colspan="3" style="border-spacing: 10em;">
                                                    <tr style="background-color: #f4f6f7; height: 40px;">
                                                        <td style="width: 10px;"></td>

                                                        <td  style="width: 10px;">
                                                            <form action="<%=request.getContextPath()%>/list" method="get">
                                                                <input type="hidden" name="isDone" id="isDone<%=count++%>"/>
                                                                <input type="hidden" name="id" value="<c:out value="${todo.id}"/>" />

                                                                    <input class="form-check-input me-2"
                                                                           type="checkbox"
                                                                           name="checkbox"
                                                                           onclick="isCheckedDone()"
                                                                           id="checkDone"
                                                                           onchange="this.form.submit()"
                                                                           value=""
                                                                           checked />
                                                            </form>

                                                        </td>
                                                        <td style="width: 150px; ">
                                                            <label class="line"><c:out value='${todo.title}'/></label>
                                                        </td>

                                                        <td style="width: 800px;">
                                                            <div class="text-middle text-muted" style="text-align: center;">
                                                                <a href="#!" class="text-muted" data-mdb-toggle="tooltip" title="Created date">
                                                                    <p class="small mb-0"><i class="fas fa-info-circle me-2"></i><c:out value='${todo.targetDate}'/></p></a>
                                                            </div>
                                                        </td>

                                                        <td style="width: 5px;">
                                                            <div>
                                                                <a href="edit?id=<c:out value='${todo.id}'/>" data-mdb-toggle="tooltip" style="border: none;  text-decoration: none;" title="Edit">
                                                                    <img src="https://cdn-icons-png.flaticon.com/512/1827/1827933.png" width="20" height="20"></a>
                                                            </div>
                                                        </td>

                                                        <td style="margin-right: 7px;">
                                                            <div style="margin-left: 5px;">
                                                                <a href="delete?id=<c:out value='${todo.id}'/>" style="border: none; text-decoration: none;" data-mdb-toggle="tooltip" title="Remove">
                                                                    <img src="https://cdn-icons.flaticon.com/png/512/484/premium/484662.png?token=exp=1648301536~hmac=5bf484b3bb69702eb40edb95833049df"
                                                                         width="20" height="20"></a>
                                                            </div>
                                                        </td>
                                                        <td style="width: 10px;"></td>
                                                    </tr>
                                                    <tr style="height: 5px; background: #fff"></tr>
                                                </table>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>

                                </div>
                            </div>
                            <br>
                            <br>
                            <br>
                            <br>

                            <hr>
                            <!-- Tabs content -->
<%--                            <form action="<%=request.getContextPath()%>/new" method="post" class="d-flex justify-content-center align-items-center mb-4">--%>
                                                                <div class="form-outline flex-fill">
<%--                                                                    <input type="text" id="form2" class="form-control" />--%>
                                                                    <label class="form-label" ></label>
                                                                </div>
                                <a href="<%=request.getContextPath()%>/new" class="btn btn-info ms-2">Add</a>
<%--                            </form>--%>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>

    <script>
        function isCheckedDone() {
            let checkboxesDone = document.querySelectorAll("[id='checkDone']");

            for (i=0; i<checkboxesDone.length; i++){
                if (checkboxesDone[i].checked == true){
                    checkboxesDone[i].checked = true;
                    document.getElementById("isDone" + i).value = "True";

                } else {
                    checkboxesDone[i].checked = false;
                    document.getElementById("isDone" + i).value = "False";
                }
            }
        }

        function isCheckedProgress() {
            let checkboxesProgress = document.querySelectorAll("[id='checkProgress']");

            for (i=0; i<checkboxesProgress.length; i++){
                if (checkboxesProgress[i].checked == true){
                    checkboxesProgress[i].checked = true;
                    document.getElementById("isDone" + i).value = "True";
                    console.log(i + ". Done value: " + document.getElementById("isDone" + i).value)

                } else {
                    checkboxesProgress[i].checked = false;
                    console.log("Checked is false")
                    document.getElementById("isDone" + i).value = "False";
                   // console.log(i + ". Done value: " + document.getElementById("isDone" + i).value)
                }
            }

        }

        function isChecked() {
            let checkboxes = document.querySelectorAll("[id='check']");

            for (i=0; i<checkboxes.length; i++){
                if (checkboxes[i].checked == true){
                    checkboxes[i].checked = true;
                    document.getElementById("isDone" + i).value = "True";
                    console.log("Checked is True")
                } else {
                    checkboxes[i].checked = false;
                    console.log("Checked is false")
                    document.getElementById("isDone" + i).value = "False";
                }
            }
        }
    </script>


    </body>
</html>
