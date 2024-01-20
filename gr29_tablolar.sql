CREATE TABLE Kullanici(
	UserID serial primary key,
	fname varchar(20) NOT NULL,
	lname varchar(20) NOT NULL,
	nickname varchar(50) NOT NULL,
	passwords varchar(16) check(char_length(passwords) >= 8) NOT NULL
);

CREATE TABLE Admin(
	nickname varchar(50) NOT NULL,
	passwords varchar(16) check(char_length(passwords) >= 8) NOT NULL
);

CREATE TABLE Company(
	company_id int NOT NULL,
	company_name varchar(20),
	konum varchar(30),
	iletisim varchar(30),
	primary key (company_id)
);

CREATE TABLE IF NOT EXISTS Sertifika_programlari (
	sertifika_id SERIAL PRIMARY KEY,
	company_id INT NOT NULL,
	sertifika_adi VARCHAR(50) NOT NULL,
	sertifika_tarihi DATE NOT NULL,
	FOREIGN KEY (company_id) REFERENCES Company(company_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Sertifika_basvuru (
	basvuru_id SERIAL PRIMARY KEY,
	sertifika_id INT NOT NULL,
	basvuran_id INT NOT NULL,
	FOREIGN KEY (sertifika_id) REFERENCES Sertifika_programlari(sertifika_id),
	FOREIGN KEY (basvuran_id) REFERENCES Kullanici(UserID)
);

CREATE TABLE Profil (
	usr_id INT PRIMARY KEY,
	okul VARCHAR(30),
	department VARCHAR(30),
	deneyim VARCHAR(30),
	email VARCHAR(30),
	FOREIGN KEY (usr_id) REFERENCES Kullanici(UserID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ilanlar (
    ilan_id SERIAL PRIMARY KEY,
    ilan_ismi VARCHAR(255) NOT NULL,
    ilan_tarihi DATE NOT NULL,
    aciklama TEXT,
    company_id INT NOT NULL,
    FOREIGN KEY (company_id) REFERENCES company(company_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Basvurular (
    basvuru_id SERIAL PRIMARY KEY,
    ilan_id INT NOT NULL,
    basvuran_id INT NOT NULL,
    FOREIGN KEY (ilan_id) REFERENCES ilanlar(ilan_id),
    FOREIGN KEY (basvuran_id) REFERENCES Kullanici(UserID)
);

CREATE TABLE IF NOT EXISTS Basvuru_sonuclari (
    basvuru_id INT NOT NULL,
    sonuc_durumu VARCHAR(50) CHECK (sonuc_durumu IN ('Kabul', 'Red', 'Beklemede')) NOT NULL,
    PRIMARY KEY (basvuru_id),
    FOREIGN KEY (basvuru_id) REFERENCES Basvurular(basvuru_id)
);


--Kullanici tablosu:

insert into Kullanici (UserID, fname, lname, passwords, nickname) values (253678, 'Stanford', 'Esley', '12345esley','StanfordEsley253678');
insert into Kullanici (UserID, fname, lname, passwords, nickname) values (253679, 'Annice', 'Palk', '12345palk','AnnicePalk253679');
insert into Kullanici (UserID, fname, lname, passwords, nickname) values (253680, 'Armin', 'Leall', '12345leall','ArminLeall253680');
insert into Kullanici (UserID, fname, lname, passwords, nickname) values (253681, 'Trixy', 'Toville', '12345totrix','TrixyToville253681');
insert into Kullanici (UserID, fname, lname, passwords, nickname) values (253682, 'Salaidh', 'Dart', 'dart56789','SalaidhDart253682');
insert into Kullanici (UserID, fname, lname, passwords, nickname) values (253683, 'North', 'Cannaway', '22north22','NorthCannaway253683');
insert into Kullanici (UserID, fname, lname, passwords, nickname) values (253684, 'Caroljean', 'Leeder', 'carol13jean','CaroljeanLeeder253684');
insert into Kullanici (UserID, fname, lname, passwords, nickname) values (253685, 'Gabi', 'Brinsden', 'gabi01sden','GabiBrinsden253685');
insert into Kullanici (UserID, fname, lname, passwords, nickname) values (253686, 'Minette', 'Rank', 'mine61rank','MinetteRank253686');
insert into Kullanici (UserID, fname, lname, passwords, nickname) values (253687, 'Stefan', 'Farnall', 'stef17an11','StefanFarnall253687');

--Admin tablosu:

insert into Admin (nickname, passwords) values ('BeyzaF�nd�k','12345beyza');
insert into Admin (nickname, passwords) values ('EbruK�l��','12345ebru');
insert into Admin (nickname, passwords) values ('Merve�ak�r','12345merve');
insert into Admin (nickname, passwords) values ('SevdaKarahan','12345sevda');

--Company tablosu:

insert into Company (company_id, company_name, konum, iletisim) values (1880, 'Linkbuzz', 'Ankara', 'linkbuzz@mail.com');
insert into Company (company_id, company_name, konum, iletisim) values (4606, 'Centidel', 'Ankara', 'centidelAnkara@mail.com');
insert into Company (company_id, company_name, konum, iletisim) values (4811, 'Jazzy', 'Istanbul', 'JazzyIst@mail.com');
insert into Company (company_id, company_name, konum, iletisim) values (1453, 'Kazu', 'Istanbul', 'KazuIstanbul@mail.com');
insert into Company (company_id, company_name, konum, iletisim) values (1077, 'Trudeo', 'Kocaeli', 'Trudeo@mail.com');
insert into Company (company_id, company_name, konum, iletisim) values (6839, 'Kazu', 'Tokyo', 'KazuTokio@mail.com');
insert into Company (company_id, company_name, konum, iletisim) values (3257, 'Limbo', 'Ankara', 'limboAnkara@mail.com');
insert into Company (company_id, company_name, konum, iletisim) values (4657, 'Martı', 'Istanbul', 'MartıTR@mail.com');
insert into Company (company_id, company_name, konum, iletisim) values (6020, 'Layo', 'Ankara', 'Layoo@mail.com');
insert into Company (company_id, company_name, konum, iletisim) values (5522, 'Shuffledrive', 'Kocaeli', 'Shuffledrive@mail.com');

-- Sertifika_programlari tablosu:

insert into Sertifika_programlari (sertifika_id, company_id, sertifika_adi, sertifika_tarihi) values (1, 1880, 'Software Development Certificate', '2022-05-20');
insert into Sertifika_programlari (sertifika_id, company_id, sertifika_adi, sertifika_tarihi) values (2, 4606, 'Data Analysis Certificate', '2022-07-15');
insert into Sertifika_programlari (sertifika_id, company_id, sertifika_adi, sertifika_tarihi) values (3, 4811, 'Project Management Certification', '2022-09-30');
insert into Sertifika_programlari (sertifika_id, company_id, sertifika_adi, sertifika_tarihi) values (4, 1453, 'Cloud Computing Certificate', '2022-11-10');
insert into Sertifika_programlari (sertifika_id, company_id, sertifika_adi, sertifika_tarihi) values (5, 1077, 'Digital Marketing Certification', '2023-01-05');
insert into Sertifika_programlari (sertifika_id, company_id, sertifika_adi, sertifika_tarihi) values (6, 6839, 'Cybersecurity Certificate', '2023-03-20');
insert into Sertifika_programlari (sertifika_id, company_id, sertifika_adi, sertifika_tarihi) values (7, 3257, 'Machine Learning Certification', '2023-05-15');
insert into Sertifika_programlari (sertifika_id, company_id, sertifika_adi, sertifika_tarihi) values (8, 4657, 'Network Administration Certificate', '2023-07-01');
insert into Sertifika_programlari (sertifika_id, company_id, sertifika_adi, sertifika_tarihi) values (9, 6020, 'Web Development Certification', '2023-09-10');
insert into Sertifika_programlari (sertifika_id, company_id, sertifika_adi, sertifika_tarihi) values (10, 5522, 'Database Management Certificate', '2023-11-25');

-- Sertifika_basvuru tablosu:

insert into Sertifika_basvuru (sertifika_id, basvuran_id, basvuru_id) values (1, 253678, 100101);
insert into Sertifika_basvuru (sertifika_id, basvuran_id, basvuru_id) values (2, 253679, 100102);
insert into Sertifika_basvuru (sertifika_id, basvuran_id, basvuru_id) values (3, 253680, 100103);
insert into Sertifika_basvuru (sertifika_id, basvuran_id, basvuru_id) values (4, 253681, 100104);
insert into Sertifika_basvuru (sertifika_id, basvuran_id, basvuru_id) values (5, 253682, 100105);
insert into Sertifika_basvuru (sertifika_id, basvuran_id, basvuru_id) values (6, 253683, 100106);
insert into Sertifika_basvuru (sertifika_id, basvuran_id, basvuru_id) values (7, 253684, 100107);
insert into Sertifika_basvuru (sertifika_id, basvuran_id, basvuru_id) values (8, 253685, 100108);
insert into Sertifika_basvuru (sertifika_id, basvuran_id, basvuru_id) values (9, 253686, 100109);
insert into Sertifika_basvuru (sertifika_id, basvuran_id, basvuru_id) values (10, 253687, 100110);

--Profil tablosu:

insert into Profil (usr_id, okul, department, deneyim, email) values (253678, 'Istanbul Technical University', 'Industrial Engineer', 'staj', 'esleystanford0101@mail.com');
insert into Profil (usr_id, okul, department, deneyim, email) values (253679, 'Oxford University', 'Mechanical Engineer', 'part-time worker', 'palkannice11@mail.com');
insert into Profil (usr_id, okul, department, deneyim, email) values (253680, 'Harvard University', 'Electrical Engineer', 'staj', 'leallarminn@mail.com');
insert into Profil (usr_id, okul, department, deneyim, email) values (253681, 'Yildiz Technical University', 'Computer Engineer', 'part time developer', 'toville2rix@mail.com');
insert into Profil (usr_id, okul, department, deneyim, email) values (253682, 'Yildiz Technical University', 'Electrical Engineer', 'internship', 'dartsalaidh13@mail.com');
insert into Profil (usr_id, okul, department, deneyim, email) values (253683, 'Yildiz Technical University', 'Industrial Engineer', 'internship', 'northcannaway02@mail.com');
insert into Profil (usr_id, okul, department, deneyim, email) values (253684, 'Yildiz Technical University', 'Computer Engineer', 'internship', 'carolLeeder6@mail.com');
insert into Profil (usr_id, okul, department, deneyim, email) values (253685, 'Karadeniz Technical University', 'Electrical Engineer', 'internship at x', 'gabigabi6@mail.com');
insert into Profil (usr_id, okul, department, deneyim, email) values (253686, 'Istanbul Technical University', 'Computer Engineer', 'internship', 'minetteRank7@mail.com');
insert into Profil (usr_id, okul, department, deneyim, email) values (253687, 'Munich Technical University', 'Computer Engineer', 'internship', 'FarnallStefan01@mail.com');

-- ilanlar tablosu için 10 adet örnek insert işlemi
INSERT INTO ilanlar (ilan_ismi, ilan_tarihi, aciklama,ilan_id, company_id) VALUES
('Veri Analisti', '2023-07-30', 'Veri analizi konusunda deneyimli adaylar aranmaktadır. İstatistik bilgisi tercih sebebidir.',101,1880),
('Yazılım Mühendisi', '2023-07-07', 'Yazılım geliştirme konusunda uzman adaylar aranmaktadır. Java, C++, Python bilenler tercih edilir.',102,4606),
('Grafik Tasarımcı', '2023-11-12', 'Kreatif ve yenilikçi düşünebilen grafik tasarımcı aranmaktadır. Adobe Creative Suite bilgisi önemlidir.',103,4811),
('Sistem Analisti', '2023-06-12', 'Bilgi sistemleri ve iş süreçleri konusunda deneyimli sistem analisti aranmaktadır.',104,1453),
('Finans Uzmanı', '2023-12-16', 'Finans alanında uzman adaylar aranmaktadır. Muhasebe ve finans konularında bilgi sahibi olmak önemlidir.',105,1077),
('Mobil Uygulama Geliştirici', '2023-03-29', 'iOS ve Android platformları için mobil uygulama geliştirme konusunda uzman adaylar aranmaktadır.',106,6839),
('Yazılım Test Mühendisi', '2023-12-15', 'Yazılım test süreçlerine hakim adaylar aranmaktadır. Test senaryolarını oluşturabilme yeteneği önemlidir.',107,6839),
('İnsan Kaynakları Uzmanı', '2023-10-17', 'İnsan kaynakları yönetimi konusunda deneyimli uzman aranmaktadır. İletişim becerileri yüksek adaylar tercih edilir.',108,4657),
('Veritabanı Yöneticisi', '2023-10-12', 'Veritabanı yönetimi konusunda uzman adaylar aranmaktadır. SQL bilgisi önemlidir.',109,6020),
('Proje Yöneticisi', '2023-05-13', 'Büyük ölçekli projeleri yönetebilecek deneyime sahip proje yöneticisi aranmaktadır.',110,5522);

--Basvurular tablosu:

insert into Basvurular (basvuru_id, basvuran_id, ilan_id) values (1, 253678, 101);
insert into Basvurular (basvuru_id, basvuran_id, ilan_id) values (2, 253679, 102);
insert into Basvurular (basvuru_id, basvuran_id, ilan_id) values (3, 253680, 103);
insert into Basvurular (basvuru_id, basvuran_id, ilan_id) values (4, 253681, 104);
insert into Basvurular (basvuru_id, basvuran_id, ilan_id) values (5, 253682, 105);
insert into Basvurular (basvuru_id, basvuran_id, ilan_id) values (6, 253683, 106);
insert into Basvurular (basvuru_id, basvuran_id, ilan_id) values (7, 253684, 107);
insert into Basvurular (basvuru_id, basvuran_id, ilan_id) values (8, 253685, 108);
insert into Basvurular (basvuru_id, basvuran_id, ilan_id) values (9, 253686, 109);
insert into Basvurular (basvuru_id, basvuran_id, ilan_id) values (10,253687, 110);

--Basvuru_sonuclari tablosu:

insert into Basvuru_sonuclari (basvuru_id, sonuc_durumu) values (1, 'Kabul');
insert into Basvuru_sonuclari (basvuru_id, sonuc_durumu) values (2, 'Kabul');
insert into Basvuru_sonuclari (basvuru_id, sonuc_durumu) values (3, 'Kabul');
insert into Basvuru_sonuclari (basvuru_id, sonuc_durumu) values (4, 'Red');
insert into Basvuru_sonuclari (basvuru_id, sonuc_durumu) values (5, 'Beklemede');
insert into Basvuru_sonuclari (basvuru_id, sonuc_durumu) values (6, 'Red');
insert into Basvuru_sonuclari (basvuru_id, sonuc_durumu) values (7, 'Beklemede');
insert into Basvuru_sonuclari (basvuru_id, sonuc_durumu) values (8, 'Kabul');
insert into Basvuru_sonuclari (basvuru_id, sonuc_durumu) values (9, 'Red');
insert into Basvuru_sonuclari (basvuru_id, sonuc_durumu) values (10, 'Beklemede');
