SELECT * FROM tblLoaiHang;

SELECT * FROM tblSanPham;

SELECT * FROM tblKhachHang;

SELECT * FROM tblNhanVien;

SELECT * FROM tblDonHang;
SELECT * FROM tblChiTietDonHang;

--CHƯƠNG 4: XÂY DỰNG CÁC VIEW
--1. View danh sách sản phẩm và loại hàng
CREATE VIEW vw_DanhSachSanPham AS
SELECT sp.sMaSanPham, sp.sTenSanPham, lh.sTenLoaiHang, sp.fGiaBan, sp.iSoLuongTon
FROM tblSanPham sp
JOIN tblLoaiHang lh ON sp.sMaLoaiHang = lh.sMaLoaiHang;

SELECT * FROM vw_DanhSachSanPham;

--2 View danh sách khách hàng
CREATE VIEW vw_DanhSachKhachHang AS
SELECT sMaKhachHang, sHoTen, sSoDienThoai, sEmail, sDiaChi
FROM tblKhachHang;

SELECT * FROM vw_DanhSachKhachHang;

--3 View danh sách nhân viên
CREATE VIEW vw_DanhSachNhanVien AS
SELECT sMaNhanVien, sHoTen, sChucVu, sSoDienThoai, sEmail
FROM tblNhanVien;

SELECT * FROM vw_DanhSachNhanVien;

--4 View danh sách đơn hàng
CREATE VIEW vw_DanhSachDonHang AS
SELECT dh.sMaDonHang, kh.sHoTen AS TenKhachHang, nv.sHoTen AS TenNhanVien, dh.dNgayDatHang, dh.fTongTien
FROM tblDonHang dh
JOIN tblKhachHang kh ON dh.sMaKhachHang = kh.sMaKhachHang
JOIN tblNhanVien nv ON dh.sMaNhanVien = nv.sMaNhanVien;

SELECT * FROM vw_DanhSachDonHang;

--5 View chi tiết đơn hàng
CREATE VIEW vw_ChiTietDonHang AS
SELECT ctdh.sMaDonHang, sp.sTenSanPham, ctdh.iSoLuong, ctdh.fGiaBan, (ctdh.iSoLuong * ctdh.fGiaBan) AS ThanhTien
FROM tblChiTietDonHang ctdh
JOIN tblSanPham sp ON ctdh.sMaSanPham = sp.sMaSanPham;

SELECT * FROM vw_ChiTietDonHang;

--6 View tổng doanh thu theo khách hàng
CREATE VIEW vw_DoanhThuKhachHang AS
SELECT kh.sMaKhachHang, kh.sHoTen, SUM(dh.fTongTien) AS TongTienMua
FROM tblDonHang dh
JOIN tblKhachHang kh ON dh.sMaKhachHang = kh.sMaKhachHang
GROUP BY kh.sMaKhachHang, kh.sHoTen;

SELECT * FROM vw_DoanhThuKhachHang;

--7 View sản phẩm có số lượng tồn kho thấp (<10)
CREATE VIEW vw_SanPhamCanNhapHang AS
SELECT sMaSanPham, sTenSanPham, iSoLuongTon
FROM tblSanPham
WHERE iSoLuongTon < 10;

SELECT * FROM vw_SanPhamCanNhapHang;

--8 View 5 khách hàng mua nhiều nhất
CREATE VIEW vw_Top5KhachHangVip AS
SELECT TOP 5 kh.sMaKhachHang, kh.sHoTen, SUM(dh.fTongTien) AS TongTienMua
FROM tblDonHang dh
JOIN tblKhachHang kh ON dh.sMaKhachHang = kh.sMaKhachHang
GROUP BY kh.sMaKhachHang, kh.sHoTen
ORDER BY TongTienMua DESC;

SELECT * FROM vw_Top5KhachHangVip;

--9 View danh sách đơn hàng trong tháng 3
CREATE VIEW vw_DonHangThangBa AS
SELECT sMaDonHang, sMaKhachHang, sMaNhanVien, dNgayDatHang, fTongTien
FROM tblDonHang
WHERE MONTH(dNgayDatHang) = 3 
AND YEAR(dNgayDatHang) = 2024; -- Lấy năm hiện tại

SELECT * FROM vw_DonHangThangBa;
DROP VIEW vw_DonHangThangBa;

