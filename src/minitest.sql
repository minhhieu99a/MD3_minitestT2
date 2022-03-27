Create DATABASE minitest;
use minitest;
CREATE TABLE vatTu(
    idVT int not null auto_increment primary key ,
    maVT varchar(10),
    tenVT varchar(50),
    donViTinh varchar(10),
    giaTienVT double
);

INSERT INTO vatTu(maVT, tenVT, donViTinh, giaTienVT) VALUES ('1L','Chai 1L','Chai',50000),('2L','Chai 2L','Chai',70000),('3L','Chai 3L','Chai',90000),('4L','Chai 4L','Chai',110000),('5L','Chai 5L','Chai',120000);

CREATE TABLE tonKho(
    idTK int not null auto_increment primary key ,
    idVT int,
    soluongdau int,
    tongSlNhap int ,
    tongSlXuat int,
    FOREIGN KEY (idVT)references vatTu(idVT)
);

INSERT INTO tonKho(idVT, soluongdau, tongSlNhap, tongSlXuat) VALUES (1,15,null,null),(2,10,null,null),(3,20,null,null),(4,5,null,null),(5,8,null,null);

CREATE TABLE NhaCC(
    idNCC int not null  auto_increment primary key ,
    maNCC varchar(20),
    tenNCC varchar(50),
    diachiNCC varchar(50),
    sdtNCC int
);

INSERT INTO NhaCC(maNCC, tenNCC, diachiNCC, sdtNCC) VALUES ('C1','NCC C1','quận Thanh Xuân',15613135),('C2','NCC C2','quận Đống Đa',15615125),('C3','NCC C3','quận Hoàng Mai',17813135);

CREATE TABLE donDH(
 idDDH int not null  auto_increment primary key ,
 maDDH varchar(20),
 ngayDH date,
 idNCC int,
 FOREIGN KEY (idNCC)references NhaCC(idNCC)
);
INSERT INTO donDH(maDDH, ngayDH, idNCC) VALUES ('DDH1','2022-03-26',1),('DDH2','2022-03-25',2),('DDH3','2022-03-24',3);

CREATE table PN(
    idPN int not null  auto_increment primary key ,
    maPN varchar(20),
    ngayNhap date,
    idDDH int,
    FOREIGN KEY (idDDH)references donDH(idDDH)
);
INSERT INTO PN(maPN, ngayNhap, idDDH) VALUES ('PN1','2022-03-27',1),('PN2','2022-03-26',2),('PN3','2022-03-25',3);

CREATE TABLE PX(
    idPX int not null  auto_increment primary key ,
    maPX varchar(20),
    ngayXuat date,
    tenKH VARCHAR(30)
);
INSERT INTO PX(maPX, ngayXuat, tenKH) VALUES ('PX1','2022-03-29','Trần Thái Dương'),('PX2','2022-03-30','Nguyễn Minh Hiếu'),('PX3','2022-03-31','Vũ Thị Kiều Anh');

CREATE TABLE CTDH(
    idCTDH int not null  auto_increment primary key ,
    idDDH int,
    idVT int,
    SLdat int ,
    FOREIGN KEY (idDDH)references donDH(idDDH),
    FOREIGN KEY (idVT)references vatTu(idVT)
);

INSERT INTO CTDH(idDDH, idVT, SLdat) VALUES (1,1,5),(1,2,3),(2,3,6),(2,1,5),(3,3,5),(3,4,2);

CREATE TABLE CTPN(
    idCTPN int not null  auto_increment primary key ,
    idPN int,
    idVT int ,
    slNhap int ,
    dgNHap double,
    notePN text,
    FOREIGN KEY (idPN)references PN(idPN),
    FOREIGN KEY (idVT)references vatTu(idVT)
);

INSERT INTO CTPN (idPN, idVT, slNhap, dgNHap, notePN) VALUES (1,1,5,20000,'Chai 1L nhập đủ theo đơn đặt'),(1,2,3,30000,'Chai 2L nhập đủ theo đơn đặt'),(2,3,6,40000,'Chai 3L nhập đủ theo đơn đặt'),(2,1,5,20000,'Chai 1L nhập đủ theo đơn đặt'),(3,3,5,40000,'Chai 3L nhập đủ theo đơn đặt'),(3,4,2,50000,'Chai 4L nhập đủ theo đơn đặt');

CREATE TABLE CTPX(
    idCTPX int not null  auto_increment primary key ,
    idPX int,
    idVT int,
    slXuat int ,
    dgXuat double,
    notePX text,
    FOREIGN KEY (idPX)references PX(idPX),
    FOREIGN KEY (idVT)references vatTu(idVT)
);

INSERT INTO CTPX(idPX, idVT, slXuat, dgXuat , notePX) VALUES (1,1,5,50000,'Nhập đúng theo giá tiền vật tư'),(1,2,4,70000,'Nhập đúng theo giá tiền vật tư'),(2,3,5,90000,'Nhập đúng theo giá tiền vật tư'),(2,2,5,70000,'Nhập đúng theo giá tiền vật tư'),(3,3,7,90000,'Nhập đúng theo giá tiền vật tư'),(3,4,4,110000,'Nhập đúng theo giá tiền vật tư');

SELECT *FROM vatTu;
SELECT *FROM tonKho;
SELECT *FROM nhacc;
SELECT *FROM donDH;
SELECT *FROM PN;
SELECT *FROM px;
SELECT *FROM CTDH;
SELECT *FROM CTPN;
SELECT *FROM CTPX;

