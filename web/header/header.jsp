<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@page import="model.Users,model.Customers" %>
<% Users user = (Users) session.getAttribute("currentUser");
    String displayName = null;
    boolean isLoggedIn = false;
    if (user != null) {
        isLoggedIn = true;
        Customers customer = (Customers) session.getAttribute("currentCustomer");
        if (customer != null && customer.getFullName() != null
                && !customer.getFullName().isEmpty()) {
            displayName = customer.getFullName();
        } else {
            displayName = user.getUsername();
        }
    }%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <header class="header<%= isLoggedIn ? " logged-in" : ""%>">
            <div class="header-wrap">
                <div class="nav-row">
                    <!-- Logo -->
                    <div class="logo-box">
                        <a href="home/home.jsp"><img
                                src="${pageContext.request.contextPath}/asset/images/logo_gf_white.svg"
                                alt="TVT Future" class="logo-img"></a>
                    </div>
                    <!-- Desktop Navigation -->
                    <a href="${pageContext.request.contextPath}/rental" class="nav-rental">Thuê xe</a>
                    <a href="#" class="nav-about">Giới thiệu</a>
                </div>
                <!-- Login/User Button -->
                <div class="user-area">
                    <div class="btn-login<%= isLoggedIn ? " logged-in" : ""%>">
                        <button id="login-btn">
                            <span class="login-info<%= !isLoggedIn ? " login-info--guest" : ""%>">
                                <img src="${pageContext.request.contextPath}/asset/images/<%= isLoggedIn ? "user-round-white.svg" : "user-round.svg"%>" alt="User"
                                     class="user-icon">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.currentUser}">
                                        <span class="user-name">
                                            <%= displayName%>
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span>Đăng nhập</span>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </button>
                    </div>
                    <% if (isLoggedIn) { %>
                    <div id="user-dropdown">
                        <div class="dropdown-list" role="menu" aria-orientation="vertical"
                             aria-labelledby="options-menu">
                            <a class="dropdown-link" role="menuitem" href="${pageContext.request.contextPath}/my-orders">
                                <div class="dropdown-item">
                                    <img src="${pageContext.request.contextPath}/asset/images/list-order.png" class="dropdown-icon">
                                    <span class="dropdown-text">Đơn hàng của tôi</span>
                                </div>
                            </a>
                            <a class="dropdown-link" role="menuitem" href="${pageContext.request.contextPath}/account/account-info/account-info.jsp">
                                <div class="dropdown-item">
                                    <img src="${pageContext.request.contextPath}/asset/images/account.png" class="dropdown-icon">
                                    <span class="dropdown-text">Tài khoản</span>
                                </div>
                            </a>
                            <form id="logoutForm" action="${pageContext.request.contextPath}/logout" method="post" style="display:inline;">
                                <input type="hidden" name="redirectUrl" value="<% String url = request.getRequestURL().toString(); if(url.contains("header.jsp")) { url = request.getContextPath() + "/"; } out.print(url + (request.getQueryString() != null ? ("?" + request.getQueryString()) : "")); %>">
                                <button type="submit" class="dropdown-link" role="menuitem" style="background:none;border:none;padding:0;margin:0;cursor:pointer;">
                                    <div class="dropdown-item">
                                        <img src="${pageContext.request.contextPath}/asset/images/log-out.png" class="dropdown-icon">
                                        <span class="dropdown-text">Đăng xuất</span>
                                    </div>
                                </button>
                            </form>
                        </div>
                    </div>
                    <% }%>
                </div>
            </div>
            <!-- Toast notification container -->
            <div class="toast-wrap">
                <div id="logout-toast" class="toast toast--success">
                    <div class="toast-icon">
                        <svg viewBox="0 0 24 24" width="24" height="24" fill="#10b981"><path d="M12 0a12 12 0 1012 12A12.014 12.014 0 0012 0zm6.927 8.2l-6.845 9.289a1.011 1.011 0 01-1.43.188l-4.888-3.908a1 1 0 111.25-1.562l4.076 3.261 6.227-8.451a1 1 0 111.61 1.183z"></path></svg>
                    </div>
                    <div class="toast-body">Đăng xuất tài khoản thành công</div>
                    <button class="toast-close" aria-label="close" onclick="this.closest('.toast').style.display = 'none'">
                        <svg viewBox="0 0 14 16" width="16" height="16"><path fill-rule="evenodd" d="M7.71 8.23l3.75 3.75-1.48 1.48-3.75-3.75-3.75 3.75L1 11.98l3.75-3.75L1 4.48 2.48 3l3.75 3.75L9.98 3l1.48 1.48-3.75 3.75z"></path></svg>
                    </button>
                    <div class="toast-progress-wrap">
                        <div class="toast-progress-bar"></div>
                    </div>
                </div>
            </div>
        </header>
    </body>
</html>