--10 View nhân viên có số đơn hàng nhiều nhất
CREATE VIEW vw_NhanVienXuatSac AS
SELECT TOP 1 nv.sMaNhanVien, nv.sHoTen, COUNT(dh.sMaDonHang) AS SoDonHang
FROM tblDonHang dh
JOIN tblNhanVien nv ON dh.sMaNhanVien = nv.sMaNhanVien
GROUP BY nv.sMaNhanVien, nv.sHoTen
ORDER BY SoDonHang DESC;

SELECT * FROM vw_NhanVienXuatSac;



-- CHƯƠNG 5 Xây dựng các procedure 
-- 1. Thêm sản phẩm mới
CREATE PROCEDURE sp_ThemSanPham
    @MaSanPham VARCHAR(50),
    @TenSanPham VARCHAR(100),
    @MaLoaiHang VARCHAR(50),
    @GiaBan FLOAT,
    @SoLuongTon INT
AS
BEGIN
    INSERT INTO tblSanPham (sMaSanPham, sTenSanPham, sMaLoaiHang, fGiaBan, iSoLuongTon)
    VALUES (@MaSanPham, @TenSanPham, @MaLoaiHang, @GiaBan, @SoLuongTon);
END;
GO
EXEC sp_ThemSanPham 'SP001', 'Sản phẩm A', 'LH01', 50000, 100;
GO

-- 2. Cập nhật giá bán sản phẩm
CREATE PROCEDURE sp_CapNhatGiaSanPham
    @MaSanPham VARCHAR(50),
    @GiaMoi FLOAT
AS
BEGIN
    UPDATE tblSanPham SET fGiaBan = @GiaMoi WHERE sMaSanPham = @MaSanPham;
END;
GO
EXEC sp_CapNhatGiaSanPham 'SP01', 55000;
GO

-- 3. Xóa sản phẩm theo mã
CREATE PROCEDURE sp_XoaSanPham
    @MaSanPham VARCHAR(50)
AS
BEGIN
    DELETE FROM tblSanPham WHERE sMaSanPham = @MaSanPham;
END;
GO
EXEC sp_XoaSanPham 'SP001';
GO

-- 4. Lấy danh sách sản phẩm
CREATE PROCEDURE sp_LayDanhSachSanPham
AS
BEGIN
    SELECT * FROM tblSanPham;
END;
GO
EXEC sp_LayDanhSachSanPham;
GO

-- 5. Lấy danh sách đơn hàng của khách hàng theo mã
CREATE PROCEDURE sp_LayDonHangKhachHang
    @MaKhachHang VARCHAR(50)
AS
BEGIN
    SELECT * FROM tblDonHang WHERE sMaKhachHang = @MaKhachHang;
END;
GO
EXEC sp_LayDonHangKhachHang 'KH001';
GO

-- 6. Thêm khách hàng mới
CREATE PROCEDURE sp_ThemKhachHang
    @MaKhachHang VARCHAR(50),
    @HoTen VARCHAR(100),
    @SoDienThoai VARCHAR(15),
    @Email VARCHAR(100),
    @DiaChi VARCHAR(255)
AS
BEGIN
    INSERT INTO tblKhachHang (sMaKhachHang, sHoTen, sSoDienThoai, sEmail, sDiaChi)
    VALUES (@MaKhachHang, @HoTen, @SoDienThoai, @Email, @DiaChi);
END;
GO
EXEC sp_ThemKhachHang 'KH002', 'Nguyễn Văn B', '0123456789', 'b@email.com', 'Hà Nội';
GO

-- 7. Xóa khách hàng theo mã
CREATE PROCEDURE sp_XoaKhachHang
    @MaKhachHang VARCHAR(50)
AS
BEGIN
    DELETE FROM tblKhachHang WHERE sMaKhachHang = @MaKhachHang;
END;
GO
EXEC sp_XoaKhachHang 'KH002';
GO

-- 8. Lấy danh sách nhân viên
CREATE PROCEDURE sp_LayDanhSachNhanVien
AS
BEGIN
    SELECT * FROM tblNhanVien;
END;
GO
EXEC sp_LayDanhSachNhanVien;
GO

-- 9. Cập nhật thông tin nhân viên
CREATE PROCEDURE sp_CapNhatThongTinNhanVien
    @MaNhanVien VARCHAR(50),
    @HoTen VARCHAR(100),
    @ChucVu VARCHAR(50),
    @SoDienThoai VARCHAR(15),
    @Email VARCHAR(100)
