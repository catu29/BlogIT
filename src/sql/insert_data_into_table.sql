Use BlogIT;
------------------------------------------------------------------
--------------- INSERT DATA -----------------

Insert into User values
(1, 'admin', 'admin@gmail.com', N'Admin', 'defaut-user.png', N'Hiền lành, dễ thương, vui tính', 1),
(2, 'minhmonmen', 'minhmonmen@gmail.com', N'Minh Monmen', 'minhmonmen.jpg', N'Bio của Minh mon men',0),
(3, 'hoangxuantruong', 'hoangxuantruong@gmail.com', N'Hoàng Xuân Trường', 'logoava.jpg', N'Bio của Hoàng Xuân Trường', 0),
(4, 'dainguyen', 'dainguyen@gmail.com', N'Dai Nguyen', 'dog.jpg', N'Bio của Đại Nguyễn', 0),
(5, 'luuxuantrong', 'luuxuantrong@gmail.com', N'Lưu Xuân Trọng', 'logoava.jpg', N'Bio của Lưu Xuân Trọng', 0),
(6, 'anhnc', 'anhnc@gmail.com', N'Anh NC', 'cat.jpg', N'Bio của Anh NC', 0),
(7, 'dangxuanthanh', 'dangxuanthanh@gmail.com', N'Đặng Xuân Thành', 'flower.jpg', N'Bio của Đặng Xuân Thành', 0),
(8, 'junookyo', 'junookyo@gmail.com', N'Juno_okyo', 'djunookyo.jpg', N'Bio của Mạnh Tuấn', 0),
(9, 'beautyoncode', 'beautyoncode@gmail.com', N'BeautyOnCode', 'beautyoncode.jpg', 'Đam mê Python', 0);


Insert into PostComment values
(1, 3, 1, N'Hay', '2019/11/21 00:00:00', null),
(2, 2, 1, N'Thank you', '2019/11/21 00:00:00', null),
(3, 7, 2, N'Like vì 2 con dê', '2020/04/18 00:00:00', null),
(4, 8, 3, N'Có gì tiếc mà không kipalog cho những bài viết như thế này', '2020/04/18 00:00:00', null),
(5, 6, 5, N'Ui hữu ích quá boss Tuấn ơi', '2017/01/19 00:00:00', null),
(6, 5, 5, N'Cảm ơn bạn', '2017/01/19 00:00:00', 5);


Insert into PostLike values
(1, 2, '2020/06/20 00:00:00'),
(1, 9, '2020/06/20 00:00:00'),
(2, 8, '2020/06/20 00:00:00'),
(1, 3, '2020/06/20 00:00:00'),
(3, 2, '2020/06/20 00:00:00'),
(2, 5, '2020/06/20 00:00:00');


Insert into UserSeriesList values
(1, 2, N'Nghệ thuật xử lý background job', 'nghe-thuat-xu-ly-background-job'),
(2, 4, N'Tìm hiểu về RabbitMQ', 'tim-hieu-ve-rabbit-mq');



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
('security', 'Security'),
('C#', 'C#');

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
(6, 'security'),
(7, 'python'),
(7, 'til'),
(8, 'python'),
(9, 'mq'),
(10, 'mq'),
(11, 'mq');