# CAAU1
CREATE VIEW vw_CTPNHAP AS SELECT p.maPN ,vT.maVT,C.slNhap,C.dgNHap,C.dgNHap*C.slNhap as 'thanh tien' From PN P join CTPN C on P.idPN = C.idPN join vatTu vT on C.idVT = vT.idVT;

# cau2

CREATE VIEW vw_CTPNHAP_VT As SELECT P.maPN,VT.maVT,vT.tenVT,C.slNhap,C.dgNHap,C.dgNHap*C.slNhap as 'thanh tien' FROM PN P join CTPN C on P.idPN = C.idPN join vatTu vT on C.idVT = vT.idVT;

# cau3

CREATE VIEW vw_CTPNHAP_VT_PN AS SELECT P.maPN,P.ngayNhap,D.maDDH,vT.maVT,vT.tenVT,C.slNhap,C.dgNHap,C.slNhap*C.dgNHap as 'thanh tien' FROM donDH D join PN P on D.idDDH = P.idDDH join CTPN C on P.idPN = C.idPN join vatTu vT on C.idVT = vT.idVT;

# cau4

CREATE VIEW vw_CTPNHAP_VT_PN_DH AS SELECT P.maPN,P.ngayNhap,D.maDDH,N.maNCC,vT.maVT,vT.tenVT,C.slNhap,C.dgNHap,C.slNhap*C.dgNHap as 'thanh tien' FROM nhacc N join donDH D on N.idNCC = D.idNCC join PN P on D.idDDH = P.idDDH join CTPN C on P.idPN = C.idPN join vatTu vT on C.idVT = vT.idVT;

# cau 5

CREATE VIEW vw_CTPNHAP_loc AS SELECT P.maPN ,C.slNhap,C.dgNHap,C.slNhap*C.dgNHap as 'thanh tien' FROM PN P join CTPN C on P.idPN = C.idPN where slNhap>5;

# cau 6

CREATE VIEW  vw_CTPNHAP_VT_loc AS SELECT P.maPN,vT.maVT,vT.tenVT ,C.slNhap,C.dgNHap,C.slNhap*C.dgNHap as 'thanh tien' FROM PN P join CTPN C on P.idPN = C.idPN join vatTu vT on C.idVT = vT.idVT where donViTinh = 'Bộ';

# cau 7

CREATE VIEW vw_CTPXUAT AS SELECT P.maPX , vT.maVT,C.slXuat,C.dgXuat,C.slXuat*C.dgXuat as 'thanh tien' FROM PX P join CTPX C on P.idPX = C.idPX join vatTu vT on C.idVT = vT.idVT;

# cau 8

CREATE VIEW  vw_CTPXUAT_VT AS SELECT P.maPX , vT.maVT, vT.tenVT ,C.slXuat,C.dgXuat FROM PX P join CTPX C on P.idPX = C.idPX join vatTu vT on C.idVT = vT.idVT;

# cau 9

CREATE VIEW vw_CTPXUAT_VT_PX AS SELECT P.maPX , P.tenKH , vT.maVT , vT.tenVT , C.slXuat ,C.dgXuat FROM PX P join CTPX C on P.idPX = C.idPX join vatTu vT on C.idVT = vT.idVT;

# SP

# cau 1
DROP  PROCEDURE tongSoLuongCuoiCuaVatTu;
DELIMITER $$
CREATE PROCEDURE tongSoLuongCuoiCuaVatTu (IN maVT varchar(10))
BEGIN
    SELECT vT.maVT,  tK.soluongdau +C.slNhap-C2.slXuat as 'So luong cuoi cua vat tu' FROM tonKho tK join vatTu vT on vT.idVT = tK.idVT join CTPN C on vT.idVT = C.idVT join CTPX C2 on vT.idVT = C2.idVT WHERE vT.maVT = maVT GROUP BY maVT;
end $$
DELIMITER ;
call tongSoLuongCuoiCuaVatTu('1L');

# cau2
DELIMITER $$
CREATE PROCEDURE tongTienXuatVatTu (IN maVT varchar(10))
BEGIN
    SELECT C.slXuat*C.dgXuat as 'Tong tien xuat vat tu' FROM CTPX C join vatTu V  on V.idVT = C.idVT where V.maVT=maVT GROUP BY maVT;
end $$;
call tongTienXuatVatTu ('1L');

# cau3
DELIMITER $$
CREATE PROCEDURE tongSlDatTheoSoDH (IN maDDH varchar(20) )
BEGIN
    SELECT sum(C.SLdat),maDDH FROM donDH dD join CTDH C on dD.idDDH = C.idDDH where dD.maDDH=maDDH;
end $$;
call tongSLDatTheoSoDH('DDH1');

# cau4
DELIMITER $$
CREATE PROCEDURE addNewOrder (IN  maDDH varchar(20), ngayDH date,idNCC int)
BEGIN
    INSERT INTO donDH (maDDH, ngayDH, idNCC) VALUES (maDDH,ngayDH,idNCC);
end $$;
call addNewOrder ('DDH4','2022-03-22',1);

# cau5
DELIMITER $$
CREATE PROCEDURE addNewDetailOrder(IN idDDH int,idVT int ,SLdat int )
BEGIN
    INSERT INTO CTDH(idDDH, idVT, SLdat) VALUES (idDDH,idVT,SLdat);
end $$;
call addNewDetailOrder (4,1,5)