<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Điều khoản và pháp lý - TVT Future</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Tektur:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Mulish:ital,wght@0,200..1000;1,200..1000&display=swap" rel="stylesheet">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/my-orders.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/footer/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/login/login.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/password/password.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/register/register.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/header/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/privacies-policy.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/asset/images/logo_gf_black.svg">
    <style>
        .left-tabbar {
            width: 300px;
            max-width: 20%;
            padding: 1rem;
        }
        .left-tabbar-item {
            padding: 0.75rem 1rem;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            color: #2b6cb0;
        }
        .left-tabbar-item a {
            text-decoration: none;
            color: inherit;
        }
        .left-tabbar-item:hover {
            color: #2c5282;
        }
        .left-tabbar-item-selected {
            background: #fff;
            border-left: 4px solid #00d287;
        }
        .main-content {
            display: flex;
            gap: 2rem;
            padding-top: 88px; /* Đủ chỗ cho header cố định */
        }
        .content-area {
            flex: 1;
            padding: 1rem;
        }
        .policy-wrapper {
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <c:if test="${sessionScope.currentUser == null}">
        <c:redirect url="/login/login.jsp"/>
    </c:if>

    <!-- Header -->
    <div id="header-container"></div>

    <!-- Main Content -->
    <main class="main-content">
        <div class="flex-col gap-4 w-[300px] max-w-[20%] md:block hidden left-tabbar">
            <div class="left-tabbar-item px-4 py-3 text-base font-bold cursor-pointer"><a href="${pageContext.request.contextPath}/account-info">Tài khoản của tôi</a></div>
            <div class="left-tabbar-item px-4 py-3 text-base font-bold cursor-pointer"><a href="${pageContext.request.contextPath}/my-orders">Đơn hàng của tôi</a></div>
            <div class="left-tabbar-item px-4 py-3 text-base font-bold cursor-pointer left-tabbar-item-selected">
                <div class="left-tabbar-item-div-selected"></div>Điều khoản và pháp lý
            </div>
            <div class="left-tabbar-item px-4 py-3 text-base font-bold cursor-pointer"><a href="${pageContext.request.contextPath}/account/change-password/change-password.jsp">Đổi mật khẩu</a></div>
            <div style="height: 1px; background-color: rgb(221, 221, 221);"></div>
        </div>
        <div class="content-area">
            <div class="flex-1 bg-white rounded-lg">
                <div class="policy-wrapper bg-box bg-white p-[32px] is-border-radius">
                    <div class="my-16">
                        <div class="container my-16">
                            <div class="grid grid-cols-4 lg:grid-cols-12 gap-y-8 gap-x-16">
                                <div class="col-span-4 lg:col-span-12">
                                    <div class="max-w-none mx-auto prose dark:prose-invert">
                                                    <h2 class="col-start-2 text-title"><strong>CÔNG TY CỔ PHẦN THƯƠNG MẠI VÀ DỊCH
                                                            VỤ GREEN FUTURE</strong></h2>
                                                    <h2 class="col-start-2 text-title"><strong>ĐIỀU KHOẢN CHUNG</strong></h2>
                                                    <p class="col-start-2" style="text-align: left;"><strong>PHẦN I.
                                                            GIỚI THIỆU</strong></p>
                                                    <h1 class="col-start-2">1.MỤC ĐÍCH</h1>
                                                    <p class="col-start-2" style="text-align: left;">Điều Khoản Chung
                                                        này (“<strong>ĐKC</strong>”) áp dụng cho các Khách Hàng sử dụng
                                                        dịch vụ cho thuê xe ô tô của Công ty Cổ phần Thương mại và Dịch
                                                        vụ Green Future (“<strong>Green Future</strong>”). Tại ĐKC này,
                                                        Green Future và Khách Hàng sẽ được gọi riêng là một
                                                        “<strong>Bên</strong>” hoặc gọi chung là “<strong>Các
                                                            Bên</strong>”.</p>
                                                    <h1 class="col-start-2">2.ĐỊNH NGHĨA</h1>
                                                    <h2 class="col-start-2">Trừ trường hợp được quy định khác tại Hợp
                                                        Đồng Dịch Vụ (như được định nghĩa ở dưới), các từ ngữ, thuật ngữ
                                                        được viết hoa tại ĐKC này có nghĩa như sau:</h2>
                                                    <h2 class="col-start-2">2.1."<strong>Bảng tổng hợp Phí Dịch
                                                            Vụ</strong>” có nghĩa là bảng tổng hợp Phí Dịch Vụ mà Khách
                                                        Hàng có nghĩa vụ phải thanh toán, được Green Future lập và gửi
                                                        cho Khách Hàng sau khi ký kết biên bản trả Xe (đối với Dịch Vụ
                                                        theo giờ/ngày), hoặc sau mỗi Kỳ Thanh Toán (đối với Dịch Vụ theo
                                                        tháng/năm).</h2>
                                                    <h2 class="col-start-2">2.2.<strong>“Cao Điểm” </strong>hoặc<strong>
                                                            “Lễ Tết”</strong> là khoảng thời gian bao gồm:</h2>
                                                    <ol class="list col-start-2">
                                                        <li value="1">Tết Nguyên Đán (Âm lịch): Từ ngày 28 tháng Chạp
                                                            đến mùng 5 tháng Giêng (Âm lịch);</li>
                                                        <li value="2">Lễ 30/4 - 1/5: Từ 29/4 đến 2/5;</li>
                                                        <li value="3">Lễ Quốc Khánh 2/9: Từ 31/8 đến 3/9;</li>
                                                        <li value="4">Lễ Giáng Sinh và Tết Dương lịch: Từ ngày 24/12 của
                                                            năm đến ngày 2/1 của năm liền sau;</li>
                                                        <li value="5">Giỗ Tổ Hùng Vương (10/3 Âm lịch): Từ ngày liền
                                                            trước ngày 10/3 Âm lịch đến ngày liền sau ngày 10/3 Âm lịch;
                                                            hoặc</li>
                                                        <li value="6">Giai đoạn Cao Điểm khác theo quyết định và công bố
                                                            của Green Future trên Kênh Thông Tin tùy từng thời điểm.
                                                        </li>
                                                    </ol>
                                                    <h2 class="col-start-2">2.3.<strong>“Chi Phí</strong>” là các loại
                                                        phí thực tế phát sinh khi Khách Hàng sử dụng Dịch Vụ mà Green
                                                        Future trả thay Khách Hàng (nếu có) như quy định tại Điều – Phần
                                                        II của ĐKC.</h2>
                                                    <h2 class="col-start-2">2.4.“<strong>Dịch Vụ</strong>” có nghĩa là
                                                        bất kỳ dịch vụ cho thuê Xe (bao gồm dịch vụ cho thuê Xe tự lái
                                                        và dịch vụ cho thuê Xe có kèm Tài Xế) theo bất kỳ thời hạn nào
                                                        (theo giờ/ngày/tháng/năm) theo thỏa thuận giữa Green Future và
                                                        Khách Hàng.</h2>
                                                    <h2 class="col-start-2">2.5.“<strong>Đặt Dịch Vụ</strong>” là việc
                                                        Khách Hàng gửi yêu cầu cung cấp Dịch Vụ tới Green Future theo
                                                        các phương thức quy định tại ĐKC này.</h2>
                                                    <h2 class="col-start-2">2.6.<strong>“Giới Hạn Km Sử Dụng</strong>”
                                                        có nghĩa là giới hạn quãng đường/lộ trình di chuyển của Xe và Xe
                                                        thay thế (nếu có) tương ứng với Phí Cơ Bản, được quy định cụ thể
                                                        tại Hợp Đồng Dịch Vụ.</h2>
                                                    <h2 class="col-start-2">2.7.<strong>“Giờ Làm Việc”</strong> là 01
                                                        (một) giờ trong khoảng thời gian bắt đầu từ 7h sáng tới 21h hàng
                                                        ngày.</h2>
                                                    <h2 class="col-start-2">2.8.“<strong>Hợp Đồng Dịch Vụ</strong>” là
                                                        hợp đồng được ký kết giữa Green Future và Khách Hàng, và các phụ
                                                        lục sửa đổi, bổ sung (nếu có) nhằm cung cấp Dịch Vụ cho Khách
                                                        Hàng tùy từng trường hợp.</h2>
                                                    <h2 class="col-start-2">2.9.“<strong>Kênh Thông Tin</strong>” có
                                                        nghĩa là (i) website<a class=""
                                                            href="https://greenfuture.tech/"><span
                                                                style="text-decoration: underline;">https://greenfuture.tech/</span></a>,
                                                        (ii) ứng dụng di động Green Future Rental, và/hoặc (iii) các
                                                        kênh truyền thông, thông tin, trang thông tin điện tử khác thuộc
                                                        sở hữu của Green Future hoặc do Green Future quản lý, vận hành
                                                        và khai thác, được Green Future thông báo và công bố chính thức
                                                        cho Khách Hàng trước khi triển khai áp dụng.</h2>
                                                    <h2 class="col-start-2">2.10.“<strong>Khách Hàng</strong>” có nghĩa
                                                        là bất kỳ tổ chức, cá nhân nào đã ký kết Hợp Đồng Dịch Vụ với tư
                                                        cách là bên thuê Xe.</h2>
                                                    <h2 class="col-start-2">2.11.“<strong>Người Sử Dụng</strong>” có
                                                        nghĩa là bất kỳ cá nhân nào sử dụng Xe trong thời hạn của Dịch
                                                        Vụ, bao gồm cả người lái Xe và người ngồi trên xe.</h2>
                                                    <h2 class="col-start-2">2.12.“<strong>Ngày Làm Việc</strong>” có
                                                        nghĩa là các ngày từ thừ Hai đến thứ Bảy hàng tuần, và không bao
                                                        gồm Chủ Nhật và các ngày nghỉ, ngày lễ theo quy định của pháp
                                                        luật Việt Nam.</h2>
                                                    <h2 class="col-start-2">2.13.“<strong>Phí Cơ Bản</strong>” là phí để
                                                        sử dụng Dịch Vụ trong phạm vi Giới Hạn Km Sử Dụng như được quy
                                                        định tại Điều – Phần II của ĐKC.</h2>
                                                    <h2 class="col-start-2">2.14.“<strong>Phí Dịch Vụ</strong>” có nghĩa
                                                        là mọi chi phí, phí tổn, khoản thanh toán phát sinh trong quá
                                                        trình sử dụng Dịch Vụ mà Khách Hàng phải thanh toán cho Green
                                                        Future theo quy định tại ĐKC và Hợp Đồng Dịch Vụ, trong đó bao
                                                        gồm nhưng không giới hạn tại Phí Cơ Bản, Phí Vượt Giới Hạn Km Sử
                                                        Dụng và các Phụ Phí Khác (như được quy định cụ thể ở tại ĐKC
                                                        này).</h2>
                                                    <h2 class="col-start-2">2.15.“<strong>Phụ</strong>
                                                        <strong>Phí</strong>” có nghĩa là có nghĩa là các khoản phí phụ
                                                        thu ngoài Phí Cơ Bản phát sinh trong quá trình sử dụng Dịch Vụ
                                                        như được quy định tại Điều – Phẩn II của ĐKC.</h2>
                                                    <h2 class="col-start-2">2.16.“<strong>Tài Xế</strong>” có nghĩa là
                                                        người lái Xe Ô Tô của Green Future đối với Dịch Vụ cho thuê Xe
                                                        có kèm Tài Xế.</h2>
                                                    <h2 class="col-start-2">2.17.“<strong>Xe”</strong> hoặc “<strong>Xe
                                                            Ô Tô”</strong> có nghĩa là bất kỳ xe ô tô nào thuộc quyền sở
                                                        hữu, sử dụng và/hoặc quản lý hợp pháp của Green Future, được sử
                                                        dụng để cung cấp Dịch Vụ, đã được mua bảo hiểm trách nhiệm dân
                                                        sự của chủ xe cơ giới theo quy định của pháp luật.</h2>
                                                    <p class="col-start-2" style="text-align: left;"></p>
                                                    <p class="col-start-2" style="text-align: left;"><strong>PHẦN II.
                                                            ĐIỀU KHOẢN CHUNG</strong></p>
                                                    <ol class="list col-start-2">
                                                        <li value="1">
                                                            <h1 class="col-start-2">DỊCH VỤ CỦA GREEN FUTURE</h1>
                                                        </li>
                                                    </ol>
                                                    <h2 class="col-start-2">1.1.Green Future cung cấp các loại hình Dịch
                                                        Vụ (bao gồm cho thuê Xe kèm Tài Xế, và cho thuê Xe không kèm Tài
                                                        Xế) cho Khách Hàng theo ĐKC này và Hợp Đồng Dịch Vụ với thời hạn
                                                        thuê linh hoạt như sau:</h2>
                                                    <h3 class="col-start-2">1.1.1.Dịch Vụ theo giờ: Được tính từ thời
                                                        điểm Khách Hàng nhận Xe và kết thúc sau khoảng thời gian tương
                                                        ứng với số giờ đã thuê.</h3>
                                                    <h3 class="col-start-2">1.1.2.Dịch Vụ theo ngày: Được tính từ thời
                                                        điểm Khách Hàng nhận bàn giao Xe cho đến hết hai mươi bốn (24)
                                                        tiếng liền sau thời điểm nhận bàn giao Xe.</h3>
                                                    <h3 class="col-start-2">1.1.3.Dịch Vụ theo tháng: Được tính từ ngày
                                                        Khách Hàng nhận bàn giao Xe đến ngày liền trước cùng ngày của
                                                        tháng kết thúc thời hạn thuê Xe.</h3>
                                                    <h3 class="col-start-2">1.1.4.Dịch Vụ theo năm: Được tính từ ngày
                                                        Khách Hàng nhận bàn giao Xe đến ngày trước cùng ngày của năm kế
                                                        tiếp.</h3>
                                                    <h2 class="col-start-2">1.2.Đối với Dịch Vụ cho thuê Xe kèm Tài Xế,
                                                        thời gian làm việc của Tài Xế như sau:</h2>
                                                    <h3 class="col-start-2">1.2.1.Dịch Vụ thuê Xe kèm Tài Xế theo ngày:
                                                        Từ 8 giờ sáng đến 18 giờ tối (hoặc tối đa 10 giờ trong khoảng
                                                        thời gian từ 0 giờ sáng tới 23 giờ 59 phút cùng ngày), từ thứ
                                                        Hai đến thứ Bảy, và không bao gồm ngày nghỉ lễ theo quy định của
                                                        pháp luật.</h3>
                                                    <h3 class="col-start-2">1.2.2.Dịch Vụ thuê Xe kèm Tài Xế theo tháng:
                                                        Tài Xế làm việc không quá 26 ngày/tháng dương lịch (được tính từ
                                                        ngày 1 và kết thúc vào ngày cuối cùng của tháng), và trong khung
                                                        giờ từ 8 giờ sáng đến 18 giờ tối của mỗi ngày không bao gồm Chủ
                                                        Nhật, ngày nghỉ lễ theo quy định của pháp luật.</h3>
                                                    <ol class="list col-start-2">
                                                        <li value="2">
                                                            <h1 class="col-start-2">ĐẶT, GIẢM, HỦY DỊCH VỤ:</h1>
                                                        </li>
                                                    </ol>
                                                    <h2 class="col-start-2">2.1.Phương thức Đặt Dịch Vụ</h2>
                                                    <h3 class="col-start-2">Đặt Dịch Vụ được thực hiện thông qua (i) các
                                                        công cụ đặt Dịch Vụ trên các Kênh Thông Tin của Green Future;
                                                        hoặc (ii) gửi thư đặt Dịch Vụ cho Green Future tới địa chỉ thư
                                                        điện tử của Green Future được công bố trên các Kênh Thông Tin
                                                        theo biểu mẫu tại Phụ lục 01 đính kèm Hợp đồng thuê xe.</h3>
                                                    <h2 class="col-start-2">2.2.Thời gian Đặt Dịch Vụ</h2>
                                                    <h3 class="col-start-2">2.2.1.Trong giai đoạn thường (không phải là
                                                        giai đoạn Cao Điểm, Lễ Tết):</h3>
                                                    <h4 class="col-start-2">(a)Thời điểm Đặt Dịch Vụ từ 7 giờ sáng đến
                                                        trước 18 giờ cùng ngày: Khách Hàng có thể yêu cầu giao nhận Xe
                                                        sớm nhất sau 03 (ba) Giờ Làm Việc cùng ngày kể từ thời điểm đặt
                                                        Dịch Vụ;</h4>
                                                    <h4 class="col-start-2">(b)Thời điểm Đặt Dịch Vụ từ 18 giờ đến 21
                                                        giờ cùng ngày: Khách Hàng có thể yêu cầu giao nhận Xe sớm nhất
                                                        bắt đầu từ 8 giờ sáng ngày hôm sau;</h4>
                                                    <h4 class="col-start-2">(c)Thời điểm Đặt Dịch Vụ từ 21 giờ đến trước
                                                        7 giờ sáng ngày hôm sau: Green Future sẽ liên hệ để chốt thời
                                                        điểm giao Xe cho Khách Hàng.</h4>
                                                    <h3 class="col-start-2">2.2.2.Trong giai đoạn Cao Điểm, Lễ Tết,
                                                        Khách Hàng có thể thực hiện đặt Dịch Vụ và yêu cầu thời gian
                                                        giao nhận Xe sớm nhất sau 05 (năm) Ngày Làm Việc kể từ thời điểm
                                                        Đặt Dịch Vụ.</h3>
                                                    <h3 class="col-start-2">2.2.3.Đối với Dịch Vụ thuê Xe theo ngày,
                                                        Khách hàng có thể yêu cầu thay đổi thời gian giao/trả Xe hoặc
                                                        loại Xe trước khi bắt đầu thời hạn của Dịch Vụ, tùy thuộc vào
                                                        tình trạng sẵn có và thời điểm nhận xe. Khách Hàng có thể bị
                                                        tính phí thay đổi Dịch Vụ.</h3>
                                                    <h3 class="col-start-2">2.2.4.Khách Hàng chỉ có thể yêu cầu giao
                                                        nhận Xe trong khung Giờ Làm Việc khi Đặt Dịch Vụ. Nếu thời gian
                                                        yêu cầu giao Xe hoặc trả Xe nằm ngoài khung Giờ Làm Việc thì
                                                        Green Future sẽ liên hệ để chốt thời điểm giao hoặc trả Xe cho
                                                        Khách Hàng.</h3>
                                                    <h2 class="col-start-2">2.3.Giảm, hủy Dịch Vụ trước khi sử dụng Dịch
                                                        Vụ</h2>
                                                    <h3 class="col-start-2">2.3.1.Giảm, hủy Dịch Vụ thuê Xe theo ngày:
                                                    </h3>
                                                    <h4 class="col-start-2">(a)Khách Hàng thực hiện yêu cầu giảm, hủy
                                                        Dịch Vụ trước thời điểm sử dụng Dịch Vụ ít nhất 24 (hai mươi tư)
                                                        giờ trong giai đoạn thường, hoặc ít nhất 72 giờ trong giai đoạn
                                                        Cao Điểm: Khách Hàng được miễn phí giảm, hủy Dịch Vụ và hoàn lại
                                                        khoản Phí Cơ Bản tương ứng với thời gian giảm, hủy Dịch Vụ Khách
                                                        Hàng yêu cầu.</h4>
                                                    <h4 class="col-start-2">(b)Khách Hàng được hoàn lại 50% (năm mươi
                                                        phần trăm) khoản Phí Cơ Bản tương ứng với thời gian giảm, hủy
                                                        Dịch Vụ Khách Hàng yêu cầu trong trường hợp Khách Hàng thực hiện
                                                        yêu cầu giảm, hủy Dịch Vụ:</h4>
                                                    <h5 class="col-start-2">(i)trong vòng 24 giờ gần nhất tính đến trước
                                                        thời điểm sử dụng Dịch Vụ trong giai đoạn thường; hoặc</h5>
                                                    <h5 class="col-start-2">(ii)trong khoảng thời gian từ sau 72 giờ đến
                                                        24 giờ trước thời điểm trước thời điểm sử dụng Dịch Vụ trong
                                                        giai đoạn Cao Điểm.</h5>
                                                    <h4 class="col-start-2">(c)Green Future sẽ không hoàn trả Phí Cơ Bản
                                                        cho Khách Hàng trong các trường hợp sau:</h4>
                                                    <h5 class="col-start-2">(i)Khách Hàng không có mặt để nhận xe tại
                                                        Địa Điểm Giao Nhận Xe vào thời điểm giao nhận xe; hoặc</h5>
                                                    <h5 class="col-start-2">(ii)Khách Hàng thực hiện yêu cầu giảm, hủy
                                                        Dịch Vụ trong khoảng thời gian muộn hơn 24 (hai mươi tư) giờ
                                                        trước thời điểm sử dụng Dịch Vụ trong giai đoạn Cao Điểm.</h5>
                                                    <h3 class="col-start-2">2.3.2.Giảm, hủy Dịch Vụ cho thuê Xe theo
                                                        tháng:</h3>
                                                    <h4 class="col-start-2">(a)Khách Hàng thực hiện yêu cầu giảm, hủy
                                                        Dịch Vụ trước thời điểm sử dụng Dịch Vụ ít nhất 30 (ba mươi)
                                                        ngày sẽ không phải thanh toán phí giảm, hủy Dịch Vụ.</h4>
                                                    <h4 class="col-start-2">(b)Khách Hàng thực hiện yêu cầu giảm, hủy
                                                        Dịch Vụ trong khoảng thời gian muộn hơn 30 (ba mươi) ngày cho
                                                        đến 15 (mười lăm) ngày trước thời điểm sử dụng Dịch Vụ có nghĩa
                                                        vụ thanh toán phí giảm, hủy Dịch Vụ là 50% giá trị Khoản Đặt Cọc
                                                        của Dịch Vụ bị giảm, hủy.</h4>
                                                    <h4 class="col-start-2">(c)Khách Hàng thực hiện yêu cầu giảm, hủy
                                                        Dịch Vụ muộn hơn 15 (mười lăm) ngày trước thời điểm sử dụng Dịch
                                                        Vụ có nghĩa vụ thanh toán phí giảm, hủy Dịch Vụ là 70% giá trị
                                                        Khoản Đặt Cọc của Dịch Vụ bị giảm, hủy.</h4>
                                                    <h3 class="col-start-2">2.3.3.Giảm, hủy Dịch Vụ cho thuê Xe theo
                                                        năm:</h3>
                                                    <h4 class="col-start-2">(a)Khách Hàng thực hiện yêu cầu giảm, hủy
                                                        Dịch Vụ trước thời điểm sử dụng Dịch Vụ ít nhất 30 (ba mươi)
                                                        ngày có nghĩa vụ thanh toán phí giảm, hủy Dịch Vụ là 50% giá trị
                                                        Khoản Đặt Cọc của Dịch Vụ bị giảm, hủy.</h4>
                                                    <h4 class="col-start-2">(b)Khách Hàng thực hiện yêu cầu giảm, hủy
                                                        Dịch Vụ trong khoảng thời gian muộn hơn 30 (ba mươi) trước thời
                                                        điểm sử dụng Dịch Vụ ngày có nghĩa vụ thanh toán phí giảm, hủy
                                                        Dịch Vụ là 100% giá trị Khoản Đặt Cọc của Dịch Vụ bị giảm, hủy.
                                                    </h4>
                                                    <h1 class="col-start-2">3.NGUYÊN TẮC TÍNH PHÍ DỊCH VỤ VÀ CÁC CHI PHÍ
                                                        PHÁT SINH</h1>
                                                    <h2 class="col-start-2">3.1.Phí Cơ Bản</h2>
                                                    <h3 class="col-start-2">3.1.1.Phí Cơ Bản cho mỗi Xe thuê tương ứng
                                                        với thời hạn của Dịch Vụ và loại hình Dịch Vụ mà Khách Hàng sử
                                                        dụng trong Giới Hạn Km Sử Dụng, với đơn giá được niêm yết tại
                                                        các địa điểm kinh doanh của Green Future và/hoặc trên các Kênh
                                                        Thông Tin của Green Future tùy từng thời điểm (“<strong>Phí Cơ
                                                            Bản</strong>”).</h3>
                                                    <h3 class="col-start-2">3.1.2.Thời gian cung cấp Dịch Vụ được tính
                                                        từ thời điểm Khách Hàng được giao Xe đến thời điểm Khách Hàng
                                                        trả Xe trên thực tế, bao gồm cả thời gian Khách Hàng không sử
                                                        dụng Xe (đối với Dịch Vụ cho thuê Xe tự lái) và thời gian không
                                                        lái Xe của Tài Xế (đối với Dịch Vụ cho thuê Xe kèm Tài Xế).</h3>
                                                    <h3 class="col-start-2">3.1.3.Cách thức tính Phí Cơ Bản</h3>
                                                    <h4 class="col-start-2">(a)Đối với Dịch Vụ cho thuê Xe theo ngày,
                                                        Phí Cơ Bản của mỗi ngày sẽ được tính từ thời điểm Khách Hàng
                                                        nhận bàn giao Xe cho đến hết hai mươi bốn (24) tiếng liền sau
                                                        thời điểm nhận bàn giao Xe.</h4>
                                                    <h4 class="col-start-2">(b)Đối với Dịch Vụ cho Thuê Xe theo
                                                        tháng/năm, Phí Cơ Bản mỗi tháng sẽ được tính theo Kỳ Thanh Toán
                                                        quy định tại Điều của ĐKC này. Trong tháng Green Future và Khách
                                                        Hàng giao/trả Xe, Phí Cơ Bản sẽ được tính trên số ngày sử dụng
                                                        Xe thực tế trong Kỳ Thanh Toán.</h4>
                                                    <h3 class="col-start-2">3.1.4.Phí Cơ Bản đã bao gồm các chi phí sau
                                                        đây:</h3>
                                                    <h4 class="col-start-2">(a)Bảo hiểm vật chất Xe, các loại bảo hiểm
                                                        bắt buộc theo quy định của pháp luật;</h4>
                                                    <h4 class="col-start-2">(b)Phí bảo trì đường bộ; và</h4>
                                                    <h4 class="col-start-2">(c)Phí bảo trì bảo dưỡng Xe theo quy định
                                                        của công ty sản xuất Xe.</h4>
                                                    <h3 class="col-start-2">Phí Cơ Bản không bao gồm các khoản Phụ Phí
                                                        và các chi phí phát sinh khác quy định tại Điều 3.2 và 3.3</h3>
                                                    <h2 class="col-start-2">3.2.Phụ Phí</h2>
                                                    <h3 class="col-start-2">3.2.1.Phí Vượt Giới Hạn Km Sử Dụng</h3>
                                                    <ol class="list col-start-2">
                                                        <li value="1">Phí Vượt Giới Hạn Km Sử Dụng là khoản phí Khách
                                                            Hàng phải thanh toán cho Green Future khi lộ trình di chuyển
                                                            của Khách Hàng trong quá trình sử dụng Dịch Vụ vượt Giới Hạn
                                                            Km Sử Dụng.</li>
                                                        <li value="2">Km phụ trội sẽ được tính chính xác đến hai số sau
                                                            dấu phẩy và được làm tròn theo nguyên tắc: Chữ số thứ ba sau
                                                            dấu phẩy rút gọn nếu lớn hơn hoặc bằng 5 thì được tăng thêm
                                                            một đơn vị; nếu nhỏ hơn 5 thì không tính.</li>
                                                    </ol>
                                                    <h3 class="col-start-2">3.2.2.Phí trả Xe quá hạn</h3>
                                                    <h4 class="col-start-2">(a)Đối với Dịch Vụ cho thuê Xe theo ngày,
                                                        Khách Hàng có nghĩa vụ thanh toán cho Green Future phụ phí trả
                                                        Xe quá hạn trong trường hợp Khách Hàng trả Xe quá hạn như sau:
                                                    </h4>
                                                    <h5 class="col-start-2">(i)Muộn từ 01 đến 03 giờ: Khách Hàng thanh
                                                        toán khoản phụ thu 150.000VNĐ/giờ cho mỗi giờ muộn (từ 30 phút
                                                        trở lên sẽ được làm tròn thành 1 giờ).</h5>
                                                    <h5 class="col-start-2">(ii)Muộn từ trên 03 giờ đến 06 giờ: Khách
                                                        Hàng có nghĩa vụ thanh toán cho GF phụ phí trả Xe quá hạn là 50%
                                                        (năm mươi phần trăm) Phí Cơ Bản áp dụng cho 01 (một) ngày.</h5>
                                                    <h5 class="col-start-2">(iii)Muộn từ trên 06 (sáu) giờ: Khách Hàng
                                                        có nghĩa vụ thanh toán cho GF phụ phí trả Xe quá hạn là 100%
                                                        (một trăm phần trăm) Phí Cơ Bản áp dụng cho 01 (một) ngày, trừ
                                                        trường hợp quy định tại Mục (iv) dưới đây.</h5>
                                                    <h5 class="col-start-2">(iv)Nếu Khách Hàng trả Xe muộn sau 22h00 mà
                                                        thời gian đến hạn trả Xe tính đến 22h00 chưa vượt quá 06 (sáu)
                                                        giờ, Khách Hàng sẽ trả thêm phí&nbsp;trả Xe quá hạn bằng 50% Phí
                                                        Cơ Bản 01 (một) ngày và Khách Hàng cần trả xe muộn nhất lúc 8h00
                                                        ngày kế tiếp. Nếu Khách Hàng trả Xe sau 8h00 của ngày kế tiếp,
                                                        Khách Hàng có nghĩa vụ thanh toán cho GF phụ phí trả Xe quá hạn
                                                        là Phí Cơ Bản áp dụng cho 01 (một) ngày và Khách Hàng được trả
                                                        xe muộn nhất tới 21h00&nbsp;ngày hôm đó (phí này sẽ tính luỹ kế
                                                        cộng cồn tới khi khách hàng hoàn tất nghĩa vụ trả xe).</h5>
                                                    <h4 class="col-start-2">(b)Đối với Dịch Vụ cho thuê Xe theo
                                                        tháng/năm: Nếu khách hàng trả Xe muộn sau 21 giờ của Ngày hết
                                                        hạn thuê Xe, Khách Hàng có nghĩa vụ thanh toán Phí Cơ Bản áp
                                                        dụng đối với loại Dịch Vụ này cho 01 (một) ngày.</h4>
                                                    <h3 class="col-start-2">3.2.3.Phí trả Xe trước hạn</h3>
                                                    <h4 class="col-start-2">(a)Đối với Dịch Vụ cho thuê Xe theo ngày:
                                                    </h4>
                                                    <h5 class="col-start-2">(i)Trong trường hợp Khách Hàng thông bảo trả
                                                        Xe trước hạn cho Green Future ít nhất 05 (năm) trước ngày dự
                                                        định trả Xe, Khách Hàng được miễn phí trả Xe trước hạn, và được
                                                        hoàn lại khoản Phí Cơ Bản đối với thời gian thuê Xe không sử
                                                        dụng theo Hợp Đồng Dịch Vụ;</h5>
                                                    <h5 class="col-start-2">(ii)Trong trường hợp Khách Hàng thông báo
                                                        trả Xe trước hạn cho Green Future từ dưới 05 (năm) ngày đến 03
                                                        (ba) ngày trước ngày dự định trả Xe, Khách Hàng được hoàn lại
                                                        50% Phí Cơ Bản đối với thời gian thuê Xe không sử dụng. 50% Phí
                                                        Cơ Bản còn lại đối với thời gian thuê Xe không sử dụng là phí
                                                        trả Xe trước hạn mà Khách Hàng phải thanh toán cho Green Future;
                                                    </h5>
                                                    <h5 class="col-start-2">(iii)Trong trường hợp Khách Hàng thông báo
                                                        trả Xe trước hạn cho Green Future muộn hơn 03 (ba) ngày trước
                                                        ngày dự định trả Xe, Green Future không có nghĩa vụ hoàn lại cho
                                                        Khách hàng khoản Phí Cơ bản đã được thanh toán theo Hợp Đồng
                                                        Dịch Vụ. Theo đó, khoản Phí Cơ Bản đối với thời gian thuê Xe
                                                        không sử dụng là phí trả Xe trước hạn mà Khách Hàng phải thanh
                                                        toán cho Green Future.</h5>
                                                    <h4 class="col-start-2">(b)Đối với Dịch Vụ cho thuê Xe theo tháng:
                                                    </h4>
                                                    <h5 class="col-start-2">(i)Trong trường hợp Khách Hàng thông bảo trả
                                                        Xe trước hạn cho Green Future ít nhất 30 (ba mươi) trước ngày dự
                                                        định trả Xe, Khách Hàng được miễn phí trả Xe trước hạn;</h5>
                                                    <h5 class="col-start-2">(ii)Trong trường hợp Khách Hàng thông báo
                                                        trả Xe trước hạn cho Green Future từ dưới 30 (ba mươi) ngày đến
                                                        15 (mười lăm) ngày trước ngày dự định trả Xe, tiền phí trả xe
                                                        trước hạn là 50% giá trị Khoản Đặt Cọc cho Xe được trả trước
                                                        hạn;</h5>
                                                    <h5 class="col-start-2">(iii)Trong trường hợp Khách Hàng thông báo
                                                        trả Xe trước hạn cho Green Future muộn hơn 15 (mười lăm) ngày
                                                        trước ngày dự định trả Xe, tiền phí trả xe trước hạn là 100% giá
                                                        trị Khoản Đặt Cọc cho Xe được trả trước hạn.</h5>
                                                    <h4 class="col-start-2">(c)Đối với Dịch Vụ cho thuê Xe theo năm:
                                                    </h4>
                                                    <h5 class="col-start-2">(i)Trong trường hợp Khách Hàng thông báo trả
                                                        Xe trước hạn cho Green Future ít nhất 30 (ba mươi) trước ngày dự
                                                        định trả Xe, tiền phí trả xe trước hạn là 50% giá trị Khoản Đặt
                                                        Cọc cho Xe được trả trước hạn;</h5>
                                                    <h5 class="col-start-2">(ii)Trong trường hợp Khách Hàng thông báo
                                                        trả Xe trước hạn cho Green Future muộn hơn 30 (ba mươi) ngày
                                                        trước ngày dự định trả Xe, tiền phí trả xe trước hạn là 100% giá
                                                        trị Khoản Đặt Cọc cho Xe được trả trước hạn.</h5>
                                                    <h3 class="col-start-2">3.2.4.Các loại Phụ Phí khác</h3>
                                                    <h3 class="col-start-2">Các loại Phụ Phí khác bao gồm nhưng không
                                                        giới hạn: phí làm việc ngoài giờ của Tài Xế (đối với Dịch Vụ
                                                        thuê xe kèm Tài Xế), phụ phí cung cấp Dịch Vụ cuối tuần và các
                                                        giai đoạn Cao Điểm, Lễ Tết, phí trả Xe ngoài Giờ Làm Việc, và
                                                        các loại phụ phí khác theo chính sách của GF được thông báo cho
                                                        Khách Hàng tại thời điểm Khách Hàng thực hiện Đặt Dịch Vụ.</h3>
                                                    <h2 class="col-start-2">3.3.Các khoản Chi Phí phải trả:</h2>
                                                    <h3 class="col-start-2">3.3.1.Bồi thường thiệt hại: Khách Hàng có
                                                        trách nhiệm bồi thường toàn bộ thiệt hại liên quan đến Xe (nếu
                                                        có) trong thời gian Xe hoặc giấy tờ Xe bị cơ quan chức năng thu
                                                        giữ do hành vi vi phạm pháp luật của Khách Hàng, Người Sử Dụng
                                                        hoặc do hành vi vi phạm pháp luật xuất phát từ yêu cầu của Khách
                                                        Hàng và/hoặc Người Sử Dụng.</h3>
                                                    <h3 class="col-start-2">3.3.2.Các chi phí mà GF thanh toán thay cho
                                                        Khách Hàng trong quá trình Khách Hàng sử dụng Dịch Vụ, bao gồm:
                                                    </h3>
                                                    <h4 class="col-start-2">(a)Phí sạc pin;</h4>
                                                    <h4 class="col-start-2">(b)Phí giao xe tới địa điểm (không phải là
                                                        địa điểm kinh doanh của GF) mà Khách Hàng chỉ định;</h4>
                                                    <h4 class="col-start-2">(c)Phí bảo dưỡng theo quy định của công ty
                                                        sản xuất Xe;</h4>
                                                    <h4 class="col-start-2">(d)Phí cầu đường, phí đỗ Xe;</h4>
                                                    <h4 class="col-start-2">(e)Các khoản phạt vi phạm an toàn giao
                                                        thông; và</h4>
                                                    <h4 class="col-start-2">(f)Các chi phí liên quan khác.</h4>
                                                    <h1 class="col-start-2">4.ĐẶT CỌC</h1>
                                                    <h2 class="col-start-2">4.1.Khách Hàng có nghĩa vụ đặt cọc một khoản
                                                        tiền tương ứng với loại xe, số lượng xe và thời gian thuê xe
                                                        (theo ngày/tháng/năm) mà Khách Hàng thuê (“<strong>Khoản Đặt
                                                            Cọc</strong>”), theo các yêu cầu về đặt cọc được công bố
                                                        trên các Kênh Thông Tin của Green Future tùy từng thời điểm hoặc
                                                        tại Hợp Đồng Dịch Vụ.</h2>
                                                    <h2 class="col-start-2">4.2.Thời hạn đặt cọc:</h2>
                                                    <h3 class="col-start-2">Đối với Dịch Vụ theo giờ/ngày: Ngay sau khi
                                                        Khách Hàng thực hiện Đặt Dịch Vụ.</h3>
                                                    <h3 class="col-start-2">Đối với Dịch Vụ theo tháng/năm:<em> </em>05
                                                        (năm) Ngày Làm Việc kể từ ngày Khách Hàng Đặt Dịch Vụ và chậm
                                                        nhất 15 (mười lăm) ngày trước thời điểm bàn giao Xe.</h3>
                                                    <h2 class="col-start-2">4.3.Đặt Dịch Vụ chỉ có hiệu lực khi Khách
                                                        Hàng chuyển đầy đủ Khoản Đặt Cọc cho Green Future theo thời hạn
                                                        đặt cọc quy định tại ĐKC hoặc một thời hạn khác quy định cụ thể
                                                        tại Hợp Đồng Dịch Vụ.</h2>
                                                    <h2 class="col-start-2">4.4.Khoản Đặt Cọc phải được duy trì đầy đủ
                                                        trong suốt thời hạn thuê để đảm bảo cho việc Khách Hàng thực
                                                        hiện các nghĩa vụ thanh toán theo ĐKC và/hoặc Hợp Đồng Dịch Vụ.
                                                        Trong trường hợp Khoản Đặt Cọc bị cấn trừ theo quy định, Khách
                                                        Hàng có nghĩa vụ nộp bổ sung Khoản Đặt Cọc trong thời hạn nêu
                                                        tại thông báo của Green Future. Nếu Khách Hàng chậm nộp bổ sung,
                                                        Khách Hàng phải chịu phạt theo lãi suất 0,05%/ ngày tính trên số
                                                        tiền chậm nộp.</h2>
                                                    <h2 class="col-start-2">4.5.Khoản Đặt Cọc không được tính lãi và sẽ
                                                        được Green Future hoàn trả cho Khách Hàng với các điều kiện sau:
                                                        (i) Green Future đã cấn trừ các nghĩa vụ tài chính của Khách
                                                        Hàng với Green Future (nếu có); và (ii) không có các dấu hiệu vi
                                                        phạm pháp luật mà Green Future cho rằng có khả năng dẫn đến việc
                                                        bị xử phạt hành chính hoặc bồi thường thiệt hại.</h2>
                                                    <h2 class="col-start-2">4.6.Green Future sẽ hoàn trả Khoản Đặt Cọc
                                                        cho Khách Hàng sau 07 (bảy) Ngày Làm Việc kể từ khi Khách Hàng
                                                        ký Biên bản bàn giao lại Xe. Sau đó, thời hạn thực tế Khách Hàng
                                                        nhận được Khoản Đặt Cọc này sẽ phụ thuộc vào lịch biểu của ngân
                                                        hàng hoặc đơn vị cung cấp dịch vụ thanh toán trực tuyến mà Khách
                                                        Hàng sử dụng.</h2>
                                                    <h1 class="col-start-2">5.THANH TOÁN</h1>
                                                    <h2 class="col-start-2">5.1.Khách Hàng chuyển Khoản Đặt Cọc, thanh
                                                        toán Phí Dịch Vụ bằng phương thức thanh toán được xác định cụ
                                                        thể tại Hợp Đồng Dịch Vụ.</h2>
                                                    <h2 class="col-start-2">5.2.Thanh toán Dịch Vụ theo giờ/ngày</h2>
                                                    <h3 class="col-start-2">5.2.1.Khách Hàng thanh toán trước Phí Cơ Bản
                                                        cho GF ngay sau khi Đặt Dịch Vụ và cùng thời điểm với việc
                                                        chuyển Khoản Đặt Cọc.</h3>
                                                    <h3 class="col-start-2">5.2.2.Sau khi Các Bên ký biên bản bàn giao
                                                        trả xe, Green Future gửi Bảng Tổng Hợp Phí Dịch Vụ cho Khách
                                                        Hàng qua địa chỉ thư điện tử của Khách Hàng. Trong thời hạn 03
                                                        (ba) giờ kể từ khi nhận được Bảng Tổng Hợp Phí Dịch Vụ, Khách
                                                        Hàng có nghĩa vụ xem xét, đối chiếu và phản hồi qua email về số
                                                        liệu của Bảng Tổng Hợp Phí Dịch Vụ. Quá thời hạn nêu trên mà
                                                        Green Future không nhận được phản hồi từ Khách Hàng thì được xem
                                                        là Khách Hàng đã đồng ý và Green Future sẽ tiến hành xuất hóa
                                                        đơn tài chính và gửi đề nghị thanh toán cho Khách Hàng. Việc
                                                        Khách Hàng xác nhận (hoặc quá thời hạn nhưng không phản hồi) về
                                                        Bảng Tổng Hợp Phí Dịch Vụ như quy định nêu trên được xem là Các
                                                        Bên đã thống nhất nghiệm thu Dịch Vụ.</h3>
                                                    <h3 class="col-start-2">5.2.3.Phí Dịch Vụ (nếu có) sẽ được cấn trừ
                                                        vào Khoản Đặt Cọc. Trong trường hợp các khoản Phí Dịch Vụ phát
                                                        sinh lớn hơn Khoản Đặt Cọc, Khách Hàng thanh toán khoản chênh
                                                        lệch cho Green Future trong thời hạn 01 (một) ngày kể từ khi
                                                        Green Future gửi Bảng Tổng Hợp Phí Dịch Vụ.</h3>
                                                    <h2 class="col-start-2">5.3.Thanh toán Dịch Vụ theo tháng/năm</h2>
                                                    <h3 class="col-start-2">5.3.1.Kỳ thanh toán: 01 (một) tháng theo kỳ
                                                        chốt Phí Cơ Bản từ ngày 23 tháng trước đến 22 tháng liền sau của
                                                        mỗi tháng dương lịch (“<strong>Kỳ Thanh Toán</strong>”).</h3>
                                                    <h3 class="col-start-2">5.3.2.Đối soát:</h3>
                                                    <h4 class="col-start-2">(a)Trong 02 (hai) Ngày Làm Việc kể từ ngày
                                                        kết thúc Kỳ Thanh Toán có liên quan, Green Future gửi Bảng Tổng
                                                        Hợp Phí Dịch Vụ cho Khách Hàng qua địa chỉ thư điện tử của Khách
                                                        Hàng.</h4>
                                                    <h4 class="col-start-2">(b)Trong thời hạn 02 (hai) ngày kể từ khi
                                                        nhận được Bảng Tổng Hợp Phí Dịch Vụ, Khách Hàng có nghĩa vụ xem
                                                        xét, đối chiếu và phản hồi qua email về số liệu của Bảng Tổng
                                                        Hợp Phí Dịch Vụ. Quá thời hạn nêu trên mà Green Future không
                                                        nhận được phản hồi từ Khách Hàng thì được xem là Khách Hàng đã
                                                        đồng ý với Bảng Tổng Hợp Phí Dịch Vụ và Green Future sẽ tiến
                                                        hành xuất hóa đơn tài chính và gửi đề nghị thanh toán cho Khách
                                                        Hàng. Việc Khách Hàng xác nhận (hoặc quá thời hạn nhưng không
                                                        phản hồi) về Bảng Tổng Hợp Phí Dịch Vụ như quy định nêu trên
                                                        được xem là các bên đã thống nhất và nghiệm thu Dịch Vụ cho thời
                                                        gian sử dụng Dịch Vụ tương ứng</h4>
                                                    <h4 class="col-start-2">(c)Trong trường hợp Các Bên không thể thống
                                                        nhất được số liệu của Bảng Tổng Hợp Phí Dịch Vụ trong thời hạn
                                                        nêu tại Điều (b) của ĐKC, Green Future sẽ xuất hóa đơn tài chính
                                                        theo số liệu tại Bảng Tổng Hợp Phí Dịch Vụ và Khách Hàng có
                                                        nghĩa vụ thanh toán toàn bộ các khoản tiền theo hóa đơn tài
                                                        chính do Green Future đã lập trong thời hạn nêu tại Điều của
                                                        ĐKC. Các Bên sẽ tiếp tục trao đổi về phần số liệu chưa thể thống
                                                        nhất của Kỳ Thanh Toán đó trong Kỳ Thanh Toán tiếp theo, và
                                                        khoản chênh lệch (nếu có) sẽ được đối trừ vào Kỳ Thanh Toán tiếp
                                                        theo. Green Future sẽ xuất hóa đơn tài chính ở Kỳ Thanh Toán
                                                        tiếp theo trên cơ sở có tính toán số tiền chênh lệch trong Kỳ
                                                        Thanh Trước liền trước đó.</h4>
                                                    <h4 class="col-start-2">(d)Green Future sẽ xuất hóa đơn tài chính
                                                        cho Khách Hàng không muộn hơn ngày cuối cùng của tháng dương
                                                        lịch sử dụng Dịch Vụ.</h4>
                                                    <h3 class="col-start-2">5.3.3.Khách Hàng có trách nhiệm thanh toán
                                                        Phí Dịch Vụ theo hóa đơn tài chính do Green Future xuất trong
                                                        vòng 05 (năm) Ngày Làm Việc kể từ khi Khách Hàng nhận được đề
                                                        nghị thanh toán và hóa đơn tài chính nhưng không muộn hơn ngày
                                                        15 của tháng liền sau tháng sử dụng Dịch Vụ.</h3>
                                                    <h2 class="col-start-2">5.4.Mức thuế giá trị gia tăng sẽ được tính
                                                        theo quy định của pháp luật áp dụng tại thời điểm xuất hóa đơn,
                                                        và Khách Hàng có nghĩa vụ thanh toán Phí Dịch Vụ tương ứng với
                                                        số tiền ghi trên hóa đơn.</h2>
                                                    <h2 class="col-start-2">5.5.Chậm thanh toán</h2>
                                                    <h3 class="col-start-2">5.5.1.Sau 03 (ba) Ngày Làm Việc kể từ ngày
                                                        hết hạn thanh toán của bất kỳ khoản thanh toán nào theo quy định
                                                        tại ĐKC này và/hoặc Hợp Đồng Dịch Vụ mà Khách Hàng chưa hoàn
                                                        thành thanh toán, Green Future có quyền cấn trừ Khoản Đặt Cọc để
                                                        đảm bảo nghĩa vụ thanh toán của Khách Hàng. Trong trường hợp
                                                        khoản cấn trừ lớn hơn Khoản Đặt Cọc, Khách Hàng phải thanh phải
                                                        chịu phạt theo lãi suất 0,05%/ ngày tính trên khoản phải thanh
                                                        toán còn lại sau khi cấn trừ cho đến ngày thanh toán thực tế;
                                                    </h3>
                                                    <h3 class="col-start-2">5.5.2.Mọi khoản chậm thanh toán của Khách
                                                        Hàng, bao gồm cả việc thanh toán bù Khoản Đặt Cọc theo Điều ,
                                                        không được muộn quá 10 (mười) ngày kể từ ngày hết hạn thanh
                                                        toán. Quá thời hạn này mà Khách Hàng không hoàn thành nghĩa vụ
                                                        thanh toán của mình, Green Future hoặc Bên thứ ba (do Green
                                                        Future chỉ định) được phép tiến hành hạn chế/khóa hệ thống để
                                                        dừng hoạt động của Xe và chấm dứt Hợp Đồng Dịch Vụ theo quy định
                                                        tại ĐKC này.</h3>
                                                    <h1 class="col-start-2">6.GIAO/TRẢ XE</h1>
                                                    <h2 class="col-start-2">6.1.Green Future giao Xe và Khách Hàng nhận
                                                        Xe sau khi Hai Bên ký Hợp Đồng Dịch Vụ và Green Future đã nhận
                                                        được (i) Phí Cơ Bản (chỉ đối với Dịch Vụ theo giờ/ngày) và (ii)
                                                        Khoản Đặt Cọc.</h2>
                                                    <h2 class="col-start-2">6.2.Green Future chỉ giao và nhận trả Xe
                                                        trong Giờ Làm Việc. Riêng đối với Dịch Vụ theo giờ/ngày, Green
                                                        Future nhận trả Xe sau Giờ Làm Việc kèm phụ thu, nhưng trong mọi
                                                        trường hợp không muộn hơn 22 giờ cùng ngày.</h2>
                                                    <h2 class="col-start-2">6.3.Các Bên sẽ ký kết biên bản giao nhận
                                                        Xe<strong> </strong>làm cơ sở ghi nhận thời điểm bắt đầu thuê Xe
                                                        trên thực tế. Biên bản bàn giao Xe là một phần không tách rời
                                                        của Hợp Đồng Dịch Vụ.</h2>
                                                    <h2 class="col-start-2">6.4.Khách hàng có trách nhiệm kiểm tra tình
                                                        trạng Xe, số dư tài khoản ETC khi nhận Xe và xác nhận với đại
                                                        diện của Green Future về tình trạng của Xe (bao gồm cả dung
                                                        lượng pin đã được sạc). Bất kỳ sự cố hoặc hư hỏng nào trên Xe
                                                        cần phải được ghi nhận và xác nhận bởi Green Future và Khách
                                                        Hàng tại thời điểm giao Xe.</h2>
                                                    <h2 class="col-start-2">6.5.Khách Hàng trả Xe cho Green Future vào
                                                        thời gian và tại địa điểm giao nhận đã thỏa thuận tại Hợp Đồng
                                                        Dịch Vụ. Các thông tin Xe liệt kê trên biên bản bàn giao trả Xe
                                                        cần được kiểm tra và xác nhận bởi nhân viên Green Future tại địa
                                                        điểm trả Xe.</h2>
                                                    <h2 class="col-start-2">6.6.Khách Hàng có trách nhiệm cuối cùng và
                                                        toàn bộ đối với mọi hỏng hóc, thiệt hại của Xe và thiệt hại với
                                                        bên thứ ba nếu do lỗi của Khách Hàng, kể cả trong trường hợp
                                                        thiệt hại được đơn vị bảo hiểm chi trả. Khách Hàng chịu hoàn
                                                        toàn trách nhiệm trong trường hợp Xe gây tai nạn hoặc liên quan
                                                        đến các vụ việc trái pháp luật do lỗi của Khách Hàng.</h2>
                                                    <h2 class="col-start-2">6.7.Việc bàn giao trả Xe chỉ được coi là
                                                        hoàn thành sau khi Khách Hàng đã khắc phục, sửa chữa mọi mất
                                                        mát, hư hỏng, thiệt hại đối với Xe, đưa Xe về tình trạng nguyên
                                                        trạng như khi nhận bàn giao từ Green Future&nbsp;(trừ các hao
                                                        mòn tự nhiên).</h2>
                                                    <h1 class="col-start-2">7.ĐỔI XE</h1>
                                                    <h2 class="col-start-2">7.1.Đổi Xe do lỗi của Khách Hàng:</h2>
                                                    <h3 class="col-start-2">7.1.1.Trường hợp Xe bị sự cố, hỏng hóc hoặc
                                                        tai nạn không sử dụng được do lỗi của Khách Hàng, Green Future
                                                        sẽ xem xét cung cấp Xe thay thế cùng loại theo yêu cầu của Khách
                                                        Hàng tùy theo khả năng của Green Future tại thời điểm đó.</h3>
                                                    <h3 class="col-start-2">7.1.2.Trong trường hợp này đổi Xe, Khách
                                                        Hàng có nghĩa vụ thanh toán đầy đủ phụ phí và chi phí phát sinh
                                                        liên quan đến việc đổi Xe cũng như bồi thường cho các lỗi, hỏng
                                                        hóc đối với Xe theo ĐKC này theo thông báo của Green Future.
                                                    </h3>
                                                    <h2 class="col-start-2">7.2.Đổi Xe không phải do lỗi của Khách Hàng:
                                                    </h2>
                                                    <h3 class="col-start-2">7.2.1.Trường hợp Xe bị hỏng do lỗi của nhà
                                                        sản xuất hoặc Xe bị sự cố, hỏng hóc không phải do lỗi của Khách
                                                        Hàng, Green Future sẽ cung cấp Xe thay thế cùng loại để Khách
                                                        Hàng sử dụng bằng chi phí của Green Future.</h3>
                                                    <h3 class="col-start-2">7.2.2.Trong trường hợp Green Future không
                                                        thể cung cấp Xe thay thế, Green Future có trách nhiệm giảm trừ
                                                        Phí Cơ Bản tương ứng với thời gian Xe không thể sử dụng.</h3>
                                                    <h3 class="col-start-2">7.2.3.Để làm rõ, ngoài trách nhiệm nêu tại
                                                        Điều , Green Future không phải chịu bất kỳ trách nhiệm nào khác,
                                                        kể cả các thiệt hại của Khách Hàng (nếu có).</h3>
                                                    <h1 class="col-start-2">8.TRÁCH NHIỆM CỦA KHÁCH HÀNG</h1>
                                                    <h2 class="col-start-2">8.1.Chỉ được sử dụng Xe vào các mục đích
                                                        theo quy định tại Hợp Đồng Dịch Vụ và phù hợp với các quy định
                                                        của pháp luật, không sử dụng Xe để kinh doanh dịch vụ vận tải,
                                                        đặt cọc, cầm cố, thế chấp, đảm bảo cho việc thực hiện nghĩa vụ
                                                        dân sự hoặc sử dụng cho hoạt động vi phạm quy định pháp luật,
                                                        bao gồm nhưng không giới hạn: vận chuyển ma túy, động vật quý
                                                        hiếm, tiền giả, hàng hóa dễ cháy, nổ hoặc cấm lưu hành.</h2>
                                                    <h2 class="col-start-2">8.2.Đáp ứng và duy trì các tiêu chuẩn của
                                                        khách thuê (“<strong>Tiêu Chuẩn Của Khách Thuê</strong>”) trong
                                                        suốt thời gian thuê đồng thời cung cấp đầy đủ các giấy tờ theo
                                                        quy định của Green Future áp dụng tại từng thời điểm và/hoặc
                                                        thông báo của Green Future cho Khách Hàng. Tiêu Chuẩn Của Khách
                                                        Thuê được hiểu là: (i) Đối với Khách Hàng là tổ chức, doanh
                                                        nghiệp: được thành lập hợp pháp, không thuộc diện tạm ngừng hoạt
                                                        động hoặc giải thể hoặc chờ giải thể, không trong quá trình bị
                                                        điều tra hoặc khởi tố hình sự; (ii) Đối với Khách Hàng là cá
                                                        nhân: có đầy đủ năng lực hành vi dân sự, đáp ứng điều kiện tham
                                                        gia giao thông theo quy định pháp luật, và có giấy phép lái xe
                                                        còn hiệu lực theo quy định của pháp luật Việt Nam hoặc có lái xe
                                                        đáp ứng tiêu chuẩn quy định tại Điều (áp dụng đối với Dịch Vụ
                                                        không kèm Tài Xế). Khách Hàng có nghĩa vụ cung cấp cho Green
                                                        Future bằng chứng về việc duy trì đầy đủ các Tiêu Chuẩn Của
                                                        Khách Thuê.</h2>
                                                    <h2 class="col-start-2">8.3.Không bóc tem niêm phong, tem đảm bảo,
                                                        tác động hoặc can thiệp vào các hệ thống kỹ thuật, an toàn, giám
                                                        sát hoặc tiện nghi của Xe, tự ý thay thế, tráo đổi bất kỳ phụ
                                                        tùng, linh kiện Xe. Trường hợp có nhu cầu điều chỉnh, thay thế
                                                        liên quan đến nội thất, ngoại thất, hệ thống điện, kết cấu của
                                                        Xe thì Khách Hàng phải gửi phương án kỹ thuật, thi công cho
                                                        Green Future để Green Future thẩm định. Việc thi công chỉ được
                                                        phép triển khai khi nhận được sự chấp thuận bằng văn bản của
                                                        Green Future. Khách Hàng cam kết chịu trách nhiệm và chi trả mọi
                                                        chi phí phát sinh để sửa chữa Xe hoặc khắc phục sự cố do các tác
                                                        động hoặc can thiệp của Khách Hàng vào Xe mà không được sự chấp
                                                        thuận của Green Future. Việc sửa chữa phải được thực hiện tại cơ
                                                        sở bảo hành hoặc trạm dịch vụ của nhà sản xuất Xe hoặc được nhà
                                                        sản xuất Xe ủy quyền.</h2>
                                                    <h2 class="col-start-2">8.4.Tuân thủ đúng lịch bảo dưỡng, bảo trì
                                                        theo hướng dẫn của nhà sản xuất Xe hoặc theo yêu cầu của Green
                                                        Future, phối hợp với Green Future để bảo trì bảo dưỡng và sửa
                                                        chữa Xe tại các cơ sở bảo hành hoặc trạm dịch vụ của nhà sản
                                                        xuất Xe hoặc được nhà sản xuất Xe ủy quyền. Trường hợp Khách
                                                        Hàng không tuân thủ quy định tại Điều này, Green Future có quyền
                                                        can thiệp đến hệ thống vận hành của Xe và thu hồi Xe không được
                                                        bảo dưỡng, bảo trì.</h2>
                                                    <h2 class="col-start-2">8.5.Trong trường hợp phát sinh hỏng hóc,
                                                        thiệt hại về Xe hoặc Xe gặp tai nạn, thông báo ngay cho Green
                                                        Future và/hoặc đơn vị bảo hiểm theo thông tin do Green Future
                                                        cung cấp tại từng thời điểm, đồng thời có trách nhiệm giải quyết
                                                        mọi tranh chấp, khiếu nại với bên thứ ba, phối hợp với cơ quan
                                                        chức năng và phối hợp với Green Future để hoàn tất các thủ tục
                                                        bảo hiểm.</h2>
                                                    <h2 class="col-start-2">8.6.Trong mọi trường hợp khi Xe bị hư hỏng
                                                        và thuộc trách nhiệm sửa chữa của Khách Hàng, Khách Hàng có
                                                        nghĩa vụ tuân thủ các quy trình, quy định về sửa chữa, bồi
                                                        thường (i) được quy định tại ĐKC này hoặc (ii) theo thông báo
                                                        bằng văn bản của Green Future.</h2>
                                                    <h2 class="col-start-2">8.7.Bồi thường toàn bộ thiệt hại liên quan
                                                        đến Xe (nếu có) trong thời gian Xe hoặc giấy tờ Xe bị cơ quan
                                                        chức năng thu giữ do hành vi vi phạm pháp luật của Khách Hàng,
                                                        Người Sử Dụng hoặc do hành vi vi phạm pháp luật xuất phát từ yêu
                                                        cầu của Khách Hàng.</h2>
                                                    <h2 class="col-start-2">8.8.Đối với Dịch Vụ không kèm Tài Xế:</h2>
                                                    <h3 class="col-start-2">8.8.1.Khách Hàng sẽ chịu trách nhiệm hoàn
                                                        toàn về việc điều khiển và sử dụng Xe của người lái xe, và đảm
                                                        bảo người lái xe có giấy phép lái xe còn hiệu lực và tuân thủ
                                                        đầy đủ pháp luật khi tham gia giao thông và các hướng dẫn, chỉ
                                                        dẫn kỹ thuật, an toàn theo khuyến cáo của nhà sản xuất Xe. Để
                                                        làm rõ, Xe bị hư hỏng do tai nạn trong quá trình Khách Hàng sử
                                                        dụng Xe (bất kể là lỗi của người lái Xe hay lỗi của một bên thứ
                                                        ba khác) được coi là lỗi của Khách Hàng theo quy định tại Điều
                                                        Khoản Chung này, và Khách Hàng phải chịu trách nhiệm đối với
                                                        toàn bộ hư hỏng, thiệt hại.</h3>
                                                    <h3 class="col-start-2">8.8.2.Khi gặp bất kỳ tình trạng bất thường
                                                        nào xảy ra đối với Xe như: tăng nhiệt độ đột ngột, chết máy
                                                        không rõ nguyên nhân hoặc không sử dụng được chức năng bất kỳ,
                                                        mất phanh, mất kiểm soát v.v. Khách Hàng và/hoặc người lái xe
                                                        không được cố gắng tự xử lý sự cố hay tiếp tục sử dụng mà phải
                                                        ngay lập tức áp dụng các biện pháp, chỉ dẫn an toàn sau đó thông
                                                        báo ngay cho Green Future để được hướng dẫn.</h3>
                                                    <h2 class="col-start-2">8.9.Đối với dịch vụ Cho thuê Xe Ô tô có kèm
                                                        Tài Xế, Khách Hàng đảm bảo:</h2>
                                                    <h3 class="col-start-2">8.9.1.Khách Hàng, Người Sử Dụng cư xử văn
                                                        minh, lịch sự và không có các hành vi gây mất tập trung cho Tài
                                                        Xế trong quá trình di chuyển, không yêu cầu Tài Xế thực hiện các
                                                        hành vi vi phạm luật giao thông đường bộ.</h3>
                                                    <h3 class="col-start-2">8.9.2.Khách Hàng, Người Sử Dụng không hối
                                                        lộ, hứa hẹn các lợi ích khác và/hoặc thông đồng với Tài Xế để
                                                        thực hiện các hành vi vi phạm pháp luật hoặc gian lận nhật ký
                                                        hành trình.</h3>
                                                    <h3 class="col-start-2">8.9.3.Chịu trách nhiệm đối với Người Sử Dụng
                                                        và hành lý của Người Sử Dụng. Đảm bảo Người Sử Dụng tự bảo quản
                                                        tài sản trong quá trình sử dụng Dịch Vụ và miễn trừ Green Future
                                                        và Tài Xế đối với trách nhiệm về các mất mát, tổn thất tài sản
                                                        này.</h3>
                                                    <h3 class="col-start-2">8.9.4.Khách Hàng chỉ được sử dụng Xe khi có
                                                        Tài Xế của Green Future. Trong trường hợp khách hàng sử dụng Xe
                                                        khi không có Tài Xế, Khách Hàng phải thông báo cho Green Future
                                                        bằng email và được Green Future chấp thuận và Các Bên sẽ ký Biên
                                                        bản bàn giao và hoàn trả Xe theo biểu mẫu do Green Future quy
                                                        định để xác định tình trạng xe từ thời điểm Khách Hàng sử dụng
                                                        xe không có Tài Xế.</h3>
                                                    <h3 class="col-start-2">8.9.5.Người Sử Dụng đảm bảo thời gian lái Xe
                                                        của Tài Xế không được quá 10 (mười) giờ trong một ngày và không
                                                        được lái Xe liên tục quá 4 (bốn) giờ hoặc thời gian khác ngắn
                                                        hơn nếu quy định pháp luật có thay đổi. Khi Người Sử Dụng có yêu
                                                        cầu Tài Xế lái Xe vượt quá thời gian trên, Tài Xế có quyền từ
                                                        chối thực hiện Dịch Vụ, Green Future và Tài Xế không phải chịu
                                                        bất kỳ trách nhiệm nào, kể cả các thiệt hại của Khách Hàng và
                                                        Người Sử Dụng (nếu có).</h3>
                                                    <h1 class="col-start-2">9.CHO THUÊ LẠI</h1>
                                                    <h3 class="col-start-2">Trong trường hợp Khách Hàng cho thuê lại Xe,
                                                        Khách Hàng cam kết:</h3>
                                                    <h2 class="col-start-2">9.1.Thông báo cho Green Future trước ít nhất
                                                        01 (một) Ngày Làm Việc về việc cho thuê lại Xe (bao gồm thông
                                                        tin khách thuê lại xe);</h2>
                                                    <h2 class="col-start-2">9.2.Thời hạn của hợp đồng cho thuê lại Xe
                                                        phải kết thúc sớm hơn hoặc muộn nhất trùng với thời điểm chấm
                                                        dứt thời hạn thuê Xe theo Hợp Đồng Dịch Vụ.</h2>
                                                    <h2 class="col-start-2">9.3.Hợp đồng cho thuê lại Xe phải có quy
                                                        định về việc: (i) Hợp đồng cho thuê lại sẽ tự động chấm dứt hiệu
                                                        lực ngay lập tức trong trường hợp Hợp Đồng Dịch Vụ chấm dứt vì
                                                        bất kỳ lý do gì; (ii) bên thuê lại Xe không được cho thuê lại Xe
                                                        trong bất kỳ trường hợp nào và không được dùng Xe để cung cấp
                                                        dịch vụ vận tải.</h2>
                                                    <h2 class="col-start-2">9.4.Yêu cầu bên thuê lại đáp ứng đầy đủ Tiêu
                                                        Chuẩn Của Khách Thuê theo quy định tại ĐKC này và tuân thủ các
                                                        nghĩa vụ tương tự nghĩa vụ của Khách Hàng với Green Future theo
                                                        ĐKC này và Hợp Đồng Dịch Vụ. Trong vòng 07 (bảy) ngày kể từ ngày
                                                        Green Future yêu cầu, Khách Hàng cung cấp đầy đủ các giấy tờ
                                                        chứng minh bên thuê lại đáp ứng đầy đủ Tiêu Chuẩn Của Khách
                                                        Thuê.</h2>
                                                    <h2 class="col-start-2">9.5.Khách Hàng chịu toàn bộ trách nhiệm về
                                                        việc sử dụng Xe của bên thuê lại, việc cho thuê lại trong mọi
                                                        trường hợp không làm ảnh hưởng đến quyền lợi của Green Future.
                                                    </h2>
                                                    <h2 class="col-start-2">9.6.Tuân thủ các điều kiện cho thuê lại khác
                                                        theo quy định của Green Future tại từng thời điểm.</h2>
                                                    <h1 class="col-start-2">10.BẤT KHẢ KHÁNG</h1>
                                                    <h2 class="col-start-2">10.1.Trong thời gian thực hiện Hợp Đồng Dịch
                                                        Vụ, những sự kiện sau được coi là sự kiện bất khả kháng
                                                        (“<strong>Sự Kiện Bất Khả Kháng</strong>”): Mưa lớn, bão lụt,
                                                        sạt lở, động đất, chiến tranh, hoả hoạn, dịch bệnh, sự thay đổi
                                                        của chính sách, pháp luật của nhà nước hoặc các sự kiện xảy ra
                                                        một cách khách quan khác.</h2>
                                                    <h2 class="col-start-2">10.2.Bên bị ảnh hưởng bởi Sự Kiện Bất Khả
                                                        Kháng chỉ được miễn trách nhiệm nếu đáp ứng các điều kiện sau
                                                        đây: Sự kiện đó hoàn toàn nằm ngoài sự kiểm soát hợp lý hoặc
                                                        không do lỗi hoặc sơ suất của Bên bị ảnh hưởng bởi sự kiện bất
                                                        khả kháng, mặc dù Bên đó đã áp dụng mọi biện pháp cần thiết và
                                                        trong khả năng cho phép để đề phòng, khắc phục hoặc giảm bớt
                                                        thiệt hại, gây ra việc chậm trễ hoặc gián đoạn, đình trệ việc
                                                        thực hiện nghĩa vụ trong Hợp Đồng Dịch Vụ.</h2>
                                                    <h2 class="col-start-2">10.3.Trong trường hợp một Sự Kiện Bất Khả
                                                        Kháng kéo dài hơn 60 ngày, bất kỳ Bên nào cũng có thể, bằng một
                                                        thông báo bằng văn bản gửi Bên kia, đơn phương chấm dứt Hợp Đồng
                                                        Dịch Vụ.</h2>
                                                    <h1 class="col-start-2">11.BẢO MẬT THÔNG TIN</h1>
                                                    <h2 class="col-start-2">11.1.Khách Hàng và Green Future cam kết
                                                        rằng, trong thời gian hiệu lực của Hợp Đồng Dịch Vụ<em> </em>và
                                                        sau khi Hợp Đồng Dịch Vụ<em> </em>giữa Khách Hàng và Green
                                                        Future chấm dứt, Bên được tiết lộ sẽ tuyệt đối bảo mật các thông
                                                        tin mật (“<strong>Thông Tin Mật</strong>”) của Bên tiết lộ. Theo
                                                        đó, Bên được tiết lộ không được tiết lộ Thông Tin Mật cho bất kỳ
                                                        bên thứ ba nào, dù là trực tiếp hay gián tiếp, trong bất kỳ tình
                                                        huống nào, khi không có sự đồng ý bằng văn bản của của Bên tiết
                                                        lộ trừ trường hợp quy định dưới đây. Cho mục đích quy định tại
                                                        điều này, Thông Tin Mật được hiểu là các thông tin bao gồm nhưng
                                                        không giới hạn các điều khoản của Hợp Đồng Dịch Vụ<em> </em>ký
                                                        giữa Green Future và Khách Hàng, và/hoặc các thông tin, dữ liệu,
                                                        văn bản được tạo ra do liên quan đến hoặc phát sinh từ việc thực
                                                        hiện Hợp Đồng Dịch Vụ, các thông tin, dữ liệu, văn bản được Bên
                                                        tiết lộ cung cấp cho Bên được tiết lộ cho dù dưới bất kỳ hình
                                                        thức nào để thực hiện Hợp Đồng Dịch Vụ.</h2>
                                                    <h2 class="col-start-2">11.2.Nghĩa vụ bảo mật sẽ được loại trừ nếu
                                                        Thông Tin Mật:</h2>
                                                    <ul class="list col-start-2">
                                                        <li value="1">(a) đã được phổ biến rộng rãi trong công chúng bởi
                                                            Bên tiết lộ;</li>
                                                        <li value="2">(b) do Bên được tiết tộ cung cấp cho nhân viên,
                                                            chuyên gia tư vấn tài chính, pháp lý hoặc nhà thầu của Bên
                                                            được tiết lộ vì mục đích thực hiện các nghĩa vụ của Bên được
                                                            tiết lộ theo Hợp ĐồngDịch Vụ,với điều kiện là Bên được tiết
                                                            lộ phải chịu trách nhiệm và đảm bảo các đối tượng được tiết
                                                            lộ Thông Tin Mật phải tuân thủ quy định bảo mật như nội dung
                                                            nêu trên;</li>
                                                        <li value="3">(c) do Bên được tiết lộ nhận được từ một bên thứ
                                                            ba độc lập với việc thực hiện Hợp ĐồngDịch Vụmà không chịu
                                                            bất kỳ nghĩa vụ bảo mật nào; hoặc</li>
                                                        <li value="4">(d) được yêu cầu tiết lộ bởi cơ quan có thẩm quyền
                                                            hoặc bất kỳ toà án có thẩm quyền xét xử thích hợp nào đối
                                                            với Bên được tiết lộ.</li>
                                                    </ul>
                                                    <h2 class="col-start-2">11.3.Bên được tiết lộ đồng ý rằng bất cứ vi
                                                        phạm nào đối với nghĩa vụ bảo mật thông tin này có thể gây ra
                                                        những tổn hại không thể khôi phục được với Bên tiết lộ, theo đó
                                                        Bên tiết lộ sẽ có quyền tìm kiếm các biện pháp để giảm nhẹ thiệt
                                                        hại và buộc Bên được tiết lộ bồi thường toàn bộ thiệt hại phát
                                                        sinh từ vi phạm đó.</h2>
                                                    <h2 class="col-start-2">11.4.Không trái với các quy định về bảo mật
                                                        Thông Tin Mật tại Điều này, Khách Hàng đồng ý cho Green Future
                                                        khởi tạo, lưu trữ, duy trì và cập nhật các dữ liệu thông tin cá
                                                        nhân do Khách Hàng cung cấp, cập nhật và những thông tin phát
                                                        sinh từ việc Khách Hàng sử dụng Dịch Vụ của Green Future, và
                                                        đồng ý cho Green Future sử dụng các dữ liệu này cho các mục đích
                                                        vận hành và kinh doanh của Green Future, bao gồm nhưng không
                                                        giới hạn tại việc giới thiệu các sản phẩm, dịch vụ cung cấp bởi
                                                        Green Future, nâng cao chất lượng cung cấp Dịch Vụ của Green
                                                        Future. Tất cả các dữ liệu mà Green Future thu thập được từ
                                                        Khách Hàng sẽ được bảo vệ và được sử dụng theo quy định tại
                                                        Chính Sách Xử Lý và Bảo Vệ Dữ Liệu được công bố công khai trên
                                                        các Kênh Thông Tin của Green Future.</h2>
                                                    <h1 class="col-start-2">12.QUY ĐỊNH KHÁC</h1>
                                                    <h2 class="col-start-2">Green Future có thể sửa đổi hoặc bổ sung ĐKC
                                                        tùy từng thời điểm. Việc sửa đổi, bổ sung ĐKC sẽ được áp dụng
                                                        sau khi Green Future thông báo sửa đổi, bổ sung ĐKC thông qua
                                                        địa chỉ email của Khách Hàng hoặc thông qua các các Kênh Thông
                                                        Tin của Green Future, tùy thuộc vào quyết định của Green Future
                                                        tại thời điểm sửa đổi, bổ sung ĐKC.</h2>
                                                    <p class="col-start-2" style="text-align: left;"></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
<!-- Footer -->
    <div id="footer-container"></div>

    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/home/home.js"></script>
    <script src="${pageContext.request.contextPath}/login/login.js"></script>
    <script src="${pageContext.request.contextPath}/password/password.js"></script>
    <script src="${pageContext.request.contextPath}/register/register.js"></script>
    <script>
        // Tải header
        fetch('${pageContext.request.contextPath}/header/header.jsp')
            .then(response => {
                if (!response.ok) throw new Error('Failed to load header.jsp');
                return response.text();
            })
            .then(data => {
                document.getElementById('header-container').innerHTML = data;
                const loginBtn = document.querySelector('.btn-login');
                const userDropdown = document.getElementById('header-user-dropdown');
                if (loginBtn && !userDropdown) {
                    loginBtn.addEventListener('click', function (e) {
                        e.preventDefault();
                        openLogin();
                    });
                }
                var script = document.createElement('script');
                script.src = '${pageContext.request.contextPath}/header/header.js';
                script.onload = function () {
                    if (typeof initHeaderDropdown === 'function') {
                        initHeaderDropdown();
                    }
                    if (typeof showLogoutToastIfNeeded === 'function') {
                        showLogoutToastIfNeeded();
                        setTimeout(showLogoutToastIfNeeded, 300);
                        setTimeout(showLogoutToastIfNeeded, 700);
                        setTimeout(showLogoutToastIfNeeded, 1200);
                        setTimeout(showLogoutToastIfNeeded, 2000);
                    }
                };
                script.onerror = function () {
                    console.error('Failed to load header.js');
                };
                document.body.appendChild(script);
            })
            .catch(error => console.error('Error loading header:', error));

        // Tải footer
        fetch('${pageContext.request.contextPath}/footer/footer.jsp')
            .then(response => {
                if (!response.ok) throw new Error('Failed to load footer.jsp');
                return response.text();
            })
            .then(data => {
                document.getElementById('footer-container').innerHTML = data;
            })
            .catch(error => console.error('Error loading footer:', error));

        // Tự động bật modal register nếu có lỗi đăng ký
        <% if (request.getAttribute("showRegisterModal") != null && Boolean.parseBoolean(request.getAttribute("showRegisterModal").toString())) { %>
        document.addEventListener('DOMContentLoaded', function () {
            openRegister();
        });
        <% } %>

        // Tự động bật modal login nếu có lỗi đăng nhập
        <% if (request.getAttribute("showLoginModal") != null && Boolean.parseBoolean(request.getAttribute("showLoginModal").toString())) { %>
        document.addEventListener('DOMContentLoaded', function () {
            openLogin();
        });
        <% } %>
    </script>

    <!-- Login Modal -->
    <jsp:include page="/login/login.jsp" />

    <!-- Password Reset Modal -->
    <div id="password-container"></div>
    <script>
        fetch('${pageContext.request.contextPath}/password/password.jsp')
            .then(response => {
                if (!response.ok) throw new Error('Failed to load password.jsp');
                return response.text();
            })
            .then(data => {
                document.getElementById('password-container').innerHTML = data;
                if (typeof initPasswordFunctionality === 'function') {
                    initPasswordFunctionality();
                }
            })
            .catch(error => console.error('Error loading password modal:', error));
    </script>

    <!-- Register Modal -->
    <div id="register-container"></div>
    <script>
        fetch('${pageContext.request.contextPath}/register/register.jsp')
            .then(response => {
                if (!response.ok) throw new Error('Failed to load register.jsp');
                return response.text();
            })
            .then(data => {
                document.getElementById('register-container').innerHTML = data;
                if (typeof initRegisterFunctionality === 'function') {
                    initRegisterFunctionality();
                }
            })
            .catch(error => console.error('Error loading register modal:', error));
    </script>
</body>

</html>