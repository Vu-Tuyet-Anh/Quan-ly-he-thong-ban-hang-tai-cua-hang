CREATE DATABASE QuanLyBanHang;
GO
USE QuanLyBanHang;
GO
--Tạo bảng (tblLoaiHang) - Danh mục sản phẩm
CREATE TABLE tblLoaiHang (
    sMaLoaiHang VARCHAR(20) PRIMARY KEY,
    sTenLoaiHang NVARCHAR(255) NOT NULL
);
--Tạo bảng (tblSanPham) - Sản phẩm
CREATE TABLE tblSanPham (
    sMaSanPham VARCHAR(20) PRIMARY KEY,
    sTenSanPham NVARCHAR(255) NOT NULL,
    sMaLoaiHang VARCHAR(20) NOT NULL,
    fGiaBan DECIMAL(10,2) NOT NULL,
    iSoLuongTon INT NOT NULL,
    sMoTa NVARCHAR(255) NULL,
    FOREIGN KEY (sMaLoaiHang) REFERENCES tblLoaiHang(sMaLoaiHang)
);

--Tạo bảng (tblKhachHang) - Khách hàng
CREATE TABLE tblKhachHang (
    sMaKhachHang VARCHAR(20) PRIMARY KEY,
    sHoTen NVARCHAR(255) NOT NULL,
    sSoDienThoai VARCHAR(15) UNIQUE,
    sEmail VARCHAR(50) UNIQUE,
    sDiaChi NVARCHAR(255) NULL
);
--Tạo bảng (tblNhanVien) - Nhân viên
CREATE TABLE tblNhanVien (
    sMaNhanVien VARCHAR(20) PRIMARY KEY,
    sHoTen NVARCHAR(255) NOT NULL,
    sChucVu NVARCHAR(255) NOT NULL,
    sSoDienThoai VARCHAR(15) UNIQUE,
    sEmail VARCHAR(50) UNIQUE
);
--Tạo bảng (tblDonHang) - Đơn hàng
CREATE TABLE tblDonHang (
    sMaDonHang VARCHAR(20) PRIMARY KEY,
    sMaKhachHang VARCHAR(20) NOT NULL,
    sMaNhanVien VARCHAR(20) NOT NULL,
    dNgayDatHang DATETIME NOT NULL,
    fTongTien DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (sMaKhachHang) REFERENCES tblKhachHang(sMaKhachHang),
    FOREIGN KEY (sMaNhanVien) REFERENCES tblNhanVien(sMaNhanVien)
);
--Tạo bảng (tblChiTietDonHang) - Chi tiết đơn hàng
CREATE TABLE tblChiTietDonHang (
    sMaDonHang VARCHAR(20),
    sMaSanPham VARCHAR(20),
    iSoLuong INT NOT NULL,
    fGiaBan DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (sMaDonHang, sMaSanPham),
    FOREIGN KEY (sMaDonHang) REFERENCES tblDonHang(sMaDonHang),
    FOREIGN KEY (sMaSanPham) REFERENCES tblSanPham(sMaSanPham)
);
--Chèn dữ liệu vào bảng tblLoaiHang (Danh mục hàng gia dụng)
INSERT INTO tblLoaiHang (sMaLoaiHang, sTenLoaiHang) VALUES
('LH01', 'Dụng cụ nhà bếp'),
('LH02', 'Thiết bị điện gia dụng'),
('LH03', 'Nội thất'),
('LH04', 'Dụng cụ vệ sinh'),
('LH05', 'Đồ gia dụng thông minh'),
('LH06', 'Thiết bị phòng tắm'),
('LH07', 'Đồ dùng học tập'),
('LH08', 'Sản phẩm chăm sóc cá nhân'),
('LH09', 'Dụng cụ sửa chữa'),
('LH10', 'Trang trí nội thất'),
('LH11', 'Đồ chơi trẻ em'),
('LH12', 'Thiết bị nhà tắm'),
('LH13', 'Sản phẩm chăm sóc thú cưng'),
('LH14', 'Phụ kiện ô tô - xe máy'),
('LH15', 'Dụng cụ thể thao'),
('LH16', 'Sách và văn phòng phẩm'),
('LH17', 'Thiết bị y tế gia đình'),
('LH18', 'Thực phẩm đóng hộp'),
('LH19', 'Dụng cụ làm vườn'),
('LH20', 'Thiết bị an ninh và giám sát');

