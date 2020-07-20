Create Database BlogIT;
Use BlogIT;
------------------------------------------
------------ CREATE TABLE ----------------

Create Table UserInfo
(
	userName varchar(254) primary key,
    pass tinytext,
    email varchar(254) unique,
    fullName nvarchar(50),
    postAmount int,
    avatar tinytext
);
-- TODO: Thêm bio

Create Table Post
(
	postId int auto_increment primary key,
    postTitle tinytext,
    postTime date,
    userName tinytext,
    likes int,
    seriesId int,
    postContent text
);
-- TODO: Thêm subtitle, order in series, cover

Create Table UserSeriesList
(
	seriesId int auto_increment primary key,
    userName tinytext,
    seriesName tinytext
);

Create Table PostComment
(
	commentId int auto_increment primary key,
    userName tinytext,
    postId int,
    content text,
    commentTime date,
    replyToCommentId int
);

Create Table ReportReasonList
(
	reasonId int auto_increment primary key,
    reasonContent tinytext
);

Create Table PostReport
(
	reportId int auto_increment primary key,
    userName tinytext,
    postId int,
    reasonId int,
    reportTime date
);

Create Table TagList
(
	tagId varchar(30) primary key,
    tagName nvarchar(50)
);

Create Table PostTag
(
	postId int,
    tagId varchar(30),
    
    primary key(postId, tagId)
);


------------------------------------------------------------------
--------------- INSERT DATA -----------------

Insert into Administrator value ('admin', 'admin');

Insert into UserInfo values
('minhmonmen', 'minhmonmen', 'minhmonmen@gmail.com', N'Minh Monmen', 18, '../resources/account.png'),
('hoangxuantruong', 'hoangxuantruong', 'hoangxuantruong@gmail.com', N'Hoàng Xuân Trường', 0, '../resources/account.png'),
('dainguyen', 'dainguyen', 'dainguyen@gmail.com', N'Dai Nguyen', 0, '../resources/account.png'),
('luuxuantrong', 'luuxuantrong', 'luuxuantrong@gmail.com', N'Lưu Xuân Trọng', 0, '../resources/account.png'),
('anhnc', 'anhnc', 'anhnc@gmail.com', N'Anh NC', 4, '../resources/account.png'),
('dangxuanthanh', 'dangxuanthanh', 'dangxuanthanh@gmail.com', N'Đặng Xuân Thành', 0, '../resources/account.png'),
('junookyo', 'junookyo', 'junookyo@gmail.com', N'Juno_okyo', 25, '../resources/account.png');

Insert into UserSeriesList values
(1, 'minhmonmen', N'Nghệ thuật xử lý background job');

Insert into PostComment values
(1, 'hoangxuantruong', 1, N'Hay', '2019/11/21', null),
(2, 'dainguyen', 1, N'Thank you', '2019/11/21', null),
(3, 'luuxuantrong', 2, N'Like vì 2 con dê', '2020/04/18', null),
(4, 'dangxuanthanh', 3, N'Có gì tiếc mà không kipalog cho những bài viết như thế này', '2020/04/18', null),
(5, 'dainguyen', 5, N'Ui hữu ích quá boss Tuấn ơi', '2017/01/19', null),
(6, 'junookyo', 5, N'Cảm ơn bạn', '2017/01/19', 5);

Insert into ReportReasonList values
(1, N'Nội dung không liên quan tiêu đề'),
(2, N'Nội dung nhạy cảm'),
(3, N'Ngôn từ không phù hợp');

Insert into TagList values
('til', 'TIL'),
('js', 'Javascript'),
('java', 'Java'),
('ruby', 'Ruby'),
('linux', 'Linux'),
('php', 'PHP'),
('nodejs', 'NodeJS'),
('programming', 'Programming'),
('springboot', 'Spring Boot'),
('springmvc', 'Spring MVC'),
('spring', 'Spring'),
('springsecurity', 'Spring Security'),
('swift', 'Swift'),
('git', 'Git'),
('python', 'Python'),
('ios', 'iOS'),
('reactjs', 'ReactJS'),
('mysql', 'MySQL'),
('android', 'Android'),
('backgroundjob', 'Background Job'),
('jobscheduling', 'Job Scheduling'),
('mq', 'Message Queue'),
('nowsh', 'now.sh'),
('tutorial', 'Tutorial'),
('junookyo', 'Juno_okyo'),
('web', 'Web'),
('xss', 'XSS'),
('hacking', 'Hacking'),
('security', 'Security');

Insert into PostTag values
(1, 'mq'),
(1, 'backgroundjob'),
(1, 'jobscheduling'),
(2, 'mq'),
(2, 'backgroundjob'),
(2, 'jobscheduling'),
(3, 'nowsh'),
(3, 'tutorial'),
(4, 'junookyo'),
(5, 'junookyo'),
(6, 'junookyo'),
(6, 'web'),
(6, 'xss'),
(6, 'hacking'),
(6, 'security');

Insert into Post values