AS
BEGIN
    UPDATE tblNhanVien 
    SET sHoTen = @HoTen, sChucVu = @ChucVu, sSoDienThoai = @SoDienThoai, sEmail = @Email
    WHERE sMaNhanVien = @MaNhanVien;
END;
GO
EXEC sp_CapNhatThongTinNhanVien 'NV001', 'Trần Văn C', 'Trưởng phòng', '0987654321', 'c@email.com';
GO

-- 10. Tính tổng doanh thu của cửa hàng
CREATE PROCEDURE sp_TinhTongDoanhThu
AS
BEGIN
    SELECT SUM(fTongTien) AS TongDoanhThu FROM tblDonHang;
END;
GO
EXEC sp_TinhTongDoanhThu;
GO

--CHƯƠNG 6 TRIGGER

-- 1. Ngăn chặn khách hàng trùng số điện thoại
CREATE TRIGGER trg_PreventDuplicatePhone
ON tblKhachHang
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM tblKhachHang K
        JOIN inserted I ON K.sSoDienThoai = I.sSoDienThoai
    )
    BEGIN
        RAISERROR ('Số điện thoại đã tồn tại!', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;


-- 2. Cập nhật tổng tiền trong đơn hàng khi thêm chi tiết đơn hàng
CREATE TRIGGER trg_UpdateTotalAmount
ON tblChiTietDonHang
AFTER INSERT
AS
BEGIN
    UPDATE sMaDonHang
    SET TongTien = TongTien + (I.SoLuong * S.Gia)
    FROM DonHang D
    JOIN inserted I ON D.MaDonHang = I.MaDonHang
    JOIN SanPham S ON I.MaSanPham = S.MaSanPham;
END;
SELECT TOP 10 * FROM tblDonHang ORDER BY sMaDonHang DESC;

-- 3. Không cho phép số lượng sản phẩm bán ra lớn hơn tồn kho
CREATE TRIGGER trg_CheckStockBeforeInsert
ON tblChiTietDonHang
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM inserted I
        JOIN SanPham S ON I.MaSanPham = S.MaSanPham
        WHERE I.SoLuong > S.SoLuongTon
    )
    BEGIN
        RAISERROR ('Số lượng sản phẩm vượt quá tồn kho!', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

-- 4. Tự động giảm số lượng tồn kho khi thêm chi tiết đơn hàng
CREATE TRIGGER trg_UpdateStock
ON tblChiTietDonHang
AFTER INSERT
AS
BEGIN
    UPDATE SanPham
    SET SoLuongTon = S.SoLuongTon - I.SoLuong
    FROM SanPham S
    JOIN inserted I ON S.MaSanPham = I.MaSanPham;
END;

-- 5. Ngăn chặn xóa nhân viên nếu họ có đơn hàng đã xử lý
CREATE TRIGGER trg_PreventDeleteEmployee
ON tblNhanVien
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM deleted D
        JOIN DonHang DH ON D.MaNhanVien = DH.MaNhanVien
    )
    BEGIN
        RAISERROR ('Không thể xóa nhân viên có đơn hàng!', 16, 1);
    END
    ELSE
    BEGIN
        DELETE FROM NhanVien WHERE MaNhanVien IN (SELECT MaNhanVien FROM deleted);
    END
END;

-- 6. Tự động ghi log khi cập nhật thông tin khách hàng
CREATE TRIGGER trg_LogCustomerUpdate
ON tblKhachHang
AFTER UPDATE
AS
BEGIN
    INSERT INTO LogKhachHang (sMaKhachHang, HanhDong, ThoiGian)
    SELECT I.sMaKhachHang, 'Cập nhật thông tin', GETDATE()
    FROM inserted I;
END;

-- 7. Ngăn chặn xóa sản phẩm nếu có trong đơn hàng
CREATE TRIGGER trg_PreventDeleteProduct
ON tblSanPham
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM deleted D
        JOIN ChiTietDonHang C ON D.MaSanPham = C.MaSanPham
    )
    BEGIN
        RAISERROR ('Không thể xóa sản phẩm đang có trong đơn hàng!', 16, 1);
    END
    ELSE
    BEGIN
        DELETE FROM SanPham WHERE MaSanPham IN (SELECT MaSanPham FROM deleted);
    END
END;