--Chèn dữ liệu vào bảng tblSanPham (Sản phẩm gia dụng)
INSERT INTO tblSanPham (sMaSanPham, sTenSanPham, sMaLoaiHang, fGiaBan, iSoLuongTon, sMoTa) VALUES
('SP01', 'Nồi chiên không dầu', 'LH02', 1500000, 20, 'Dung tích 5L, công suất 1800W'),
('SP02', 'Máy hút bụi cầm tay', 'LH02', 1200000, 15, 'Hút sạch bụi bẩn, công suất mạnh mẽ'),
('SP03', 'Bếp từ đôi', 'LH02', 3500000, 10, 'Tiết kiệm điện, điều khiển cảm ứng'),
('SP04', 'Ghế sofa vải nỉ', 'LH03', 5000000, 5, 'Mềm mại, sang trọng, khung gỗ chắc chắn'),
('SP05', 'Tủ nhựa đựng quần áo', 'LH03', 1200000, 8, 'Tủ nhựa 5 tầng, bền đẹp'),
('SP06', 'Bàn ăn gỗ sồi', 'LH03', 8000000, 3, 'Bàn gỗ cao cấp, chống thấm nước'),
('SP07', 'Máy giặt 9kg', 'LH02', 7000000, 7, 'Công nghệ Inverter, tiết kiệm điện'),
('SP08', 'Lò vi sóng 25L', 'LH02', 2000000, 12, 'Nướng, hâm nóng, rã đông nhanh'),
('SP09', 'Bộ nồi inox 5 món', 'LH01', 1800000, 15, 'Chất liệu inox cao cấp, bền đẹp'),
('SP10', 'Chảo chống dính 28cm', 'LH01', 600000, 20, 'Lớp chống dính an toàn, dễ vệ sinh'),
('SP11', 'Đèn LED cảm ứng', 'LH07', 450000, 25, 'Đèn cảm ứng ánh sáng, tiết kiệm điện'),
('SP12', 'Bình đun siêu tốc', 'LH02', 700000, 18, 'Dung tích 1.8L, tự ngắt khi sôi'),
('SP13', 'Tủ lạnh Inverter 300L', 'LH02', 9000000, 6, 'Tiết kiệm điện, ngăn đá rộng'),
('SP14', 'Máy ép trái cây', 'LH02', 2500000, 10, 'Ép kiệt nước, giữ nguyên dinh dưỡng'),
('SP15', 'Bộ dao nhà bếp 6 món', 'LH01', 750000, 30, 'Lưỡi dao thép không gỉ, sắc bén'),
('SP16', 'Quạt điều hòa', 'LH02', 3200000, 8, 'Làm mát nhanh, dung tích nước 10L'),
('SP17', 'Giường ngủ gỗ tự nhiên', 'LH03', 12000000, 4, 'Gỗ sồi bền đẹp, thiết kế sang trọng'),
('SP18', 'Bộ chăn ga gối cotton', 'LH03', 2200000, 12, 'Chất liệu cotton 100%, thoáng mát'),
('SP19', 'Máy nước nóng trực tiếp', 'LH02', 3500000, 9, 'An toàn chống giật, làm nóng nhanh'),
('SP20', 'Bàn ủi hơi nước', 'LH02', 850000, 14, 'Ủi thẳng quần áo nhanh chóng');
--3. Chèn dữ liệu vào bảng tblKhachHang (Khách hàng)
INSERT INTO tblKhachHang (sMaKhachHang, sHoTen, sSoDienThoai, sEmail, sDiaChi) VALUES
('KH01', 'Nguyễn Văn A', '0987654321', 'a@gmail.com', 'Hà Nội'),
('KH02', 'Trần Thị B', '0976543210', 'b@gmail.com', 'Hồ Chí Minh'),
('KH03', 'Lê Văn C', '0965432109', 'c@gmail.com', 'Đà Nẵng'),
('KH04', 'Phạm Thị D', '0954321098', 'd@gmail.com', 'Cần Thơ'),
('KH05', 'Hoàng Văn E', '0943210987', 'e@gmail.com', 'Huế'),
('KH06', 'Nguyễn Thị F', '0932109876', 'f@gmail.com', 'Bình Dương'),
('KH07', 'Đặng Văn G', '0921098765', 'g@gmail.com', 'Hải Phòng'),
('KH08', 'Bùi Thị H', '0910987654', 'h@gmail.com', 'Nghệ An'),
('KH09', 'Lương Văn I', '0909876543', 'i@gmail.com', 'Thanh Hóa'),
('KH10', 'Đỗ Thị K', '0898765432', 'k@gmail.com', 'Quảng Nam'),
('KH11', 'Vũ Văn L', '0887654321', 'l@gmail.com', 'Hà Nội'),
('KH12', 'Tạ Thị M', '0876543210', 'm@gmail.com', 'Hồ Chí Minh'),
('KH13', 'Cao Văn N', '0865432109', 'n@gmail.com', 'Đà Nẵng'),
('KH14', 'Đinh Thị O', '0854321098', 'o@gmail.com', 'Cần Thơ'),
('KH15', 'Ngô Văn P', '0843210987', 'p@gmail.com', 'Huế'),
('KH16', 'Phan Thị Q', '0832109876', 'q@gmail.com', 'Bình Dương'),
('KH17', 'Hà Văn R', '0821098765', 'r@gmail.com', 'Hải Phòng'),
('KH18', 'Lý Thị S', '0810987654', 's@gmail.com', 'Nghệ An'),
('KH19', 'Tôn Văn T', '0809876543', 't@gmail.com', 'Thanh Hóa'),
('KH20', 'Dương Thị U', '0798765432', 'u@gmail.com', 'Quảng Nam');
--Chèn dữ liệu vào bảng tblNhanVien (Nhân viên)
INSERT INTO tblNhanVien (sMaNhanVien, sHoTen, sChucVu, sSoDienThoai, sEmail) VALUES
('NV01', 'Phạm Thị D', 'Nhân viên bán hàng', '0954321098', 'nv1@gmail.com'),
('NV02', 'Hoàng Văn E', 'Quản lý', '0943210987', 'nv2@gmail.com'),
('NV03', 'Lê Văn T', 'Nhân viên kho', '0934567890', 'nv3@gmail.com'),
('NV04', 'Nguyễn Văn U', 'Nhân viên giao hàng', '0923456789', 'nv4@gmail.com'),
('NV05', 'Trần Thị V', 'Kế toán', '0912345678', 'nv5@gmail.com'),
('NV06', 'Nguyễn Thị A', 'Nhân viên bán hàng', '0909876543', 'nv6@gmail.com'),
('NV07', 'Trần Văn B', 'Nhân viên kho', '0898765432', 'nv7@gmail.com'),
('NV08', 'Lê Thị C', 'Nhân viên giao hàng', '0887654321', 'nv8@gmail.com'),
('NV09', 'Đặng Văn D', 'Nhân viên bảo vệ', '0876543210', 'nv9@gmail.com'),
('NV10', 'Bùi Thị E', 'Nhân viên tư vấn', '0865432109', 'nv10@gmail.com'),
('NV11', 'Phạm Văn F', 'Nhân viên kỹ thuật', '0854321098', 'nv11@gmail.com'),
('NV12', 'Hồ Thị G', 'Nhân viên marketing', '0843210987', 'nv12@gmail.com'),
('NV13', 'Dương Văn H', 'Nhân viên chăm sóc khách hàng', '0832109876', 'nv13@gmail.com'),
('NV14', 'Lý Thị I', 'Nhân viên bán hàng', '0821098765', 'nv14@gmail.com'),
('NV15', 'Cao Văn K', 'Nhân viên IT', '0810987654', 'nv15@gmail.com'),
('NV16', 'Tạ Thị L', 'Nhân viên hành chính', '0809876543', 'nv16@gmail.com'),
('NV17', 'Đinh Văn M', 'Nhân viên giao nhận', '0798765432', 'nv17@gmail.com'),
('NV18', 'Tôn Thị N', 'Nhân viên kho', '0787654321', 'nv18@gmail.com'),
('NV19', 'Mai Văn O', 'Nhân viên hỗ trợ kỹ thuật', '0776543210', 'nv19@gmail.com'),
('NV20', 'Trương Thị P', 'Quản lý kho', '0765432109', 'nv20@gmail.com');