-- Nghệ thuật xử lý background job --
(1, N'Nghệ thuật xử lý background job', '2019/11/21', 'minhmonmen', 82, 1,
N'<p>Đây thực chất là phần tiếp theo của câu chuyện anh chàng buôn chuối trong <a href="https://kipalog.com/posts/Background-job-va-queue-cho-nguoi-nong-dan">bài viết này</a></p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/h5z2n1nqv1_%E1%BA%A3nh.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/h5z2n1nqv1_%E1%BA%A3nh.png" alt="alt text"></a><a></a></p>
<h2>First things first</h2>
<p>Yeah, lại là mình đây, <strong>Minh Monmen</strong> trong vai trò chàng trai buôn chuối rảnh rỗi ngồi viết lách linh tinh. Sau khi thu thập được rất nhiều kinh nghiệm từ việc bán chuối bán chuối, mình tự nhận thấy một số người coi trọng những <strong>kỹ sư</strong> thực thụ hơn những con buôn trái nghề. Nên là trong lần này mình sẽ hóa thân thành 1 <strong>kỹ sư</strong> phần mềm giả trang để tìm hiểu về background job và tiếp tục câu chuyện còn dang dở lần trước ở mức độ sâu hơn.</p>
<p>Trong bài viết này, ngoài việc tổng hợp thông tin từ một số nguồn tin chính thống, mình cũng sẽ chia sẻ thêm về những cách thiết kế và xử lý job, queue, batch processing,... mà mình đã thực hiện sau nhiều thương vụ buôn chuối của mình.</p>
<p>Tuy nhiên, để có thể đọc hiểu trôi chảy những thứ mà mình nêu ra ở đây thì các bạn nên có 1 số kiến thức nền tảng về:</p>
<ul>
<li>Background job</li>
<li>Queue</li>
<li>Event-driven</li>
<li>Cronjob</li>
<li>Batch processing</li>
<li>Concurrency and lock</li>
</ul>
<p>Nhiêu đó đã, giờ bắt đầu nào.</p>
<h2>Các loại job và usecase của chúng</h2>
<p>Trong 1 <a href="https://docs.microsoft.com/en-us/azure/architecture/best-practices/background-jobs">bài viết</a> rất chi tiết và cụ thể của bác Bill về vấn đề này đã đề cập rõ từng loại job cũng như usecase của chúng rồi, mình sẽ chỉ tóm tắt lại cho các bạn thôi. (Nhưng hãy đọc bài viết kia để có cái nhìn chi tiết hơn)</p>
<p>Trên khía cạnh <strong>trigger</strong> thì background job có thể xuất phát từ 2 loại trigger sau:</p>
<ul>
<li>
<strong>Event-driven trigger</strong>: Là job được khởi chạy dựa trên 1 event nào đó xảy ra trong hệ thống. Có thể là việc 1 API được gọi, 1 Object được lưu vào DB,...</li>
<li>
<strong>Schedule-driven trigger</strong>: Là job khởi chạy dựa trên thời gian. Đó có thể là job định kỳ (hàng ngày, hàng giờ,...) hoặc job vào một thời điểm hay sau 1 thời điểm nhất định nào đó.</li>
</ul>
<h3>Event-driven job</h3>
<p>Bạn sẽ sử dụng <strong>event-driven job</strong> khi nó phụ thuộc vào việc xuất hiện của những sự kiện <strong>không biết sẽ xảy ra khi nào</strong> như:</p>
<ul>
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
<h3>Schedule-driven job</h3>
<p><strong>Schedule-driven</strong> được sử dụng cho các tác vụ thường xuyên, <strong>xác định được trước thời gian</strong> chạy hoặc <strong>lặp đi lặp lại</strong> như:</p>
<ul>
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
<h2>Cách giao lưu phối kết hợp</h2>
<p>Chắc vậy là đủ để các bạn hình dung sơ sơ về ứng dụng của 2 loại hình background job này rồi nhỉ? Trong khuôn khổ hạn hẹp của bài viết này thì mình sẽ giới thiệu cho các bạn 1 vài cách kết hợp 2 loại background job trên và tình huống sử dụng cụ thể khi mình xây dựng các ứng dụng.</p>
<h3>Bài toán 1: Đếm số lượng view trang web / sản phẩm</h3>
<p>Đây tưởng chừng là một bài toán có yêu cầu đơn giản mà việc thực hiện cũng lại đơn giản luôn. Cứ mỗi lần có 1 lượt view trang web hay 1 sản phẩm của bạn thì cộng cho sản phẩm đó 1 lượt view. </p>
<blockquote>
<p>Điểm quan trọng nhất của việc scale background job chính là xử lý đồng thời nhiều job cũng 1 lúc. Do vậy vấn đề về <strong>Atomic operation</strong> phải được đặt lên hàng đầu. Chi tiết bạn có thể google search thêm. Ở đây mình sẽ bỏ qua việc các vấn đề liên quan tới <strong>Atomic operation</strong> trong việc lưu trữ data của các bạn.</p>
</blockquote>
<p><strong>1. Cách nông dân</strong></p>
<p>Đơn giản là mỗi khi API view product được gọi thì bạn cộng thêm 1 view vào database </p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/cqcqt6l5rg_Simple-view-queue.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/cqcqt6l5rg_Simple-view-queue.png" alt="alt text"></a><a></a></p>
<p>Vấn đề gặp phải:</p>
<ul>
<li>
<strong>Blocking IO</strong>: Việc +1 view vào database làm chậm response của người dùng, mặc dù người dùng không cần thiết phải chờ hành động này</li>
<li>
<strong>Performance</strong>: Khi số lượng người dùng sản phẩm lớn, ví dụ có 1000 người cùng view tại 1 thời điểm thì DB của bạn sẽ phải chịu 1000 câu query update 1 lúc. Oh...</li>
</ul>
<p><strong>2. Sử dụng event-driven job</strong></p>
<p>Giờ thay vì API gọi thẳng vào DB thì ta đẩy nó vào 1 cái <strong>Job Queue</strong>. Sẽ có 1 cơ số worker ở phía sau chờ sẵn để xử lý những cái job này.</p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/mknay1j486_Simple-view-queue-2.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/mknay1j486_Simple-view-queue-2.png" alt="alt text"></a><a></a></p>
<p>Vấn đề đã giải quyết:</p>
<ul>
<li>
<strong>Non-blocking IO</strong>: Việc +1 view bây giờ đã <strong>gần như</strong> không ảnh hưởng tới thời gian response của người dùng do thời gian để đẩy job queue thường nhỏ hơn nhiều so với thời gian query update</li>
<li>
<strong>Throttling</strong>: Giờ nếu bạn có 10 worker, tại 1 thời điểm 1 worker chỉ xử lý 1 job. Vậy thì cùng lúc bạn sẽ chỉ có 10 job chạy song song, tức là dù bạn có 1000 view sản phẩm cùng lúc thì tại 1 thời điểm cũng chỉ có 10 câu lệnh update db được chạy.</li>
</ul>
<p>Vấn đề còn tồn tại:</p>
<ul>
<li>
<strong>Performance</strong>: Vâng vẫn là cái vấn đề về performance, chỉ là ở 1 cấp độ khác mà thôi. Thay vì DB của các bạn phải chịu tải lớn, thì các bạn đã đánh đổi điều đó bằng việc <strong>xử lý được ít job hơn</strong>. Và vì xử lý ít job hơn nên các bạn sẽ dễ dẫn tới trường hợp bị <strong>dồn job</strong> do worker không xử lý kịp.</li>
<li>
<strong>Busy IO</strong>: 1 vấn đề mà giải pháp này vẫn còn đó là nó vẫn còn rất gánh nặng về mặt IO cho DB. Với 1000 view, DB của các bạn vẫn phải chịu 1000 câu lệnh update liên tục. Điều đó làm ảnh hưởng rất nhiều tới hiệu năng của những tác vụ khác.</li>
</ul>
<p><strong>3. Sử dụng kết hợp 2 loại job</strong></p>
<p>Để giải quyết vấn đề về DB bottle neck thì ta sẽ nghĩ ngay tới tầng đệm (caching). Tầng caching là tầng xử lý tốt phần IO hơn rất nhiều so với các loại DB cơ bản. Do vậy chúng ta sẽ đẩy gánh nặng này cho tầng caching bằng cách tạo ra 1 <strong>scheduled job</strong> lặp đi lặp lại để ghi data từ cache xuống DB.</p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/wq7nis95l5_Simple-view-queue-3.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/wq7nis95l5_Simple-view-queue-3.png" alt="alt text"></a><a></a></p>
<p>Như các bạn thấy, khi các <strong>event job</strong> +1 view cho sản phẩm thì kết quả này được ghi vào tầng cache. Sau đó các <strong>scheduled job</strong> sẽ định kỳ lấy tổng số view chưa được đếm này (n view) từ trong cache ra để ghi vào DB (+n view)</p>
<p>Vấn đề đã giải quyết:</p>
<ul>
<li>
<strong>Performance</strong>: Do view được lưu tạm thời vào trong cache, do vậy ta có thể tận dụng sức mạnh IO của cache để nâng số worker đồng thời cũng như giảm được thời gian xử lý từng event job. Do đó tình trạng dồn queue sẽ được xử lý.</li>
<li>
<strong>Throttling hơn nữa</strong>: Việc phát sinh query update vào DB chỉ xảy ra trên các <strong>scheduled job</strong>, do vậy ta đã giảm thiểu số lần update DB thành 1 con số cố định và có thể cân đối được. Ví dụ nếu <strong>scheduled job</strong> chạy 10s 1 lần thì trong 1 phút sẽ chỉ có tối đa 6 query update DB được tạo ra (thay vì cả 1000 query update như trước)</li>
</ul>
<p>Vấn đề còn tồn tại:</p>
<ul>
<li>
<strong>Delay data</strong>: Dữ liệu view của sản phẩm sẽ không được update theo thời gian thực mà sẽ có độ trễ tùy theo tần suất <strong>scheduled job</strong>. Tuy nhiên độ trễ này thường là chấp nhận được khi so sánh với những lợi ích nó mang lại.</li>
</ul>
<blockquote>
<p>Tips: Như mình đã nói ở trên, việc xử lý <strong>atomic operation</strong> là rất quan trọng trong việc xây dựng background job. Các bạn có thể thấy trong ảnh mình sử dụng operation <strong>-n</strong> và <strong>+n</strong> do cộng và trừ thường là <strong>atomic operation</strong> trên hầu hết các loại db/cache. Đây là 1 tip cho các bạn. Không nên <strong>get rồi set counter bằng 0</strong> mà nên <strong>get rồi trừ counter đi giá trị hiện tại</strong> của nó để đảm bảo không bị mất dữ liệu view khi đang reset counter nhé.</p>
<p>Tips 2: Với redis thì các bạn không cần phải chơi trick trừ như trên, vì nó có sẵn 1 cái <strong>atomic operation</strong> là <strong>GETSET</strong> để các bạn reset counter rồi.</p>
</blockquote>
<h3>Bài toán 2: Gửi email thông báo hàng loạt</h3>
<p>Đây là bài toán thường gặp ở các hệ thống tin tức, báo cáo,... khi mà định kỳ (hàng ngày, hàng tuần) phải gửi nội dung được tổng hợp tới nhiều người dùng. Vậy background job sẽ xử lý trường hợp này như thế nào?</p>
<p><strong>1. Cách nông dân</strong></p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/yt0pnl10mj_Simple-view-queue-4.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/yt0pnl10mj_Simple-view-queue-4.png" alt="alt text"></a><a></a></p>
<p>Trong cách này thì chúng ta sẽ có <strong>1 scheduled job</strong> siêu to khổng lồ chạy để lấy danh sách người dùng từ trong database, sau đó dùng danh sách này để gửi email cho tất cả user.</p>
<p>Vấn đề gặp phải:</p>
<ul>
<li>
<strong>Thời gian xử lý lâu</strong>: Đương nhiên với duy nhất 1 scheduled job xử lý việc gửi email cho toàn bộ người dùng thì thời gian để xử lý hết được sẽ lâu đúng không? Tưởng tượng trong job này bạn phải lấy email, tạo content cho email đó, gửi email,... <strong>lần lượt</strong> cả ngàn lần.</li>
<li>
<strong>Khó retry</strong>: Với 1 job siêu to khổng lồ như này thì việc gặp lỗi giữa quá trình chạy sẽ rất khó để giải quyết do việc chạy lại job sẽ buộc phải xử lý mọi thứ <strong>từ đầu</strong>, xử lý trùng lặp,...</li>
</ul>
<p><strong>2. Cách bớt nông dân</strong></p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/mw9rmyn0d0_Simple-view-queue-5.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/mw9rmyn0d0_Simple-view-queue-5.png" alt="alt text"></a><a></a></p>
<p>Ở đây <strong>scheduled job</strong> sẽ không đảm nhận việc thực hiện nhiệm vụ nữa mà sẽ đóng vai trò là <strong>người quản lý</strong> - tạo task cho nhiều event worker chạy song song thông qua <strong>Job queue</strong></p>
<p>Vấn đề đã giải quyết:</p>
<ul>
<li>
<strong>Scalable</strong>: Chúng ta đã giải quyết được tính chất không scale được của <strong>scheduled job</strong> khi mà giờ đây nó chỉ đóng vai trò <strong>tạo task</strong> và <strong>đẩy vào job queue</strong> cho các event worker xử lý.</li>
<li>
<strong>Thời gian xử lý nhanh:</strong>: Do có thể xử lý đồng thời qua các event worker nên thời gian xử lý tổng thể sẽ giảm xuống theo cấp số nhân</li>
<li>
<strong>Dễ dàng retry</strong>: Việc xử lý lỗi giờ đây dễ dàng hơn rất nhiều vì từng job sẽ handle việc gửi email cho 1 user cụ thể. Do đó nếu có lỗi thì cũng không ảnh hưởng tới user khác. Ngoài ra từng job nhỏ còn tự retry được luôn mà không phải chạy lại toàn bộ từ đầu.</li>
</ul>
<h3>Bài toán 3: ETL process</h3>
<p>Nói qua 1 chút về thuật ngữ <strong>ETL (Extract Transform Load)</strong> thì đây là thuật ngữ để chỉ 1 quá trình xử lý xử liệu từ hệ thống nguồn tới hệ thống đích. Mà thật ra là quá trình này thường là để chuyển dữ liệu từ các hệ thống hoạt động (Operation) sang hệ thống phân tích và báo cáo (Analytic and Reporting). </p>
<p>Có rất nhiều tool được sinh ra cho quá trình này tuy nhiên có thể vì kiến thức của mình lúc ấy còn hạn chế hoặc do hệ thống của bên mình chưa khủng tới mức dùng những giải pháp đồ sộ đó mà mình đã chọn giải pháp đơn giản hơn là tự viết những tiến trình đồng bộ dữ liệu từ các hệ thống Operation tới hệ thống Analytic bằng <strong>Scheduled job</strong>.</p>
<blockquote>
<p>Tất cả job và dữ liệu xử lý trong quá trình ETL phải được thiết kế để <strong>có thể retry</strong> hoặc <strong>chạy lại</strong> mà <strong>không bị trùng lặp</strong> hay dẫn tới sai sót.</p>
</blockquote>
<p><strong>1. Cách nông dân</strong></p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/ied4f1e2lt_Simple-view-queue-6.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/ied4f1e2lt_Simple-view-queue-6.png" alt="alt text"></a><a></a></p>
<p>Trong cách này, mình có duy nhất 1 job được scheduled để làm cả 3 quá trình <strong>Extract</strong>, <strong>Transform</strong>, <strong>Load</strong>. Idea thì rất đơn giản, cứ 1 tiếng bạn chạy 1 cái job lấy hết data từ DB nguồn trong thời gian vừa rồi, làm 1 số thao tác magic trên đống dữ liệu đó, rồi đẩy vào 1 DB đích. Hết</p>
<p>Cách xử lý này có 1 cái tiện là bạn có thể tạo 1 cái pipeline đơn giản để data lần lượt được xử lý qua cả 3 quá trình một cách tuần tự mà không phải lo nghĩ gì. Tuy nhiên đời không như là mơ. Bạn sẽ gặp các vấn đề tương tự như vụ gửi email ở trên, mà còn ở mức độ nghiêm trọng hơn vì:</p>
<ul>
<li>
<strong>Thời gian xử lý lâu</strong>: Để dữ liệu chạy qua tất cả các quá trình này 1 lúc sẽ tốn thời gian và tài nguyên. Nếu để interval dài thì dữ liệu của bạn quá outdate. Nếu interval thấp thì job sau dễ chồng chéo lên job trước do job trước chưa chạy xong,...</li>
<li>
<strong>Retry</strong>: Again, vấn đề không retry được sẽ là vấn đề rất nhức nhối. Với multi-step job như này thì việc fail 1 step cuối sẽ khiến toàn bộ các step trước phải chạy lại, và... boom</li>
</ul>
<p>Hãy cùng tìm hiểu cách tiếp cận tiếp theo</p>
<p><strong>2. Cách bớt nông dân</strong></p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/8bb14bgf5g_Simple-view-queue-7.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/8bb14bgf5g_Simple-view-queue-7.png" alt="alt text"></a><a></a></p>
<p>Ở đây mình sử dụng 1 vài DB tạm để chứa các dữ liệu trong quá trình xử lý và tách 3 quá trình ETL ra thành 3 scheduled job khác nhau. Mặc dù cách này đã cải thiện về thời gian và việc xử lý lỗi trong quá trình chạy để retry từng phần được, song nó vẫn dựa trên mô hình scheduled, tức là không scale được. Cách này có thể chạy được ổn với time interval tương đối ngắn, lượng data giữa các bước sync không quá nhiều. </p>
<p>Đối với <strong>1 record dữ liệu</strong> thì việc xử lý qua từng bước sẽ là tuần tự. Tuy nhiên với <strong>nhiều record dữ liệu</strong> thì 3 quá trình này trở thành <strong>song song</strong> nhau (chạy kiểu gối đầu). Do vậy thời gian tổng thể sẽ được rút ngắn kha khá</p>
<p>Vấn đề duy nhất bạn phải giải quyết đó chính là <strong>tracking status</strong> của dữ liệu. Tức là dữ liệu của bạn đã đi tới bước nào, được xử lý chưa, thành công hay thất bại, và quan trọng hơi là được sắp xếp xử lý 1 cách có thứ tự.</p>
<p><strong>3. Cách loằng ngoằng</strong></p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/i0ej6l2m2y_Simple-view-queue-8.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/i0ej6l2m2y_Simple-view-queue-8.png" alt="alt text"></a><a></a></p>
<p>Phát triển tiếp mô hình phía trên và thêm yếu tố scaling bằng event job, mình sẽ có mô hình cuối cùng này. Trông có vẻ phức tạp vậy tuy nhiên về cấu trúc lại y hệt vụ gửi email ở phía trên thôi không có gì to tát cả.</p>
<p>Cách này đã giải quyết được gần như tất cả các vấn đề liên quan tới performance, scale, delay time,... mà ta gặp phải phía trên. Nó phù hợp với các hệ thống sync dữ liệu có độ trễ thấp do có thể giảm được thời gian delay giữa các lần chạy. </p>
<p>Tuy nhiên, vinh quang nào cũng phải trả giá bằng máu và nước mắt. Các bạn sẽ phải đánh đổi bằng việc:</p>
<ul>
<li>
<strong>Track data status</strong>: đánh dấu data đã xử lý tới bước nào</li>
<li>
<strong>Data paging</strong>: Các bạn phải có 1 cột id hay time đủ tin cậy để <strong>scheduled job</strong> có thể phân chia được từng khoảng dữ liệu cho <strong>event job</strong> xử lý đồng thời. Vì thế việc dữ liệu được tổ chức thế nào sẽ khá tricky đó nhé.</li>
</ul>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/cvee0r0x0i_Screenshot%20from%202019-11-22%2001-19-41.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/cvee0r0x0i_Screenshot%20from%202019-11-22%2001-19-41.png" alt="alt text"></a><a></a></p>
<p>Đây là minh họa cho quá trình xử lý song song nhiều bản ghi cùng lúc bởi 3 loại job. </p>
<blockquote>
<p>Tips: Tận dụng lợi thế về batch processing với từng job bằng việc tìm hiểu số record ghi đồng thời hiệu quả với từng loại DB. Ví dụ mongodb sẽ có mức ghi hiệu quả nếu mỗi job xử lý 1000 record đồng thời. Tham khảo thêm <a href="https://medium.com/dbkoda/bulk-operations-in-mongodb-ed49c109d280">tại đây</a></p>
</blockquote>
<h2>Tổng kết</h2>
<p>Qua bài viết trên mình đã đưa ra cho các bạn cái nhìn tổng quát về 2 loại background job cũng như 3 case ứng dụng thực tế trong việc kết hợp 2 loại job này để tăng khả năng xử lý của ứng dụng.</p>
<p>Mặc dù bài viết không có 1 mẩu code thực nào mà trông như thuần túy lý thuyết nhưng các bạn yên tâm rằng mọi mô hình bên trên đều đã được mình áp dụng trong thực tế và chỉ tổng kết lại kết quả và hiệu quả của nó cho các bạn mà thôi.</p>
<p>Có những mô hình mặc dù mình có nêu ra điểm chưa tốt nhưng nó cũng có thể xử lý khối lượng công việc khá lớn rồi đó. Ví dụ như mô hình 2 bài toán ETL đang xử lý vài chục triệu record dữ liệu hàng ngày từ 5 hệ thống với hơn 20 scheduled job có độ trễ dưới 2 phút. Hay mô hình 2 bài toán view cũng đang xử lý hơn 5 triệu job 1 ngày với 10 worker cho hệ thống notification thời gian thực mà chưa gặp vấn đề gì về performance. Do đó việc bạn chọn cách nào cho dự án của mình sẽ còn tùy vào tính chất và khối lượng công việc của các worker nữa.</p>
<p>Cám ơn các bạn đã quan tâm theo dõi đến đây. Hẹn gặp lại trong bài viết sau.</p>'),

-- Nghệ thuật xử lý background job phần 2 --
(2, N'Nghệ thuật xử lý background job phần 2: Job order with concurrent worker', '2020/04/18', 'minhmonmen', 13, 1,
N'<p>Aka <strong>Nghệ thuật đưa dê qua cầu</strong> của tác giả <strong>Minh Monmen</strong>.</p>
<p>Hê lô bà con cô bác họ hàng gần xa bà con khối phố. Lại là mình đây, <strong>Minh Monmen</strong> trong những chia sẻ vụn vặt về quá trình làm những sản phẩm siêu to khổng lồ (tự huyễn hoặc bản thân vậy cho có động lực). Hôm nay mình xin hân hạnh gửi đến các bạn phần tiếp theo của series <a href="https://kipalog.com/posts/Nghe-thuat-xu-ly-background-job"><strong>Nghệ thuật xử lý background job</strong></a> mà mình vừa mới nghĩ được ra thêm. </p>
<p>Thật ra đây cũng không phải chia sẻ gì mà là mình đang gặp 1 vấn đề, mình tìm ra 1 cách nông dân để giải quyết nó và đưa lên đây để các bạn cùng cho ý kiến xem nó có ok không. Rất mong nhận được nhiều gạch đá từ các bạn để đủ xây lâu đài cho vấn đề này.</p>
<h2>First things first</h2>
<p>Bài viết này dành cho những bạn đã thành công trong việc implement được hệ thống <strong>background job</strong> (hoặc những bạn chưa implement được thì save lại sau đọc dần =))). Lần này mình sẽ nói qua 1 cách nhanh chóng những thứ mình vừa mới nghĩ ra, vì để lâu lắc 1 chút là mình lại quên mất. Nên bắt đầu luôn nè.</p>
<p>Những điều cần biết trước khi đọc:</p>
<ul>
<li>Background job (hiển nhiên)</li>
<li>Queue, message queue</li>
<li>Concurrency and lock </li>
<li><a href="https://kipalog.com/posts/Nghe-thuat-xu-ly-background-job">Nghệ thuật xử lý background job phần 1</a></li>
</ul>
<p>Những điều cần biết khi đọc xong:</p>
<ul>
<li>Bài viết chỉ focus vào giải quyết bài toán <strong>concurrency</strong> và <strong>job ordering</strong>
</li>
<li>Bài viết bỏ qua các vấn đề liên quan tới các tính chất khác như <strong>reliable</strong>, <strong>retryable</strong>,... </li>
</ul>
<p>Vậy nên đọc xong đừng thắc mắc tại sao bài viết không giải quyết vấn đề retry, vấn đề tin cậy, persistent... các thứ nhé.</p>
<p>Nhào vô.</p>
<blockquote>
<p>Mọi thứ ở trong bài viết này đề cập đều ở mức <strong>thiết kế hệ thống</strong>, tức là cho các bạn một cách thiết kế nào đó <strong>phục vụ được nhu cầu</strong> nhưng <strong>không quá phụ thuộc vào công nghệ</strong>. Bạn sẽ không cần phải cài đặt Kafka hay hệ thống Message queue phức tạp nào đó để implement những cách tiếp cận dưới đây. Chính vì vậy mình sẽ loại bỏ hoàn toàn các <strong>feature riêng biệt</strong> của 1 hệ thống hay công nghệ nào đó mà chỉ quan tâm tới mô hình đơn giản nhất áp dụng được cho hầu hết công nghệ mà thôi.</p>
</blockquote>
<h2>The big problem</h2>
<p>Trong bài viết trước, mình đã bỏ qua toàn bộ các vấn đề liên quan tới <strong>sự liên hệ giữa 2 job</strong> và coi <strong>mọi job đều là độc lập</strong>. Điều này làm mọi thứ đơn giản hơn rất nhiều khi mà các bạn có thể thoải mái scale số lượng worker lên bao nhiêu cũng được để tận dụng sức mạnh của xử lý song song. Tuy nhiên trong 1 số trường hợp oái oăm hơn, khi mà các job bị phụ thuộc vào nhau bởi 1 khía cạnh nào đó thì việc các bạn vừa giữ được thứ tự xử lý job, vừa giữ được khả năng xử lý song song sẽ là một điều không đơn giản.</p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/fblvkyf7x1_%E1%BA%A3nh.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/fblvkyf7x1_%E1%BA%A3nh.png" alt="alt text"></a><a></a></p>
<p>Xử lý worker song song làm mình liên tưởng đến bài toán 2 con dê qua cầu. <strong>Làm sao để 2 con dê cùng qua 1 cây cầu an toàn mà hiệu quả?</strong></p>
<p>Chúng ta hãy đi sâu vào từng cách tiếp cận khi xử lý job có thứ tự trong phần dưới nhé.</p>
<blockquote>
<p>Mình mặc định coi <strong>1 worker chỉ xử lý được 1 job</strong> tại 1 thời điểm nhé. Với các loại worker kiểu async xử lý nhiều job cùng lúc thì sẽ coi như là multiple worker cho đơn giản.</p>
</blockquote>
<p>Giờ chúng ta có 1 bài toán ví dụ như sau:</p>
<ul>
<li>Có 1 cơ số loại job cần thực hiện. VD: <strong>tạo post</strong>, <strong>tạo comment</strong>, <strong>like post</strong>,...</li>
<li>1 số loại job sẽ cần thứ tự với điều kiện xác định. VD: comment của cùng 1 post cần được tạo đúng theo thứ tự request đẩy vào.</li>
<li>Ở đây các bạn có thể thấy điều kiện để 2 job ràng buộc về thứ tự là:
<ul>
<li>
<strong>Phần pre-defined</strong>: tức là phần biết từ khi khởi tạo. Chính là những job <strong>thuộc 1 loại nào đó</strong>. Phần này sẽ có đặc điểm là <strong>hữu hạn</strong>. Ví dụ job loại <code>tạo post</code>, job loại <code>tạo comment</code>,...</li>
<li>
<strong>Phần data-related</strong>: tức là khi khởi tạo job bạn không biết <strong>giá trị chính xác</strong>. Ví dụ những job tạo comment có <strong>cùng post_id</strong>. Phần này sẽ có đặc điểm là về lý thuyết sẽ <strong>vô hạn</strong>.</li>
</ul>
</li>
</ul>
<p>Vấn đề của chúng ta chính là ở chỗ này. Điều kiện để 2 job liên quan tới nhau không những chỉ từ <strong>loại job</strong> mà còn <strong>phụ thuộc vào data nữa</strong>. Ví dụ như job <code>comment X vào post A</code> phải được hoàn thành trước job <code>comment Y vào post A</code>.</p>
<h2>Những con đường ta đã đi qua</h2>
<p>Chúng ta cùng xem xét những cách tiếp cận dưới đây và xem chúng gặp phải những vấn đề gì nhé.</p>
<h3>1 Queue cho all job, 1 worker</h3>
<p>Đây là cách tiếp cận nông dân và dễ hiểu nhất. Với cách tiếp nhận này bạn không cần phải lo về vấn đề xử lý song song nữa. Chỉ cần queue có cơ chế <strong>FIFO (first in first out)</strong> là đủ. 1 worker tại 1 thời điểm chỉ xử lý được 1 job, và thứ tự thực hiện job sẽ chính là thứ tự được lấy từ queue ra. Bravo!!!</p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/ke0so68oah_Single-queue-1.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/ke0so68oah_Single-queue-1.png" alt="alt text"></a><a></a></p>
<p>Và tất nhiên là nó kéo theo 1 vấn đề siêu to khổng lồ. Đó là việc <strong>xử lý chậm</strong>. Tưởng tượng bạn nhận được job với tần suất là 1000 job/giờ nhưng lại chỉ có thể xử lý 500 job/giờ. Vậy là qua mỗi ngày số job sẽ cứ dồn mãi, dồn mãi... <strong>Boom!</strong></p>
<h3>1 Queue cho mỗi loại <strong>pre-defined</strong> job, mỗi queue 1 worker.</h3>
<p>Đây là bước tiến tiếp theo của cách làm trên, khi mà đã tách mỗi loại job ra 1 queue riêng, mỗi queue riêng này sẽ có <strong>1 worker</strong> của riêng mình.</p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/gesdcjq8ji_Single-queue-2.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/gesdcjq8ji_Single-queue-2.png" alt="alt text"></a><a></a></p>
<p>Cách xử lý này đã khắc phục được phần nào điểm nghẽn khi mà đã chia tải hệ thống ra nhiều loại worker. Mặc dù chỉ là 1 phần khá nhỏ. Như mình đã nói ở trên, số lượng các loại <strong>pre-defined</strong> job là hữu hạn. Ví dụ hệ thống của bạn chỉ có 3 loại job là <strong>tạo post</strong>, <strong>tạo comment</strong>, <strong>like post</strong>. Vậy là bạn sẽ có 3 worker khác nhau, mỗi worker xử lý 1 loại job riêng biệt. Và tới đây, chúng ta vẫn gần như không cần phải lo lắng tới vấn đề thứ tự thực hiện job hay concurrency. Bởi với 90% các hệ thống thì <strong>job loại A</strong> sẽ ít liên quan tới <strong>job loại B</strong>. (Nếu hệ thống của bạn là 10% còn lại, hãy theo dõi tiếp các solution khác).</p>
<p>Tuy nhiên, tương tự như cách đầu tiên, hệ thống của các bạn vẫn bị giới hạn bởi 1 worker cho 1 loại job. Do vậy mà nó vẫn chậm, rất chậm.</p>
<h3>1 queue cho mỗi loại <strong>pre-defined</strong> job, mỗi queue có nhiều worker</h3>
<p>Đây là cách mà phần lớn các hệ thống đang sử dụng. Các loại lib job queue/ task queue phổ biến như <code>Resque</code> trên ruby, <code>Celery</code> trên python, <code>Bull</code> trên Nodejs,... hay rất nhiều các loại task queue khác có backend là redis đều áp dụng pattern này. </p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/haq1fc3bt1_Single-queue-3a.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/haq1fc3bt1_Single-queue-3a.png" alt="alt text"></a><a></a></p>
<p>Thực hiện theo pattern này thì chúng ta đã xử lý được vấn đề chậm khi mà nhiều worker cùng xử lý song song 1 loại job, giúp cho hệ thống dễ dàng scale theo chiều ngang hơn. Tuy nhiên đây chính là lúc mà sự chú ý của ta đã va vào ánh mắt của vấn đề: <strong>Concurrency và Job ordering</strong>. Nhiều worker chạy song song đồng nghĩa với việc phát sinh những <strong>tranh chấp tài nguyên</strong> hay <strong>job tới sau xử lý xong trước job tới trước</strong>.</p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/i4qukzldnb_Single-queue-3b.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/i4qukzldnb_Single-queue-3b.png" alt="alt text"></a><a></a></p>
<p>Đây chính là khi cơn ác mộng bắt đầu. Mình bắt đầu vận dụng hết bộ óc thiên tài để đi search google các cách giải quyết. Và 1 số hướng tiếp cận sau sinh ra:</p>
<ul>
<li>Sử dụng <strong>Atomic transaction</strong> để update tài nguyên. Cái này chỉ phù hợp với những transaction quan trọng và <strong>nằm hoàn toàn trên 1 db</strong>. Ví dụ như bạn update 1 hoặc 1 vài bản ghi bằng atomic transaction. Tuy nhiên nó ko áp dụng được với toàn bộ 1 process dài như chuẩn bị tham số, lấy info từ svc A, tính toán,... Mình đã từng kết hợp <strong>unique index</strong> + <strong>upsert operation</strong> cho 1 vài trường hợp, tuy nhiên với tần suất job lớn thì tỷ lệ fail với upsert là rất rất nhiều, và tin mình đi, bạn không muốn phải retry đống job fail nhiều như vậy đâu =)))</li>
<li>Sử dụng <strong>Locking</strong> để khóa tài nguyên cần update. Cách này mình đã sử dụng khi nhận thấy thời gian lock không dài (chỉ vài chục ms), do đó mình chấp nhận drop hoặc retry nhưng job nào đen quá mà bị lock cùng nhau. Ban đầu thì nó cũng chạy ổn, nhưng càng về sau khi job của mình phải xử lý nhiều tác vụ hơn, và thời gian lock tăng lên đi kèm với tỷ lệ drop vài retry tăng lên luôn. Lại phải tính 1 cách khác.</li>
<li>Sử dụng cơ chế <strong>Partition queue</strong> bắt chước từ kafka. Các bạn đều biết là kafka có 1 pattern xử lý nôm na đó là <strong>tại 1 thời điểm 1 partition chỉ có 1 worker được xử lý</strong>. Vậy là mình sẽ tạo ra 10 cái queue <strong>create comment job</strong>, tạo ra 10 worker rồi cho mỗi 1 cái lắng nghe duy nhất 1 queue trên. Khi có job mới thì chia cái ID của post cho 10 rồi đẩy vào queue tương ứng. Mọi thứ nghe thật là awesome nhưng có 1 cái lỗ hồng to đùng: <strong>các loại task queue phổ biến lại không được thiết kế phức tạp như vậy</strong>. =))))))) Để implement được cơ chế học mót này mình phải quản lý số lượng worker và số lượng queue rất chặt chẽ, rồi cả thằng tạo job cũng bị phụ thuộc để biết nó đẩy job vào queue nào,... </li>
<li>Tạo cho mỗi 1 post 1 queue riêng, rồi cho 1 worker lắng nghe cái queue riêng đó. Ví dụ thay vì 1 queue <strong>create comment job</strong> thì sẽ tạo ra nhiều queue dạng <strong>create comment job - post A</strong>. Đây chính là mô hình giải quyết được bài toán. Nhưng vấn đề của mình lại là: <strong>Việc tạo queue và listen queue phải được xử lý dynamic</strong>. Tức là trong khi runtime phải liên tục tạo ra queue và consume job trong queue đó. Well well well.</li>
</ul>
<p>Ví dụ code 1 thằng task queue bất kỳ sẽ dạng như sau:</p>
<pre><code class="javascript">const queue = new Queue(\'create_comment\')
// register handler (on worker)
const handler = (job) =&gt; {
// process job
const data = job.data; // xxx
}
// Register when worker start
queue.register(handler)
// insert job
const data = "xxx";
queue.add(data)
</code></pre>
<p>Thay vào đó ta lại cần:</p>
<pre><code class="javascript">const queueA = new Queue(\'create_comment_post_A\')
const queueB = new Queue(\'create_comment_post_A\')
// register handler (on worker)
const handler = (job) =&gt; {
// process job
}
// Dynamic register ON RUNTIME
queueA.register(handler)
queueB.register(handler)
// insert job
const data = "something";
queueA.add(data)
// Dynamic unregister ON RUNTIME when process all job for post A done
queueA.unregister(handler)
// Delete queue A
queueA.destroy()
</code></pre>
<p>Đây chính là vấn đề của cách tiếp cận này. Việc đăng ký/hủy đăng ký queue nếu thực hiện như thế này sẽ cực kỳ khó quản lý nếu các bạn trực tiếp sử dụng queue của các lib task queue. Chưa nói tới việc nó còn gây ra các tác động như tạo thêm connection, rác tài nguyên,...</p>
<h2>Bước tiến lớn bằng một đoạn code nhỏ</h2>
<p>Chính trong lúc khó khăn ấy, khi mà cái khó liền ló cái ngu mình đã nghĩ ra 1 cách nông dân để sử dụng luôn hạ tầng và các cơ chế hiện tại như sau:</p>
<h3>1 queue cho mỗi loại <strong>pre-defined</strong> job, mỗi queue có nhiều worker, 1 lock + 1 datasource dạng queue để quản lý concurrency</h3>
<p>Về mặt bản chất, vẫn là bạn tạo ra các queue riêng biệt cho từng đối tượng bài post A, B, C. Tuy nhiên khi đặt trong hoàn cảnh tích hợp với các lib task queue hiện có thì ý nghĩa implement của nó lại khác. Thay vì bạn tạo ra 1 <strong>job cho post A</strong> với <strong>data X</strong>, thì bạn sẽ tạo <strong>job cho post A</strong> không có data. Sau đó <strong>job cho post A</strong> sẽ pop data từ 1 list data nào đó (redis list, database,...) và xử lý. Xử lý xong sẽ lại tự schedule <strong>job cho post A</strong> tiếp theo.</p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/slrgd76d7l_Single-queue-4.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/slrgd76d7l_Single-queue-4.png" alt="alt text"></a><a></a></p>
<p>Mô tả diễn biến của nó như sau:</p>
<pre><code class="javascript">const queue = new Queue(\'create_comment\')
// register handler (on worker)
const handler = (job) =&gt; {
// process job
const name = job.data; // create_comment_post_A
// 4. Pop data from data source
const data = datasource.pop(name); // xxx
// processing
// 5. Check if data source has next data
if (datasource.hasNext()) {
// 6a. Extend lock timeout and schedule next job for post A
extendLock(name)
queue.add(name)
} else {
// 6b. No data available, release lock for post A so new job can be scheduled
releaseLock(name)
}
}
// Register when worker start
queue.register(handler)
// insert job
const data = "xxx";
// 1. Push data to data source (a redis list / db)
datasource.push(\'create_comment_post_A\', data)
// 2. Claim lock for post A for TIMEOUT_DURATION.
const canSchedule = claimLock(\'create_comment_post_A\', TIMEOUT_DURATION)
if (canSchedule) {
// 3a. If success schedule new job for post A
queue.add(\'create_comment_post_A\')
} else {
// 3b. Job for post A already running, do nothing
}
</code></pre>
<p>1 vấn đề nhỏ với cơ chế <strong>schedule gối đầu</strong> như này là nếu 1 job cho post A đã bị fail xử lý quá thời gian timeout của lock mà không có job mới nào được add để tiếp tục xử lý job cho post A thì hàng đợi cho post A sẽ dừng mãi mãi. Lúc này mình thêm 1 tiến trình định kỳ <strong>re-scheduler</strong> để kiểm tra toàn bộ những hàng đợi có vấn đề và khởi tạo lại job.</p>
<pre><code class="javascript">// Interval running
const allProcesses = datasource.getAllLocks(); // [\'create_comment_post_A\', \'create_comment_post_B\',...]
for (let i = 0; i &lt; allProcesses.length; i++) {
const element = allProcesses[i];
if (claimLock(allProcesses[i])) {
// Job for post A does not exists but datasource still have data for post A
// Reschedule job for post A
queue.add(allProcesses[i])
}
}
</code></pre>
<p>Gần như các bạn không cần phải sửa code liên quan tới xử lý job mà ta chỉ cần can thiệp vào quá trình đẩy data vào và lấy data ra với sự tham gia của 1 data source và 1 chiếc lock. Điều này có thể dễ dàng tích hợp với phần lớn các loại database mà cơ bản nhất là redis. Sau đây là mẫu mình đã implement với redis.</p>
<pre><code class="javascript">const ALL_LOCKS_KEY = \'locks\';
const LOCK_TTL = 30; // 30s
function getLockKey(uniqueKey) {
return `lock:${uniqueKey}`;
}
function getDataKey(uniqueKey) {
return `data:${uniqueKey}`;
}
// Lua script to clear lock when data queue empty
// Usage: clearIfQueueEmpty &lt;REDIS_ALL_LOCKS_KEY&gt; &lt;REDIS_LOCK_KEY&gt; &lt;REDIS_DATA_KEY&gt; &lt;LOCK_KEY&gt;
await redisClient.defineCommand(\'clearIfQueueEmpty\', {
numberOfKeys: 3,
lua:
"if redis.call(\'llen\', KEYS[3]) == 0 then "
redis.call(\'del\', KEYS[2], KEYS[3]);
redis.call(\'srem\', KEYS[1], ARGV[1]);
return 1;
else 
return 0; 
end
});
/**
* Add a job to datasource and try schedule job for a key
* @param {Queue} queue Queue instance. Eg: new Queue("create_comment")
* @param {string} key Key to lock resource: post_A
* @param {object} data Data to push to datasource
*/
async function add(queue, key, data) {
// Push data to queue
const dataKey = getQueueDataKey(key);
await redisClient
.pipeline()
.rpush(dataKey, JSON.stringify(data))
// Push key to all lock
.sadd(ALL_LOCKS_KEY, key)
.exec();
// Check lock to ensure schedule only not running queue
const lockKey = getQueueLockKey(key);
// Claim lock
const jobStatus = await redisClient.setnx(lockKey, \'1\');
if (jobStatus === 1) {
await redisClient.expire(lockKey, LOCK_TTL);
await queue.add({ key });
}
}
/**
* Pop data from datasource to process
* @param {string} key Key to lock resource: post_A
* @return {object} Data to process
*/
async function pop(key) {
// Pop data from data source
const data = await redisClient.lpop(getQueueDataKey(key));
if (!data) {
return null;
}
return JSON.parse(data);
}
/**
* Finish a job and schedule next job
* @param {Queue} queue Queue instance. Eg: new Queue("create_comment")
* @param {string} key Key to lock resource: post_A
*/
async function finish(queue, key) {
const lockKey = getQueueLockKey(key);
// Clear job lock if data empty
const result = await redisClient.clearIfQueueEmpty(
ALL_LOCKS_KEY,
lockKey,
getQueueDataKey(key),
key
);
if (result === 0) {
// clear fail, schedule next job and extend lock
await redisClient.expire(lockKey, LOCK_TTL);
await queue.add({ key });
}
}
/**
* Ensure all queue running
*/
async function ensureAllQueueRunning() {
const keys = await redisClient.smembers(ALL_LOCKS_KEY);
let locks = [];
if (Array.isArray(keys) &amp;&amp; keys.length &gt; 0) {
locks = await redisClient.mget(
keys.map(key =&gt; getQueueLockKey(key))
);
}
const missingLockTasks = [];
locks.forEach((lock, index) =&gt; {
if (lock !== \'1\') {
missingLockTasks.push(
(async () =&gt; {
try {
const lockKey = getQueueLockKey(keys[index]);
const jobStatus = await redisClient.setnx(
lockKey,
1\'
);
if (jobStatus === 1) {
// Can schedule job for this key
await redisClient.expire(lockKey, LOCK_TTL);
await queueService
.getQueue(keys[index])
.add({ key: keys[index] });
}
} catch (error) {
logger.error(\'Reschedule failed: \', error);
}
})()
);
}
});
return Promise.all(missingLockTasks);
}
</code></pre>
<h2>Final thoughts</h2>
<p>Tất nhiên, đây chỉ là 1 prototype để các bạn áp dụng vào các hệ thống của mình nếu có yêu cầu quản trị job song song. Còn rất nhiều thứ các bạn có thể cải tiến về độ tin cậy khi pop data, retry khi xử lý lỗi, retry khi worker crash,... tuy nhiên những thứ đó lại nằm ngoài scope của bài viết này.</p>
<p>Những thứ mà cách tiếp cận của mình này đã giải quyết được:</p>
<ul>
<li>Tránh được việc listen dynamic queue của lib. Việc khai báo listen và xử lý queue chỉ nên thực hiện 1 lần khi start worker.</li>
<li>Cho phép job <strong>tạo comment X cho post A</strong> và <strong>tạo comment X cho post B</strong> chạy song song</li>
<li>Đảm bảo job <strong>tạo comment X cho post A</strong> và <strong>tạo comment Y cho post A</strong> chạy tuần tự</li>
<li>Không cần care số lượng worker hay queue, scale hạ tầng hay worker thoải mái</li>
</ul>
<p>Trên đây là những kinh nghiệm của mình khi xử lý vấn đề <strong>concurrency và job ordering</strong> trong những hệ thống sử dụng task queue đơn giản như redis. Hiện tại hệ thống task queue do mình thiết kế sử dụng <a href="https://github.com/OptimalBits/bull">Bull JS</a> đã triển khai sử dụng giải pháp task gối đầu của mình cho 1 số loại job và vận hành tốt với lượng job concurrency khá lớn. Hy vọng các bạn có thể đóng góp thêm nếu có bất cứ ý kiến cải thiện nào. </p>
<p>Cảm ơn các bạn vì đã quan tâm 1 bài viết dài vãi lúa thế này. </p>'),

-- Tôi đã clone diễn đàn Voz như thế nào. --
(3, N'Tôi đã clone diễn đàn Voz như thế nào.', '2020/03/09', 'anhnc', 61, null,
N'<h1>Ý tưởng</h1>
<p>Diễn đàn <strong>voz</strong> không còn qúa xa lạ với nhiều dev. Giao diện cổ của nó khi dùng mobile thì ức chế lòi dom. Đợt làm lại next voz tưởng ngon hơn, ai ngờ vứt cái phân trang đi, nhiều hôm vào đọc topic đang theo dõi mà kéo mỏi cả tay. </p>
<p>Cộng với thói quen đọc tít để hiểu vấn đề của các vozer thông minh :)), lại muốn sắp xếp lại đống dữ liệu cho nó dễ nhìn hơn. Nhìn phát là biết hôm nay có gì hot.</p>
<p>Chung quy lại thì chỉ là phục vụ cá nhân mình : <strong>dễ dùng, thận thiện với mobile, thu lượm thông tin trong một cái vuốt.</strong></p>
<p><a href="https://voz.now.sh/">https://voz.now.sh/</a></p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/yb6ykwy90h_screencapture-voz-now-sh-f17-2020-03-01-11_09_49.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/yb6ykwy90h_screencapture-voz-now-sh-f17-2020-03-01-11_09_49.png" alt="alt text"></a><a></a></p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/f03r7hu25w_Screenshot%20from%202020-03-01%2011-21-33.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/f03r7hu25w_Screenshot%20from%202020-03-01%2011-21-33.png" alt="alt text"></a><a></a></p>
<h1>Giải quyết</h1>
<h3>Công nghệ</h3>
<p>Vì chỉ là cái trang dành cho mình, không cần tiền để duy trì hosting. Cũng chả có nhu cần đặt quảng cáo mà cướp mất vị trí của trang chính trên Google. </p>
<p>Do đó mình chọn <strong>now.sh</strong> để tầm gửi, không sử dụng nuxtJS (framework hỗ trợ SEO), mà chỉ dùng VueJS và nền tảng backend của Now.sh làm server side.</p>
<p>Chọn một project mặc định mà now.sh gợi ý (<a href="https://zeit.co/import/templates">https://zeit.co/import/templates</a>)</p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/2jz49wst9w_Screenshot%20from%202020-03-01%2010-47-58.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/2jz49wst9w_Screenshot%20from%202020-03-01%2010-47-58.png" alt="alt text"></a><a></a></p>
<p>Thêm mắm muối cho cháu nó sinh động hơn.</p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/gfnyag0f0u_Screenshot%20from%202020-03-01%2010-49-17.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/gfnyag0f0u_Screenshot%20from%202020-03-01%2010-49-17.png" alt="alt text"></a><a></a></p>
<h3>BackEnd</h3>
<p>Ở đây sẽ là forder <code>[api]</code>, mình sẽ sử dụng <strong>axios</strong> để get dữ liệu, sau đó dùng <strong>cheerio</strong> để bóc tách dữ liệu trong đó.</p>
<p>Để tối giản việc viết code, mình đưa các config selector cho cheerio bóc tách vào <code>selector.js</code> như sau:</p>
<p>Config các thẻ selector (cái này có thể đẩy lên database)<br>
<a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/envkwmp8ae_Screenshot%20from%202020-03-01%2010-56-45.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/envkwmp8ae_Screenshot%20from%202020-03-01%2010-56-45.png" alt="alt text"></a><a></a></p>
<p>Load các thẻ selector lên và bóc tác trong source.<br>
<a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/po13z0e0wv_Screenshot%20from%202020-03-01%2010-56-01.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/po13z0e0wv_Screenshot%20from%202020-03-01%2010-56-01.png" alt="alt text"></a><a></a></p>
<p>Do admin voz config server của họ, cứ quá nhiều request trên 1 ip đến server voz. Nó sẽ response chậm lại. Gây nên tình trạng load dữ liệu trên các trang siêu nhậm, hoặc là đứng yên khi nhiều người cùng truy cập. Mình đã tiến hành sử dụng app script của google để transfer thêm dữ liệu của họ về bóc tách.</p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/c34fx4a7jc_Screenshot%20from%202020-03-09%2008-43-49.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/c34fx4a7jc_Screenshot%20from%202020-03-09%2008-43-49.png" alt="alt text"></a><a></a></p>
<pre><code>@DangXuanThanh : đoạn này chắc mình sẽ edit lại.
</code></pre>
<p>Hiện tại mình đang chỉ dùng 1 ip của now.sh cung cấp cho đọc source voz.vn. Sẽ bị block request khi đông người truy cập vào trang của mình. Nên mình sẽ dùng bot của Google thông qua Google App script (URLFetchAPI) cào dữ liệu. Gia tặng dải IP request lên voz.vn, tránh bị block.</p>
<p><a href="https://developers.google.com/apps-script/guides/web">https://developers.google.com/apps-script/guides/web</a></p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/5k6f9byd9b_Screenshot%20from%202020-03-01%2011-02-25.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/5k6f9byd9b_Screenshot%20from%202020-03-01%2011-02-25.png" alt="alt text"></a><a></a></p>
<h3>FrontEnd</h3>
<p>Vì mình đoán mọi người chỉ quan tâm nhiều đên việc BE cào dữ liệu ra sao. Nên mình không nói về code phần này nữa. </p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/egzhevbi7k_screencapture-voz-now-sh-f17-2020-03-03-11_37_03.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/egzhevbi7k_screencapture-voz-now-sh-f17-2020-03-03-11_37_03.png" alt="alt text"></a><a></a></p>
<h1>Kết</h1>
<p>Bài viết trên chỉ nói sơ qua về bài toán giải quyết nhu cầu cá nhân, có lẽ sẽ chả áp dụng được trong công việc có nhu cầu thực tế cao hơn. Mong các anh chị em đi qua dúi cho cái phê bình để mình tiến bộ.</p>
</section>'),

-- Làm thế nào để thay đổi cuộc đời bạn? --
(4, N'Làm thế nào để thay đổi cuộc đời bạn?', '2017/10/24', 'junookyo', 44, null,
N'<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/p9ia8wdsjg_How-To-Change-Your-Life.png"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/p9ia8wdsjg_How-To-Change-Your-Life.png" alt="change-your-life"></a><a></a></p>
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
<h3>Làm sao để biến một nguyện vọng thành một thay đổi hàng ngày</h3>
<p>Hãy điểm tên một vài nguyện vọng:</p>
<ul>
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
<ul>
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
<h3>Cách thực hiện thay đổi hàng ngày</h3>
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
(5, N'21 trang web hay mà bạn có thể ghé thăm mỗi khi rảnh rỗi', '2017/01/19', 'junookyo', 25, null,
N'<p>Bạn thấy chán các trang web cũ? Muốn tìm một vài góc mới của Internet để giúp bạn tìm lại sự hứng thú? Tốt thôi, bạn đã gặp may đấy. Dù bạn đang tìm những trò chơi ngớ ngẩn hay điều gì đó hữu ích thì dưới đây là 21 trang web hay mà bạn nên ghé qua.</p>
<h3>1. <a href="http://www.ted.com/talks">TED</a>
</h3>
<p>Với hơn 1900 bài talk thú vị và đầy cảm hứng, chắc chắn bạn sẽ tìm được điều gì đó mà bạn thích.</p>
<h3>2. <a href="http://www.differencebetween.net/">Difference Between</a>
</h3>
<p>Bạn muốn tìm hiểu sự khác biệt giữa bất cứ điều gì? Ví dụ giữa <a href="http://www.differencebetween.net/technology/internet/difference-between-api-and-web-service/">API và Web Service</a>.</p>
<h3>3. <a href="http://www.wonder-tonic.com/geocitiesizer/index.php">The Geocities-izer</a>
</h3>
<p>Biến bất cứ trang web nào thành một trang với giao diện xấu xí như những năm 90.</p>
<p><a class="fluidbox" href="https://1.bp.blogspot.com/-mn9EnLVpkdE/WIAlBlbtYZI/AAAAAAAADb4/7gSodZOdM1AokMsDJYrZz8LXW8XjsXk4wCEw/s1600/trang-web-hay-Geocities-izer.jpg"><img src="https://1.bp.blogspot.com/-mn9EnLVpkdE/WIAlBlbtYZI/AAAAAAAADb4/7gSodZOdM1AokMsDJYrZz8LXW8XjsXk4wCEw/s1600/trang-web-hay-Geocities-izer.jpg" alt="Geocities-izer"></a><a></a></p>
<h3>4. <a href="https://en.wikipedia.org/wiki/Special:Random">Wikipedia Random</a>
</h3>
<p><em>Rơi vào hố thỏ</em> và khám phá những chủ đề ngẫu nhiên trên Wikipedia.</p>
<h3>5. <a href="http://www.whizzpast.com/">Whizzpast</a>
</h3>
<p>Nơi tuyệt vời nhất trên Internet để tìm hiểu về những điều tuyệt vời trong lịch sử.</p>
<h3>6. <a href="http://www.findtheinvisiblecow.com/">Find the Invisible Cow</a>
</h3>
<p>Hãy chắc chắn rằng bạn đã mở loa (nhưng đừng quá to <img class="emoji" title=":trollface:" alt=":trollface:" src="https://github.githubassets.com/images/icons/emoji/trollface.png" height="20" width="20" align="absmiddle">).</p>
<h3>7. <a href="http://www.sporcle.com/">Sporcle</a>
</h3>
<p>Giải hàng ngàn câu đố hoặc tự bạn tạo ra.</p>
<h3>8. <a href="https://www.zooniverse.org/">Zooniverse</a>
</h3>
<p>Trở thành một phần của những dự án khoa học thực sự (ví dụ như khám phá bề mặt của mặt trăng) bằng cách tham gia nghiên cứu online.</p>
<h3>9. <a href="http://lang-8.com/">Lang-8</a>
</h3>
<p>Viết trong một ngôn ngữ mà bạn đang học và người bản xứ sẽ sửa các lỗi của bạn.</p>
<h3>10. <a href="http://weavesilk.com/">Silk</a>
</h3>
<p>Tạo ra các tác phẩm nghệ thuật với con chuột của bạn.</p>
<p><a class="fluidbox" href="https://4.bp.blogspot.com/-hUtNEsHgc9Q/WIAlB5jzZ-I/AAAAAAAADb8/icB7xaN_iJ4GOuPqZilkSgtZRUPqhqL8QCLcB/s1600/trang-web-hay-Silk.jpg"><img src="https://4.bp.blogspot.com/-hUtNEsHgc9Q/WIAlB5jzZ-I/AAAAAAAADb8/icB7xaN_iJ4GOuPqZilkSgtZRUPqhqL8QCLcB/s1600/trang-web-hay-Silk.jpg" alt="Silk"></a><a></a></p>
<h3>11. <a href="http://www.lettersofnote.com/">Letters of Note</a>
</h3>
<p>Một bộ sưu tập tuyệt vời của các chữ cái hấp dẫn, bưu thiếp, điện tín và các ghi chú trong quá khứ.</p>
<h3>12. <a href="https://www.khanacademy.org/">Khan Academy</a>
</h3>
<p>Nếu bạn đang muốn học hỏi thêm điều gì đó thì Khan Academy có hàng trăm khóa học giáo dục miễn phí dành cho bạn.</p>
<h3>13. <a href="https://geoguessr.com/">GeoGuessr</a>
</h3>
<p>Đoán xem hình chụp bởi Google Streetview là ở nơi nào trên thế giới.</p>
<p><a class="fluidbox" href="https://2.bp.blogspot.com/-yd6gIzi90KQ/WIAlBbzAsGI/AAAAAAAADb0/aKQSISIsZQoAFNRMC6_AHtIK5BghblREQCEw/s1600/trang-web-hay-GeoGuessr.jpg"><img src="https://2.bp.blogspot.com/-yd6gIzi90KQ/WIAlBbzAsGI/AAAAAAAADb0/aKQSISIsZQoAFNRMC6_AHtIK5BghblREQCEw/s1600/trang-web-hay-GeoGuessr.jpg" alt="GeoGuessr"></a><a></a></p>
<h3>14. <a href="http://feelgoodwardrobe.com/">Feel Good Wardrobe</a>
</h3>
<p>Trang cung cấp mẹo để mua quần áo.</p>
<h3>15. <a href="http://www.ineedaprompt.com/">I Need a Prompt</a>
</h3>
<p>Giống trang You Should Write, nhưng dành cho các nghệ sĩ.</p>
<h3>16. <a href="http://www.omegle.com/">Omegle</a>
</h3>
<p>Cảm thấy muốn nói chuyện với ai đó? Omegle giúp bạn nói chuyện (qua tin nhắn hoặc video) với một người lạ.</p>
<h3>17. <a href="http://www.myscriptfont.com/">My Script Font</a>
</h3>
<p>Tạo ra một font dựa trên chữ viết tay của chính bạn.</p>
<h3>18. <a href="http://www.liveplasma.com/">Live Plasma</a>
</h3>
<p>Live Plasma là một cỗ máy khám phá âm nhạc. Chỉ cần gõ vào một nghệ sĩ mà bạn thích và nó sẽ hiển thị những nghệ sĩ tương tự.</p>
<h3>19. <a href="http://hippopaint.fidsah.org/">Hippo Paint</a>
</h3>
<p>Một cuốn sách tô màu hoàn hảo cho cả trẻ em và người lớn - chỉ cần gõ vào thứ gì đó mà bạn thích vẽ và nó sẽ cung cấp cho bạn những hình ảnh.</p>
<p><a class="fluidbox" href="https://4.bp.blogspot.com/-ITUqw_y4QB8/WIAlBQKKbhI/AAAAAAAADbw/jNJpr_KrsE8Vj-NZ-53dDhmWXoKVD7FSQCEw/s1600/trang-web-hay-Hippo-Paint.jpg"><img src="https://4.bp.blogspot.com/-ITUqw_y4QB8/WIAlBQKKbhI/AAAAAAAADbw/jNJpr_KrsE8Vj-NZ-53dDhmWXoKVD7FSQCEw/s1600/trang-web-hay-Hippo-Paint.jpg" alt="Hippo-Paint"></a><a></a></p>
<h3>20. <a href="http://en.akinator.com/#">Akinator</a>
</h3>
<p>Một phù thủy thực sự.</p>
<h3>21. <a href="http://www.kongregate.com/">Kongregate</a>
</h3>
<p>Hàng ngàn trò chơi trực tuyến miễn phí, từ những tên tuổi lớn cho đến tư nhân.</p>
<p>© <a href="https://junookyo.blogspot.com/2017/01/21-trang-web-hay-nen-ghe-tham.html?utm_source=kipalog">Juno_okyo</a> theo <a href="http://inktank.fi/most-entertaining-websites/">inktank.fi</a></p>
<hr>
<p><img class="emoji" title=":point_right:" alt=":point_right:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f449.png" height="20" width="20" align="absmiddle"> Theo dõi Juno_okyo trên <a href="http://kipalog.com/users/juno_okyo/mypage">Kipalog</a> để nhận được thông báo khi có bài viết mới! <img class="emoji" title=":wink:" alt=":wink:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f609.png" height="20" width="20" align="absmiddle"></p>
<p><img class="emoji" title=":point_right:" alt=":point_right:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f449.png" height="20" width="20" align="absmiddle"> Social Networks: <a href="https://fb.com/907376185983675">Facebook</a> · <a href="https://twitter.com/juno_okyo">Twitter</a> · <a href="https://plus.google.com/108443613096446306111">Google+</a> · <a href="https://github.com/J2TeaM">GitHub</a></p>
</section>'),

-- Lỗ hổng bảo mật Cross-Site-Scripting (XSS) có gì nguy hiểm? --
(6, N'Lỗ hổng bảo mật Cross-Site-Scripting (XSS) có gì nguy hiểm?', '2016/08/30', 'junookyo', 28, null,
N'<p>Mỗi khi đăng những bài <a href="https://junookyo.blogspot.com/search/label/Write-up">writeup</a> về một <a href="https://junookyo.blogspot.com/search/label/XSS">lỗ hổng XSS</a> được phát hiện trên một trang web nào đó, tôi biết sẽ có những người nhếch mép cười khẩy vì lúc đó trong đầu họ sẽ nghĩ:</p>
<ul>
<li>"Cái lỗi XSS này thì có cái quái gì nguy hiểm cơ chứ?"</li>
<li>"Ngoài việc hiện lên một hộp thoại thì XSS làm được cái đếch gì nữa không?"</li>
<li>"Một lỗ hổng vớ vẩn thôi mà. Ơ mà hiện hộp thoại cũng được gọi là lỗ hổng hả?"</li>
<li>...</li>
</ul>
<p>Vậy thì, <strong>XSS có gì nguy hiểm?</strong> <img class="emoji" title=":sweat_smile:" alt=":sweat_smile:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f605.png" height="20" width="20" align="absmiddle"></p>
<p><a class="fluidbox" href="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/xss-cross-site-scripting-tutorial.png_mietrx071d"><img src="https://s3-ap-southeast-1.amazonaws.com/kipalog.com/xss-cross-site-scripting-tutorial.png_mietrx071d" alt="xss"></a><a></a></p>
<p>Thay vì viết ra đống lý thuyết nhàm chán, chúng ta sẽ cùng xem xét <strong>những hình thức tấn công khai thác XSS đã được áp dụng trong thực tiễn</strong>. Nói trước để những bạn nào còn chưa biết về XSS thì nên Google xem nó là gì trước khi đọc tiếp bài viết này nha.</p>
<h3>XSS worm</h3>
<p><a href="https://en.wikipedia.org/wiki/XSS_worm">XSS worm</a> là một dạng sâu/mã độc trên nền web và hiển nhiên là viết bằng JavaScript với mục tiêu lây nhiễm tới toàn bộ người dùng truy cập vào trang web. Ví dụ điển hình thường gặp nhất là trên mạng xã hội Facebook.</p>
<p>Với số lượng người dùng quá lớn của mình, XSS worm có tốc độ phát tán chóng mặt trên Facebook mà chúng ta thường thấy theo hình thức: A bị nhiễm &gt; gửi tin nhắn chứa mã độc cho B, C, D,... (nằm trong danh sách bạn bè của A). B, C, D và những người bạn đó cũng tiếp tục gửi tin nhắn cho toàn bộ bạn bè của chính họ. Và thế là con worm được lây lan theo cấp số nhân không thể kiểm soát.</p>
<p>* Để có thể gửi được tin nhắn, XSS worm sẽ kết hợp với <a href="https://junookyo.blogspot.com/search/label/CSRF">CSRF</a>.</p>
<p><a class="fluidbox" href="https://2.bp.blogspot.com/-O4TQBgM_mo0/V8VUsWzWZLI/AAAAAAAADGg/pHewjtkAbFo9chWoVBZBdMZGOnSP8IgmQCLcB/s1600/xss-worm.png"><img src="https://2.bp.blogspot.com/-O4TQBgM_mo0/V8VUsWzWZLI/AAAAAAAADGg/pHewjtkAbFo9chWoVBZBdMZGOnSP8IgmQCLcB/s1600/xss-worm.png" alt="xss"></a><a></a></p>
<p>Thông tin thêm: Trên Facebook còn một hình thức phổ biến khác được gọi là <a href="https://www.facebook.com/help/246962205475854">Self-XSS</a> (loại này kết hợp với kỹ năng <a href="https://en.wikipedia.org/wiki/Social_engineering_(security)">Social engineering</a>). Facebook luôn cảnh báo mỗi khi bạn nhấn F12 (mở Console) chính là để bảo vệ bạn khỏi biến thể XSS này.</p>
<h3>Browser-based Botnet</h3>
<p>Năm 2014, hãng bảo mật Incapsula (đối thủ của CloudFlare) đã có <a href="https://www.incapsula.com/blog/world-largest-site-xss-ddos-zombies.html">bài viết</a> về vụ việc một trong những trang web lớn nhất thế giới (Top 50 Alexa) bị hack, khiến toàn bộ người truy cập trở thành zombie cho một cuộc tấn công DDoS. Và các bạn đoán được điều gì đã biến người dùng trở thành zombie không? Vâng, chính là XSS. Cụ thể trong trường hợp này là một lỗ hổng <a href="http://www.acunetix.com/blog/articles/persistent-cross-site-scripting/">Persistent XSS</a>.</p>
<p>Dựa theo bài viết, thì lỗ hổng nằm trong phần thay đổi ảnh hồ sơ (avatar/profile picture). Kẻ tấn công đã chèn đoạn mã độc JavaScript vào thẻ <code>&lt;img&gt;</code> sử dụng sự kiện onload, mỗi khi ảnh được tải thì đồng nghĩa với việc đoạn JS kia sẽ được thực thi.</p>
<p><a class="fluidbox" href="https://1.bp.blogspot.com/-v4Zeuc9kYEk/V8VUsUI18XI/AAAAAAAADGc/sbdqx4_q9KEEcExljLpY2InkjBa5bHDiACLcB/s1600/xss-ddos-world-largest-site.jpg"><img src="https://1.bp.blogspot.com/-v4Zeuc9kYEk/V8VUsUI18XI/AAAAAAAADGc/sbdqx4_q9KEEcExljLpY2InkjBa5bHDiACLcB/s1600/xss-ddos-world-largest-site.jpg" alt="xss"></a><a></a></p>
<p>Vì là trang web nằm top nên lưu lượng người truy cập lớn đã bị lợi dụng để thực thi đoạn JS sử dụng truy vấn Ajax trỏ vào trang web bất kỳ. Và thế là trang web đó trở thành nạn nhân bị DDoS.</p>
<p>* Thông tin thêm: Cách đây 3, 4 năm tôi có phát hiện ra một lỗ hổng SQL Injection trong một diễn đàn lớn (hiện vẫn trong Top 500 Alexa VN) sử dụng vBB. Sau khi liên hệ báo lỗi với Ban Quản Trị nhưng lại bị chửi vì họ một mực khẳng định tôi "có âm mưu phá hoại diễn đàn" của họ, lúc ấy tôi giận lắm <img class="emoji" title=":angry:" alt=":angry:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f620.png" height="20" width="20" align="absmiddle"></p>
<p>Với lỗ hổng SQLi trong tay, tôi khai thác được Password (hash) và <a href="https://en.wikipedia.org/wiki/Salt_(cryptography)">Salt</a> của toàn bộ tài khoản Admin sau đó crack ra được mật khẩu (plain text) của một tài khoản. Truy cập vào AdminCP trong phần tạo thông báo, tôi chèn một đoạn JavaScript tạo truy vấn trỏ thằng về Blog của tôi. Nói thẳng là tự DDoS đi cho dễ hiểu, vì tôi biết chắc Blog của tôi không thể sập được (Google bảo kê mà, hehe). Kết quả là số người truy cập diễn đàn kia trở thành lượng traffic lớn dội thẳng vào Blog của tôi, rank Alexa tăng vọt <img class="emoji" title=":trollface:" alt=":trollface:" src="https://github.githubassets.com/images/icons/emoji/trollface.png" height="20" width="20" align="absmiddle"></p>
<p><a class="fluidbox" href="https://2.bp.blogspot.com/-mDOdN0fAzK4/V8VUsDZGgYI/AAAAAAAADGY/0ETQWy84pn05cwjBn5VNldttxmRsTvYcACLcB/s1600/xss-based-botnet-ddos.png"><img src="https://2.bp.blogspot.com/-mDOdN0fAzK4/V8VUsDZGgYI/AAAAAAAADGY/0ETQWy84pn05cwjBn5VNldttxmRsTvYcACLcB/s1600/xss-based-botnet-ddos.png" alt="juno-okyo-blog"></a><a></a></p>
<h3>XSS &gt; CSRF &gt; Upload Web-Shell</h3>
<p>Đây là kịch bản mà tôi quen thuộc nhất vì đã áp dụng nó rất nhiều, từ hồi vBB (vBulletin) còn phổ biến. Ngoài ra thì kịch bản này thường dễ áp dụng với WordPress do cấu trúc quản lý plugin của nền tảng này. Chi tiết về cách thức tấn công:</p>
<ol>
<li>Tìm một lỗ hổng XSS.</li>
<li>Thử chiếm Security Token của người dùng dựa theo lỗ hổng XSS tìm thấy.</li>
<li>Sử dụng Security Token để tạo plugin (hoặc thay đổi code của plugin có sẵn), từ đó có được Form Upload.</li>
<li>Sử dụng Form Upload ở bước 3 để tải lên Web-Shell. Bạn đã toàn quyền quản lý trang web đó thông qua Web-Shell. Lúc này có thể bắt đầu cài cắm back-door hoặc tải toàn bộ Cơ sở dữ liệu của trang web về.</li>
</ol>
<p>* Bạn có thể tạo ra web-shell ngay từ bước 3 nhưng thường thì code của một con shell rất lớn, có thể ảnh hưởng tới tốc độ truy vấn khi khai thác. Do đó tôi thường tạo ra một Form Upload trước.</p>
<p>Ảnh demo trong vBB:</p>
<p><a class="fluidbox" href="https://2.bp.blogspot.com/-w1vC0thWTBM/V8VVmvBb2cI/AAAAAAAADGo/nIi_2r-n0dQveeX_tE4QIqZzYZoxvbeeACLcB/s1600/xss-csrf-upload-shell.png"><img src="https://2.bp.blogspot.com/-w1vC0thWTBM/V8VVmvBb2cI/AAAAAAAADGo/nIi_2r-n0dQveeX_tE4QIqZzYZoxvbeeACLcB/s1600/xss-csrf-upload-shell.png" alt="xss-vbb"></a><a></a></p>
<p>Video demo quá trình khai thác lỗ hổng DOM-based XSS trong Yoast SEO (a.k.a WordPress SEO) - một trong những plugin được sử dụng nhiều nhất theo thống kê từ WordPress.</p>
<p> <div class="iframe-wrapper youtube">
<iframe frameborder="0" allowfullscreen src="//www.youtube.com/embed/78_g3PSAAcM"></iframe>
</div>
</p>
<h3>Tổng kết</h3>
<p>Trong bài viết này, tôi đã đưa ra 3 kịch bản nguy hiểm nhất khi khai thác lỗ hổng bảo mật XSS theo đánh giá của cá nhân tôi. Ngoài ra sẽ còn rất nhiều kịch bản khác dựa theo sức sáng tạo và kỹ năng của một Hacker. Bạn còn biết kịch bạn nào thú vị hơn? Hãy để lại dưới phần bình luận nhé! ;)</p>
<blockquote>
<p>"Ờ thì nghe cũng có vẻ nguy hiểm đấy, nhưng sao tôi thấy ông hay viết về XSS thế? Rảnh quá hả!?"</p>
</blockquote>
<p>À... một lỗi vừa phổ biến, nằm top 10 OWASP, lại vừa nguy hiểm, có thể kết hợp tốt với các lỗi khác. Nhưng dễ tìm, dễ fix, đã thế còn được tính bug bounty nữa.</p>
<p><a class="fluidbox" href="https://4.bp.blogspot.com/-qTmx8xcOekQ/V8VWGypLDlI/AAAAAAAADGs/7EUGngPs0q8qM1W-K2PKfR5bbdUgeJgCwCLcB/s1600/juno-okyo-hack-phimmoi-net.png"><img src="https://4.bp.blogspot.com/-qTmx8xcOekQ/V8VWGypLDlI/AAAAAAAADGs/7EUGngPs0q8qM1W-K2PKfR5bbdUgeJgCwCLcB/s1600/juno-okyo-hack-phimmoi-net.png" alt="xss-bug-bounty"></a><a></a></p>
<p>Vậy tại sao "không" chứ? <img class="emoji" title=":wink:" alt=":wink:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f609.png" height="20" width="20" align="absmiddle"></p>
<p>Happy Hacking! :)</p>
<hr>
<p><img class="emoji" title=":point_right:" alt=":point_right:" src="https://github.githubassets.com/images/icons/emoji/unicode/1f449.png" height="20" width="20" align="absmiddle"> Theo dõi Juno_okyo trên <a href="http://kipalog.com/users/juno_okyo/mypage">Kipalog</a> · <a href="https://fb.com/907376185983675">Facebook</a> · <a href="https://twitter.com/juno_okyo">Twitter</a> · <a href="https://plus.google.com/108443613096446306111">Google+</a> · <a href="http://goo.gl/J92rsc">Youtube</a></p>
</section>');
select * from userinfo