-- 8. Tự động cập nhật trạng thái đơn hàng khi thanh toán
CREATE TRIGGER trg_UpdateOrderStatus
ON tblDonHang
AFTER UPDATE
AS
BEGIN
    UPDATE DonHang
    SET TrangThaiDonHang = 'Hoàn thành'
    FROM DonHang D
    JOIN inserted I ON D.MaDonHang = I.MaDonHang
    WHERE I.TrangThaiThanhToan = 'Đã thanh toán';
END;

-- 9. Ghi log khi nhân viên đăng nhập
CREATE TABLE NhatKyDangNhap (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    MaNhanVien NVARCHAR(50) NOT NULL,
    ThoiGianDangNhap DATETIME DEFAULT GETDATE()
);
CREATE TABLE LogNhanVien (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    MaNhanVien NVARCHAR(50) NOT NULL,
    HanhDong NVARCHAR(50) NOT NULL,
    ThoiGian DATETIME DEFAULT GETDATE()
);
CREATE TRIGGER trg_LogEmployeeLogin
ON NhatKyDangNhap
AFTER INSERT
AS
BEGIN
    INSERT INTO LogNhanVien (MaNhanVien, HanhDong, ThoiGian)
    SELECT MaNhanVien, 'Đăng nhập', GETDATE() FROM inserted;
END;

-- 10. Tự động đặt ngày tạo khi thêm đơn hàng mới

CREATE TRIGGER trg_SetOrderDate
ON tblDonHang
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO tblDonHang (sMaDonHang, sMaKhachHang, sMaNhanVien, dNgayDatHang, fTongTien)
    SELECT sMaDonHang, sMaKhachHang, sMaNhanVien, GETDATE(), fTongTien
    FROM inserted;
END;

--CHƯƠNG 7
--1 Tạo tài khoản người dùng
-- Tạo tài khoản cho QUẢN LÝ (Admin)
CREATE LOGIN QUANLY WITH PASSWORD = 'Admin@123';
CREATE USER QUANLY FOR LOGIN QUANLY;

-- Tạo tài khoản cho NHÂN VIÊN
CREATE LOGIN NHANVIEN WITH PASSWORD = 'Staff@123';
CREATE USER NHANVIEN FOR LOGIN NHANVIEN;

-- Tạo tài khoản cho KHÁCH HÀNG
CREATE LOGIN KHACHHANG WITH PASSWORD = 'Customer@123';
CREATE USER KHACHHANG FOR LOGIN KHACHHANG;

-- 2️ Phân quyền truy cập bảng dữ liệu
-- Toàn quyền trên toàn bộ database
ALTER ROLE db_owner ADD MEMBER QUANLY;
-- Cho phép đọc và chèn đơn hàng nhưng không xóa
GRANT SELECT, INSERT, UPDATE ON tblDonHang TO NHANVIEN;
GRANT SELECT, INSERT, UPDATE ON tblChiTietDonHang TO NHANVIEN;
GRANT SELECT ON tblKhachHang TO NHANVIEN;
-- Chỉ có thể xem thông tin đơn hàng của mình
GRANT SELECT ON tblDonHang TO KHACHHANG;
GRANT SELECT ON tblChiTietDonHang TO KHACHHANG;
--3️ Phân quyền EXECUTE trên Stored Procedures (nếu có)
CREATE PROCEDURE sp_TaoDonHang 
    @sMaDonHang VARCHAR(20),
    @sMaKhachHang VARCHAR(20),
    @sMaNhanVien VARCHAR(20),
    @fTongTien DECIMAL(10,2)
AS
BEGIN
    INSERT INTO tblDonHang (sMaDonHang, sMaKhachHang, sMaNhanVien, dNgayDatHang, fTongTien)
    VALUES (@sMaDonHang, @sMaKhachHang, @sMaNhanVien, GETDATE(), @fTongTien);
END;

CREATE PROCEDURE sp_CapNhatDonHang 
    @sMaDonHang VARCHAR(20),
    @fTongTienMoi DECIMAL(10,2)
AS
BEGIN
    UPDATE tblDonHang
    SET fTongTien = @fTongTienMoi
    WHERE sMaDonHang = @sMaDonHang;
END;

-- Cho phép nhân viên thực thi các stored procedure liên quan đến đơn hàng
GRANT EXECUTE ON sp_TaoDonHang TO NHANVIEN;
GRANT EXECUTE ON sp_CapNhatDonHang TO NHANVIEN;
