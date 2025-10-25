<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <div class="sm:px-6 sm:pb-6">
            <footer id="ft">
                <div class="footer-bg">
                    <img alt="Green Future Logo" class="footer-logo" src="${pageContext.request.contextPath}/asset/images/logo_gf_white.svg"
                         onclick="window.location.href = '${pageContext.request.contextPath}/home/home.jsp'" style="cursor: pointer;">
                    <div class="footer-row">
                        <div class="footer-company">
                            <p class="company-title">CÔNG TY CỔ PHẦN THƯƠNG MẠI VÀ<br>DỊCH VỤ TVT FUTURE</p>
                            <p class="company-info">MST/MSDN: 0110771285 do Sở KHĐT TP Đà Nẵng cấp lần 01 ngày
                                28/02/2025</p>
                            <p class="company-info">Địa chỉ: Khu đô thị công nghệ FPT Đà Nẵng, Phường Ngũ
                                Hành Sơn, Thành phố Đà Nẵng</p>
                            <img alt="BCT Logo" class="bct-logo" src="${pageContext.request.contextPath}/asset/images/logo-bct.png" style="color: transparent;">
                        </div>
                        <div class="footer-links">
                            <div class="footer-services">
                                <div class="footer-section-title"><a href="${pageContext.request.contextPath}/rental">Thuê xe</a></div>
                                <ul class="footer-link-list">
                                    <li><a>Ngắn hạn</a></li>
                                    <li><a>Dài hạn</a></li>
                                    <li><a>Doanh nghiệp</a></li>
                                </ul>
                            </div>
                            <div class="footer-about">
                                <div class="footer-section-title">Giới thiệu</div>
                                <ul class="footer-link-list">
                                    <li><a href="${pageContext.request.contextPath}/ve-chung-toi">Về chúng tôi</a></li>
                                    <li><a href="${pageContext.request.contextPath}/privacies-policy">Dịch vụ</a></li>
                                </ul>
                            </div>
                            <div class="footer-contact">
                                <div class="footer-section-title">Liên hệ</div>
                                <div class="footer-contact-list">
                                    <div class="footer-contact-row" onclick="window.location.href = 'tel:0778579293'"
                                         style="cursor: pointer;">
                                        <img alt="Headset Icon" width="16" height="16" src="${pageContext.request.contextPath}/asset/images/headset.svg">
                                        <span class="footer-contact-main-phone">0778 579 293</span>
                                    </div>
                                    <div class="footer-contact-row" onclick="window.location.href = 'tel:0889957488'"
                                         style="cursor: pointer;">
                                        <img alt="Phone call icon" width="16" height="16" src="${pageContext.request.contextPath}/asset/images/phone-call.svg">
                                        <span class="footer-contact-phone">0889 957 488</span>
                                    </div>
                                    <div class="footer-contact-row"
                                         onclick="window.location.href = 'mailto:support@tvtfuture.tech'" style="cursor: pointer;">
                                        <img alt="Mail icon" width="16" height="16" src="${pageContext.request.contextPath}/asset/images/mail.svg">
                                        <span class="footer-contact-email">support@tvtfuture.tech</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="footer-social">
                            <img alt="Instagram" class="social-icon" src="${pageContext.request.contextPath}/asset/images/icon-insta.svg">
                            <img alt="YouTube" class="social-icon" src="${pageContext.request.contextPath}/asset/images/icon-youtube.svg">
                            <img alt="Facebook" class="social-icon" src="${pageContext.request.contextPath}/asset/images/icon-facebook.svg">
                            <img alt="TikTok" class="social-icon" src="${pageContext.request.contextPath}/asset/images/icon-tiktok.svg">
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <p class="footer-copyright">© 2025 TVT Future. All rights reserved.</p>
                        <p class="footer-bottom-link">Điều khoản sử dụng</p>
                        <img src="${pageContext.request.contextPath}/asset/images/arrow-up.svg" class="arrow">
                    </div>
                </div>
            </footer>
        </div>
    </body>
</html>