--Chèn dữ liệu vào bảng tblDonHang (Đơn hàng)
INSERT INTO tblDonHang (sMaDonHang, sMaKhachHang, sMaNhanVien, dNgayDatHang, fTongTien) VALUES
('DH01', 'KH01', 'NV01', '2024-03-06', 3500000),
('DH02', 'KH02', 'NV02', '2024-03-07', 7200000),
('DH03', 'KH03', 'NV01', '2024-03-08', 4500000),
('DH04', 'KH04', 'NV03', '2024-03-09', 5200000),
('DH05', 'KH05', 'NV04', '2024-03-10', 6300000),
('DH06', 'KH06', 'NV02', '2024-03-11', 8100000),
('DH07', 'KH07', 'NV05', '2024-03-12', 2950000),
('DH08', 'KH08', 'NV03', '2024-03-13', 6800000),
('DH09', 'KH09', 'NV01', '2024-03-14', 4250000),
('DH10', 'KH10', 'NV04', '2024-03-15', 7200000),
('DH11', 'KH11', 'NV06', '2024-03-16', 3600000),
('DH12', 'KH12', 'NV07', '2024-03-17', 5400000),
('DH13', 'KH13', 'NV02', '2024-03-18', 4600000),
('DH14', 'KH14', 'NV08', '2024-03-19', 3200000),
('DH15', 'KH15', 'NV09', '2024-03-20', 5900000),
('DH16', 'KH16', 'NV10', '2024-03-21', 8800000),
('DH17', 'KH17', 'NV03', '2024-03-22', 4700000),
('DH18', 'KH18', 'NV11', '2024-03-23', 6150000),
('DH19', 'KH19', 'NV12', '2024-03-24', 7300000),
('DH20', 'KH20', 'NV13', '2024-03-25', 4200000);

