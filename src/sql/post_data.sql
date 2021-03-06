Insert into Post values
-- Tiêu đề --
-- (postId, N'Title\', \'TitleUnsigned\', N'SubTitle\', \'PostTime\', userId, seriesId, seriesOrder, \'image\', N'postContent')

-- Nghệ thuật xử lý background job --
(1, 
N'Nghệ thuật xử lý background job', 
'nghe-thuat-xu-ly-background-job', 
N'Trong bài viết này, ngoài việc tổng hợp thông tin từ một số nguồn tin chính thống, mình cũng sẽ chia sẻ thêm về những cách thiết kế và xử lý job, queue, batch processing,... mà mình đã thực hiện sau nhiều thương vụ buôn chuối của mình.', 
'2019/11/21 00:00:00', 
2, 
1, 
1, 
'queue.jpg', 
N'<section id="content" class="ui pilled segment md" ng-non-bindable="">
<p>Đây thực chất là phần tiếp theo của câu chuyện anh chàng buôn chuối trong <a href="https://kipalog.com/posts/Background-job-va-queue-cho-nguoi-nong-dan">bài viết này</a></p>
<p><a class="fluidbox fluidbox__instance-1 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/h5z2n1nqv1_%E1%BA%A3nh.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/h5z2n1nqv1_%E1%BA%A3nh.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 258px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<span id="toc-first-things-first"></span><h2 class="ui dividing header">First things first</h2>
<p>Yeah, lại là mình đây, <strong>Minh Monmen</strong> trong vai trò chàng trai buôn chuối rảnh rỗi ngồi viết lách linh tinh. Sau khi thu thập được rất nhiều kinh nghiệm từ việc bán chuối bán chuối, mình tự nhận thấy một số người coi trọng những <strong>kỹ sư</strong> thực thụ hơn những con buôn trái nghề. Nên là trong lần này mình sẽ hóa thân thành 1 <strong>kỹ sư</strong> phần mềm giả trang để tìm hiểu về background job và tiếp tục câu chuyện còn dang dở lần trước ở mức độ sâu hơn.</p>
<p>Trong bài viết này, ngoài việc tổng hợp thông tin từ một số nguồn tin chính thống, mình cũng sẽ chia sẻ thêm về những cách thiết kế và xử lý job, queue, batch processing,... mà mình đã thực hiện sau nhiều thương vụ buôn chuối của mình.</p>
<p>Tuy nhiên, để có thể đọc hiểu trôi chảy những thứ mà mình nêu ra ở đây thì các bạn nên có 1 số kiến thức nền tảng về:</p>
<ul class="ui list">
<li>Background job</li>
<li>Queue</li>
<li>Event-driven</li>
<li>Cronjob</li>
<li>Batch processing</li>
<li>Concurrency and lock</li>
</ul>
<p>Nhiêu đó đã, giờ bắt đầu nào.</p>
<span id="toc-c-c-lo-i-job-v-usecase-c-a-ch-ng"></span><h2 class="ui dividing header">Các loại job và usecase của chúng</h2>
<p>Trong 1 <a href="https://docs.microsoft.com/en-us/azure/architecture/best-practices/background-jobs">bài viết</a> rất chi tiết và cụ thể của bác Bill về vấn đề này đã đề cập rõ từng loại job cũng như usecase của chúng rồi, mình sẽ chỉ tóm tắt lại cho các bạn thôi. (Nhưng hãy đọc bài viết kia để có cái nhìn chi tiết hơn)</p>
<p>Trên khía cạnh <strong>trigger</strong> thì background job có thể xuất phát từ 2 loại trigger sau:</p>
<ul class="ui list">
<li>
<strong>Event-driven trigger</strong>: Là job được khởi chạy dựa trên 1 event nào đó xảy ra trong hệ thống. Có thể là việc 1 API được gọi, 1 Object được lưu vào DB,...</li>
<li>
<strong>Schedule-driven trigger</strong>: Là job khởi chạy dựa trên thời gian. Đó có thể là job định kỳ (hàng ngày, hàng giờ,...) hoặc job vào một thời điểm hay sau 1 thời điểm nhất định nào đó.</li>
</ul>
<span id="toc-event-driven-job"></span><h3 class="ui dividing header">Event-driven job</h3>
<p>Bạn sẽ sử dụng <strong>event-driven job</strong> khi nó phụ thuộc vào việc xuất hiện của những sự kiện <strong>không biết sẽ xảy ra khi nào</strong> như:</p>
<ul class="ui list">
<li>
<strong>Gửi email</strong> cho user khi họ <strong>đăng ký</strong>
</li>
<li>
<strong>Xử lý video</strong> sau khi user <strong>upload lên</strong>
</li>
<li>
<strong>Tạo report</strong> cho user sau khi họ <strong>submit yêu cầu</strong>
...</li>
</ul>
<p>Event-driven job thường được trigger thông qua hệ thống <strong>job queue</strong> và <strong>worker</strong>. Mỗi khi có event, job,... được đẩy vào job queue thì worker sẽ lắng nghe và xử lý lần lượt.</p>
<p>Mô hình của event-driven job là xử lý <strong>hàng loạt cùng lúc</strong> dựa trên nhiều worker chạy song song. Do đó loại job này <strong>có tính scalable</strong></p>
<span id="toc-schedule-driven-job"></span><h3 class="ui dividing header">Schedule-driven job</h3>
<p><strong>Schedule-driven</strong> được sử dụng cho các tác vụ thường xuyên, <strong>xác định được trước thời gian</strong> chạy hoặc <strong>lặp đi lặp lại</strong> như:</p>
<ul class="ui list">
<li>
<strong>Publish bài post</strong> đã được lên lịch sẵn</li>
<li>
<strong>Dọn dẹp file tạm</strong> hàng ngày</li>
<li>
<strong>Gửi email báo cáo</strong> hàng tuần
...</li>
</ul>
<p>Schedule-driven job thường được trigger thông qua <strong>crontab</strong>, <strong>interval</strong> hay <strong>forever repeat</strong> code.</p>
<p>Mô hình của schedule-driven job thường là <strong>một job</strong> được xử lý tại 1 thời điểm theo thời gian được đặt sẵn. Vì vậy loại job này <strong>KHÔNG có tính scalable</strong></p>
<span id="toc-c-ch-giao-l-u-ph-i-k-t-h-p"></span><h2 class="ui dividing header">Cách giao lưu phối kết hợp</h2>
<p>Chắc vậy là đủ để các bạn hình dung sơ sơ về ứng dụng của 2 loại hình background job này rồi nhỉ? Trong khuôn khổ hạn hẹp của bài viết này thì mình sẽ giới thiệu cho các bạn 1 vài cách kết hợp 2 loại background job trên và tình huống sử dụng cụ thể khi mình xây dựng các ứng dụng.</p>
<span id="toc-b-i-to-n-1-m-s-l-ng-view-trang-web-s-n-ph-m"></span><h3 class="ui dividing header">Bài toán 1: Đếm số lượng view trang web / sản phẩm</h3>
<p>Đây tưởng chừng là một bài toán có yêu cầu đơn giản mà việc thực hiện cũng lại đơn giản luôn. Cứ mỗi lần có 1 lượt view trang web hay 1 sản phẩm của bạn thì cộng cho sản phẩm đó 1 lượt view. </p>
<blockquote>
<p>Điểm quan trọng nhất của việc scale background job chính là xử lý đồng thời nhiều job cũng 1 lúc. Do vậy vấn đề về <strong>Atomic operation</strong> phải được đặt lên hàng đầu. Chi tiết bạn có thể google search thêm. Ở đây mình sẽ bỏ qua việc các vấn đề liên quan tới <strong>Atomic operation</strong> trong việc lưu trữ data của các bạn.</p>
</blockquote>
<p><strong>1. Cách nông dân</strong></p>
<p>Đơn giản là mỗi khi API view product được gọi thì bạn cộng thêm 1 view vào database </p>
<p><a class="fluidbox fluidbox__instance-2 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/cqcqt6l5rg_Simple-view-queue.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/cqcqt6l5rg_Simple-view-queue.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 481px; height: 91px; top: 0px; left: 91.7031px;"></div></div></a><a></a></p>
<p>Vấn đề gặp phải:</p>
<ul class="ui list">
<li>
<strong>Blocking IO</strong>: Việc +1 view vào database làm chậm response của người dùng, mặc dù người dùng không cần thiết phải chờ hành động này</li>
<li>
<strong>Performance</strong>: Khi số lượng người dùng sản phẩm lớn, ví dụ có 1000 người cùng view tại 1 thời điểm thì DB của bạn sẽ phải chịu 1000 câu query update 1 lúc. Oh...</li>
</ul>
<p><strong>2. Sử dụng event-driven job</strong></p>
<p>Giờ thay vì API gọi thẳng vào DB thì ta đẩy nó vào 1 cái <strong>Job Queue</strong>. Sẽ có 1 cơ số worker ở phía sau chờ sẵn để xử lý những cái job này.</p>
<p><a class="fluidbox fluidbox__instance-3 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/mknay1j486_Simple-view-queue-2.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/mknay1j486_Simple-view-queue-2.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 641px; height: 91px; top: 0px; left: 11.7031px;"></div></div></a><a></a></p>
<p>Vấn đề đã giải quyết:</p>
<ul class="ui list">
<li>
<strong>Non-blocking IO</strong>: Việc +1 view bây giờ đã <strong>gần như</strong> không ảnh hưởng tới thời gian response của người dùng do thời gian để đẩy job queue thường nhỏ hơn nhiều so với thời gian query update</li>
<li>
<strong>Throttling</strong>: Giờ nếu bạn có 10 worker, tại 1 thời điểm 1 worker chỉ xử lý 1 job. Vậy thì cùng lúc bạn sẽ chỉ có 10 job chạy song song, tức là dù bạn có 1000 view sản phẩm cùng lúc thì tại 1 thời điểm cũng chỉ có 10 câu lệnh update db được chạy.</li>
</ul>
<p>Vấn đề còn tồn tại:</p>
<ul class="ui list">
<li>
<strong>Performance</strong>: Vâng vẫn là cái vấn đề về performance, chỉ là ở 1 cấp độ khác mà thôi. Thay vì DB của các bạn phải chịu tải lớn, thì các bạn đã đánh đổi điều đó bằng việc <strong>xử lý được ít job hơn</strong>. Và vì xử lý ít job hơn nên các bạn sẽ dễ dẫn tới trường hợp bị <strong>dồn job</strong> do worker không xử lý kịp.</li>
<li>
<strong>Busy IO</strong>: 1 vấn đề mà giải pháp này vẫn còn đó là nó vẫn còn rất gánh nặng về mặt IO cho DB. Với 1000 view, DB của các bạn vẫn phải chịu 1000 câu lệnh update liên tục. Điều đó làm ảnh hưởng rất nhiều tới hiệu năng của những tác vụ khác.</li>
</ul>
<p><strong>3. Sử dụng kết hợp 2 loại job</strong></p>
<p>Để giải quyết vấn đề về DB bottle neck thì ta sẽ nghĩ ngay tới tầng đệm (caching). Tầng caching là tầng xử lý tốt phần IO hơn rất nhiều so với các loại DB cơ bản. Do vậy chúng ta sẽ đẩy gánh nặng này cho tầng caching bằng cách tạo ra 1 <strong>scheduled job</strong> lặp đi lặp lại để ghi data từ cache xuống DB.</p>
<p><a class="fluidbox fluidbox__instance-4 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/wq7nis95l5_Simple-view-queue-3.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/wq7nis95l5_Simple-view-queue-3.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 641px; height: 241px; top: 0px; left: 11.7031px;"></div></div></a><a></a></p>
<p>Như các bạn thấy, khi các <strong>event job</strong> +1 view cho sản phẩm thì kết quả này được ghi vào tầng cache. Sau đó các <strong>scheduled job</strong> sẽ định kỳ lấy tổng số view chưa được đếm này (n view) từ trong cache ra để ghi vào DB (+n view)</p>
<p>Vấn đề đã giải quyết:</p>
<ul class="ui list">
<li>
<strong>Performance</strong>: Do view được lưu tạm thời vào trong cache, do vậy ta có thể tận dụng sức mạnh IO của cache để nâng số worker đồng thời cũng như giảm được thời gian xử lý từng event job. Do đó tình trạng dồn queue sẽ được xử lý.</li>
<li>
<strong>Throttling hơn nữa</strong>: Việc phát sinh query update vào DB chỉ xảy ra trên các <strong>scheduled job</strong>, do vậy ta đã giảm thiểu số lần update DB thành 1 con số cố định và có thể cân đối được. Ví dụ nếu <strong>scheduled job</strong> chạy 10s 1 lần thì trong 1 phút sẽ chỉ có tối đa 6 query update DB được tạo ra (thay vì cả 1000 query update như trước)</li>
</ul>
<p>Vấn đề còn tồn tại:</p>
<ul class="ui list">
<li>
<strong>Delay data</strong>: Dữ liệu view của sản phẩm sẽ không được update theo thời gian thực mà sẽ có độ trễ tùy theo tần suất <strong>scheduled job</strong>. Tuy nhiên độ trễ này thường là chấp nhận được khi so sánh với những lợi ích nó mang lại.</li>
</ul>
<blockquote>
<p>Tips: Như mình đã nói ở trên, việc xử lý <strong>atomic operation</strong> là rất quan trọng trong việc xây dựng background job. Các bạn có thể thấy trong ảnh mình sử dụng operation <strong>-n</strong> và <strong>+n</strong> do cộng và trừ thường là <strong>atomic operation</strong> trên hầu hết các loại db/cache. Đây là 1 tip cho các bạn. Không nên <strong>get rồi set counter bằng 0</strong> mà nên <strong>get rồi trừ counter đi giá trị hiện tại</strong> của nó để đảm bảo không bị mất dữ liệu view khi đang reset counter nhé.</p>
<p>Tips 2: Với redis thì các bạn không cần phải chơi trick trừ như trên, vì nó có sẵn 1 cái <strong>atomic operation</strong> là <strong>GETSET</strong> để các bạn reset counter rồi.</p>
</blockquote>
<span id="toc-b-i-to-n-2-g-i-email-th-ng-b-o-h-ng-lo-t"></span><h3 class="ui dividing header">Bài toán 2: Gửi email thông báo hàng loạt</h3>
<p>Đây là bài toán thường gặp ở các hệ thống tin tức, báo cáo,... khi mà định kỳ (hàng ngày, hàng tuần) phải gửi nội dung được tổng hợp tới nhiều người dùng. Vậy background job sẽ xử lý trường hợp này như thế nào?</p>
<p><strong>1. Cách nông dân</strong></p>
<p><a class="fluidbox fluidbox__instance-5 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/yt0pnl10mj_Simple-view-queue-4.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/yt0pnl10mj_Simple-view-queue-4.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 456px; height: 316px; top: 0px; left: 104.203px;"></div></div></a><a></a></p>
<p>Trong cách này thì chúng ta sẽ có <strong>1 scheduled job</strong> siêu to khổng lồ chạy để lấy danh sách người dùng từ trong database, sau đó dùng danh sách này để gửi email cho tất cả user.</p>
<p>Vấn đề gặp phải:</p>
<ul class="ui list">
<li>
<strong>Thời gian xử lý lâu</strong>: Đương nhiên với duy nhất 1 scheduled job xử lý việc gửi email cho toàn bộ người dùng thì thời gian để xử lý hết được sẽ lâu đúng không? Tưởng tượng trong job này bạn phải lấy email, tạo content cho email đó, gửi email,... <strong>lần lượt</strong> cả ngàn lần.</li>
<li>
<strong>Khó retry</strong>: Với 1 job siêu to khổng lồ như này thì việc gặp lỗi giữa quá trình chạy sẽ rất khó để giải quyết do việc chạy lại job sẽ buộc phải xử lý mọi thứ <strong>từ đầu</strong>, xử lý trùng lặp,...</li>
</ul>
<p><strong>2. Cách bớt nông dân</strong></p>
<p><a class="fluidbox fluidbox__instance-6 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/mw9rmyn0d0_Simple-view-queue-5.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/mw9rmyn0d0_Simple-view-queue-5.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 183px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p>Ở đây <strong>scheduled job</strong> sẽ không đảm nhận việc thực hiện nhiệm vụ nữa mà sẽ đóng vai trò là <strong>người quản lý</strong> - tạo task cho nhiều event worker chạy song song thông qua <strong>Job queue</strong></p>
<p>Vấn đề đã giải quyết:</p>
<ul class="ui list">
<li>
<strong>Scalable</strong>: Chúng ta đã giải quyết được tính chất không scale được của <strong>scheduled job</strong> khi mà giờ đây nó chỉ đóng vai trò <strong>tạo task</strong> và <strong>đẩy vào job queue</strong> cho các event worker xử lý.</li>
<li>
<strong>Thời gian xử lý nhanh:</strong>: Do có thể xử lý đồng thời qua các event worker nên thời gian xử lý tổng thể sẽ giảm xuống theo cấp số nhân</li>
<li>
<strong>Dễ dàng retry</strong>: Việc xử lý lỗi giờ đây dễ dàng hơn rất nhiều vì từng job sẽ handle việc gửi email cho 1 user cụ thể. Do đó nếu có lỗi thì cũng không ảnh hưởng tới user khác. Ngoài ra từng job nhỏ còn tự retry được luôn mà không phải chạy lại toàn bộ từ đầu.</li>
</ul>
<span id="toc-b-i-to-n-3-etl-process"></span><h3 class="ui dividing header">Bài toán 3: ETL process</h3>
<p>Nói qua 1 chút về thuật ngữ <strong>ETL (Extract Transform Load)</strong> thì đây là thuật ngữ để chỉ 1 quá trình xử lý xử liệu từ hệ thống nguồn tới hệ thống đích. Mà thật ra là quá trình này thường là để chuyển dữ liệu từ các hệ thống hoạt động (Operation) sang hệ thống phân tích và báo cáo (Analytic and Reporting). </p>
<p>Có rất nhiều tool được sinh ra cho quá trình này tuy nhiên có thể vì kiến thức của mình lúc ấy còn hạn chế hoặc do hệ thống của bên mình chưa khủng tới mức dùng những giải pháp đồ sộ đó mà mình đã chọn giải pháp đơn giản hơn là tự viết những tiến trình đồng bộ dữ liệu từ các hệ thống Operation tới hệ thống Analytic bằng <strong>Scheduled job</strong>.</p>
<blockquote>
<p>Tất cả job và dữ liệu xử lý trong quá trình ETL phải được thiết kế để <strong>có thể retry</strong> hoặc <strong>chạy lại</strong> mà <strong>không bị trùng lặp</strong> hay dẫn tới sai sót.</p>
</blockquote>
<p><strong>1. Cách nông dân</strong></p>
<p><a class="fluidbox fluidbox__instance-7 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/ied4f1e2lt_Simple-view-queue-6.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/ied4f1e2lt_Simple-view-queue-6.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 493px; height: 81px; top: 0px; left: 85.7031px;"></div></div></a><a></a></p>
<p>Trong cách này, mình có duy nhất 1 job được scheduled để làm cả 3 quá trình <strong>Extract</strong>, <strong>Transform</strong>, <strong>Load</strong>. Idea thì rất đơn giản, cứ 1 tiếng bạn chạy 1 cái job lấy hết data từ DB nguồn trong thời gian vừa rồi, làm 1 số thao tác magic trên đống dữ liệu đó, rồi đẩy vào 1 DB đích. Hết</p>
<p>Cách xử lý này có 1 cái tiện là bạn có thể tạo 1 cái pipeline đơn giản để data lần lượt được xử lý qua cả 3 quá trình một cách tuần tự mà không phải lo nghĩ gì. Tuy nhiên đời không như là mơ. Bạn sẽ gặp các vấn đề tương tự như vụ gửi email ở trên, mà còn ở mức độ nghiêm trọng hơn vì:</p>
<ul class="ui list">
<li>
<strong>Thời gian xử lý lâu</strong>: Để dữ liệu chạy qua tất cả các quá trình này 1 lúc sẽ tốn thời gian và tài nguyên. Nếu để interval dài thì dữ liệu của bạn quá outdate. Nếu interval thấp thì job sau dễ chồng chéo lên job trước do job trước chưa chạy xong,...</li>
<li>
<strong>Retry</strong>: Again, vấn đề không retry được sẽ là vấn đề rất nhức nhối. Với multi-step job như này thì việc fail 1 step cuối sẽ khiến toàn bộ các step trước phải chạy lại, và... boom</li>
</ul>
<p>Hãy cùng tìm hiểu cách tiếp cận tiếp theo</p>
<p><strong>2. Cách bớt nông dân</strong></p>
<p><a class="fluidbox fluidbox__instance-8 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/8bb14bgf5g_Simple-view-queue-7.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/8bb14bgf5g_Simple-view-queue-7.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 551px; height: 510px; top: 0px; left: 56.7031px;"></div></div></a><a></a></p>
<p>Ở đây mình sử dụng 1 vài DB tạm để chứa các dữ liệu trong quá trình xử lý và tách 3 quá trình ETL ra thành 3 scheduled job khác nhau. Mặc dù cách này đã cải thiện về thời gian và việc xử lý lỗi trong quá trình chạy để retry từng phần được, song nó vẫn dựa trên mô hình scheduled, tức là không scale được. Cách này có thể chạy được ổn với time interval tương đối ngắn, lượng data giữa các bước sync không quá nhiều. </p>
<p>Đối với <strong>1 record dữ liệu</strong> thì việc xử lý qua từng bước sẽ là tuần tự. Tuy nhiên với <strong>nhiều record dữ liệu</strong> thì 3 quá trình này trở thành <strong>song song</strong> nhau (chạy kiểu gối đầu). Do vậy thời gian tổng thể sẽ được rút ngắn kha khá</p>
<p>Vấn đề duy nhất bạn phải giải quyết đó chính là <strong>tracking status</strong> của dữ liệu. Tức là dữ liệu của bạn đã đi tới bước nào, được xử lý chưa, thành công hay thất bại, và quan trọng hơi là được sắp xếp xử lý 1 cách có thứ tự.</p>
<p><strong>3. Cách loằng ngoằng</strong></p>
<p><a class="fluidbox fluidbox__instance-9 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/i0ej6l2m2y_Simple-view-queue-8.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/i0ej6l2m2y_Simple-view-queue-8.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 505px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p>Phát triển tiếp mô hình phía trên và thêm yếu tố scaling bằng event job, mình sẽ có mô hình cuối cùng này. Trông có vẻ phức tạp vậy tuy nhiên về cấu trúc lại y hệt vụ gửi email ở phía trên thôi không có gì to tát cả.</p>
<p>Cách này đã giải quyết được gần như tất cả các vấn đề liên quan tới performance, scale, delay time,... mà ta gặp phải phía trên. Nó phù hợp với các hệ thống sync dữ liệu có độ trễ thấp do có thể giảm được thời gian delay giữa các lần chạy. </p>
<p>Tuy nhiên, vinh quang nào cũng phải trả giá bằng máu và nước mắt. Các bạn sẽ phải đánh đổi bằng việc:</p>
<ul class="ui list">
<li>
<strong>Track data status</strong>: đánh dấu data đã xử lý tới bước nào</li>
<li>
<strong>Data paging</strong>: Các bạn phải có 1 cột id hay time đủ tin cậy để <strong>scheduled job</strong> có thể phân chia được từng khoảng dữ liệu cho <strong>event job</strong> xử lý đồng thời. Vì thế việc dữ liệu được tổ chức thế nào sẽ khá tricky đó nhé.</li>
</ul>
<p><a class="fluidbox fluidbox__instance-10 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/cvee0r0x0i_Screenshot%20from%202019-11-22%2001-19-41.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/cvee0r0x0i_Screenshot%20from%202019-11-22%2001-19-41.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 202px; height: 512px; top: 0px; left: 231.203px;"></div></div></a><a></a></p>
<p>Đây là minh họa cho quá trình xử lý song song nhiều bản ghi cùng lúc bởi 3 loại job. </p>
<blockquote>
<p>Tips: Tận dụng lợi thế về batch processing với từng job bằng việc tìm hiểu số record ghi đồng thời hiệu quả với từng loại DB. Ví dụ mongodb sẽ có mức ghi hiệu quả nếu mỗi job xử lý 1000 record đồng thời. Tham khảo thêm <a href="https://medium.com/dbkoda/bulk-operations-in-mongodb-ed49c109d280">tại đây</a></p>
</blockquote>
<span id="toc-t-ng-k-t"></span><h2 class="ui dividing header">Tổng kết</h2>
<p>Qua bài viết trên mình đã đưa ra cho các bạn cái nhìn tổng quát về 2 loại background job cũng như 3 case ứng dụng thực tế trong việc kết hợp 2 loại job này để tăng khả năng xử lý của ứng dụng.</p>
<p>Mặc dù bài viết không có 1 mẩu code thực nào mà trông như thuần túy lý thuyết nhưng các bạn yên tâm rằng mọi mô hình bên trên đều đã được mình áp dụng trong thực tế và chỉ tổng kết lại kết quả và hiệu quả của nó cho các bạn mà thôi.</p>
<p>Có những mô hình mặc dù mình có nêu ra điểm chưa tốt nhưng nó cũng có thể xử lý khối lượng công việc khá lớn rồi đó. Ví dụ như mô hình 2 bài toán ETL đang xử lý vài chục triệu record dữ liệu hàng ngày từ 5 hệ thống với hơn 20 scheduled job có độ trễ dưới 2 phút. Hay mô hình 2 bài toán view cũng đang xử lý hơn 5 triệu job 1 ngày với 10 worker cho hệ thống notification thời gian thực mà chưa gặp vấn đề gì về performance. Do đó việc bạn chọn cách nào cho dự án của mình sẽ còn tùy vào tính chất và khối lượng công việc của các worker nữa.</p>
<p>Cám ơn các bạn đã quan tâm theo dõi đến đây. Hẹn gặp lại trong bài viết sau.</p>
</section>'),

-- Nghệ thuật xử lý background job phần 2 --
(2, 
N'Nghệ thuật xử lý background job phần 2: Job order with concurrent worker', 
'nghe-thuat-xu-ly-background-job-phan-2', 
N'Bài viết này dành cho những bạn đã thành công trong việc implement được hệ thống', 
'2020/04/18 00:00:00', 
2, 
1, 
2, 
'queue.jpg',
N'<section id="content" class="ui pilled segment md" ng-non-bindable="">
<p>Aka <strong>Nghệ thuật đưa dê qua cầu</strong> của tác giả <strong>Minh Monmen</strong>.</p>
<p>Hê lô bà con cô bác họ hàng gần xa bà con khối phố. Lại là mình đây, <strong>Minh Monmen</strong> trong những chia sẻ vụn vặt về quá trình làm những sản phẩm siêu to khổng lồ (tự huyễn hoặc bản thân vậy cho có động lực). Hôm nay mình xin hân hạnh gửi đến các bạn phần tiếp theo của series <a href="https://kipalog.com/posts/Nghe-thuat-xu-ly-background-job"><strong>Nghệ thuật xử lý background job</strong></a> mà mình vừa mới nghĩ được ra thêm. </p>
<p>Thật ra đây cũng không phải chia sẻ gì mà là mình đang gặp 1 vấn đề, mình tìm ra 1 cách nông dân để giải quyết nó và đưa lên đây để các bạn cùng cho ý kiến xem nó có ok không. Rất mong nhận được nhiều gạch đá từ các bạn để đủ xây lâu đài cho vấn đề này.</p>
<span id="toc-first-things-first"></span><h2 class="ui dividing header">First things first</h2>
<p>Bài viết này dành cho những bạn đã thành công trong việc implement được hệ thống <strong>background job</strong> (hoặc những bạn chưa implement được thì save lại sau đọc dần =))). Lần này mình sẽ nói qua 1 cách nhanh chóng những thứ mình vừa mới nghĩ ra, vì để lâu lắc 1 chút là mình lại quên mất. Nên bắt đầu luôn nè.</p>
<p>Những điều cần biết trước khi đọc:</p>
<ul class="ui list">
<li>Background job (hiển nhiên)</li>
<li>Queue, message queue</li>
<li>Concurrency and lock </li>
<li><a href="https://kipalog.com/posts/Nghe-thuat-xu-ly-background-job">Nghệ thuật xử lý background job phần 1</a></li>
</ul>
<p>Những điều cần biết khi đọc xong:</p>
<ul class="ui list">
<li>Bài viết chỉ focus vào giải quyết bài toán <strong>concurrency</strong> và <strong>job ordering</strong>
</li>
<li>Bài viết bỏ qua các vấn đề liên quan tới các tính chất khác như <strong>reliable</strong>, <strong>retryable</strong>,... </li>
</ul>
<p>Vậy nên đọc xong đừng thắc mắc tại sao bài viết không giải quyết vấn đề retry, vấn đề tin cậy, persistent... các thứ nhé.</p>
<p>Nhào vô.</p>
<blockquote>
<p>Mọi thứ ở trong bài viết này đề cập đều ở mức <strong>thiết kế hệ thống</strong>, tức là cho các bạn một cách thiết kế nào đó <strong>phục vụ được nhu cầu</strong> nhưng <strong>không quá phụ thuộc vào công nghệ</strong>. Bạn sẽ không cần phải cài đặt Kafka hay hệ thống Message queue phức tạp nào đó để implement những cách tiếp cận dưới đây. Chính vì vậy mình sẽ loại bỏ hoàn toàn các <strong>feature riêng biệt</strong> của 1 hệ thống hay công nghệ nào đó mà chỉ quan tâm tới mô hình đơn giản nhất áp dụng được cho hầu hết công nghệ mà thôi.</p>
</blockquote>
<span id="toc-the-big-problem"></span><h2 class="ui dividing header">The big problem</h2>
<p>Trong bài viết trước, mình đã bỏ qua toàn bộ các vấn đề liên quan tới <strong>sự liên hệ giữa 2 job</strong> và coi <strong>mọi job đều là độc lập</strong>. Điều này làm mọi thứ đơn giản hơn rất nhiều khi mà các bạn có thể thoải mái scale số lượng worker lên bao nhiêu cũng được để tận dụng sức mạnh của xử lý song song. Tuy nhiên trong 1 số trường hợp oái oăm hơn, khi mà các job bị phụ thuộc vào nhau bởi 1 khía cạnh nào đó thì việc các bạn vừa giữ được thứ tự xử lý job, vừa giữ được khả năng xử lý song song sẽ là một điều không đơn giản.</p>
<p><a class="fluidbox fluidbox__instance-1 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/fblvkyf7x1_%E1%BA%A3nh.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/fblvkyf7x1_%E1%BA%A3nh.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 374px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p>Xử lý worker song song làm mình liên tưởng đến bài toán 2 con dê qua cầu. <strong>Làm sao để 2 con dê cùng qua 1 cây cầu an toàn mà hiệu quả?</strong></p>
<p>Chúng ta hãy đi sâu vào từng cách tiếp cận khi xử lý job có thứ tự trong phần dưới nhé.</p>
<blockquote>
<p>Mình mặc định coi <strong>1 worker chỉ xử lý được 1 job</strong> tại 1 thời điểm nhé. Với các loại worker kiểu async xử lý nhiều job cùng lúc thì sẽ coi như là multiple worker cho đơn giản.</p>
</blockquote>
<p>Giờ chúng ta có 1 bài toán ví dụ như sau:</p>
<ul class="ui list">
<li>Có 1 cơ số loại job cần thực hiện. VD: <strong>tạo post</strong>, <strong>tạo comment</strong>, <strong>like post</strong>,...</li>
<li>1 số loại job sẽ cần thứ tự với điều kiện xác định. VD: comment của cùng 1 post cần được tạo đúng theo thứ tự request đẩy vào.</li>
<li>Ở đây các bạn có thể thấy điều kiện để 2 job ràng buộc về thứ tự là:
<ul class="ui list">
<li>
<strong>Phần pre-defined</strong>: tức là phần biết từ khi khởi tạo. Chính là những job <strong>thuộc 1 loại nào đó</strong>. Phần này sẽ có đặc điểm là <strong>hữu hạn</strong>. Ví dụ job loại <code>tạo post</code>, job loại <code>tạo comment</code>,...</li>
<li>
<strong>Phần data-related</strong>: tức là khi khởi tạo job bạn không biết <strong>giá trị chính xác</strong>. Ví dụ những job tạo comment có <strong>cùng post_id</strong>. Phần này sẽ có đặc điểm là về lý thuyết sẽ <strong>vô hạn</strong>.</li>
</ul>
</li>
</ul>
<p>Vấn đề của chúng ta chính là ở chỗ này. Điều kiện để 2 job liên quan tới nhau không những chỉ từ <strong>loại job</strong> mà còn <strong>phụ thuộc vào data nữa</strong>. Ví dụ như job <code>comment X vào post A</code> phải được hoàn thành trước job <code>comment Y vào post A</code>.</p>
<span id="toc-nh-ng-con-ng-ta-i-qua"></span><h2 class="ui dividing header">Những con đường ta đã đi qua</h2>
<p>Chúng ta cùng xem xét những cách tiếp cận dưới đây và xem chúng gặp phải những vấn đề gì nhé.</p>
<span id="toc-1-queue-cho-all-job-1-worker"></span><h3 class="ui dividing header">1 Queue cho all job, 1 worker</h3>
<p>Đây là cách tiếp cận nông dân và dễ hiểu nhất. Với cách tiếp nhận này bạn không cần phải lo về vấn đề xử lý song song nữa. Chỉ cần queue có cơ chế <strong>FIFO (first in first out)</strong> là đủ. 1 worker tại 1 thời điểm chỉ xử lý được 1 job, và thứ tự thực hiện job sẽ chính là thứ tự được lấy từ queue ra. Bravo!!!</p>
<p><a class="fluidbox fluidbox__instance-2 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/ke0so68oah_Single-queue-1.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/ke0so68oah_Single-queue-1.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 113px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p>Và tất nhiên là nó kéo theo 1 vấn đề siêu to khổng lồ. Đó là việc <strong>xử lý chậm</strong>. Tưởng tượng bạn nhận được job với tần suất là 1000 job/giờ nhưng lại chỉ có thể xử lý 500 job/giờ. Vậy là qua mỗi ngày số job sẽ cứ dồn mãi, dồn mãi... <strong>Boom!</strong></p>
<span id="toc-1-queue-cho-m-i-lo-i-pre-defined-job-m-i-queue-1-worker-"></span><h3 class="ui dividing header">1 Queue cho mỗi loại <strong>pre-defined</strong> job, mỗi queue 1 worker.</h3>
<p>Đây là bước tiến tiếp theo của cách làm trên, khi mà đã tách mỗi loại job ra 1 queue riêng, mỗi queue riêng này sẽ có <strong>1 worker</strong> của riêng mình.</p>
<p><a class="fluidbox fluidbox__instance-3 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/gesdcjq8ji_Single-queue-2.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/gesdcjq8ji_Single-queue-2.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 332px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p>Cách xử lý này đã khắc phục được phần nào điểm nghẽn khi mà đã chia tải hệ thống ra nhiều loại worker. Mặc dù chỉ là 1 phần khá nhỏ. Như mình đã nói ở trên, số lượng các loại <strong>pre-defined</strong> job là hữu hạn. Ví dụ hệ thống của bạn chỉ có 3 loại job là <strong>tạo post</strong>, <strong>tạo comment</strong>, <strong>like post</strong>. Vậy là bạn sẽ có 3 worker khác nhau, mỗi worker xử lý 1 loại job riêng biệt. Và tới đây, chúng ta vẫn gần như không cần phải lo lắng tới vấn đề thứ tự thực hiện job hay concurrency. Bởi với 90% các hệ thống thì <strong>job loại A</strong> sẽ ít liên quan tới <strong>job loại B</strong>. (Nếu hệ thống của bạn là 10% còn lại, hãy theo dõi tiếp các solution khác).</p>
<p>Tuy nhiên, tương tự như cách đầu tiên, hệ thống của các bạn vẫn bị giới hạn bởi 1 worker cho 1 loại job. Do vậy mà nó vẫn chậm, rất chậm.</p>
<span id="toc-1-queue-cho-m-i-lo-i-pre-defined-job-m-i-queue-c-nhi-u-worker"></span><h3 class="ui dividing header">1 queue cho mỗi loại <strong>pre-defined</strong> job, mỗi queue có nhiều worker</h3>
<p>Đây là cách mà phần lớn các hệ thống đang sử dụng. Các loại lib job queue/ task queue phổ biến như <code>Resque</code> trên ruby, <code>Celery</code> trên python, <code>Bull</code> trên Nodejs,... hay rất nhiều các loại task queue khác có backend là redis đều áp dụng pattern này. </p>
<p><a class="fluidbox fluidbox__instance-4 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/haq1fc3bt1_Single-queue-3a.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/haq1fc3bt1_Single-queue-3a.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 394px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p>Thực hiện theo pattern này thì chúng ta đã xử lý được vấn đề chậm khi mà nhiều worker cùng xử lý song song 1 loại job, giúp cho hệ thống dễ dàng scale theo chiều ngang hơn. Tuy nhiên đây chính là lúc mà sự chú ý của ta đã va vào ánh mắt của vấn đề: <strong>Concurrency và Job ordering</strong>. Nhiều worker chạy song song đồng nghĩa với việc phát sinh những <strong>tranh chấp tài nguyên</strong> hay <strong>job tới sau xử lý xong trước job tới trước</strong>.</p>
<p><a class="fluidbox fluidbox__instance-5 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/i4qukzldnb_Single-queue-3b.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/i4qukzldnb_Single-queue-3b.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 319px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p>Đây chính là khi cơn ác mộng bắt đầu. Mình bắt đầu vận dụng hết bộ óc thiên tài để đi search google các cách giải quyết. Và 1 số hướng tiếp cận sau sinh ra:</p>
<ul class="ui list">
<li>Sử dụng <strong>Atomic transaction</strong> để update tài nguyên. Cái này chỉ phù hợp với những transaction quan trọng và <strong>nằm hoàn toàn trên 1 db</strong>. Ví dụ như bạn update 1 hoặc 1 vài bản ghi bằng atomic transaction. Tuy nhiên nó ko áp dụng được với toàn bộ 1 process dài như chuẩn bị tham số, lấy info từ svc A, tính toán,... Mình đã từng kết hợp <strong>unique index</strong> + <strong>upsert operation</strong> cho 1 vài trường hợp, tuy nhiên với tần suất job lớn thì tỷ lệ fail với upsert là rất rất nhiều, và tin mình đi, bạn không muốn phải retry đống job fail nhiều như vậy đâu =)))</li>
<li>Sử dụng <strong>Locking</strong> để khóa tài nguyên cần update. Cách này mình đã sử dụng khi nhận thấy thời gian lock không dài (chỉ vài chục ms), do đó mình chấp nhận drop hoặc retry nhưng job nào đen quá mà bị lock cùng nhau. Ban đầu thì nó cũng chạy ổn, nhưng càng về sau khi job của mình phải xử lý nhiều tác vụ hơn, và thời gian lock tăng lên đi kèm với tỷ lệ drop vài retry tăng lên luôn. Lại phải tính 1 cách khác.</li>
<li>Sử dụng cơ chế <strong>Partition queue</strong> bắt chước từ kafka. Các bạn đều biết là kafka có 1 pattern xử lý nôm na đó là <strong>tại 1 thời điểm 1 partition chỉ có 1 worker được xử lý</strong>. Vậy là mình sẽ tạo ra 10 cái queue <strong>create comment job</strong>, tạo ra 10 worker rồi cho mỗi 1 cái lắng nghe duy nhất 1 queue trên. Khi có job mới thì chia cái ID của post cho 10 rồi đẩy vào queue tương ứng. Mọi thứ nghe thật là awesome nhưng có 1 cái lỗ hồng to đùng: <strong>các loại task queue phổ biến lại không được thiết kế phức tạp như vậy</strong>. =))))))) Để implement được cơ chế học mót này mình phải quản lý số lượng worker và số lượng queue rất chặt chẽ, rồi cả  thằng tạo job cũng bị phụ thuộc để biết nó đẩy job vào queue nào,... </li>
<li>Tạo cho mỗi 1 post 1 queue riêng, rồi cho 1 worker lắng nghe cái queue riêng đó. Ví dụ thay vì 1 queue <strong>create comment job</strong> thì sẽ tạo ra nhiều queue dạng <strong>create comment job - post A</strong>. Đây chính là mô hình giải quyết được bài toán. Nhưng vấn đề của mình lại là: <strong>Việc tạo queue và listen queue phải được xử lý dynamic</strong>. Tức là trong khi runtime phải liên tục tạo ra queue và consume job trong queue đó. Well well well.</li>
</ul>
<p>Ví dụ code 1 thằng task queue bất kỳ sẽ dạng như sau:</p>
<pre><code class="javascript ui segment hljs "><span class="hljs-keyword">const</span> queue = <span class="hljs-keyword">new</span> Queue(<span class="hljs-string">\'create_comment\'</span>)
<span class="hljs-comment">// register handler (on worker)</span>
<span class="hljs-keyword">const</span> handler = (job) =&gt; {
    <span class="hljs-comment">// process job</span>
    <span class="hljs-keyword">const</span> data = job.data; <span class="hljs-comment">// xxx</span>
}
<span class="hljs-comment">// Register when worker start</span>
queue.register(handler)

<span class="hljs-comment">// insert job</span>
<span class="hljs-keyword">const</span> data = <span class="hljs-string">"xxx"</span>;
queue.add(data)
</code></pre>
<p>Thay vào đó ta lại cần:</p>
<pre><code class="javascript ui segment hljs "><span class="hljs-keyword">const</span> queueA = <span class="hljs-keyword">new</span> Queue(<span class="hljs-string">\'create_comment_post_A\'</span>)
<span class="hljs-keyword">const</span> queueB = <span class="hljs-keyword">new</span> Queue(<span class="hljs-string">\'create_comment_post_A\'</span>)

<span class="hljs-comment">// register handler (on worker)</span>
<span class="hljs-keyword">const</span> handler = (job) =&gt; {
    <span class="hljs-comment">// process job</span>
}
<span class="hljs-comment">// Dynamic register ON RUNTIME</span>
queueA.register(handler)
queueB.register(handler)

<span class="hljs-comment">// insert job</span>
<span class="hljs-keyword">const</span> data = <span class="hljs-string">"something"</span>;
queueA.add(data)

<span class="hljs-comment">// Dynamic unregister ON RUNTIME when process all job for post A done</span>
queueA.unregister(handler)
<span class="hljs-comment">// Delete queue A</span>
queueA.destroy()
</code></pre>
<p>Đây chính là vấn đề của cách tiếp cận này. Việc đăng ký/hủy đăng ký queue nếu thực hiện như thế này sẽ cực kỳ khó quản lý nếu các bạn trực tiếp sử dụng queue của các lib task queue. Chưa nói tới việc nó còn gây ra các tác động như tạo thêm connection, rác tài nguyên,...</p>
<span id="toc-b-c-ti-n-l-n-b-ng-m-t-o-n-code-nh-"></span><h2 class="ui dividing header">Bước tiến lớn bằng một đoạn code nhỏ</h2>
<p>Chính trong lúc khó khăn ấy, khi mà cái khó liền ló cái ngu mình đã nghĩ ra 1 cách nông dân để sử dụng luôn hạ tầng và các cơ chế hiện tại như sau:</p>
<span id="toc-1-queue-cho-m-i-lo-i-pre-defined-job-m-i-queue-c-nhi-u-worker-1-lock-1-datasource-d-ng-queue-qu-n-l-concurrency"></span><h3 class="ui dividing header">1 queue cho mỗi loại <strong>pre-defined</strong> job, mỗi queue có nhiều worker, 1 lock + 1 datasource dạng queue để quản lý concurrency</h3>
<p>Về mặt bản chất, vẫn là bạn tạo ra các queue riêng biệt cho từng đối tượng bài post A, B, C. Tuy nhiên khi đặt trong hoàn cảnh tích hợp với các lib task queue hiện có thì ý nghĩa implement của nó lại khác. Thay vì bạn tạo ra 1 <strong>job cho post A</strong> với <strong>data X</strong>, thì bạn sẽ tạo <strong>job cho post A</strong> không có data. Sau đó <strong>job cho post A</strong> sẽ pop data từ 1 list data nào đó (redis list, database,...) và xử lý. Xử lý xong sẽ lại tự schedule <strong>job cho post A</strong> tiếp theo.</p>
<p><a class="fluidbox fluidbox__instance-6 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/slrgd76d7l_Single-queue-4.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/slrgd76d7l_Single-queue-4.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 360px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p>Mô tả diễn biến của nó như sau:</p>
<pre><code class="javascript ui segment hljs "><span class="hljs-keyword">const</span> queue = <span class="hljs-keyword">new</span> Queue(<span class="hljs-string">\'create_comment\'</span>)

<span class="hljs-comment">// register handler (on worker)</span>
<span class="hljs-keyword">const</span> handler = (job) =&gt; {
    <span class="hljs-comment">// process job</span>
    <span class="hljs-keyword">const</span> name = job.data; <span class="hljs-comment">// create_comment_post_A</span>
    <span class="hljs-comment">// 4. Pop data from data source</span>
    <span class="hljs-keyword">const</span> data = datasource.pop(name); <span class="hljs-comment">// xxx</span>

    <span class="hljs-comment">// processing</span>

    <span class="hljs-comment">// 5. Check if data source has next data</span>
    <span class="hljs-keyword">if</span> (datasource.hasNext()) {
        <span class="hljs-comment">// 6a. Extend lock timeout and schedule next job for post A</span>
        extendLock(name)
        queue.add(name)
    } <span class="hljs-keyword">else</span> {
        <span class="hljs-comment">// 6b. No data available, release lock for post A so new job can be scheduled</span>
        releaseLock(name)
    }
}
<span class="hljs-comment">// Register when worker start</span>
queue.register(handler)

<span class="hljs-comment">// insert job</span>
<span class="hljs-keyword">const</span> data = <span class="hljs-string">"xxx"</span>;
<span class="hljs-comment">// 1. Push data to data source (a redis list / db)</span>
datasource.push(<span class="hljs-string">\'create_comment_post_A\'</span>, data)
<span class="hljs-comment">// 2. Claim lock for post A for TIMEOUT_DURATION. </span>
<span class="hljs-keyword">const</span> canSchedule = claimLock(<span class="hljs-string">\'create_comment_post_A\'</span>, TIMEOUT_DURATION)
<span class="hljs-keyword">if</span> (canSchedule) {
    <span class="hljs-comment">// 3a. If success schedule new job for post A </span>
    queue.add(<span class="hljs-string">\'create_comment_post_A\'</span>)
} <span class="hljs-keyword">else</span> {
    <span class="hljs-comment">// 3b. Job for post A already running, do nothing</span>
}
</code></pre>
<p>1 vấn đề nhỏ với cơ chế <strong>schedule gối đầu</strong> như này là nếu 1 job cho post A đã bị fail xử lý quá thời gian timeout của lock mà không có job mới nào được add để tiếp tục xử lý job cho post A thì hàng đợi cho post A sẽ dừng mãi mãi. Lúc này mình thêm 1 tiến trình định kỳ <strong>re-scheduler</strong> để kiểm tra toàn bộ những hàng đợi có vấn đề và khởi tạo lại job.</p>
<pre><code class="javascript ui segment hljs "><span class="hljs-comment">// Interval running</span>
<span class="hljs-keyword">const</span> allProcesses = datasource.getAllLocks(); <span class="hljs-comment">// [\'create_comment_post_A\', \'create_comment_post_B\',...]</span>
<span class="hljs-keyword">for</span> (<span class="hljs-keyword">let</span> i = <span class="hljs-number">0</span>; i &lt; allProcesses.length; i++) {
    <span class="hljs-keyword">const</span> element = allProcesses[i];
    <span class="hljs-keyword">if</span> (claimLock(allProcesses[i])) {
        <span class="hljs-comment">// Job for post A does not exists but datasource still have data for post A</span>
        <span class="hljs-comment">// Reschedule job for post A</span>
        queue.add(allProcesses[i])
    }
}
</code></pre>
<p>Gần như các bạn không cần phải sửa code liên quan tới xử lý job mà ta chỉ cần can thiệp vào quá trình đẩy data vào và lấy data ra với sự tham gia của 1 data source và 1 chiếc lock. Điều này có thể dễ dàng tích hợp với phần lớn các loại database mà cơ bản nhất là redis. Sau đây là mẫu mình đã implement với redis.</p>
<pre><code class="javascript ui segment hljs "><span class="hljs-keyword">const</span> ALL_LOCKS_KEY = <span class="hljs-string">\'locks\'</span>;
<span class="hljs-keyword">const</span> LOCK_TTL = <span class="hljs-number">30</span>; <span class="hljs-comment">// 30s</span>
<span class="hljs-function"><span class="hljs-keyword">function</span> <span class="hljs-title">getLockKey</span><span class="hljs-params">(uniqueKey)</span> </span>{
    <span class="hljs-keyword">return</span> `lock:${uniqueKey}`;
}

<span class="hljs-function"><span class="hljs-keyword">function</span> <span class="hljs-title">getDataKey</span><span class="hljs-params">(uniqueKey)</span> </span>{
    <span class="hljs-keyword">return</span> `data:${uniqueKey}`;
}

<span class="hljs-comment">// Lua script to clear lock when data queue empty</span>
<span class="hljs-comment">// Usage: clearIfQueueEmpty &lt;REDIS_ALL_LOCKS_KEY&gt; &lt;REDIS_LOCK_KEY&gt; &lt;REDIS_DATA_KEY&gt; &lt;LOCK_KEY&gt;</span>
await redisClient.defineCommand(<span class="hljs-string">\'clearIfQueueEmpty\'</span>, {
    numberOfKeys: <span class="hljs-number">3</span>,
    lua:
        <span class="hljs-string">"if redis.call(\'llen\', KEYS[3]) == 0 then "</span>
            + <span class="hljs-string">"redis.call(\'del\', KEYS[2], KEYS[3]);"</span>
            + <span class="hljs-string">"redis.call(\'srem\', KEYS[1], ARGV[1]);"</span>
            + <span class="hljs-string">"return 1;"</span>
        + <span class="hljs-string">"else "</span>
            + <span class="hljs-string">"return 0; "</span>
        + <span class="hljs-string">"end"</span>
});

<span class="hljs-comment">/**
* Add a job to datasource and try schedule job for a key
* @param {Queue} queue Queue instance. Eg: new Queue("create_comment")
* @param {string} key  Key to lock resource: post_A
* @param {object} data Data to push to datasource
*/</span>
async <span class="hljs-function"><span class="hljs-keyword">function</span> <span class="hljs-title">add</span><span class="hljs-params">(queue, key, data)</span> </span>{
    <span class="hljs-comment">// Push data to queue</span>
    <span class="hljs-keyword">const</span> dataKey = getQueueDataKey(key);
    await redisClient
        .pipeline()
        .rpush(dataKey, <span class="hljs-built_in">JSON</span>.stringify(data))
        <span class="hljs-comment">// Push key to all lock</span>
        .sadd(ALL_LOCKS_KEY, key)
        .exec();

    <span class="hljs-comment">// Check lock to ensure schedule only not running queue</span>
    <span class="hljs-keyword">const</span> lockKey = getQueueLockKey(key);
    <span class="hljs-comment">// Claim lock</span>
    <span class="hljs-keyword">const</span> jobStatus = await redisClient.setnx(lockKey, <span class="hljs-string">\'1\'</span>);
    <span class="hljs-keyword">if</span> (jobStatus === <span class="hljs-number">1</span>) {
        await redisClient.expire(lockKey, LOCK_TTL);
        await queue.add({ key });
    }
}

<span class="hljs-comment">/**
* Pop data from datasource to process
* @param {string} key  Key to lock resource: post_A
* @return {object}     Data to process
*/</span>
async <span class="hljs-function"><span class="hljs-keyword">function</span> <span class="hljs-title">pop</span><span class="hljs-params">(key)</span> </span>{
    <span class="hljs-comment">// Pop data from data source</span>
    <span class="hljs-keyword">const</span> data = await redisClient.lpop(getQueueDataKey(key));
    <span class="hljs-keyword">if</span> (!data) {
        <span class="hljs-keyword">return</span> <span class="hljs-literal">null</span>;
    }
    <span class="hljs-keyword">return</span> <span class="hljs-built_in">JSON</span>.parse(data);
}

<span class="hljs-comment">/**
* Finish a job and schedule next job
* @param {Queue} queue Queue instance. Eg: new Queue("create_comment")
* @param {string} key  Key to lock resource: post_A
*/</span>
async <span class="hljs-function"><span class="hljs-keyword">function</span> <span class="hljs-title">finish</span><span class="hljs-params">(queue, key)</span> </span>{
    <span class="hljs-keyword">const</span> lockKey = getQueueLockKey(key);
    <span class="hljs-comment">// Clear job lock if data empty</span>
    <span class="hljs-keyword">const</span> result = await redisClient.clearIfQueueEmpty(
        ALL_LOCKS_KEY,
        lockKey,
        getQueueDataKey(key),
        key
    );
    <span class="hljs-keyword">if</span> (result === <span class="hljs-number">0</span>) {
        <span class="hljs-comment">// clear fail, schedule next job and extend lock</span>
        await redisClient.expire(lockKey, LOCK_TTL);
        await queue.add({ key });
    }
}

<span class="hljs-comment">/**
* Ensure all queue running
*/</span>
async <span class="hljs-function"><span class="hljs-keyword">function</span> <span class="hljs-title">ensureAllQueueRunning</span><span class="hljs-params">()</span> </span>{
    <span class="hljs-keyword">const</span> keys = await redisClient.smembers(ALL_LOCKS_KEY);
    <span class="hljs-keyword">let</span> locks = [];
    <span class="hljs-keyword">if</span> (<span class="hljs-built_in">Array</span>.isArray(keys) &amp;&amp; keys.length &gt; <span class="hljs-number">0</span>) {
        locks = await redisClient.mget(
            keys.map(key =&gt; getQueueLockKey(key))
        );
    }
    <span class="hljs-keyword">const</span> missingLockTasks = [];
    locks.forEach((lock, index) =&gt; {
        <span class="hljs-keyword">if</span> (lock !== <span class="hljs-string">\'1\'</span>) {
            missingLockTasks.push(
                (async () =&gt; {
                    <span class="hljs-keyword">try</span> {
                        <span class="hljs-keyword">const</span> lockKey = getQueueLockKey(keys[index]);
                        <span class="hljs-keyword">const</span> jobStatus = await redisClient.setnx(
                            lockKey,
                            <span class="hljs-string">\'1\'</span>
                        );
                        <span class="hljs-keyword">if</span> (jobStatus === <span class="hljs-number">1</span>) {
                            <span class="hljs-comment">// Can schedule job for this key</span>
                            await redisClient.expire(lockKey, LOCK_TTL);
                            await queueService
                                .getQueue(keys[index])
                                .add({ key: keys[index] });
                        }
                    } <span class="hljs-keyword">catch</span> (error) {
                        logger.error(<span class="hljs-string">\'Reschedule failed: \'</span>, error);
                    }
                })()
            );
        }
    });
    <span class="hljs-keyword">return</span> Promise.all(missingLockTasks);
}
</code></pre>
<span id="toc-final-thoughts"></span><h2 class="ui dividing header">Final thoughts</h2>
<p>Tất nhiên, đây chỉ là 1 prototype để các bạn áp dụng vào các hệ thống của mình nếu có yêu cầu quản trị job song song. Còn rất nhiều thứ các bạn có thể cải tiến về độ tin cậy khi pop data, retry khi xử lý lỗi, retry khi worker crash,... tuy nhiên những thứ đó lại nằm ngoài scope của bài viết này.</p>
<p>Những thứ mà cách tiếp cận của mình này đã giải quyết được:</p>
<ul class="ui list">
<li>Tránh được việc listen dynamic queue của lib. Việc khai báo listen và xử lý queue chỉ nên thực hiện 1 lần khi start worker.</li>
<li>Cho phép job <strong>tạo comment X cho post A</strong> và <strong>tạo comment X cho post B</strong> chạy song song</li>
<li>Đảm bảo job <strong>tạo comment X cho post A</strong> và <strong>tạo comment Y cho post A</strong> chạy tuần tự</li>
<li>Không cần care số lượng worker hay queue, scale hạ tầng hay worker thoải mái</li>
</ul>
<p>Trên đây là những kinh nghiệm của mình khi xử lý vấn đề <strong>concurrency và job ordering</strong> trong những hệ thống sử dụng task queue đơn giản như redis. Hiện tại hệ thống task queue do mình thiết kế sử dụng <a href="https://github.com/OptimalBits/bull">Bull JS</a> đã triển khai sử dụng giải pháp task gối đầu của mình cho 1 số loại job và vận hành tốt với lượng job concurrency khá lớn. Hy vọng các bạn có thể đóng góp thêm nếu có bất cứ ý kiến cải thiện nào. </p>
<p>Cảm ơn các bạn vì đã quan tâm 1 bài viết dài vãi lúa thế này. </p>
</section>'),

-- Tôi đã clone diễn đàn Voz như thế nào. --
(3, 
N'Tôi đã clone diễn đàn Voz như thế nào.', 
'toi-da-clone-dien-dan-voz-nhu-the-nao', 
N'Chỉ là phục vụ cá nhân mình : dễ dùng, thận thiện với mobile, thu lượm thông tin trong một cái vuốt', 
'2020/03/09 00:00:00', 
2, 
null, 
null, 
'voz.jpg',
N'<section id="content" class="ui pilled segment md" ng-non-bindable="">
<span id="toc--t-ng"></span><h1 class="ui dividing header">Ý tưởng</h1>
<p>Diễn đàn <strong>voz</strong> không còn qúa xa lạ với nhiều dev. Giao diện cổ của nó khi dùng mobile thì ức chế lòi dom. Đợt làm lại next voz tưởng ngon hơn, ai ngờ vứt cái phân trang đi, nhiều hôm vào đọc topic đang theo dõi mà kéo mỏi cả tay. </p>
<p>Cộng với thói quen đọc tít để hiểu vấn đề của các vozer thông minh :)), lại muốn sắp xếp lại đống dữ liệu cho nó dễ nhìn hơn. Nhìn phát là biết hôm nay có gì hot.</p>
<p>Chung quy lại thì chỉ là phục vụ cá nhân mình : <strong>dễ dùng, thận thiện với mobile, thu lượm thông tin trong một cái vuốt.</strong></p>
<p><a href="https://voz.now.sh/">https://voz.now.sh/</a></p>
<p><a class="fluidbox fluidbox__instance-1 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/yb6ykwy90h_screencapture-voz-now-sh-f17-2020-03-01-11_09_49.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/yb6ykwy90h_screencapture-voz-now-sh-f17-2020-03-01-11_09_49.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 1110px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p><a class="fluidbox fluidbox__instance-2 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/f03r7hu25w_Screenshot%20from%202020-03-01%2011-21-33.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/f03r7hu25w_Screenshot%20from%202020-03-01%2011-21-33.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 349px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<span id="toc-gi-i-quy-t"></span><h1 class="ui dividing header">Giải quyết</h1>
<span id="toc-c-ng-ngh-"></span><h3 class="ui dividing header">Công nghệ</h3>
<p>Vì chỉ là cái trang dành cho mình, không cần tiền để duy trì hosting. Cũng chả có nhu cần đặt quảng cáo mà cướp mất vị trí của trang chính trên Google. </p>
<p>Do đó mình chọn  <strong>now.sh</strong> để tầm gửi, không sử dụng nuxtJS (framework hỗ trợ SEO), mà chỉ dùng VueJS và nền tảng backend của Now.sh làm server side.</p>
<p>Chọn một project mặc định mà now.sh gợi ý (<a href="https://zeit.co/import/templates">https://zeit.co/import/templates</a>)</p>
<p><a class="fluidbox fluidbox__instance-3 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/2jz49wst9w_Screenshot%20from%202020-03-01%2010-47-58.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/2jz49wst9w_Screenshot%20from%202020-03-01%2010-47-58.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 127px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p>Thêm mắm muối cho cháu nó sinh động hơn.</p>
<p><a class="fluidbox fluidbox__instance-4 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/gfnyag0f0u_Screenshot%20from%202020-03-01%2010-49-17.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/gfnyag0f0u_Screenshot%20from%202020-03-01%2010-49-17.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 307px; height: 666px; top: 0px; left: 178.703px;"></div></div></a><a></a></p>
<span id="toc-backend"></span><h3 class="ui dividing header">BackEnd</h3>
<p>Ở đây sẽ là forder <code>[api]</code>, mình sẽ sử dụng <strong>axios</strong> để get dữ liệu, sau đó dùng <strong>cheerio</strong> để bóc tách dữ liệu trong đó.</p>
<p>Để tối giản việc viết code, mình đưa các config selector cho cheerio bóc tách vào <code>selector.js</code> như sau:</p>
<p>Config các thẻ selector (cái này có thể đẩy lên database)<br>
<a class="fluidbox fluidbox__instance-5 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/envkwmp8ae_Screenshot%20from%202020-03-01%2010-56-45.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/envkwmp8ae_Screenshot%20from%202020-03-01%2010-56-45.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 563px; height: 475px; top: 0px; left: 50.7031px;"></div></div></a><a></a></p>
<p>Load các thẻ selector lên và bóc tác trong source.<br>
<a class="fluidbox fluidbox__instance-6 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/po13z0e0wv_Screenshot%20from%202020-03-01%2010-56-01.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/po13z0e0wv_Screenshot%20from%202020-03-01%2010-56-01.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 380px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p>Do admin voz config server của họ, cứ quá nhiều request trên 1 ip đến server voz. Nó sẽ response chậm lại. Gây nên tình trạng load dữ liệu trên các trang siêu nhậm, hoặc là đứng yên khi nhiều người cùng truy cập. Mình đã tiến hành sử dụng app script của google để transfer thêm dữ liệu của họ về bóc tách.</p>
<p><a class="fluidbox fluidbox__instance-7 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/c34fx4a7jc_Screenshot%20from%202020-03-09%2008-43-49.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/c34fx4a7jc_Screenshot%20from%202020-03-09%2008-43-49.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 147px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<pre><code class="ui segment hljs ruby"><span class="hljs-variable">@DangXuanThanh</span> <span class="hljs-symbol">:</span> đoạn này chắc mình sẽ edit lại. 
</code></pre>
<p>Hiện tại mình đang chỉ dùng 1 ip của now.sh cung cấp cho đọc source voz.vn. Sẽ bị block request khi đông người truy cập vào trang của mình. Nên mình sẽ dùng bot của Google thông qua Google App script (URLFetchAPI) cào dữ liệu. Gia tặng dải IP request lên voz.vn, tránh bị block.</p>
<p><a href="https://developers.google.com/apps-script/guides/web">https://developers.google.com/apps-script/guides/web</a></p>
<p><a class="fluidbox fluidbox__instance-8 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/5k6f9byd9b_Screenshot%20from%202020-03-01%2011-02-25.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/5k6f9byd9b_Screenshot%20from%202020-03-01%2011-02-25.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 551px; height: 218px; top: 0px; left: 56.7031px;"></div></div></a><a></a></p>
<span id="toc-frontend"></span><h3 class="ui dividing header">FrontEnd</h3>
<p>Vì mình đoán mọi người chỉ quan tâm nhiều đên việc BE cào dữ liệu ra sao. Nên mình không nói về code phần này nữa. </p>
<p><a class="fluidbox fluidbox__instance-9 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/egzhevbi7k_screencapture-voz-now-sh-f17-2020-03-03-11_37_03.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/egzhevbi7k_screencapture-voz-now-sh-f17-2020-03-03-11_37_03.png" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 641px; height: 3134px; top: 0px; left: 11.7031px;"></div></div></a><a></a></p>
<span id="toc-k-t"></span><h1 class="ui dividing header">Kết</h1>
<p>Bài viết trên chỉ nói sơ qua về bài toán giải quyết nhu cầu cá nhân, có lẽ sẽ chả áp dụng được trong công việc có nhu cầu thực tế cao hơn. Mong các anh chị em đi qua dúi cho cái phê bình để mình tiến bộ.</p>
</section>'),

-- Làm thế nào để thay đổi cuộc đời bạn? --
(4, 
N'Làm thế nào để thay đổi cuộc đời bạn?', 
'lam-the-nao-de-thay-doi-cuoc-doi-ban', 
N'"Bạn sẽ không bao giờ thay đổi cuộc đời mình cho đến khi bạn thay đổi điều gì đó mà bạn đang làm hằng ngày" - Mike Murdock', 
'2017/10/24 00:00:00', 
7, 
null, 
null, 
'How-To-Change-Your-Life.jpg',
N'<section id="content" class="ui pilled segment md" ng-non-bindable="">
<p><a class="fluidbox fluidbox__instance-1 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/p9ia8wdsjg_How-To-Change-Your-Life.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/p9ia8wdsjg_How-To-Change-Your-Life.png" alt="change-your-life" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 600px; height: 329px; top: 0px; left: 32.2031px;"></div></div></a><a></a></p>
<blockquote>
<p>"Bạn sẽ không bao giờ thay đổi cuộc đời mình cho đến khi bạn thay đổi điều gì đó mà bạn đang làm hằng ngày" - Mike Murdock.</p>
</blockquote>
<p>Bắt đầu với một câu tuyên bố đơn giản: <strong>Bạn muốn trở thành gì?</strong></p>
<p>Bạn có hi vọng một ngày nào đó trở thành một nhà văn, nhạc sĩ, nhà thiết kế, lập trình viên, phiên dịch viên, một họa sĩ Manga, một doanh nhân hay một chuyên gia về lĩnh vực nào đó?</p>
<p>Làm thế nào để đạt được điều đó? Bạn sẽ viết ý định của bạn vào một mảnh giấy, đặt nó trong một cái chai và thả nó ra biển với hi vọng nó sẽ trở thành sự thật? Không. Vũ trụ sẽ không khiến nó xảy ra, mà chính là bạn.</p>
<p>Bạn có từng đặt cho mình một mục tiêu lớn để hoàn thành vào cuối năm hoặc trong ba tháng? Chắc chắn rồi, nhưng điều đó không khiến bạn hoàn thành. Thực tế, nếu bạn nghĩ lại về hầu hết các ví dụ trong cuộc sống của bạn sẽ thấy việc đặt ra các mục tiêu lớn dài hạn có lẽ không hiệu quả. Bao nhiêu lần chiến lược này đã thành công?</p>
<p>Tôi sẽ đặt ra luật ở đây, dựa trên nhiều trải nghiệm tôi đã thực hiện trong suốt 7 năm qua: không có điều gì thay đổi trừ khi bạn thực hiện thay đổi hằng ngày.</p>
<p>Tôi đã thử các bước hành động hàng tuần, những điều tôi làm hàng ngày, những mục tiêu lớn hàng tháng, nhiều sự thay đổi khác. Không cái nào có tác dụng trừ việc thay đổi hàng ngày.</p>
<p>Nếu bạn không muốn biến nó thành sự thay đổi hàng ngày thì bạn không thực sự muốn thay đổi cuộc sống theo cách này. Bạn <strong>chỉ thích</strong> ý tưởng học vẽ/nói tiếng Nhật/chơi đàn ghi-ta, lập trình bằng PHP/... Bạn <strong>không thực sự muốn làm điều đó</strong>.</p>
<p>Vì vậy hãy thay đổi hàng ngày. Cùng xem nó hoàn thành như nào!</p>
<span id="toc-l-m-sao-bi-n-m-t-nguy-n-v-ng-th-nh-m-t-thay-i-h-ng-ng-y"></span><h3 class="ui dividing header">Làm sao để biến một nguyện vọng thành một thay đổi hàng ngày</h3>
<p>Hãy điểm tên một vài nguyện vọng:</p>
<ul class="ui list">
<li>Giảm cân</li>
<li>Viết một quyến sách</li>
<li>Ngừng trì hoãn</li>
<li>Yêu một ai đó</li>
<li>Trở nên hạnh phúc</li>
<li>Du lịch khắp thế giới</li>
<li>Uống nhiều nước hơn</li>
<li>Học tiếng Anh</li>
<li>Tiết kiệm tiền</li>
<li>Chụp nhiều ảnh hơn</li>
<li>Đọc nhiều sách hơn</li>
</ul>
<p>Làm thế nào để bạn biến những ý tưởng cao cả này thành những thay đổi hàng ngày? Suy nghĩ về những điều bạn có thể làm mỗi ngày mà có thể làm thay đổi xảy ra hoặc ít nhất đưa bạn tới gần mục tiêu hơn. Điều đó không phải lúc nào cũng dễ dàng nhưng hãy nhìn vào một vài ý tưởng:</p>
<ul class="ui list">
<li>
<strong>Giảm cân</strong> - bắt đầu đi bộ mỗi ngày trong 10 phút, rồi lên 15 phút sau một tuần, rồi 20 phút,... cho đến khi bạn đi bộ 30-40 phút một ngày thì thực hiện một thay đổi khác - uống nước lọc thay vì soda.</li>
<li>
<strong>Viết một cuốn sách</strong> - viết 10 phút mỗi ngày.</li>
<li>
<strong>Ngưng trì hoãn</strong> - Tôi có thể đã nghe những lời mỉa mai (và theo nghĩ đen) đùa về cách mọi người đối phó với sự trì hoãn. Dù sao, hãy làm một hành động hàng ngày: đặt ra một Nhiệm Vụ Quan Trọng Nhất vào mỗi buổi sáng, và thực hiện điều đó mỗi 10 phút trước khi mở trình duyệt/thiết bị di động của bạn.</li>
<li>
<strong>Yêu</strong> - đi đâu đó mỗi ngày và gặp gỡ/giao tiếp xã hội với những người mới. Hoặc làm điều gì đó hàng ngày mà khiến bạn trở thành một người hấp dẫn.</li>
<li>
<strong>Trở nên hạnh phúc</strong> - làm điều gì đó mỗi ngày để làm cho thế giới tốt hơn, để giúp mọi người.</li>
<li>
<strong>Du lịch khắp thế giới</strong> - tiết kiệm tiền (xem mục tiếp theo). Hoặc bắt đầu bán đồ của bạn, để bạn có thể gói ghém đồ đạc của mình vào một chiếc ba lô và bắt đầu chuyến du lịch.</li>
<li>
<strong>Tiết kiệm tiền</strong> - bắt đầu cắt giảm các khoản chi phí. Bắt đầu nấu nướng và ăn ở nhà. Bán xe và đi xe đạp/đi bộ/xe bus. Bắt đầu tìm kiếm một ngôi nhà nhỏ hơn. Dùng công cụ miễn phí thay vì mua mọi thứ.</li>
<li>
<strong>Uống nhiều nước hơn</strong> - uống nước mỗi khi bạn thức dậy, sau đó là mỗi lần bạn nghỉ ngơi (mỗi giờ một lần).</li>
<li>
<strong>Học tiếng Anh</strong> - học tiếng Anh ở Duolingo và xem một video trên TED mỗi ngày.</li>
<li>
<strong>Đọc nhiều sách hơn</strong> - đọc mỗi buổi sáng và trước khi bạn đi ngủ.</li>
</ul>
<p>Bạn có ý tưởng. Nhưng không phải tất cả đều là những ý tưởng hoàn hảo, nhưng bạn có thể đưa ra một ý tưởng nào đó tốt hơn cho bạn. Quan trọng là, <strong>làm điều đó hàng ngày</strong>.</p>
<span id="toc-c-ch-th-c-hi-n-thay-i-h-ng-ng-y"></span><h3 class="ui dividing header">Cách thực hiện thay đổi hàng ngày</h3>
<p>Phương pháp này khá là đơn giản và nếu bạn thực sự thực hiện nó, kết quả gần như không thể tin được:</p>
<ol>
<li>
<strong>Một thay đổi tại một thời điểm</strong>. Bạn có thể phá vỡ quy tắc này, nhưng đừng ngạc nhiên nếu bạn thất bại. Thực hiện một thay đổi trong một tháng trước khi cân nhắc một giây. Chỉ thêm một thay đổi khác nếu bạn đã thành công ở thay đổi đầu tiên.</li>
<li>
<strong>Bắt đầu nhỏ</strong>. OK, tôi đã nói điều này hai lần rồi. Tuy nhiên, không ai làm điều đó. Bắt đầu với 10 phút hoặc ít hơn. Năm phút tốt hơn nếu đó là một thay đổi khó khăn. Nếu bạn vẫn thất bại, giảm xuống còn 2 phút.</li>
<li>
<strong>Thực hiện cùng thời điểm mỗi ngày</strong>. OK, không đúng nghĩa đen trong cùng phút, như vào lúc 6:00 sáng, nhưng sau cùng một cú kích hoạt trong thói quen hàng ngày của bạn - như sau khi uống ly cà phê đầu tiên vào buổi sáng, sau khi bạn đi làm, sau khi bạn về nhà, sau khi bạn đánh răng, tắm, ăn sáng, thức dậy, ăn trưa, bật máy tính hoặc lần đầu tiên gặp vợ mỗi ngày.</li>
<li>
<strong>Thực hiện một cam kết rất lớn với ai đó hoặc với nhiều người</strong>. Hãy đảm bảo rằng đó là người có ý kiến bạn tôn trọng. Ví dụ, tôi đã thực hiện một cam kết học/lập trình PHP ít nhất 10 phút mỗi ngày với bạn của tôi - Tynan. Tôi đã cam kết với vợ, bạn bè, độc giả của blog này, với con tôi và nhiều hơn nữa.</li>
<li>
<strong>Hãy chịu trách nhiệm</strong>. Lấy ví dụ về việc lập trình của tôi với Tynan... mỗi ngày tôi phải cập nhật một bảng tính Google cho biết mình đã lập trình/học được bao nhiêu phút mỗi ngày, và anh ấy có thể kiểm tra bảng tính đã được chia sẻ này. Công cụ bạn sử dụng không quan trọng - bạn có thể đăng lên Facebook hoặc Twitter, gửi email cho ai đó, đánh dấu nó trên lịch, báo cáo trực tiếp. Chỉ cần đảm bảo bạn chịu trách nhiệm mỗi ngày, không phải mỗi tháng. Và đảm bảo rằng người đó đang kiểm tra. Nếu họ không kiểm tra bạn, bạn cần tìm một đối tác hoặc nhóm mới.</li>
<li>
<strong>Có những kết quả</strong>. Kết quả quan trọng nhất của việc làm hay không làm thói quen hàng ngày là nếu bạn không làm vậy thì mọi người sẽ tôn trọng bạn ít hơn, và ngược lại. Nếu hệ thống nhiệm vụ của bạn không được thiết lập theo cách này, hãy tìm một cách khác để thực hiện. Bạn có thể cần thay đổi người mà bạn báo cáo nhiệm vụ. Nhưng bạn có thể thêm các kết quả thú vị khác: tôi đã hứa sẽ hát một bài hát tiếng Nhật trước những người lạ mặt nếu tôi thất bại. Kết quả cũng có thể tích cực - ví dụ như một phần thưởng lớn mỗi tuần nếu bạn không bỏ lỡ một ngày nào. Làm kết quả lớn hơn nếu bạn bỏ lỡ hai ngày liên tiếp và rất lớn nếu bạn bỏ lỡ ba ngày.</li>
<li>
<strong>Tận hưởng thay đổi</strong>. Nếu bạn không như vậy, bạn cũng có thể tìm một thay đổi khác để thực hiện. Nếu hành động hàng ngày cảm thấy buồn tẻ và nhàm chán thì bạn đang làm sai. Tìm một cách khác để tận hưởng nó hoặc bạn sẽ không thể theo đuổi lâu dài. Hoặc tìm một vài thay đổi khác mà bạn thích hơn.</li>
</ol>
<p>Vậy thôi. Bảy bước khá đơn giản và bạn đã có một cuộc sống thay đổi. Không điều nào trong số này là không thể - thực tế, bạn có thể đưa chúng vào hành động ngay hôm nay.</p>
<p>Thay đổi hàng ngày nào mà bạn sẽ làm hôm nay?</p>
<p>Dịch bởi <a href="https://junookyo.blogspot.com/2017/10/thay-doi-cuoc-doi-ban.html?utm_source=kipalog">Juno_okyo</a> từ bài viết: <a href="https://zenhabits.net/change/">How to Change Your Life: A User’s Guide</a></p>
<hr>
<p><img class="emoji" title=":point_right:" alt=":point_right:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f449.png" height="20" width="20" align="absmiddle"> Theo dõi Juno_okyo trên <a href="http://kipalog.com/users/juno_okyo/mypage">Kipalog</a> để nhận được thông báo khi có bài viết mới! <img class="emoji" title=":wink:" alt=":wink:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f609.png" height="20" width="20" align="absmiddle"></p>
<p><img class="emoji" title=":point_right:" alt=":point_right:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f449.png" height="20" width="20" align="absmiddle"> Social Networks: <a href="https://fb.com/907376185983675">Facebook</a> · <a href="https://twitter.com/juno_okyo">Twitter</a> · <a href="https://plus.google.com/108443613096446306111">Google+</a> · <a href="https://github.com/J2TeaM">GitHub</a></p>
</section>'),

-- 21 trang web hay mà bạn có thể ghé thăm mỗi khi rảnh rỗi --
(5, 
N'21 trang web hay mà bạn có thể ghé thăm mỗi khi rảnh rỗi', 
'21-trang-web-hay-ma-ban-co-the-ghe-tham-moi-khi-ranh-roi', 
N'Bạn thấy chán các trang web cũ? Muốn tìm một vài góc mới của Internet để giúp bạn tìm lại sự hứng thú? Tốt thôi, bạn đã gặp may đấy. Dù bạn đang tìm những trò chơi ngớ ngẩn hay điều gì đó hữu ích thì dưới đây là 21 trang web hay mà bạn nên ghé qua.', 
'2017/01/19 00:00:00', 
7, 
null, 
null, 
'21trangwebhay.jpg',
N'<section id="content" class="ui pilled segment md" ng-non-bindable="">
<p>Bạn thấy chán các trang web cũ? Muốn tìm một vài góc mới của Internet để giúp bạn tìm lại sự hứng thú? Tốt thôi, bạn đã gặp may đấy. Dù bạn đang tìm những trò chơi ngớ ngẩn hay điều gì đó hữu ích thì dưới đây là 21 trang web hay mà bạn nên ghé qua.</p>
<span id="toc-1-ted-"></span><h3 class="ui dividing header">1. <a href="http://www.ted.com/talks">TED</a>
</h3>
<p>Với hơn 1900 bài talk thú vị và đầy cảm hứng, chắc chắn bạn sẽ tìm được điều gì đó mà bạn thích.</p>
<span id="toc-2-difference-between-"></span><h3 class="ui dividing header">2. <a href="http://www.differencebetween.net/">Difference Between</a>
</h3>
<p>Bạn muốn tìm hiểu sự khác biệt giữa bất cứ điều gì? Ví dụ giữa <a href="http://www.differencebetween.net/technology/internet/difference-between-api-and-web-service/">API và Web Service</a>.</p>
<span id="toc-3-the-geocities-izer-"></span><h3 class="ui dividing header">3. <a href="http://www.wonder-tonic.com/geocitiesizer/index.php">The Geocities-izer</a>
</h3>
<p>Biến bất cứ trang web nào thành một trang với giao diện xấu xí như những năm 90.</p>
<p><a class="fluidbox fluidbox__instance-1 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://1.bp.blogspot.com/-mn9EnLVpkdE/WIAlBlbtYZI/AAAAAAAADb4/7gSodZOdM1AokMsDJYrZz8LXW8XjsXk4wCEw/s1600/trang-web-hay-Geocities-izer.jpg"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://1.bp.blogspot.com/-mn9EnLVpkdE/WIAlBlbtYZI/AAAAAAAADb4/7gSodZOdM1AokMsDJYrZz8LXW8XjsXk4wCEw/s1600/trang-web-hay-Geocities-izer.jpg" alt="Geocities-izer" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 412px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<span id="toc-4-wikipedia-random-"></span><h3 class="ui dividing header">4. <a href="https://en.wikipedia.org/wiki/Special:Random">Wikipedia Random</a>
</h3>
<p><em>Rơi vào hố thỏ</em> và khám phá những chủ đề ngẫu nhiên trên Wikipedia.</p>
<span id="toc-5-whizzpast-"></span><h3 class="ui dividing header">5. <a href="http://www.whizzpast.com/">Whizzpast</a>
</h3>
<p>Nơi tuyệt vời nhất trên Internet để tìm hiểu về những điều tuyệt vời trong lịch sử.</p>
<span id="toc-6-find-the-invisible-cow-"></span><h3 class="ui dividing header">6. <a href="http://www.findtheinvisiblecow.com/">Find the Invisible Cow</a>
</h3>
<p>Hãy chắc chắn rằng bạn đã mở loa (nhưng đừng quá to <img class="emoji" title=":trollface:" alt=":trollface:" src="https://github.githubassets.com/images/icons/emoji/trollface.png" height="20" width="20" align="absmiddle">).</p>
<span id="toc-7-sporcle-"></span><h3 class="ui dividing header">7. <a href="http://www.sporcle.com/">Sporcle</a>
</h3>
<p>Giải hàng ngàn câu đố hoặc tự bạn tạo ra.</p>
<span id="toc-8-zooniverse-"></span><h3 class="ui dividing header">8. <a href="https://www.zooniverse.org/">Zooniverse</a>
</h3>
<p>Trở thành một phần của những dự án khoa học thực sự (ví dụ như khám phá bề mặt của mặt trăng) bằng cách tham gia nghiên cứu online.</p>
<span id="toc-9-lang-8-"></span><h3 class="ui dividing header">9. <a href="http://lang-8.com/">Lang-8</a>
</h3>
<p>Viết trong một ngôn ngữ mà bạn đang học và người bản xứ sẽ sửa các lỗi của bạn.</p>
<span id="toc-10-silk-"></span><h3 class="ui dividing header">10. <a href="http://weavesilk.com/">Silk</a>
</h3>
<p>Tạo ra các tác phẩm nghệ thuật với con chuột của bạn.</p>
<p><a class="fluidbox fluidbox__instance-2 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://4.bp.blogspot.com/-hUtNEsHgc9Q/WIAlB5jzZ-I/AAAAAAAADb8/icB7xaN_iJ4GOuPqZilkSgtZRUPqhqL8QCLcB/s1600/trang-web-hay-Silk.jpg"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://4.bp.blogspot.com/-hUtNEsHgc9Q/WIAlB5jzZ-I/AAAAAAAADb8/icB7xaN_iJ4GOuPqZilkSgtZRUPqhqL8QCLcB/s1600/trang-web-hay-Silk.jpg" alt="Silk" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 331px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<span id="toc-11-letters-of-note-"></span><h3 class="ui dividing header">11. <a href="http://www.lettersofnote.com/">Letters of Note</a>
</h3>
<p>Một bộ sưu tập tuyệt vời của các chữ cái hấp dẫn, bưu thiếp, điện tín và các ghi chú trong quá khứ.</p>
<span id="toc-12-khan-academy-"></span><h3 class="ui dividing header">12. <a href="https://www.khanacademy.org/">Khan Academy</a>
</h3>
<p>Nếu bạn đang muốn học hỏi thêm điều gì đó thì Khan Academy có hàng trăm khóa học giáo dục miễn phí dành cho bạn.</p>
<span id="toc-13-geoguessr-"></span><h3 class="ui dividing header">13. <a href="https://geoguessr.com/">GeoGuessr</a>
</h3>
<p>Đoán xem hình chụp bởi Google Streetview là ở nơi nào trên thế giới.</p>
<p><a class="fluidbox fluidbox__instance-3 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://2.bp.blogspot.com/-yd6gIzi90KQ/WIAlBbzAsGI/AAAAAAAADb0/aKQSISIsZQoAFNRMC6_AHtIK5BghblREQCEw/s1600/trang-web-hay-GeoGuessr.jpg"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://2.bp.blogspot.com/-yd6gIzi90KQ/WIAlBbzAsGI/AAAAAAAADb0/aKQSISIsZQoAFNRMC6_AHtIK5BghblREQCEw/s1600/trang-web-hay-GeoGuessr.jpg" alt="GeoGuessr" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 321px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<span id="toc-14-feel-good-wardrobe-"></span><h3 class="ui dividing header">14. <a href="http://feelgoodwardrobe.com/">Feel Good Wardrobe</a>
</h3>
<p>Trang cung cấp mẹo để mua quần áo.</p>
<span id="toc-15-i-need-a-prompt-"></span><h3 class="ui dividing header">15. <a href="http://www.ineedaprompt.com/">I Need a Prompt</a>
</h3>
<p>Giống trang You Should Write, nhưng dành cho các nghệ sĩ.</p>
<span id="toc-16-omegle-"></span><h3 class="ui dividing header">16. <a href="http://www.omegle.com/">Omegle</a>
</h3>
<p>Cảm thấy muốn nói chuyện với ai đó? Omegle giúp bạn nói chuyện (qua tin nhắn hoặc video) với một người lạ.</p>
<span id="toc-17-my-script-font-"></span><h3 class="ui dividing header">17. <a href="http://www.myscriptfont.com/">My Script Font</a>
</h3>
<p>Tạo ra một font dựa trên chữ viết tay của chính bạn.</p>
<span id="toc-18-live-plasma-"></span><h3 class="ui dividing header">18. <a href="http://www.liveplasma.com/">Live Plasma</a>
</h3>
<p>Live Plasma là một cỗ máy khám phá âm nhạc. Chỉ cần gõ vào một nghệ sĩ mà bạn thích và nó sẽ hiển thị những nghệ sĩ tương tự.</p>
<span id="toc-19-hippo-paint-"></span><h3 class="ui dividing header">19. <a href="http://hippopaint.fidsah.org/">Hippo Paint</a>
</h3>
<p>Một cuốn sách tô màu hoàn hảo cho cả trẻ em và người lớn - chỉ cần gõ vào thứ gì đó mà bạn thích vẽ và nó sẽ cung cấp cho bạn những hình ảnh.</p>
<p><a class="fluidbox fluidbox__instance-4 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://4.bp.blogspot.com/-ITUqw_y4QB8/WIAlBQKKbhI/AAAAAAAADbw/jNJpr_KrsE8Vj-NZ-53dDhmWXoKVD7FSQCEw/s1600/trang-web-hay-Hippo-Paint.jpg"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://4.bp.blogspot.com/-ITUqw_y4QB8/WIAlBQKKbhI/AAAAAAAADbw/jNJpr_KrsE8Vj-NZ-53dDhmWXoKVD7FSQCEw/s1600/trang-web-hay-Hippo-Paint.jpg" alt="Hippo-Paint" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 399px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<span id="toc-20-akinator-"></span><h3 class="ui dividing header">20. <a href="http://en.akinator.com/#">Akinator</a>
</h3>
<p>Một phù thủy thực sự.</p>
<span id="toc-21-kongregate-"></span><h3 class="ui dividing header">21. <a href="http://www.kongregate.com/">Kongregate</a>
</h3>
<p>Hàng ngàn trò chơi trực tuyến miễn phí, từ những tên tuổi lớn cho đến tư nhân.</p>
<p>© <a href="https://junookyo.blogspot.com/2017/01/21-trang-web-hay-nen-ghe-tham.html?utm_source=kipalog">Juno_okyo</a> theo <a href="http://inktank.fi/most-entertaining-websites/">inktank.fi</a></p>
<hr>
<p><img class="emoji" title=":point_right:" alt=":point_right:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f449.png" height="20" width="20" align="absmiddle"> Theo dõi Juno_okyo trên <a href="http://kipalog.com/users/juno_okyo/mypage">Kipalog</a> để nhận được thông báo khi có bài viết mới! <img class="emoji" title=":wink:" alt=":wink:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f609.png" height="20" width="20" align="absmiddle"></p>
<p><img class="emoji" title=":point_right:" alt=":point_right:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f449.png" height="20" width="20" align="absmiddle"> Social Networks: <a href="https://fb.com/907376185983675">Facebook</a> · <a href="https://twitter.com/juno_okyo">Twitter</a> · <a href="https://plus.google.com/108443613096446306111">Google+</a> · <a href="https://github.com/J2TeaM">GitHub</a></p>
</section>'),

-- Lỗ hổng bảo mật Cross-Site-Scripting (XSS) có gì nguy hiểm? --
(6, 
N'Lỗ hổng bảo mật Cross-Site-Scripting (XSS) có gì nguy hiểm?', 
'lo-hong-bao-mat-xss-co-gi-nguy-hiem', 
N'Thay vì viết ra đống lý thuyết nhàm chán, chúng ta sẽ cùng xem xét những hình thức tấn công khai thác XSS đã được áp dụng trong thực tiễn. Nói trước để những bạn nào còn chưa biết về XSS thì nên Google xem nó là gì trước khi đọc tiếp bài viết này nha.', 
'2016/08/30 09:00:00', 
7, 
null, 
null, 
'xss.jpg',
N'<section id="content" class="ui pilled segment md" ng-non-bindable="">
<p>Mỗi khi đăng những bài <a href="https://junookyo.blogspot.com/search/label/Write-up">writeup</a> về một <a href="https://junookyo.blogspot.com/search/label/XSS">lỗ hổng XSS</a> được phát hiện trên một trang web nào đó, tôi biết sẽ có những người nhếch mép cười khẩy vì lúc đó trong đầu họ sẽ nghĩ:</p>
<ul class="ui list">
<li>"Cái lỗi XSS này thì có cái quái gì nguy hiểm cơ chứ?"</li>
<li>"Ngoài việc hiện lên một hộp thoại thì XSS làm được cái đếch gì nữa không?"</li>
<li>"Một lỗ hổng vớ vẩn thôi mà. Ơ mà hiện hộp thoại cũng được gọi là lỗ hổng hả?"</li>
<li>...</li>
</ul>
<p>Vậy thì, <strong>XSS có gì nguy hiểm?</strong> <img class="emoji" title=":sweat_smile:" alt=":sweat_smile:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f605.png" height="20" width="20" align="absmiddle"></p>
<p><a class="fluidbox fluidbox__instance-1 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/xss-cross-site-scripting-tutorial.png_mietrx071d"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/xss-cross-site-scripting-tutorial.png_mietrx071d" alt="xss" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 600px; height: 315px; top: 0px; left: 32.2031px;"></div></div></a><a></a></p>
<p>Thay vì viết ra đống lý thuyết nhàm chán, chúng ta sẽ cùng xem xét <strong>những hình thức tấn công khai thác XSS đã được áp dụng trong thực tiễn</strong>. Nói trước để những bạn nào còn chưa biết về XSS thì nên Google xem nó là gì trước khi đọc tiếp bài viết này nha.</p>
<span id="toc-xss-worm"></span><h3 class="ui dividing header">XSS worm</h3>
<p><a href="https://en.wikipedia.org/wiki/XSS_worm">XSS worm</a> là một dạng sâu/mã độc trên nền web và hiển nhiên là viết bằng JavaScript với mục tiêu lây nhiễm tới toàn bộ người dùng truy cập vào trang web. Ví dụ điển hình thường gặp nhất là trên mạng xã hội Facebook.</p>
<p>Với số lượng người dùng quá lớn của mình, XSS worm có tốc độ phát tán chóng mặt trên Facebook mà chúng ta thường thấy theo hình thức: A bị nhiễm &gt; gửi tin nhắn chứa mã độc cho B, C, D,... (nằm trong danh sách bạn bè của A). B, C, D và những người bạn đó cũng tiếp tục gửi tin nhắn cho toàn bộ bạn bè của chính họ. Và thế là con worm được lây lan theo cấp số nhân không thể kiểm soát.</p>
<p>* Để có thể gửi được tin nhắn, XSS worm sẽ kết hợp với <a href="https://junookyo.blogspot.com/search/label/CSRF">CSRF</a>.</p>
<p><a class="fluidbox fluidbox__instance-2 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://2.bp.blogspot.com/-O4TQBgM_mo0/V8VUsWzWZLI/AAAAAAAADGg/pHewjtkAbFo9chWoVBZBdMZGOnSP8IgmQCLcB/s1600/xss-worm.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://2.bp.blogspot.com/-O4TQBgM_mo0/V8VUsWzWZLI/AAAAAAAADGg/pHewjtkAbFo9chWoVBZBdMZGOnSP8IgmQCLcB/s1600/xss-worm.png" alt="xss" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 285px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p>Thông tin thêm: Trên Facebook còn một hình thức phổ biến khác được gọi là <a href="https://www.facebook.com/help/246962205475854">Self-XSS</a> (loại này kết hợp với kỹ năng <a href="https://en.wikipedia.org/wiki/Social_engineering_(security)">Social engineering</a>). Facebook luôn cảnh báo mỗi khi bạn nhấn F12 (mở Console) chính là để bảo vệ bạn khỏi biến thể XSS này.</p>
<span id="toc-browser-based-botnet"></span><h3 class="ui dividing header">Browser-based Botnet</h3>
<p>Năm 2014, hãng bảo mật Incapsula (đối thủ của CloudFlare) đã có <a href="https://www.incapsula.com/blog/world-largest-site-xss-ddos-zombies.html">bài viết</a> về vụ việc một trong những trang web lớn nhất thế giới (Top 50 Alexa) bị hack, khiến toàn bộ người truy cập trở thành zombie cho một cuộc tấn công DDoS. Và các bạn đoán được điều gì đã biến người dùng trở thành zombie không? Vâng, chính là XSS. Cụ thể trong trường hợp này là một lỗ hổng <a href="http://www.acunetix.com/blog/articles/persistent-cross-site-scripting/">Persistent XSS</a>.</p>
<p>Dựa theo bài viết, thì lỗ hổng nằm trong phần thay đổi ảnh hồ sơ (avatar/profile picture). Kẻ tấn công đã chèn đoạn mã độc JavaScript vào thẻ <code>&lt;img&gt;</code> sử dụng sự kiện onload, mỗi khi ảnh được tải thì đồng nghĩa với việc đoạn JS kia sẽ được thực thi.</p>
<p><a class="fluidbox fluidbox__instance-3 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://1.bp.blogspot.com/-v4Zeuc9kYEk/V8VUsUI18XI/AAAAAAAADGc/sbdqx4_q9KEEcExljLpY2InkjBa5bHDiACLcB/s1600/xss-ddos-world-largest-site.jpg"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://1.bp.blogspot.com/-v4Zeuc9kYEk/V8VUsUI18XI/AAAAAAAADGc/sbdqx4_q9KEEcExljLpY2InkjBa5bHDiACLcB/s1600/xss-ddos-world-largest-site.jpg" alt="xss" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 598px; height: 549px; top: 0px; left: 33.2031px;"></div></div></a><a></a></p>
<p>Vì là trang web nằm top nên lưu lượng người truy cập lớn đã bị lợi dụng để thực thi đoạn JS sử dụng truy vấn Ajax trỏ vào trang web bất kỳ. Và thế là trang web đó trở thành nạn nhân bị DDoS.</p>
<p>* Thông tin thêm: Cách đây 3, 4 năm tôi có phát hiện ra một lỗ hổng SQL Injection trong một diễn đàn lớn (hiện vẫn trong Top 500 Alexa VN) sử dụng vBB. Sau khi liên hệ báo lỗi với Ban Quản Trị nhưng lại bị chửi vì họ một mực khẳng định tôi "có âm mưu phá hoại diễn đàn" của họ, lúc ấy tôi giận lắm <img class="emoji" title=":angry:" alt=":angry:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f620.png" height="20" width="20" align="absmiddle"></p>
<p>Với lỗ hổng SQLi trong tay, tôi khai thác được Password (hash) và <a href="https://en.wikipedia.org/wiki/Salt_(cryptography)">Salt</a> của toàn bộ tài khoản Admin sau đó crack ra được mật khẩu (plain text) của một tài khoản. Truy cập vào AdminCP trong phần tạo thông báo, tôi chèn một đoạn JavaScript tạo truy vấn trỏ thằng về Blog của tôi. Nói thẳng là tự DDoS đi cho dễ hiểu, vì tôi biết chắc Blog của tôi không thể sập được (Google bảo kê mà, hehe). Kết quả là số người truy cập diễn đàn kia trở thành lượng traffic lớn dội thẳng vào Blog của tôi, rank Alexa tăng vọt <img class="emoji" title=":trollface:" alt=":trollface:" src="https://github.githubassets.com/images/icons/emoji/trollface.png" height="20" width="20" align="absmiddle"></p>
<p><a class="fluidbox fluidbox__instance-4 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://2.bp.blogspot.com/-mDOdN0fAzK4/V8VUsDZGgYI/AAAAAAAADGY/0ETQWy84pn05cwjBn5VNldttxmRsTvYcACLcB/s1600/xss-based-botnet-ddos.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://2.bp.blogspot.com/-mDOdN0fAzK4/V8VUsDZGgYI/AAAAAAAADGY/0ETQWy84pn05cwjBn5VNldttxmRsTvYcACLcB/s1600/xss-based-botnet-ddos.png" alt="juno-okyo-blog" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 279px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<span id="toc-xss-csrf-upload-web-shell"></span><h3 class="ui dividing header">XSS &gt; CSRF &gt; Upload Web-Shell</h3>
<p>Đây là kịch bản mà tôi quen thuộc nhất vì đã áp dụng nó rất nhiều, từ hồi vBB (vBulletin) còn phổ biến. Ngoài ra thì kịch bản này thường dễ áp dụng với WordPress do cấu trúc quản lý plugin của nền tảng này. Chi tiết về cách thức tấn công:</p>
<ol>
<li>Tìm một lỗ hổng XSS.</li>
<li>Thử chiếm Security Token của người dùng dựa theo lỗ hổng XSS tìm thấy.</li>
<li>Sử dụng Security Token để tạo plugin (hoặc thay đổi code của plugin có sẵn), từ đó có được Form Upload.</li>
<li>Sử dụng Form Upload ở bước 3 để tải lên Web-Shell. Bạn đã toàn quyền quản lý trang web đó thông qua Web-Shell. Lúc này có thể bắt đầu cài cắm back-door hoặc tải toàn bộ Cơ sở dữ liệu của trang web về.</li>
</ol>
<p>* Bạn có thể tạo ra web-shell ngay từ bước 3 nhưng thường thì code của một con shell rất lớn, có thể ảnh hưởng tới tốc độ truy vấn khi khai thác. Do đó tôi thường tạo ra một Form Upload trước.</p>
<p>Ảnh demo trong vBB:</p>
<p><a class="fluidbox fluidbox__instance-5 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://2.bp.blogspot.com/-w1vC0thWTBM/V8VVmvBb2cI/AAAAAAAADGo/nIi_2r-n0dQveeX_tE4QIqZzYZoxvbeeACLcB/s1600/xss-csrf-upload-shell.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://2.bp.blogspot.com/-w1vC0thWTBM/V8VVmvBb2cI/AAAAAAAADGo/nIi_2r-n0dQveeX_tE4QIqZzYZoxvbeeACLcB/s1600/xss-csrf-upload-shell.png" alt="xss-vbb" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 409px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p>Video demo quá trình khai thác lỗ hổng DOM-based XSS trong Yoast SEO (a.k.a WordPress SEO) - một trong những plugin được sử dụng nhiều nhất theo thống kê từ WordPress.</p>
<p>            </p><div class="iframe-wrapper youtube">
              <iframe frameborder="0" allowfullscreen="" src="//www.youtube.com/embed/78_g3PSAAcM"></iframe>
            </div>
<p></p>
<span id="toc-t-ng-k-t"></span><h3 class="ui dividing header">Tổng kết</h3>
<p>Trong bài viết này, tôi đã đưa ra 3 kịch bản nguy hiểm nhất khi khai thác lỗ hổng bảo mật XSS theo đánh giá của cá nhân tôi. Ngoài ra sẽ còn rất nhiều kịch bản khác dựa theo sức sáng tạo và kỹ năng của một Hacker. Bạn còn biết kịch bạn nào thú vị hơn? Hãy để lại dưới phần bình luận nhé! ;)</p>
<blockquote>
<p>"Ờ thì nghe cũng có vẻ nguy hiểm đấy, nhưng sao tôi thấy ông hay viết về XSS thế? Rảnh quá hả!?"</p>
</blockquote>
<p>À... một lỗi vừa phổ biến, nằm top 10 OWASP, lại vừa nguy hiểm, có thể kết hợp tốt với các lỗi khác. Nhưng dễ tìm, dễ fix, đã thế còn được tính bug bounty nữa.</p>
<p><a class="fluidbox fluidbox__instance-6 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://4.bp.blogspot.com/-qTmx8xcOekQ/V8VWGypLDlI/AAAAAAAADGs/7EUGngPs0q8qM1W-K2PKfR5bbdUgeJgCwCLcB/s1600/juno-okyo-hack-phimmoi-net.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://4.bp.blogspot.com/-qTmx8xcOekQ/V8VWGypLDlI/AAAAAAAADGs/7EUGngPs0q8qM1W-K2PKfR5bbdUgeJgCwCLcB/s1600/juno-okyo-hack-phimmoi-net.png" alt="xss-bug-bounty" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 480px; height: 320px; top: 0px; left: 92.2031px;"></div></div></a><a></a></p>
<p>Vậy tại sao "không" chứ? <img class="emoji" title=":wink:" alt=":wink:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f609.png" height="20" width="20" align="absmiddle"></p>
<p>Happy Hacking! :)</p>
<hr>
<p><img class="emoji" title=":point_right:" alt=":point_right:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f449.png" height="20" width="20" align="absmiddle"> Theo dõi Juno_okyo trên <a href="http://kipalog.com/users/juno_okyo/mypage">Kipalog</a> · <a href="https://fb.com/907376185983675">Facebook</a> · <a href="https://twitter.com/juno_okyo">Twitter</a> · <a href="https://plus.google.com/108443613096446306111">Google+</a> · <a href="http://goo.gl/J92rsc">Youtube</a></p>
</section>'),

-- Khám Phá Đại Bản Doanh Python Sê Ri Âu Vờ Viêu --
(7, 
N'Khám Phá Đại Bản Doanh Python Sê Ri Âu Vờ Viêu', 
'kham-pha-dai-ban-doanh-python-se-ri-au-vo-vieu', 
N'Sáng nay là một buổi sáng cuối tuần, chồng mình bỏ bê mình, á lộn, chồng mình có việc bận nên không có đi vi vu với mình được, cho nên mình rãnh quá mình lại ngồi viết blog', 
'2020/07/20 09:30:56', 
9, 
null, 
null, 
'python.jpg',
N'<section id="content" class="ui pilled segment md" ng-non-bindable="">
<p><a class="fluidbox fluidbox__instance-1 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://beautyoncode.com/wp-content/uploads/2019/12/Screen-Shot-2019-12-28-at-8.23.21-AM.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://beautyoncode.com/wp-content/uploads/2019/12/Screen-Shot-2019-12-28-at-8.23.21-AM.png" alt="" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 318px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p>Và từ đó, sê ri “Khám Phá Đại Bản Doanh Python” ra đời</p>
<span id="toc-m-b-i"></span><h2 class="ui dividing header">Mở bài</h2>
<p>Sáng nay là một buổi sáng cuối tuần, chồng mình bỏ bê mình, á lộn, chồng mình có việc bận nên không có đi vi vu với mình được, cho nên mình rãnh quá mình lại ngồi viết blog</p>
<p>Sau khi quần 15 phút trên trang chủ python.org, ý tưởng viết bài nó tới tấp ập tới, làm mình đỡ không nổi, phải mau lẹ viết một cái sê ri au vờ viêu chớ sợ nó bay mất</p>
<p><strong>Cảm giác đầu tiên là NGỢP</strong>, vì nó nhiều quá trời luôn, sơ sơ thì là: <strong>Get Started</strong>, <strong>Documentation</strong>, <strong>Community</strong>, <strong>Jobs</strong>, <strong>Python Package Index(PyPI)</strong>, <strong>News</strong>, <strong>Events</strong>, <strong>Success Stories</strong>, …</p>
<p>Mà cái đám ở trên mình cũng chưa đọc qua nữa, giỏi là mình hay dòm ngó chỗ documentation xí, cho nên đối với mình tụi nó cũng mới toanh toanh.</p>
<p>Thấy vậy mới thấy cái sê ri ni đặt tên quá đúng, đúng nghĩa là <strong>KHÁM PHÁ</strong> luôn chứ thật mình cũng có biết cái mẹo gì đâu, hihi</p>
<p><strong>Cảm giác thứ hai là NỔI DA GÀ</strong>, vì cái độ chuyên nghiệp của cái site python.org, quả không hổ danh là <strong>ĐẠI BẢN DOANH</strong> của ngôn ngữ đang HOT nhứt thế giới</p>
<p>Càng xem càng nổi da gà là thật, thôi mình lướt sơ qua một vòng trang python.org:</p>
<span id="toc-th-n-b-i"></span><h2 class="ui dividing header">Thân bài</h2>
<span id="toc-top-bar"></span><h3 class="ui dividing header">Top bar</h3>
<p><a class="fluidbox fluidbox__instance-2 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://beautyoncode.com/wp-content/uploads/2019/12/Screen-Shot-2019-12-28-at-9.17.02-AM.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://beautyoncode.com/wp-content/uploads/2019/12/Screen-Shot-2019-12-28-at-9.17.02-AM.png" alt="" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 26px; top: 0px; left: 0px;"></div></div></a><a></a><br>
(thanh top bar màu mè nhứt cả trang, màu ở trên cái top border á nghe <img class="emoji" title=":smile:" alt=":smile:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f604.png" height="20" width="20" align="absmiddle">)</p>
<p>Đầu tiên, là một cái top bar màu mè nhứt so với toàn trang web. Nó bao gồm những link đi tới: <strong>Python</strong>, <strong>PSF</strong>, <strong>Docs</strong>, <strong>PyPI</strong>, <strong>Jobs</strong> và <strong>Community</strong>. Hẳn đây là những mục mà người dùng hay vô nhứt cho nên nó được đặt ở đầu trang web để kiếm cho tiện</p>
<span id="toc-header"></span><h3 class="ui dividing header">Header</h3>
<p><a class="fluidbox fluidbox__instance-3 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://beautyoncode.com/wp-content/uploads/2019/12/Screen-Shot-2019-12-28-at-9.18.53-AM.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://beautyoncode.com/wp-content/uploads/2019/12/Screen-Shot-2019-12-28-at-9.18.53-AM.png" alt="" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 65px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p>(logo và thanh search bar)</p>
<p>Tiếp đến là cái logo và thanh search bar, bonus thêm nút “Donate” dễ thấy và nút “Socialize” có để link tới Facebook, Twitter, Chat on IRC.</p>
<p>Vô trỏng dòm thử(ý nói mấy cái link), thì thấy có vẻ như trang Facebook bị bỏ hoang rồi, post cuối tận năm 2014 cơ.</p>
<p>Twitter thì có vẻ hoạt động năm nổ hơn, vừa 3g trước. Ô kê, follow Twitter thôi</p>
<p>Còn IRC, cái ni lạ hen, để bữa sau thử nghiệm cái ni ở một post khác nhé.<br>
<a class="fluidbox fluidbox__instance-4 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://beautyoncode.com/wp-content/uploads/2019/12/Screen-Shot-2019-12-28-at-9.31.03-AM.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://beautyoncode.com/wp-content/uploads/2019/12/Screen-Shot-2019-12-28-at-9.31.03-AM.png" alt="" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 258px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p>Phần còn lại của Header là thanh Main Navigation và cái Overview, kèm theo một dòng intro nhẹ</p>
<p>Thấy cái overview bấm được thế là mình bấm hắn trước, cha cha, bấm qua bấm lại là đủ hiểu syntax của Python hắn như răng rồi, có thể hình dung sơ sơ và làm quen nhẹ nhẹ được rồi, chỗ ni thời điểm mình dòm là hắn giới thiệu cái function, list, print và loops. Hay quá hen! <img class="emoji" title=":smile:" alt=":smile:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f604.png" height="20" width="20" align="absmiddle"></p>
<p>Còn về cái main navigation, không biết có phải do mình hai lúa không mà mình thấy hắn có phần intro ở bên cạnh cái menu dropdown á, nhìn cũng hay hay, lại có thêm thông tin từng mục để đọc.</p>
<span id="toc-main-content"></span><h3 class="ui dividing header">Main content</h3>
<p><a class="fluidbox fluidbox__instance-5 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://beautyoncode.com/wp-content/uploads/2019/12/Screen-Shot-2019-12-28-at-9.45.57-AM.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://beautyoncode.com/wp-content/uploads/2019/12/Screen-Shot-2019-12-28-at-9.45.57-AM.png" alt="" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 459px; top: 0px; left: 0px;"></div></div></a><a></a><br>
(Cái hình ni thiếu PEPs với PSF ở dưới á)</p>
<p>Trong phần content chính của trang web, là các widgets, mỗi cái là một nội dung, bao gồm: Get Started, Download, Docs, Jobs, Latest News, Upcoming Events, Success Stories, Use Python for…, Python Enhance Proposals(PEPs), Python Software Foundation(PSF)</p>
<p>Đuối chưa? Mới đọc tiêu đề thôi mà thấy hơi đuối rồi đó kaka, chỗ ni có tới 9 phần luôn á</p>
<p>Mình có bỏ link ở trên hết á, mấy bạn cứ thoả mái dòm qua nghe, nếu không muốn đọc mấy bài dòm qua tào lao của mình, hihi</p>
<span id="toc-footer"></span><h3 class="ui dividing header">Footer</h3>
<p>Yeah, cuối cùng cũng đã kéo tới cuối trang. Thực ra đây là single page mà, nó có một trang ngắn thôi à, lol.</p>
<p>Ở chỗ footer ni, là một list danh sách cái link trong main navigation á. Thay vì mình phải hover vô từng mục trong chỗ main navigation thì ở đây người ta ghi rõ hết ra luôn rồi nè.<br>
<a class="fluidbox fluidbox__instance-6 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://beautyoncode.com/wp-content/uploads/2019/12/Screen-Shot-2019-12-28-at-9.52.19-AM.png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://beautyoncode.com/wp-content/uploads/2019/12/Screen-Shot-2019-12-28-at-9.52.19-AM.png" alt="" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 302px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p>Từ cái bảng này, mình chọn ra 5 phần dưới đây mà mình cho là hay ho nhất để viết những bài tiếp theo, bao gồm:</p>
<p>Muốn biết Python làm được những gì, hẳn là mình cần phải dòm qua <strong>Applications</strong>, cái ni có vẻ ngắn, mình sẽ gộp với <strong>Getting Started</strong>, <strong>Help</strong> và <strong>Success Stories</strong> để thành một bài sương sương mở đầu sê ri, tạo động lực để đi tiếp vì qua đám này hẳn mình hiểu cái độ quan trọng của Python và háo hức cho hành trình tiếp theo, lương ngàn đô đang chờ đợi, kaka.</p>
<p>Tiếp đến, mình sẽ gặm qua phần khó ăn nhất “<strong>Documentation</strong>”</p>
<p>Thực ra mình cũng ngán mấy cái documentation dữ lắm, cho nên mình không dại dột chi mà chui vô liền cái document lắm chữ đâu. Mình thấy ở đây còn có nhiều sự lựa chọn khác có vẻ dễ thương hơn nhiều, đó là “<strong>Audio/Visual Talks</strong>” và “<strong>Beginner Guide“</strong>, coi bộ được ha, post tiếp theo sẽ về hai bạn nhỏ này nhé.</p>
<p>Sau khi quần qua quần lại, làm quen, đá nháy các kiểu, hẳn là mình cũng đã tự tin hơn rồi, dã đến lúc chui vô hang cọp rồi đây. Ô kê, post tiếp nữa sẽ là về official document nhé.</p>
<p>Mình vô cái docs dòm thử rồi, thực ra hắn chỉ là single page giới thiệu thôi, documents thì chia thành nhiều level khác nhau: Beginner, Moderate, Advanced, General và document của Python3.x và Python2.x resources.</p>
<p>Lượn một vòng qua tùm lum link thì hơi thở mình không còn đều đặn nữa rồi. Không hổ danh là hang cọp, lượn lờ một xí mà đã sợ chết khiếp rồi. Hắn nhiều quá trời đất luôn. Ở level beginner như mình, thôi hãy biết điều mà đọc theo BeginnerGuide và học theo Tutorial</p>
<p>Sau khi học sương sương basic Python, thì thời gian tới hẳn là sẽ ở chung lâu bền rồi, cũng đã tới lúc học qua các sự thay đổi quan trọng của nó, được biết đến với tên PEPs. Có quá trời quá đất PEPs luôn, mình có search qua thì thấy có một vài PEPs thuộc loại must-read gồm:</p>
<ul class="ui list">
<li><p><a href="https://www.python.org/dev/peps/pep-0020/">PEP 20 – The Zen of Python</a></p></li>
<li><p><a href="https://www.python.org/dev/peps/pep-0008/">PEP 8 – Style Guide for Python Code</a></p></li>
<li><p><a href="https://www.python.org/dev/peps/pep-0257/">PEP 257 – Docstring Conventions</a></p></li>
<li><p><a href="https://www.python.org/dev/peps/pep-0257/">PEP 287 – reStructuredText Docstring Format</a></p></li>
</ul>
<p>Tụi mình sẽ cùng đọc qua mấy bạn quan trọng ni trong một bài post nè</p>
<p>(Lau mồ hôi xí) Ô kê, tiếp, còn gì nữa, chiến luôn nào?</p>
<p>Hú hồn, phần khó nhứt đã qua, những thì còn lại là những món quà nho nhỏ cho những ai đã cùng chiến tới đây – post cuối cùng của series sẽ lướt qua PyPI, check qua cách để update kiến thức Python, những events và jobs</p>
<p>Tada, ta da, thế là chúng ta đã học xong Python rồi phải hân =))</p>
<p>Đùa bố à, mày vừa lướt qua nó như một cơn gió thôi gái ạ :”&gt;</p>
<p>Hôm ni âu vờ viêu như vậy cũng được rồi đó ha, cuối cùng mình xem tóm tóm sơ cái plan cho cái sê ri ni, những bài tiếp theo chúng ta sẽ cùng khám phá thêm:</p>
<span id="toc-kh-m-ph-i-b-n-doanh-python-plan-ti-p-theo-"></span><h2 class="ui dividing header">Khám Phá Đại Bản Doanh Python plan tiếp theo:</h2>
<p><strong>Phần 1: Lượn lờ cùng Python(Applications, Getting Started, Help, Success Stories)</strong></p>
<p>→ Blog: Python có thể dùng làm gì nhỉ?</p>
<p>→ Blog: Ai đã thành công cùng Python?</p>
<p>→ Blog: Háo hức với Python quá ♥ Mình nên bắt đầu từ đâu?</p>
<p>→ Blog: Tài liệu videos và audios cho người học và nghiên cứu Python</p>
<p><strong>Phần 2: Hẹn hò cùng Python(The Python Tutorial)</strong></p>
<p>→ Blog: Tôi và Python, lần hẹn đầu tiên</p>
<p>→ Blog: Tôi và Python, lần hẹn thứ hai</p>
<p>→ Blog: Tôi và Python, lần hẹn thứ ba</p>
<p>→ Blog: Tôi và Python, lần hẹn thứ n</p>
<p>→ Blog: Tôi và Python, lễ ra mắt</p>
<p>(Đùa á =)) chỗ ni chưa viết gì nơi, chỉ chém cho vui nhà vậy hoai à)</p>
<p><strong>Phần 3: Đọc thêm về người bạn đời của tôi</strong></p>
<p>→ PEPs must-read</p>
<p>→ PyPI, news Python, events, jobs</p>
<span id="toc-k-t-b-i"></span><h2 class="ui dividing header">Kết bài</h2>
<p>Mọi người chán em chưa? Em thì thấy cũng hơi chán bản thân mình rồi đây, con đường này sao mà dài quá zậy nè.</p>
<p>Mọi người có chán em thì cũng đi dòm qua cái trang python.org đi nhé. Còn nếu lười dòm thì đợi post lần sau cùng đi dòm với em nghe.</p>
<p>Cám ơn mọi người đã đọc!</p>
<p>Mình đang tập viết blog, mọi người ghé <a href="https://beautyoncode.com">nhà mặt tiền</a> hoặc <a href="https://beautyoncode.wordpress.com/">nhà trong kiệt</a> của mình chơi.<br>
Hay follow/like <a href="https://www.facebook.com/beautyoncode">fanpage</a> này để cập nhật những bài viết mới nhất nhé <img class="emoji" title=":heart_eyes:" alt=":heart_eyes:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f60d.png" height="20" width="20" align="absmiddle"></p>
<p>BeautyOnCode</p>
</section>'),

-- Python có thể dùng để làm gì nhỉ? --
(8, 
N'Python có thể dùng để làm gì nhỉ?', 
'Python-co-the-dung-de-lam-gi-nhi', 
N'Trong phần này, tụi mình sẽ cùng nhau dạo quanh quanh những phần ngoài lề trước khi tấn công vào document ở những phần tiếp theo nhé.', 
'2020/07/20 10:05:36', 
9, 
null, 
null, 
'python.jpg',
N'<section id="content" class="ui pilled segment md" ng-non-bindable="">
<p><a class="fluidbox fluidbox__instance-1 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://beautyoncode.com/wp-content/uploads/2020/01/What-can-I-do-with-Python..png"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://beautyoncode.com/wp-content/uploads/2020/01/What-can-I-do-with-Python..png" alt="" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 363px; top: 0px; left: 0px;"></div></div></a><a></a><br>
(hình lượm trên internet)</p>
<p>Chào mừng mọi người đến với bài post đầu tiên của phần “Lượn lờ cùng Python” của series “<a href="https://beautyoncode.com/kham-pha-dai-ban-doanh-python-se-ri-au-vo-vieu/">Khám phá Đại Bản Doanh Python</a>”(Overview của series nằm ở <a href="https://beautyoncode.com/kham-pha-dai-ban-doanh-python-se-ri-au-vo-vieu/">đây</a> ạ)</p>
<p>Trong phần này, tụi mình sẽ cùng nhau dạo quanh quanh những phần ngoài lề trước khi tấn công vào document ở những phần tiếp theo nhé. </p>
<p><strong><em>Mình sẽ đi tìm hiểu nhưng câu hỏi sau trong “Lượn lờ cùng Python”:</em></strong></p>
<blockquote>
<p><strong><a href="https://beautyoncode.com/khong-biet-python-co-the-dung-de-lam-gi-nhi%e2%80%8b/">Python có thể dùng để làm gì nhỉ?</a></strong></p>
<p><a href="https://beautyoncode.com/ai-da-thanh-cong-cung-python/">Ai đã thành công cùng Python?</a></p>
<p><a href="https://beautyoncode.com/bat-dau-voi-python/">Háo hức với Python quá ♥ Mình nên bắt đầu từ đâu?</a></p>
</blockquote>
<p>Những nội dung trong bài series này từ “<strong>Đại bản doanh Python</strong>” <a href="python.org">python.org</a>, mình viết bằng ngôn ngữ của mình kèm theo những tài liệu khác mà mình thấy liên quan và hữu ích cho chủ đề của bài.</p>
<p>Bài dưới đây sẽ đi trả lời câu hỏi “Python có thể dùng để làm gì nhỉ?” nằm trong mục “<a href="https://www.python.org/about/apps/">Applications</a>” nha.</p>
<span id="toc-python-c-th-d-ng-l-m-g-nh-"></span><h1 class="ui dividing header">Python có thể dùng để làm gì nhỉ?</h1>
<span id="toc-m-b-i"></span><h2 class="ui dividing header">Mở bài</h2>
<p>Học Python đang là xu hướng của thế giới, Python được các ông trùm như Instagram, Netflix, Reddit, Lyft, Google, Spotify, New York Times và Bloomberg sử dụng. </p>
<p>Vậy nó có thể làm được gì mà người ta dùng nhiều quá vậy nè </p>
<span id="toc-th-n-b-i"></span><h2 class="ui dividing header">Thân bài</h2>
<p>Phần này giới thiệu ứng dụng của Python ở 5 nhóm chính, bao gồm:</p>
<p>→ <strong>Web and Internet development</strong>(Phát triển Web và Internet)</p>
<p>→ <strong>Scientific and Numberic</strong>(Khoa học và số học)</p>
<p>→ <strong>Education</strong>(một ngôn ngữ tuyệt vời trong giảng dạy về lập trình)</p>
<p>→ <strong>GUI Desktop</strong>(Viết những giao diện người dùng cho desktop)</p>
<p>→ <strong>Software Development</strong>(Phát triển phần mềm)</p>
<p>→ <strong>Software Developmen</strong>t(Phát triển phần mềm)</p>
<span id="toc-ph-t-tri-n-web-v-internet"></span><h3 class="ui dividing header">Phát triển Web và Internet</h3>
<p>Có lẽ Python phát triển nhất trong lĩnh vực này, với nhiều sự lựa chọn như:</p>
<p>→ Các frameworks phổ biến nhất là <a href="https://www.djangoproject.com/">Django</a> và <a href="https://trypyramid.com/">Pyramid</a>.</p>
<p>→ Các micro-frameworks là <a href="http://flask.pocoo.org/">Flask</a> và <a href="http://bottlepy.org/docs/dev/">Bottle</a>.</p>
<p>→ Và các CMS(hệ thống quản trị nội dung) như <a href="https://www.plone.org/">Plone</a>, <a href="https://www.django-cms.org/en/">django CMS</a><br>
→ Thư viện Python còn hỗ trợ nhiều giao thức internet như là: <a href="https://docs.python.org/3/library/markup.html">HTML và XML</a>, <a href="https://docs.python.org/3/library/json.html">JSON</a>, <a href="https://docs.python.org/3/library/email.html">E-mail processing</a>, rồi còn support <a href="https://docs.python.org/3/library/ftplib.html">FTP</a>, <a href="https://docs.python.org/2/library/imaplib.html">IMAP</a>, các <a href="https://docs.python.org/3/library/internet.html">internet protocols</a> … và cũng dễ dùng <a href="https://docs.python.org/3/howto/sockets.html">socket interface</a> nữa.</p>
<p>→ Cuối cùng, Python có một thư viện to đùng PyPI với nhiều thư viện hỗ trợ lập trình web, phổ biến phải kể đến: <a href="https://pypi.org/project/requests/">Requests</a>, <a href="https://www.crummy.com/software/BeautifulSoup/">BeautifulSoup</a>, <a href="https://pypi.org/project/feedparser/">Feedparser</a>, <a href="https://pypi.org/project/paramiko/">Paramiko</a>, <a href="https://twistedmatrix.com/trac/">Twisted Python</a>.</p>
<span id="toc-khoa-h-c-v-s-h-c"></span><h3 class="ui dividing header">Khoa học và Số học</h3>
<p>Python cũng được sử dụng rộng rãi trong khoa học và số học:</p>
<p>→ <a href="https://scipy.org/">SciPy</a> là bộ sưu tập các gói giành cho toán học, khoa học, kỹ thuật</p>
<p>→ <a href="https://pandas.pydata.org/">Pandas</a> là thư viện phân tích dữ liệu và mô phỏng</p>
<p>→ <a href="http://ipython.org/">IPython</a> mà một trình shell mạnh mẽ có tính năng chỉnh sửa và ghi lại phiên làm việc một cách dễ dàng ngoài ra còn hỗ trợ trực quan và tính toán song song.</p>
<p>→ Cuối cùng là <a href="https://software-carpentry.org/">The Software Carpentry Course</a> nơi dạy những kỹ năng cơ bản trong khoa học máy tính, cung cấp nhiều tài liệu học miễn phí và có cộng đồng mạnh.</p>
<span id="toc-gi-ng-d-y-l-p-tr-nh"></span><h3 class="ui dividing header">Giảng dạy lập trình</h3>
<p>Python là một ngôn ngữ tuyệt vời trong giảng dạy lập trình ở nhiều cấp độ từ cơ bản đến nâng cao.</p>
<p>Nhiều cuốn sách giảng dạy lập trình được viết với ngôn ngữ Python như là: </p>
<p>→ <a href="http://www.openbookproject.net/thinkcs/python/english2e/">How to Think Like a Computer Scientist</a></p>
<p>→ <a href="https://mcsp.wartburg.edu/zelle/python/">Python Programming: An Introduction to Computer Science</a></p>
<p>→ <a href="http://pragprog.com/book/gwpy2/practical-programming">Practical Programming</a></p>
<p>Nhóm “<a href="https://www.python.org/community/sigs/current/edu-sig">Education Special Interest Group</a>” là nơi thảo luận giành cho công tác giảng dạy về Python</p>
<span id="toc-giao-di-n-desktop"></span><h3 class="ui dividing header">Giao diện desktop</h3>
<p>→ <a href="https://docs.python.org/3/library/tkinter.html">Tkinter</a> là thư viện dùng để viết GUI desktop được xây dựng bằng Python.</p>
<p>Nếu bạn có hứng thú với side project build Desktop GUI với Tkinter có thể check qua document Tkinter ở đây và video tutorial ở             </p><div class="iframe-wrapper youtube">
             <iframe frameborder="0" allowfullscreen="" src="//www.youtube.com/embed/ELkaEpN29PU"></iframe>
            </div>
.<p></p>
<p>→ Ngoài ra còn có các gói GUI toolkit khác sử dụng trên nhiều nền tảng như <a href="https://www.wxpython.org/">wxWidgets</a>, <a href="https://kivy.org/#home">Kvy</a>, Qt thông qua <a href="https://riverbankcomputing.com/software/pyqt/intro">pyqt</a>, <a href="https://wiki.qt.io/Qt_for_Python">pyside</a>, <a href="https://pygobject.readthedocs.io/en/latest/">GTK+</a>, <a href="https://sourceforge.net/projects/pywin32/">win32 extensions</a>.</p>
<span id="toc-ph-t-tri-n-ph-n-m-m"></span><h3 class="ui dividing header">Phát triển phần mềm</h3>
<p>Các nhà phát triển thường dùng Python để quản lý, kiểm thử, thử nghiệm, và xây dựng phần mềm</p>
<p>→ <a href="https://www.scons.org/">Scons</a> là một công cụ xây dựng phần mềm</p>
<p>→ <a href="http://buildbot.net/">Buildbot</a> và <a href="http://gump.apache.org/">Apache Gum</a>p dùng trong tự động biên dịch và kiểm thử</p>
<p>→ <a href="http://roundup.sourceforge.net/">ERP Roundup</a> hay <a href="https://www.edgewall.org/trac/">Trac</a> cho kiểm soát lỗi và quản lý dự án</p>
<span id="toc-x-y-d-ng-ng-d-ng-th-ng-m-i"></span><h3 class="ui dividing header">Xây dựng ứng dụng thương mại</h3>
<p>Python cũng được sử dụng trong xây dựng ERP(Enterprise Resource Planning Software) và các hệ thống thương mại điện tử, như là:</p>
<p>→ <a href="https://www.odoo.com/vi_VN/">Odoo</a> là phần mềm quản lý công ty nơi quản lý hàng loạt các ứng dụng kinh doanh cùng một chỗ tạo thành bộ ứng dựng quản lý doanh nghiệp hoàn chỉnh.</p>
<p>→ <a href="http://www.tryton.org/foundation">Tryton</a> là mô hình 3 lớp(Presentation, Business, Data) giành cho các nền tảng ứng dụng chung.</p>
<span id="toc-k-t-b-i"></span><h2 class="ui dividing header">Kết bài</h2>
<p>Trên đây là nội dung từ “<a href="https://www.python.org/about/apps/">Đại Bản Doanh</a>” được mình viết lại theo kiểu hiểu chi dịch nấy.</p>
<p>Cuối cùng là một món quà nhỏ nhỏ giành, về những ứng dụng của Python trong ngành tụi mình và những công việc giành cho người làm Python nha, coi như bonus cho phần dịch tào lao củ chuối của mình ở trên ^^</p>
<span id="toc-bonus-n-i-dung"></span><h2 class="ui dividing header">Bonus Nội Dung</h2>
<span id="toc-3-ng-d-ng-ch-nh-c-a-python"></span><h3 class="ui dividing header">3 ứng dụng chính của Python</h3>
<p>Đây là một video giới thiệu về những thứ Python có thể làm cũng rất là hay ho và dễ hiểu từ kênh CS Dojo – một developer của Google – mọi người xem qua nghen, nội dung chính mình tóm tắt ngay bên dưới ha</p>
<p><a href="https://youtu.be/kLZuut1fYzQ">Video nè, hỏng có thumbnail</a></p>
<p>Trong video trên giới thiệu Python áp dụng trong 3 lĩnh vực chính là:</p>
<p>♣ Web Development: Web Framework(Django, Flask)</p>
<p>♣ Data Science, Data analysis/visualization</p>
<ul class="ui list">
<li>Machine Learning: Machine learning framework for Python: scikit-learn, TensorFlow</li>
<li>Data analysis/visualization: Data visualization library by Python: matplolib</li>
</ul>
<p>♣ Scripting</p>
<p>*những ứng dụng khác nữa như(không quá phổ biến) là: *</p>
<p>– Game Development(PyGame)</p>
<p>– Desktop applications(Tkinter, QT)</p>
<p>– Embedded applications(Raspberry Pi)</p>
<span id="toc-h-c-python-th-c-th-n-p-h-s-v-nh-ng-v-tr-ni-n-"></span><h2 class="ui dividing header">Học Python thì có thể nộp hồ sơ vô những vị trí ni nè</h2>
<p>Trước khi học Python, mình cũng nên biết rõ học xong rồi mình sẽ ứng tuyển vô những vị trí nào, lương hướng ra sao để có động lực chứ nè.</p>
<p>Ô kê, vô nào!</p>
<p>Trước nhứt là mình có thể làm <strong>Python Developer</strong>, lúc nớ mình sẽ làm những thứ như sau:</p>
<p>♣ Xây dựng trang web</p>
<p>♣ Tối ưu hoá thuật toán, data</p>
<p>♣ Giải quyết các vấn đề về phân tích dữ liệu</p>
<p>♣ Thực hiện bảo mật và bảo vệ dữ liệu</p>
<p>♣ Viết mã đơn giản, tái sử dụng được, hiệu quả hơn</p>
<p>Thứ tiếp theo, mình có thể làm <strong>Product Manager</strong>, </p>
<p>Họ sẽ phát triển những tính năng mới từ lỗ hổng của thị trường, và chắc chắn về tại sao sản phẩm lại được xây dựng như vậy. Do đó, data đóng vai trò quan trọng trong công việc của họ, vì vậy, nhiều công ty họ tuyển Product Manager biết Python</p>
<p>Tiếp nữa, mình có thể làm <strong>Data Analyst</strong>, </p>
<p>Vì Data Analyst là người sẽ làm việc với khối lượng thông tin khổng lồ, nhiều công ty sẽ tìm kiếm những người có khả năng sàng lọc lượng lớn thông tin, với sự hỗ trợ của các thư viện Python như SciPy hay Pandas</p>
<p>Ngoài ra, học Python còn phù hợp cho những công việc như <strong>Giáo Viên</strong>(dạy Python, dạy lập trình),  đôi khi các nhân viên trong lĩnh vực khác cũng học Python để hỗ trợ cho công việc nhằm cắt giảm chi phí, …</p>
<p>Tính ra sau bài ni mình cũng biết đến nhiều lĩnh vực về Python phếch ♥</p>
<span id="toc-k-t-b-i-l-n-2-"></span><h2 class="ui dividing header">Kết bài lần 2 <img class="emoji" title=":smile:" alt=":smile:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f604.png" height="20" width="20" align="absmiddle">
</h2>
<p>Ở bài viết sau, mình sẽ cùng khám phá câu hỏi “<a href="https://beautyoncode.com/ai-da-thanh-cong-cung-python/">Ai đã thành công cùng Python?</a>” cùng phần “Success Stories” nhé.</p>
<p>Cám ơn mọi người đã đọc!</p>
<p>Mình đang tập viết blog, mọi người ghé <a href="https://beautyoncode.com">nhà mặt tiền</a> hoặc <a href="https://beautyoncode.wordpress.com/">nhà trong kiệt</a> của mình chơi.<br>
Hay follow/like <a href="https://www.facebook.com/beautyoncode">fanpage</a> này để cập nhật những bài viết mới nhất nhé <img class="emoji" title=":heart_eyes:" alt=":heart_eyes:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f60d.png" height="20" width="20" align="absmiddle"></p>
<p>BeautyOnCode</p>
</section>'),

-- RabbitMQ và những điều cần biết --
(9, 
N'RabbitMQ và những điều cần biết', 
'rabbitmq-va-nhung-dieu-can-biet', 
N'Với lập trình viên thì rabbitmq rất đáng giá, nếu không có các hệ thống message broker như rabbitmq thì bất cứ lúc nào cần đẩy data giữa các thành phần trong hệ thống, lập trình viên cần một kết nối trực tiếp.', 
'2020/07/15 02:03:00', 
7, 
null, 
null, 
'rabbitmq.jpg', 
N'<section id="content" class="ui pilled segment md" ng-non-bindable="">
<p><strong>RabbitMQ là gì?</strong></p>
<p>Với lập trình viên thì rabbitmq rất đáng giá, nếu không có các hệ thống message broker như rabbitmq thì bất cứ lúc nào cần đẩy data giữa các thành phần trong hệ thống, lập trình viên cần một kết nối trực tiếp. Thật ra, RabbitMQ chỉ là một message broker được sử dụng giao thức AMQP - Advanced Message Queue Protocol, nó được lập trình bằng ngôn ngữ Erlang, ngoài ra nó cung cấp cho lập trình viên một phương tiện trung gian để giao tiếp giữa nhiều thành phần trong một hệ thống lớn.Với cách này, RabbitMQ sẽ nhận message đến từ các thành phần khác nhau trong hệ thống, lưu trữ dữ liệu an toàn trước khi đẩy đến đích.</p>
<p>Hệ thống càng lớn, mức độ trao đổi message giữa càng thành phần cũng vì thế tăng lên khiến việc lập trình trở nên phức tạp. Đã từng có thời kì, các lập trình viên chỉ nên tập trung vào business logic của ứng dụng còn các công tác hậu trường thì nên được tái sử dụng các giải pháp đã có. Rabbitmq cũng là một giải pháp rất tốt trong các kiến trúc hệ thống lớn.</p>
<p><strong>Có nên dùng RabbitMQ?</strong></p>
<p>Trong một hệ thống phân tán sẽ có rất nhiều thành phần khác nhau. Nếu muốn các thành phần này giao tiếp được với nhau thì chúng phải biết nhau, nhưng điều này lại gây rắc rối cho việc viết code. Một thành phần phải biết quá nhiều đâm ra rất khó maintain, debug. Giải pháp ở đây là thay vì các liên kết trực tiếp, khiến các thành phần phải biết nhau thì sử dụng một liên kết trung gian qua một message broker. Với sự tham gia của message broker thì producer sẽ không hề biết consumer. Nó chỉ việc gửi message đến các queue trong message broker. Consumer chỉ việc đăng ký nhận message từ các queue này.</p>
<p>Có thể hiểu, vì producer nói chuyện với consumer trung gian qua message broker nên dù producer và consumer có khác biệt nhau về ngôn ngữ thì giao tiếp vẫn thành công. Dù viết bằng java, python, php hay ruby... thì chỉ cần thỏa mãn giao thức với message broker thì thông suốt hết. HIện nay, rabbitmq cũng đã cung cấp client library cho khá nhiều các ngôn ngữ rồi. Tính năng này cho phép tích hợp hệ thống linh hoạt.</p>
<p><strong>Các loại Exchange trong Rabbitmq</strong></p>
<p>Có 5 loại Exchange: direct, topic, fanout, headers.</p>
<p><strong>Direct Exchange</strong></p>
<p>Chức năng của Direct exchange là đẩy message đến hàng chờ đợi dựa theo khóa định tuyến routing key. Loại trao đổi trực tiếp này khá hữu ích khi bạn muốn phân biệt các thông báo được xuất bản cho cùng một trao đổi bằng cách sử dụng một mã định danh chuỗi đơn giản.</p>
<p><strong>Fanout Exchange</strong></p>
<p>Chức năng của Fanout exchange sẽ đẩy message đến toàn bộ hàng đợi gắn với nó. Nó được xem là một bản copy message tới tất cả những hàng đợi với bất kể một routing key nào. Nếu được đăng ký thì nó sẽ bị bỏ qua. Exchange này hữu ích với trường hợp ta cần một dữ liệu được gửi tới nhiều thiết bị khác nhau với cùng một message nhưng cách xử lý ở mỗi thiết bị, mỗi nơi là khác nhau.</p>
<p><strong>Topic Exchange</strong></p>
<p>Topic exchange sẽ làm một wildcard để gắn routing key với một routing pattern khai báo trong binding. Consumer có thể đăng ký những topic mà nó quan tâm. Cú pháp được sử dụng ở đây là * và #.</p>
<p><strong>Headers Exchange</strong></p>
<p>Một header exchange sẽ dùng các thuộc tính header của message để định tuyến. Headers Exchange rất giống với Topic Exchange, nhưng nó định tuyến dựa trên các giá trị tiêu đề thay vì các khóa định tuyến.</p>
<p>Một thông điệp được coi là phù hợp nếu giá trị của tiêu đề bằng với giá trị được chỉ định khi ràng buộc.</p>
<p><strong>Dead Letter Exchange</strong></p>
<p>Nếu không tìm thấy hàng đợi phù hợp cho tin nhắn, tin nhắn sẽ tự động bị hủy. RabbitMQ cung cấp một tiện ích mở rộng AMQP được gọi là “Dead Letter Exchange” — Cung cấp chức năng để chụp các tin nhắn không thể gửi được.</p>
<p><strong>Các tính năng nổi bật của RabbitMQ</strong></p>
<p><strong>Liên kết</strong></p>
<p>Đối với các server cần các kết nối không quá chặt chẽ và có độ tin cậy cao so với clustering cho phép, RabbitMQ cung cấp một mô hình liên kết phù hợp với yêu cầu này.</p>
<p><strong>Routing linh hoạt</strong></p>
<p>Tin nhắn sẽ được route thông qua trao đổi trước khi chuyển đến queue. RabbitMQ cung cấp một số loại trao đổi được tích hợp sẵn cho định tuyến logic điển hình. Với các định tuyến phức tạp hơn, bạn có thể liên kết các trao đổi với nhau hoặc thậm chí có thể viết các kiểu trao đổi của riêng bạn như một plugin.</p>
<p><strong>Clustering/cụm</strong></p>
<p>RabbitMQ có chức năng nhóm lại với nhau, hợp thành một nhà trung gian duy nhất.</p>
<p><strong>Độ tin cậy</strong></p>
<p>RabbitMQ hỗ trợ nhiều tính năng khác nhau cho phép bạn giao dịch các tác vụ một cách tin cậy, với thời gian lưu lâu hơn, xác nhận giao hàng, xác nhận của nhà xuất bản và tính khả dụng cao.</p>
<p><strong>Queue có tính sẵn sàng cao</strong></p>
<p>Queue có thể được nhân bản trên một số máy trong một cluster, đảm bảo cho tin nhắn của bạn luôn an toàn ngay cả khi xảy ra tình huống lỗi phần cứng.</p>
<p><strong>Đa giao thức</strong></p>
<p>RabbitMQ hỗ trợ messaging thông qua nhiều giao thức messaging khác nhau.</p>
<p><strong>Đa dạng ứng dụng ngôn ngữ</strong></p>
<p>RabbitMQ hiện đã được phát triển với hệ ngôn ngữ phong phú bao gồm hầu hết mọi ngôn ngữ bạn có thể nghĩ đến.</p>
<p><strong>Giao diện quản lý</strong></p>
<p>Với giao diện quản lý sử dụng dễ dàng, RabbitMQ cho phép bạn theo dõi và kiểm soát mọi vấn đề trong chương trình messaging trung gian.</p>
<p><strong>Hệ thống plugin</strong></p>
<p>RabbitMQ hỗ trợ một loạt các phần mở rộng của plugin dưới nhiều hình thức khác nhau hoặc bạn cũng có thể tự viết các tiện ích mở rộng này.</p>
<p><strong>Tracing/Truy vết</strong></p>
<p>Nếu hệ thống messaging của bạn bị lỗi hoặc hoạt động không tốt, RabbitMQ sẽ hỗ trợ các thao tác truy vết để giúp bạn hiểu được hệ thống đang hoạt động như thế nào và vấn đề nào đang phát sinh.</p>
</section>'),

-- Tìm hiểu RabbitMQ - Phần 1 --
(10, 
N'Tìm hiểu RabbitMQ - Phần 1', 
'tim-hieu-ve-rabbit-mq-phan-1', 
N'RabbitMQ là một message broker ( message-oriented middleware) sử dụng giao thức AMQP - Advanced Message Queue Protocol (Đây là giao thức phổ biến, thực tế rabbitmq hỗ trợ nhiều giao thức)', 
'2015/08/15 18:56:00', 
4, 
2, 
1, 
'rabbitmq.jpg', 
N'<section id="content" class="ui pilled segment md" ng-non-bindable="">
<span id="toc-gi-i-thi-u"></span><h1 class="ui dividing header">Giới thiệu</h1>
<p>RabbitMQ là một message broker ( message-oriented middleware) sử dụng giao thức AMQP - Advanced Message Queue Protocol (Đây là giao thức phổ biến, thực tế rabbitmq hỗ trợ nhiều giao thức). RabbitMQ được lập trình bằng ngôn ngữ Erlang. RabbitMQ cung cấp cho lập trình viên một phương tiện trung gian để giao tiếp giữa nhiều thành phần trong một hệ thống lớn ( Ví dụ openstack - Một công nghệ rất thú vị hi vọng một ngày nào đó tôi đủ sức để viết vài bài về chủ đề này ). RabbitMQ sẽ nhận message đến từ các thành phần khác nhau trong hệ thống, lưu trữ chúng an toàn trước khi đẩy đến đích.</p>
<p>Thực sự, với lập trình viên thì rabbitmq rất đáng giá. Nếu không có các hệ thống message broker như rabbitmq thì bất cứ lúc nào cần đẩy data giữa các thành phần trong hệ thống, lập trình viên cần một kết nối trực tiếp. Một hệ thống càng lớn. Số thành phần càng nhiều, mức độ trao đổi message giữa càng thành phần cũng vì thế tăng lên khiến việc lập trình trở nên phức tạp. Tôi từng đọc vài bài báo về lập trình thì thấy họ khuyến cáo các lập trình viên chỉ nên tập trung vào business logic của ứng dụng còn các công tác hậu trường thì nên được tái sử dụng các giải pháp đã có. Rabbitmq cũng là một giải pháp rất tốt trong các kiến trúc hệ thống lớn. </p>
<span id="toc-t-i-sao-l-i-s-d-ng-rabbitmq"></span><h1 class="ui dividing header">Tại sao lại sử dụng RabbitMQ</h1>
<p>Chúng ta thử xem các message broker như rabbitmq đem lại lợi ích gì trong việc thiết kế ứng dụng. Trong một hệ thống phân tán (distributed system), có rất nhiều thành phần. Nếu muốn các thành phần này giao tiếp được với nhau thì chúng phải biết nhau. Nhưng điều này gây rắc rối cho việc viết code. Một thành phần phải biết quá nhiều đâm ra rất khó maintain, debug. Giải pháp ở đây là thay vì các liên kết trực tiếp, khiến các thành phần phải biết nhau thì sử dụng một liên kết trung gian qua một message broker. Với sự tham gia của message broker thì producer sẽ không hề biết consumer. Nó chỉ việc gửi message đến các queue trong message broker. Consumer chỉ việc đăng ký nhận message từ các queue này. </p>
<p>Tất nhiên, có thể có một giải pháp là sử dụng database để lưu các message trong các temporary table. Tuy nhiên xét về hiệu năng thì không thể bằng message broker vì một số lý do: Tần xuất trao đổi message cao sẽ làm tăng load của database, giảm performance đáng kể. Trong môi trường multithread, database cần có cơ chế lock. Lock cũng làm giảm performance. Sử dụng message broker sẽ không có vấn đề này.</p>
<p>Vì producer nói chuyện với consumer trung gian qua message broker nên dù producer và consumer có khác biệt nhau về ngôn ngữ thì giao tiếp vẫn thành công. Dù viết bằng java, python, php hay ruby... thì chỉ cần thỏa mãn giao thức với message broker thì thông suốt hết. HIện nay, rabbitmq cũng đã cung cấp client library cho khá nhiều các ngôn ngữ rồi. Tính năng này cho phép tích hợp hệ thống linh hoạt.</p>
<p>Một đặc tính của rabbitmq là asynchronous. Producer không thể biết khi nào message đến được consumer hay khi nào message được consumer xử lý xong. Đối với producer, đẩy message đến message broker là xong việc. Consumer sẽ lấy message về khi nó muốn. Đặc tính này có thể được tận dụng để xây dựng các hệ thống lưu trữ và xử lý log. ELK stack - Elasticsearch Logstash Kibana là một ví dụ. Đây là hệ thống được sử dụng trong môi trường DevOps khá hiệu quả. Giải quyết bài toán chia sẻ log của ứng dụng cho dev. Log được đẩy vào message broker rồi qua logstash lưu trữ vào elastic để đánh index. Sau đó index được kibana (một web interface) sử dụng để thực hiện truy vấn và hiển thị kết quả</p>
<p><a class="fluidbox fluidbox__instance-1 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/Screenshot%20from%202015-05-29%2000%3A23%3A51.png_j7u77yz8l5"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/Screenshot%20from%202015-05-29%2000%3A23%3A51.png_j7u77yz8l5" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 353px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p>Bản thân redis cũng có thể đảm nhận vai trò của message broker ( Dù cho mục đích ban đầu của nó không phải vậy. Đây là tính năng mở rộng sau này của redis ) Mô hình trên bạn có thể hoàn toàn thay redis queue bằng rabbitmq.</p>
<p>Bên cạnh các lợi ích kể trên, rabbitmq còn có nhiều tính năng thú vị khác như:</p>
<ul class="ui list">
<li>cluster: các bạn có thể gom nhiều rabbitmq instance vào một cluster. Một queue được đinh nghĩa trên một instance khi đó đều có thể truy xuất từ các instance còn lại. Có thể tận dụng để làm load balancing (tuy rằng có hạn chế, tôi sẽ nói sau)</li>
<li>high availibilty: cho phép failover khi sử dụng mirror queue.</li>
<li>reliability: có cơ chế ack để đảm bảo message được nhận bởi consumer đã được xử lý.</li>
</ul>
<span id="toc-m-h-nh"></span><h1 class="ui dividing header">Mô hình</h1>
<p><a class="fluidbox fluidbox__instance-2 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/Screenshot%20from%202015-05-24%2022%3A07%3A35.png_syxcagcxq7"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/Screenshot%20from%202015-05-24%2022%3A07%3A35.png_syxcagcxq7" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 664px; height: 173px; top: 0px; left: 0px;"></div></div></a><a></a></p>
<p>Có thể hiểu message broker gần như bưu điện. Site A theo cách gọi của rabbitmq là producer (người gửi thông điệp). Site B và Site C theo cách gọi của rabbitmq là consumer (người nhận thông điệp). Producer connect đến message broker để đẩy message. Message sẽ đi qua message broker để đến được consumer. Cấu trúc của message broker chỉ gồm hai phần exchange và queue. </p>
<p>Exchange có nhiều loại. Trong hình vẽ trên exchange type là fanout. Lựa chọn các exchange type khác nhau sẽ dẫn đến khác đối xử khác nhau của message broker với thông điệp nhận được từ producer. Exchange được bind (liên kêt) đến một số queue nhất định.  Với exchange type là fanout, message sẽ được broadcast đến các queue được bind với exchange. Consumer sẽ connect đến message broker để lấy message từ các queue.</p>
<span id="toc-c-i-t-v-c-u-h-nh-c-b-n"></span><h1 class="ui dividing header">Cài đặt và cấu hình cơ bản</h1>
<p>Các bạn có thể tham khảo hướng dẫn trực tiếp từ trang chủ của rabbitmq:<br>
<a href="https://www.rabbitmq.com/install-rpm.html">https://www.rabbitmq.com/install-rpm.html</a></p>
<p>Vì rabbitmq được lập trình bằng erlang nên bạn cần cài đặt erlang trước. Tôi cài đặt erlang từ epel repo:</p>
<pre><code class="ui segment hljs sql">wget http://download.fedoraproject.org/pub/epel/6/i386/epel-<span class="hljs-operator"><span class="hljs-keyword">release</span>-<span class="hljs-number">6</span>-<span class="hljs-number">8.</span>noarch.rpm
rpm -ivh epel-<span class="hljs-keyword">release</span>-<span class="hljs-number">6</span>-<span class="hljs-number">8.</span>noarch.rpm
yum <span class="hljs-keyword">install</span> <span class="hljs-comment">--enablerepo=epel erlang</span>
</span></code></pre>
<p>Sau đó, tôi cài tiếp rabbitmq:</p>
<pre><code class="ui segment hljs groovy">wget <span class="hljs-string">https:</span><span class="hljs-comment">//www.rabbitmq.com/releases/rabbitmq-server/v3.5.2/rabbitmq-server-3.5.2-1.noarch.rpm</span>
rpm --<span class="hljs-keyword">import</span> <span class="hljs-string">https:</span><span class="hljs-comment">//www.rabbitmq.com/rabbitmq-signing-key-public.asc</span>
rpm -ivh rabbitmq-server-<span class="hljs-number">3.5</span><span class="hljs-number">.2</span>-<span class="hljs-number">1.</span>noarch.rpm
</code></pre>
<p>VIệc cài đặt đến đây là xong. Bạn có thể start thử service của rabbitmq bằng cách:<br>
<code>service rabbitmq-server start</code></p>
<p>Cấu hình mẫu của rabbitmq đi kèm gói cài đặt nằm ở:<br>
/usr/share/doc/rabbitmq-server-3.5.2/<br>
Tôi copy về khu vực đặt file cấu hình của rabbitmq rồi đổi tên:</p>
<pre><code class="ui segment hljs gradle">cp <span class="hljs-regexp">/usr/</span>share<span class="hljs-regexp">/doc/</span>rabbitmq-server-<span class="hljs-number">3.5</span>.<span class="hljs-number">2</span><span class="hljs-regexp">/rabbitmq.config.example /</span>etc<span class="hljs-regexp">/rabbitmq/</span>
mv <span class="hljs-regexp">/etc/</span>rabbitmq<span class="hljs-regexp">/rabbitmq.config.example  /</span>etc<span class="hljs-regexp">/rabbitmq/</span>rabbitmq.config
</code></pre>
<p>Cấu hình của rabbitmq mặc định chạy khá ổn. Các bạn có thể sử dụng luôn mà không cần bận tâm tùy chỉnh cấu hình. </p>
<span id="toc-c-i-t-management-plugin"></span><h1 class="ui dividing header">Cài đặt  management plugin</h1>
<p>Rabbitmq có đi kèm một plugin cho phép quản trị hoạt động qua một web interface trông rất trực quan và thân thiện. Nhưng mặc định, plugin này không được enable. Để enable, bạn thực hiện lệnh sau:</p>
<pre><code class="ui segment hljs ">rabbitmq-plugins enable rabbitmq_management
</code></pre>
<p>Tất cả các hoạt động quản trị qua web cũng có thể thực hiện qua một command line tool có tên là rabbitmqadmin. Tool này đi kèm trong management plugin. Bạn cũng chỉ có thể sử dụng nó sau khi đã enable management plugin. </p>
<p>Cách download rabbitmqadmin tool:</p>
<p>Tôi cài đặt rabbitmq trên một server có ip 192.168.3.252 nên địa chỉ download sẽ là:</p>
<pre><code class="ui segment hljs groovy"><span class="hljs-string">http:</span><span class="hljs-comment">//192.168.3.252:15672/cli/rabbitmqadmin</span>
</code></pre>
<p>Cách sử dụng tool này trong các tình huống cụ thể sẽ nằm trong các phần tới.</p>
</section>'),

-- Tìm hiểu RabbitMQ - Phần 2 --
(11, 
N'Tìm hiểu RabbitMQ - Phần 2', 
'tim-hieu-ve-rabbit-mq-phan-2', 
N'Trong phần 1, tôi đã giới thiệu về sơ lược rabbitmq, vai trò của rabbitmq trong hệ thống phân tán và hướng dẫn cài đặt. Trong phần này, tôi sẽ trình bày cách về cluster và cấu hình cluster trong rabbitmq', 
'2015/09/06 08:56:00', 
4, 
2, 
1, 
'rabbitmq.jpg',
N'<section id="content" class="ui pilled segment md" ng-non-bindable="">
<p>Trong phần 1, tôi đã giới thiệu về sơ lược rabbitmq, vai trò của rabbitmq trong hệ thống phân tán và hướng dẫn cài đặt. Trong phần này, tôi sẽ trình bày cách về cluster và cấu hình cluster trong rabbitmq</p>
<span id="toc-cluster-l-g-"></span><h1 class="ui dividing header">Cluster là gì</h1>
<p>Cluster là nhóm các thành phần mà hoạt động cùng với nhau để cung cấp một dịch vụ nào đó. Thành phần ở đây gọi là một node. Mỗi node này là một process hoạt động. Thường thì node được đồng nhất với một server do mỗi node thường được cài đặt trên một server riêng rẽ ( để tránh bị chết chùm ). Khái niệm cluster này xuất hiện trong rất nhiều kiến trúc như galera, mysql, redis... Mục đích sử dụng cluster là để load balancing, high availibility (đảm bảo hệ thống vẫn hoạt động khi có sự cố), scale hệ thống. </p>
<span id="toc-cluster-trong-rabbitmq"></span><h1 class="ui dividing header">Cluster trong rabbitmq</h1>
<p>Trong rabbitmq, một cluster là một nhóm các erlang node làm việc cùng với nhau. Mỗi erlang node có một rabbitmq application hoạt động và cùng chia sẻ tài nguyên: user, vhost, queue, exchange...</p>
<p><a class="fluidbox fluidbox__instance-1 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/Screenshot%20from%202015-06-01%2023%3A26%3A39.png_w0mj6sxzay"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/Screenshot%20from%202015-06-01%2023%3A26%3A39.png_w0mj6sxzay" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 513px; height: 362px; top: 0px; left: 75.7031px;"></div></div></a><a></a></p>
<span id="toc-m-t-s-c-i-m-c-n-ch-"></span><h1 class="ui dividing header">Một số đặc điểm cần chú ý</h1>
<ul class="ui list">
<li>Metadata của một node được replicate đến các node còn lại trong cluster ngoại trừ queue. Queue được tạo ra trên node nào thì vẫn nằm trên node đó, không có replicate gì hết nhưng bạn hoàn toàn có thể nhìn thấy một queue tạo ra trên một node khi truy xuất qua các node còn lại do đó đối với client một cluster rabbitmq chẳng khác gì một single rabbitmq. </li>
<li> Vì queue không được replicate nên bản thân cluster rabbitmq chưa cung cấp high availibility (HA). Bạn vẫn cần cấu hình thêm chút nữa nhưng cluster là tiền đề để rabbitmq có thể thực hiện được HA.</li>
<li>Một node có thể là disc node (mặc định) hoặc ram node</li>
<li>Như trong tài liệu của rabbitmq có khẳng định, rabbitmq không xử lý tốt network partition nên không khuyến khích sử dụng cluster của rabbitmq trên WAN. Có thể bạn sẽ thắc mắc network partition là gì ? Một network partition hay còn gọi là split brain là tình huống rất hay gặp trong hệ cluster. </li>
</ul>
<p><a class="fluidbox fluidbox__instance-2 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/Screenshot%20from%202015-06-01%2023%3A29%3A21.png_bwnuenk169"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/Screenshot%20from%202015-06-01%2023%3A29%3A21.png_bwnuenk169" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 371px; height: 398px; top: 0px; left: 146.703px;"></div></div></a><a></a></p>
<p>Khi network partition xảy ra, hệ cluster bị chia đôi và mỗi phần không thể liên lạc được với phần còn lại nên đâm ra bản thân từng partition lại cứ ngỡ nó là toàn bộ cluster. Vấn đề chính là ở đây. Mỗi partition khi đó sẽ không đồng bộ được với phần còn lại nên chúng ta sẽ có hai tập dữ liệu riêng biệt trên mỗi partition. Nguyên do dẫn đến network partition thường là network không ổn định hoặc quá tải trên node (Khi quá tải do CPU hoặc IO bị nghẽn network của server thường rất chập chờn ). LAN network so với WAN network thì thường ổn định hơn nhiều nên rabbitmq cluster thích hợp khi các node được liên kết với nhau qua LAN network. Về network partition, tôi sẽ trình bày trong một phần khác.</p>
<ul class="ui list">
<li>Clustering rabbitmq chỉ là một trong ba cách cấu hình hệ phân tán rabbitmq. Clustering phù hợp cho môi trường LAN network còn với môi trường WAN network thì các mô hình như federation hay shovel lại được khuyến khích. Trong trường hợp của tôi, tôi không sử dụng rabbitmq trong môi trường WAN nên hai mô hình shovel và federation tôi không trình bày.</li>
</ul>
<span id="toc--i-u-ki-n-thi-t-l-p-clustering"></span><h1 class="ui dividing header">Điều kiện để thiết lập clustering</h1>
<ul class="ui list">
<li>Tất cả các node phải cùng erlang version và rabbitmq version</li>
<li>Các node liên kết qua LAN network</li>
<li>Tất cả các node chia sẻ cùng một erlang cookie</li>
</ul>
<p><em>Trong mô hình cluster, các node sử dụng phương thức trao đổi giữa của erlang. Khi sử dụng phương thức này, hai erlang node chỉ nói chuyện được với nhau khi có cùng erlang cookie. Erlang cookie chỉ là một chuỗi ký tự. Khi startup một rabbitmq server lần đầu tiên, mặc định một erlang cookie ngẫu nhiên được sinh ra nằm trong <code>/var/lib/rabbitmq/.erlang.cookie</code></em></p>
<span id="toc-l-m-vi-c-v-i-cluster"></span><h1 class="ui dividing header">Làm viêc với cluster</h1>
<span id="toc-th-c-hi-n-t-o-cluster"></span><h3 class="ui dividing header">Thực hiện tạo cluster</h3>
<p>Chuẩn bị ba rabbitmq server thỏa mãn đủ điều kiện. </p>
<p>Đầu tiên, chúng ta cần chọn một node, sau đó copy erlang cookie của node đó sang các node còn lại.</p>
<p>Vì node name của rabbitmq có dạng <code>rabbit@hostname</code> nên bạn cần chuẩn bị sẵn hostname cho mỗi node. Hostname là bất cứ string nào bạn muốn nhưng tốt nhất đừng sử dụng các ký tự đặc biệt trong này. Sau đó đưa vào <code>/etc/hosts</code> của cả ba node:</p>
<pre><code class="ui segment hljs bash"><span class="hljs-number">192.168</span>.<span class="hljs-number">3.241</span> rabbit1  <span class="hljs-comment">### gọi là node 1</span>
<span class="hljs-number">192.168</span>.<span class="hljs-number">3.242</span> rabbit2  <span class="hljs-comment">### gọi là node 2</span>
<span class="hljs-number">192.168</span>.<span class="hljs-number">3.252</span> rabbit3  <span class="hljs-comment">### gọi là node 3</span>
</code></pre>
<p>Như bạn thấy, tôi lựa chọn cách đặt tên an toàn để tránh rắc rối.</p>
<p><strong>Bước 1:</strong><br>
Khởi động rabbitmq-server trên mỗi node.<br>
Trên mỗi node, bạn có thể chạy</p>
<p><code>service rabbitmq-server start</code><br>
hoặc<br>
<code>rabbitmq-server -detached</code></p>
<p>Trong cách thứ hai, bạn có thể sẽ gặp một warning:<br>
<strong>Warning: PID file not written; -detached was passed.</strong><br>
Đừng quá lo lắng. Trong manual của rabbitmq-server có cho biết khi chạy với tham số -detached server process sẽ hoạt động ở chế độ background và điều đó khiến cho pid của process không được ghi vào pid file.</p>
<p><strong>Bước 2:</strong><br>
Chọn một node làm khởi điểm sau đó các node còn lại sẽ join với node khởi điểm để hình thành lên cluster.</p>
<p>Trước khi thực hiện, chúng ta thử xem cluster status của từng node trước khi join với nhau. Trên mỗi node, bạn thực hiện lệnh<br>
<code>rabbitmqctl cluster_status</code></p>
<p>Và đây là kết quả:</p>
<p>Trên rabbit@rabbit1</p>
<pre><code class="ui segment hljs r">Cluster status of node rabbit@rabbit1 <span class="hljs-keyword">...</span>
[{nodes,[{disc,[rabbit@rabbit1]}]}]
</code></pre>
<p>Trên rabbit@rabbit2</p>
<pre><code class="ui segment hljs r">Cluster status of node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[{nodes,[{disc,[rabbit@rabbit2]}]}]
</code></pre>
<p>Trên rabbit@rabbit3</p>
<pre><code class="ui segment hljs r">Cluster status of node rabbit@rabbit3 <span class="hljs-keyword">...</span>
[{nodes,[{disc,[rabbit@rabbit3]}]}]
</code></pre>
<p>Có thể thấy mỗi node đang là một cluster riêng biệt. Tôi sẽ phải gom cả ba node này để hình thành một cluster duy nhất.</p>
<p>Giả sử, tôi chọn node rabbit@rabbit2 làm node khởi điểm. Với vai trò node khởi điểm, node rabbit@rabbit2 sẽ không cần cấu hình gì thêm.</p>
<p>Đảm bảo node 2 đang chạy</p>
<pre><code class="ui segment hljs r">[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl start_app</span>
Starting node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl cluster_status</span>
Cluster status of node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[{nodes,[{disc,[rabbit@rabbit2]}]},
 {running_nodes,[rabbit@rabbit2]},
 {cluster_name,&lt;&lt;<span class="hljs-string">"rabbit@rabbit2"</span>&gt;&gt;},
 {partitions,[]}]

</code></pre>
<p>Tôi cần join node 1 với node 2</p>
<pre><code class="ui segment hljs r">[root@rabbit1 ~]<span class="hljs-comment"># rabbitmqctl stop_app</span>
Stopping node rabbit@rabbit1 <span class="hljs-keyword">...</span>
[root@rabbit1 ~]<span class="hljs-comment"># rabbitmqctl join_cluster rabbit@rabbit2</span>
Clustering node rabbit@rabbit1 with rabbit@rabbit2 <span class="hljs-keyword">...</span>
[root@rabbit1 ~]<span class="hljs-comment"># rabbitmqctl start_app</span>
Starting node rabbit@rabbit1 <span class="hljs-keyword">...</span>
</code></pre>
<p>Làm tương tự với node 3</p>
<pre><code class="ui segment hljs r">[root@rabbit3 ~]<span class="hljs-comment"># rabbitmqctl stop_app</span>
Stopping node rabbit@rabbit3 <span class="hljs-keyword">...</span>
[root@rabbit3 ~]<span class="hljs-comment"># rabbitmqctl join_cluster rabbit@rabbit2</span>
Clustering node rabbit@rabbit3 with rabbit@rabbit2 <span class="hljs-keyword">...</span>
[root@rabbit3 ~]<span class="hljs-comment"># rabbitmqctl start_app</span>
Starting node rabbit@rabbit3 <span class="hljs-keyword">...</span>
</code></pre>
<p><strong>Bước 3:</strong><br>
Xem cluster status trên mỗi node.</p>
<p>Trên node 1</p>
<pre><code class="ui segment hljs ruby">[root<span class="hljs-variable">@rabbit1</span> ~]<span class="hljs-comment"># rabbitmqctl cluster_status</span>
<span class="hljs-constant">Cluster</span> status of node rabbit<span class="hljs-variable">@rabbit1</span> ...
[{nodes,[{disc,[rabbit<span class="hljs-variable">@rabbit1</span>,rabbit<span class="hljs-variable">@rabbit2</span>,rabbit<span class="hljs-variable">@rabbit3</span>]}]},
 {running_nodes,[rabbit<span class="hljs-variable">@rabbit2</span>,rabbit<span class="hljs-variable">@rabbit3</span>,rabbit<span class="hljs-variable">@rabbit1</span>]},
 {cluster_name,&lt;&lt;<span class="hljs-string">"rabbit@rabbit2"</span><span class="hljs-prompt">&gt;&gt;</span>},
 {partitions,[]}]
</code></pre>
<p>Trên node 2</p>
<pre><code class="ui segment hljs ruby">[root<span class="hljs-variable">@rabbit2</span> ~]<span class="hljs-comment"># rabbitmqctl cluster_status</span>
<span class="hljs-constant">Cluster</span> status of node rabbit<span class="hljs-variable">@rabbit2</span> ...
[{nodes,[{disc,[rabbit<span class="hljs-variable">@rabbit1</span>,rabbit<span class="hljs-variable">@rabbit2</span>,rabbit<span class="hljs-variable">@rabbit3</span>]}]},
 {running_nodes,[rabbit<span class="hljs-variable">@rabbit1</span>,rabbit<span class="hljs-variable">@rabbit3</span>,rabbit<span class="hljs-variable">@rabbit2</span>]},
 {cluster_name,&lt;&lt;<span class="hljs-string">"rabbit@rabbit2"</span><span class="hljs-prompt">&gt;&gt;</span>},
 {partitions,[]}]

</code></pre>
<p>Trên node 3</p>
<pre><code class="ui segment hljs ruby">[root<span class="hljs-variable">@rabbit3</span> ~]<span class="hljs-comment"># rabbitmqctl cluster_status</span>
<span class="hljs-constant">Cluster</span> status of node rabbit<span class="hljs-variable">@rabbit3</span> ...
[{nodes,[{disc,[rabbit<span class="hljs-variable">@rabbit1</span>,rabbit<span class="hljs-variable">@rabbit2</span>,rabbit<span class="hljs-variable">@rabbit3</span>]}]},
 {running_nodes,[rabbit<span class="hljs-variable">@rabbit1</span>,rabbit<span class="hljs-variable">@rabbit2</span>,rabbit<span class="hljs-variable">@rabbit3</span>]},
 {cluster_name,&lt;&lt;<span class="hljs-string">"rabbit@rabbit2"</span><span class="hljs-prompt">&gt;&gt;</span>},
 {partitions,[]}]
</code></pre>
<p>Bạn có thể cấu hình cluster trong config. Trên mỗi node, bạn chỉ cần khai báo dòng sau trong /etc/rabbitmq/rabbitmq.config</p>
<pre><code class="ui segment hljs scala">{cluster_nodes, {[<span class="hljs-symbol">\'rabbit</span><span class="hljs-annotation">@rabbit</span>1\',<span class="hljs-symbol">\'rabbit</span><span class="hljs-annotation">@rabbit</span>2\',<span class="hljs-symbol">\'rabbit</span><span class="hljs-annotation">@rabbit</span>3\'], disc}}
</code></pre>
<p><strong>Nhận xét:</strong><br>
Có thể thấy tất cả các node đã nhìn thấy nhau. Tất cả đều là disc node (mặc định). Tất cả các node đều đang running. Cluster_name được lấy theo node name của node khởi điểm và không có một partition nào trong cluster.</p>
<p><em>Một node trong cluster có thể bị stop/start (dùng rabbitmqctl stop_app/rabbitmqctl start_app trên chính node đó) đồng nghĩa ngừng cung cấp dịch vụ trong cluster nhưng bản thân node đó vẫn không bị loại khỏi cluster</em></p>
<span id="toc-th-c-hi-n-restart-cluster"></span><h3 class="ui dividing header">Thực hiện restart cluster</h3>
<p>Chúng ta sẽ restart lần lượt từng node.</p>
<p>Giả sử tôi thực hiện restart theo thứ tự sau:<br>
stop node 3 -&gt; stop node 1 -&gt; start node 3 -&gt; start node 1. Node 2 vẫn giữ hoạt động để đảm bảo dịch vụ không down. </p>
<p>Stop node 3, node 1</p>
<p>Trên node 3:</p>
<pre><code class="ui segment hljs r">[root@rabbit3 ~]<span class="hljs-comment">#  rabbitmqctl stop</span>
Stopping and halting node rabbit@rabbit3 <span class="hljs-keyword">...</span>
</code></pre>
<p><em>Bạn có thể dùng <code>service rabbitmq-server stop</code> thay cho <code>rabbitmqctl top</code></em></p>
<p>Trên node 1:</p>
<pre><code class="ui segment hljs sql">[root@rabbit1 ~]# service rabbitmq-server <span class="hljs-operator"><span class="hljs-keyword">stop</span>
Stopping rabbitmq-<span class="hljs-keyword">server</span>: rabbitmq-<span class="hljs-keyword">server</span>.
</span></code></pre>
<p>Xem cluster status trên node 2:</p>
<pre><code class="ui segment hljs r">[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl cluster_status</span>
Cluster status of node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[{nodes,[{disc,[rabbit@rabbit1,rabbit@rabbit2,rabbit@rabbit3]}]},
 {running_nodes,[rabbit@rabbit2]},
 {cluster_name,&lt;&lt;<span class="hljs-string">"rabbit@rabbit2"</span>&gt;&gt;},
 {partitions,[]}]
</code></pre>
<p>Chỉ còn một mình node 2 đang hoạt động</p>
<p>Start node 3, node 1</p>
<p>Trên node 3:</p>
<pre><code class="ui segment hljs sql">[root@rabbit3 ~]# service rabbitmq-server <span class="hljs-operator"><span class="hljs-keyword">start</span>
<span class="hljs-keyword">Starting</span> rabbitmq-<span class="hljs-keyword">server</span>: SUCCESS
rabbitmq-<span class="hljs-keyword">server</span>.
</span></code></pre>
<p>Trên node 1:</p>
<pre><code class="ui segment hljs sql">[root@rabbit1 ~]# service rabbitmq-server <span class="hljs-operator"><span class="hljs-keyword">start</span>
<span class="hljs-keyword">Starting</span> rabbitmq-<span class="hljs-keyword">server</span>: SUCCESS
rabbitmq-<span class="hljs-keyword">server</span>.
</span></code></pre>
<p>Xem cluster status trên node 2:</p>
<pre><code class="ui segment hljs ruby">[root<span class="hljs-variable">@rabbit2</span> root]<span class="hljs-comment"># rabbitmqctl cluster_status</span>
<span class="hljs-constant">Cluster</span> status of node rabbit<span class="hljs-variable">@rabbit2</span> ...
[{nodes,[{disc,[rabbit<span class="hljs-variable">@rabbit1</span>,rabbit<span class="hljs-variable">@rabbit2</span>,rabbit<span class="hljs-variable">@rabbit3</span>]}]},
 {running_nodes,[rabbit<span class="hljs-variable">@rabbit1</span>,rabbit<span class="hljs-variable">@rabbit3</span>,rabbit<span class="hljs-variable">@rabbit2</span>]},
 {cluster_name,&lt;&lt;<span class="hljs-string">"rabbit@rabbit2"</span><span class="hljs-prompt">&gt;&gt;</span>},
 {partitions,[]}]

</code></pre>
<p>Như vậy, ngay sau khi được start trở lại, các node sẽ tự động tham gia vào cluster và running luôn.</p>
<p>Trong các trường hợp có sự cố nghiêm trọng như toàn bộ các node đều down lần lượt hoặc tất cả đều down đồng thời  thì quy trình start cluster lại hơi khác một chút. Chúng ta đi vào từng trường hợp một.</p>
<p><strong>Trường hợp thứ nhất:</strong> Tình huống xảy ra khi bạn cần restart cluster để upgrade cho rabbitmq hoặc erlang. Sau khi node 1, node 2 được bạn stop thì thảm họa xảy ra với node còn lại. Node còn lại bị down ngoài ý muốn. Trong trường hợp này việc khởi động lại cluster đòi hỏi thứ tự: Node cuối cùng bị down phải là node đầu tiên được start. Giả sử các node bị down theo thứ tự: node 3 -&gt; node 1 -&gt; node 2. Sau đó tôi cố gắng start các node 3 hoặc node 1 đầu tiên. Tôi sẽ không thành công. Rabbitmq để lại vài dòng log sau:</p>
<pre><code class="ui segment hljs sql">This cluster node was shut down while other nodes were still running.
To avoid losing data, you should <span class="hljs-operator"><span class="hljs-keyword">start</span> the other nodes <span class="hljs-keyword">first</span>, <span class="hljs-keyword">then</span>
<span class="hljs-keyword">start</span> this one. <span class="hljs-keyword">To</span> <span class="hljs-keyword">force</span> this node <span class="hljs-keyword">to</span> <span class="hljs-keyword">start</span>, <span class="hljs-keyword">first</span> invoke
<span class="hljs-string">"rabbitmqctl force_boot"</span>. <span class="hljs-keyword">If</span> you <span class="hljs-keyword">do</span> so, <span class="hljs-keyword">any</span> changes made <span class="hljs-keyword">on</span> other
cluster nodes <span class="hljs-keyword">after</span> this one was shut down may be lost.
</span></code></pre>
<p>Để khởi động được cluster, bạn chỉ cần tuân theo nguyên tắc, start node 2 đầu tiên. Với các node sau, thứ tự không quan trọng. Bạn có thể dùng thứ tự node 2 - &gt; node 1  -&gt; node 3 hoặc node2 -&gt; node 3 -&gt; node1.</p>
<p><strong>Trường hợp thứ hai:</strong> Cũng giống trường hợp một nhưng đáng tiếc là node 2 bị sự cố quá nghiêm trọng không thể phục hồi được. Vậy là node cuối cùng không thể boot được. Lúc này bạn phải ép một node không phải node down cuối cùng làm node khởi điểm</p>
<pre><code class="ui segment hljs r">[root@rabbit1 root]<span class="hljs-comment"># rabbitmqctl force_boot</span>
Forcing boot <span class="hljs-keyword">for</span> Mnesia dir /var/lib/rabbitmq/mnesia/rabbit@rabbit1 <span class="hljs-keyword">...</span>
[root@rabbit1 root]<span class="hljs-comment"># service rabbitmq-server start</span>
Starting rabbitmq-server: SUCCESS
rabbitmq-server.
</code></pre>
<p>Sau đó bạn khởi động lại các node kế tiếp. </p>
<p><strong>Trường hợp thứ ba:</strong> Khủng khiếp hơn ! Bạn chẳng làm gì nhưng cụm server mà chứa rabbitmq cluster bị crash đột ngột. Lúc này thì bạn chẳng thể biết node nào down trước hay down sau cả. Cách xử lý giống hệt trường hợp thứ hai</p>
<span id="toc-r-i-m-t-node-kh-i-cluster"></span><h3 class="ui dividing header">Rời một node khỏi cluster</h3>
<p><strong>Cách 1:</strong> Để cho bản thân node đó quên rằng nó đã từng ở trong cluster. Giả sử tôi muốn tách node 2 khỏi cluster hoàn toàn.</p>
<pre><code class="ui segment hljs r">[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl stop_app                                                                                                      </span>
Stopping node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl reset</span>
Resetting node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl start_app</span>
Starting node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl cluster_status</span>
Cluster status of node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[{nodes,[{disc,[rabbit@rabbit2]}]},
 {running_nodes,[rabbit@rabbit2]},
 {cluster_name,&lt;&lt;<span class="hljs-string">"rabbit@rabbit2"</span>&gt;&gt;},
 {partitions,[]}]
</code></pre>
<p>Để reset thành công, bạn không được config cluster trong file cấu hình.<br>
Reset đồng thời sẽ xóa mọi data của node 2 như vhost, user, exchange, queue...</p>
<p><strong>Cách 2:</strong> Làm cho các node còn lại trong cluster hắt hủi node cần được tách khỏi cluster :(</p>
<p>[root@rabbit2 root]# rabbitmqctl stop_app<br>
Stopping node rabbit@rabbit2 ...</p>
<p>[root@rabbit3 root]# rabbitmqctl forget_cluster_node rabbit@rabbit2<br>
Removing node rabbit@rabbit2 from cluster ...</p>
<p>Lúc này các node còn lại trong cluster đều đã không coi node 2 nằm trong cluster nhưng node2 vẫn không chịu chấp nhận thực tế phũ phàng đó. Nếu bạn start_app node 2</p>
<pre><code class="ui segment hljs perl">Error: {error,{inconsistent_cluster,<span class="hljs-string">"Node rabbit<span class="hljs-variable">@rabbit2</span> thinks it\'s clustered with node rabbit<span class="hljs-variable">@rabbit3</span>, but rabbit<span class="hljs-variable">@rabbit3</span> disagrees"</span>}}
</code></pre>
<p>Để node 2 hoạt động được bình thường, bạn phải làm nó quên đi nó từng thuộc về cluster.</p>
<pre><code class="ui segment hljs r">[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl reset</span>
Resetting node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl start_app</span>
Starting node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl cluster_status</span>
Cluster status of node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[{nodes,[{disc,[rabbit@rabbit2]}]},
 {running_nodes,[rabbit@rabbit2]},
 {cluster_name,&lt;&lt;<span class="hljs-string">"rabbit@rabbit2"</span>&gt;&gt;},
 {partitions,[]}]
</code></pre>
<span id="toc-th-m-m-t-node-v-o-cluster"></span><h3 class="ui dividing header">Thêm một node vào cluster</h3>
<pre><code class="ui segment hljs r">[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl stop_app</span>
Stopping node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl join_cluster rabbit@rabbit3</span>
Clustering node rabbit@rabbit2 with rabbit@rabbit3 <span class="hljs-keyword">...</span>
[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl start_app</span>
Starting node rabbit@rabbit2 <span class="hljs-keyword">...</span>
root@rabbit2 roorabbitmqctl cluster_status
Cluster status of node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[{nodes,[{disc,[rabbit@rabbit1,rabbit@rabbit2,rabbit@rabbit3]}]},
 {running_nodes,[rabbit@rabbit1,rabbit@rabbit3,rabbit@rabbit2]},
 {cluster_name,&lt;&lt;<span class="hljs-string">"rabbit@rabbit2"</span>&gt;&gt;},
 {partitions,[]}]
</code></pre>
<p>Nếu cố join_cluster từ một running node, bạn sẽ gặp:</p>
<pre><code class="ui segment hljs http"><span class="hljs-attribute">Error</span>: <span class="hljs-string">mnesia_unexpectedly_running</span>
</code></pre>
<span id="toc-th-m-m-t-ram-node"></span><h3 class="ui dividing header">Thêm một RAM node</h3>
<p><strong>So sánh RAM node với disc node</strong><br>
Sự khác biệt lớn nhất là ram node chỉ giữ metadata của nó trong memory còn bản thân các queue data vẫn lưu xuống disk. Sự khác biệt này cho phép ram node ít tạo ra các hoạt động IO hơn nên performance tốt hơn disc node. Một cluster hoàn toàn chỉ có ram node thì rất có nguy cơ mất metadata. Giải pháp an toàn hơn cả là trộn lẫn ram node và disc node. Trong cluster, phần metadata được replicate giữa các node (disc node lưu metadata trên disk) nên sẽ không lo mất sạch metadata.</p>
<pre><code class="ui segment hljs r">[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl stop_app</span>
Stopping node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl join_cluster --ram rabbit@rabbit3</span>
Clustering node rabbit@rabbit2 with rabbit@rabbit3 <span class="hljs-keyword">...</span>
[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl start_app</span>
Starting node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl cluster_status</span>
Cluster status of node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[{nodes,[{disc,[rabbit@rabbit3,rabbit@rabbit1]},{ram,[rabbit@rabbit2]}]},
 {running_nodes,[rabbit@rabbit1,rabbit@rabbit3,rabbit@rabbit2]},
 {cluster_name,&lt;&lt;<span class="hljs-string">"rabbit@rabbit2"</span>&gt;&gt;},
 {partitions,[]}]
</code></pre>
<span id="toc-thay-i-node-type"></span><h3 class="ui dividing header">Thay đổi node type</h3>
<pre><code class="ui segment hljs r">[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl stop_app</span>
Stopping node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl change_cluster_node_type disc</span>
Turning rabbit@rabbit2 into a disc node <span class="hljs-keyword">...</span>
[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl start_app</span>
Starting node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl cluster_status</span>
Cluster status of node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[{nodes,[{disc,[rabbit@rabbit1,rabbit@rabbit2,rabbit@rabbit3]}]},
 {running_nodes,[rabbit@rabbit1,rabbit@rabbit3,rabbit@rabbit2]},
 {cluster_name,&lt;&lt;<span class="hljs-string">"rabbit@rabbit2"</span>&gt;&gt;},
 {partitions,[]}]
[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl stop_app</span>
Stopping node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl change_cluster_node_type ram</span>
Turning rabbit@rabbit2 into a ram node <span class="hljs-keyword">...</span>
[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl start_app</span>
Starting node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[root@rabbit2 root]<span class="hljs-comment"># rabbitmqctl cluster_status</span>
Cluster status of node rabbit@rabbit2 <span class="hljs-keyword">...</span>
[{nodes,[{disc,[rabbit@rabbit3,rabbit@rabbit1]},{ram,[rabbit@rabbit2]}]},
 {running_nodes,[rabbit@rabbit1,rabbit@rabbit3,rabbit@rabbit2]},
 {cluster_name,&lt;&lt;<span class="hljs-string">"rabbit@rabbit2"</span>&gt;&gt;},
 {partitions,[]}]
</code></pre>
<span id="toc-m-h-nh-load-balancing-v-i-rabbitmq-cluster"></span><h1 class="ui dividing header">Mô hình load balancing với rabbitmq cluster</h1>
<p><a class="fluidbox fluidbox__instance-3 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/Screenshot%20from%202015-06-04%2012%3A07%3A05.png_sickk69b9b"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/Screenshot%20from%202015-06-04%2012%3A07%3A05.png_sickk69b9b" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 470px; height: 274px; top: 0px; left: 97.2031px;"></div></div></a><a></a></p>
<p>Nếu bạn cấu hình HA queue, queue data giữa các node sẽ được đồng bộ (Trong phần tới tôi sẽ trình bày cách cấu hinh HA cho queue). Nghe có vẻ rất giống mysql replication phải không. Nhưng thực tế  thì không giống vậy. Trong hệ rabbitmq cluster, khi áp dụng HA policy, một queue sẽ có master và các slave. Queue được tạo ra trên node nào thì queue đó sẽ là master các replicate của queue đó trên các node còn lại sẽ là slave queue. Tính chất master-slave không áp dụng trên cụ thể một node mà trên cụ thể một queue. Một node có thể  là  master với  queue này nhưng lại là slave với queue khác. Điểm thú vị là request đến queue đi từ client qua load balancer sẽ được chuyển hướng đến node mà chứa master queue</p>
<p>Xem hình minh họa ở dưới</p>
<p><a class="fluidbox fluidbox__instance-4 fluidbox--initialized fluidbox--closed fluidbox--ready" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/Screenshot%20from%202015-06-04%2012%3A25%3A47.png_125uaz66w"><div class="fluidbox__wrap" style="z-index: 990;"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/Screenshot%20from%202015-06-04%2012%3A25%3A47.png_125uaz66w" alt="alt text" class="fluidbox__thumb" style="opacity: 1;"><div class="fluidbox__ghost" style="width: 465px; height: 455px; top: 0px; left: 99.7031px;"></div></div></a><a></a></p>
<p>Master queue nằm trên node 2 (nơi queue đó được tạo ra). Request từ client đến queue đó đi qua load balancer đập vào node 3 nhưng node 3 sẽ thay vì tự phục vụ luôn thì  chuyển hướng request đến node 2 (nơi chứa master queue). Vì nguyên tắc họat động này mà HA policy trên rabbitmq không giúp  chia tải trên các node được mà chỉ cho phép đảm bảo dịch vụ vẫn vận hành khi có sự cố. Khi node chứa master queue bị down, rabbitmq cluster sẽ promote node chứa slave queue có thời gian hoạt động lâu nhất lên làm master.</p>
<p>Vậy có cách nào khắc phục để chia tải giữa các node không ?</p>
<ul class="ui list">
<li>Bạn có thể tạo queue đều trên tất cả các node trong cluster do vậy các master queue sẽ trải đều trên toàn bộ cluster nên hạn
chế các extra network hop giống như trong hình minh họa. Cách này bạn vẫn có thể sử dụng load balancer để  điểm trup cập từ client được
tập trung.</li>
<li>Client có một danh sách các queue và biết được master queue nằm trên node nào để truy cập trực tiếp. Cách này
sẽ không còn cần đến load balancer nữa.</li>
</ul>
<p><strong>Vấn đề timeout</strong></p>
<p>Bản thân client sẽ luôn giữ kết nối đến rabbitmq. Sẽ không có timeout nếu như bạn kết nối trực tiếp nhưng khi qua một proxy thì vấn đề xuất hiện. Proxy sẽ không giữ kết nối liên tục giữa client và backend nên trong quá trình sử  dụng bạn có thể thấy hiện tượng client bị mất kết nối sau một quãng thời gian không sử  dụng. Đáng tiếc rabbitmq client không có cơ chế reconnect lại.</p>
<p>Một linux client có cơ chế tự động gửi lại keep-alive packet để duy trì kết nối nhưng quãng thời gian này quá lâu. <code>cat /proc/sys/net/ipv4/tcp_keepalive_time</code> trả về giá trị 7200 nghĩa là cứ sau 2 tiếng mới có một cú gửi keep-alived. Muốn proxy duy trì kết nối thì keep-alived packet phải được gửi trước khi timeout của proxy kết thúc. Trong trường hợp của tôi proxy là haproxy. Tôi điều chỉnh chút ít về cấu hình. Tôi bổ sung ba dòng sau vào cụm backend rabbitmq</p>
<pre><code class="ui segment hljs applescript"><span class="hljs-keyword">timeout</span> client  <span class="hljs-number">3</span>h
<span class="hljs-keyword">timeout</span> server  <span class="hljs-number">3</span>h
option          clitcpka
</code></pre>
<p>Kết thúc phần hai. Trong phần tới, tôi sẽ trình bày về  network partition trong rabbitmq cluster</p>
<p><strong>Nguồn tham khảo:</strong><br>
<a href="http://insidethecpu.com/2014/11/17/load-balancing-a-rabbitmq-cluster/">http://insidethecpu.com/2014/11/17/load-balancing-a-rabbitmq-cluster/</a><br>
<a href="https://stackoverflow.com/questions/10461808/how-to-load-distribution-in-rabbitmq-cluster">https://stackoverflow.com/questions/10461808/how-to-load-distribution-in-rabbitmq-cluster</a><br>
<a href="https://deviantony.wordpress.com/2014/10/30/rabbitmq-and-haproxy-a-timeout-issue/">https://deviantony.wordpress.com/2014/10/30/rabbitmq-and-haproxy-a-timeout-issue/</a></p>
</section>');