--dữ liệu vào bảng tblChiTietDonHang
INSERT INTO tblChiTietDonHang (sMaDonHang, sMaSanPham, iSoLuong, fGiaBan)
VALUES 
('DH01', 'SP01', '02', 1500000),
('DH02', 'SP02', '07', 1200000),
('DH03', 'SP03', '20', 3500000),
('DH04', 'SP04', '24', 5000000),
('DH05', 'SP05', '10', 1200000),
('DH06', 'SP06', '01', 8000000),
('DH07', 'SP07', '12', 7000000),
('DH08', 'SP08', '03',  2000000),
('DH09', 'SP09', '04', 1800000),
('DH10', 'SP10','05', 600000),
('DH11', 'SP11', '21', 450000),
('DH12', 'SP12', '07', 700000),
('DH13', 'SP13', '28', 9000000),
('DH14', 'SP14', '19', 2500000),
('DH15', 'SP15', '03', 750000),
('DH16', 'SP16', '21', 3200000),
('DH17', 'SP17', '02', 12000000),
('DH18', 'SP18', '23', 2200000),
('DH19', 'SP19', '04', 3500000),
('DH20', 'SP20', '05', 850000);

DELETE FROM tblChiTietDonHang;
DELETE FROM tblDonHang;
DELETE FROM tblNhanVien;
DELETE FROM tblKhachHang;
DELETE FROM tblSanPham;
DELETE FROM tblLoaiHang;

DROP TABLE tblChiTietDonHang;
DROP TABLE tblDonHang;
DROP TABLE tblNhanVien;
DROP TABLE tblKhachHang;
DROP TABLE tblSanPham;
DROP TABLE tblLoaiHang;
